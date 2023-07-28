import os
from typing import List, Generator, Dict

from PySide6.QtCore import QObject, Signal, Property, Slot, QThreadPool
from tafrigh import farrigh, Config

from .progress import Progress
from .config import CaseSensitiveConfigParser, AppConfig
from .threadpool import WorkerSignals, Worker

os.system('cls')


# BACKEND
class Backend(QObject):
    result = Signal(dict)
    progress = Signal(int, int)
    error = Signal(tuple)
    finish = Signal()

    def __init__(self, parent=None) -> None:
        super().__init__(parent=parent)
        self.signals = WorkerSignals()
        self.threadpool = QThreadPool()
        self._is_running = False
        self._urls = []

    def on_error(self, error) -> None:
        self.error.emit(error)
        self._is_running = False

    def on_result(self, result) -> None:
        self.result.emit(result)

    def on_progress(self, progress: Progress) -> None:
        self.progress.emit(progress.value, progress.remaining_time)

    def on_finish(self):
        self.finish.emit()

    @Slot()
    def start(self) -> None:
        worker = Worker(func=self.run)
        worker.signals.finished.connect(self.on_finish)
        worker.signals.progress.connect(self.on_progress)
        worker.signals.error.connect(self.on_error)
        worker.signals.result.connect(self.on_result)
        self.threadpool.start(worker)

    @Property(list)
    def urls(self) -> List[str]:
        return self._urls

    @urls.setter
    def urls(self, value: List[str]):
        self._urls = list(map(lambda x: x.replace("file:///", ""), value))

    def run(self, *args, **kwargs) -> Generator[Dict[str, int], None, None]:
        app_config: AppConfig = CaseSensitiveConfigParser.read_config()

        config = Config(
            urls_or_paths=self.urls,
            playlist_items="",
            verbose=False,
            skip_if_output_exist=True,
            model_name_or_path=app_config.whisper_model,
            task='transcribe',
            language=app_config.convert_language,
            use_whisper_jax=False,
            use_faster_whisper=True,
            beam_size=5,
            ct2_compute_type='default',

            wit_client_access_token=app_config.wit_convert_key if app_config.is_wit_engine else None,
            max_cutting_duration=int(app_config.max_part_length),

            min_words_per_segment=app_config.word_count,
            save_files_before_compact=False,
            save_yt_dlp_responses=app_config.download_json,
            output_sample=0,
            output_formats=app_config.get_output_formats(),
            output_dir=app_config.save_location.replace("file:///", ""),
        )

        return farrigh(config)

    @Slot(str)
    @staticmethod
    def open_folder(path: str):
        os.startfile(path)
