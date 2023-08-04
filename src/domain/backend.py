"""Backend that interacts with tafrigh."""
from collections import OrderedDict
import json
from pathlib import Path
from platform import system
from subprocess import Popen
from typing import Any, Optional

from PySide6.QtCore import Property, QObject, QThreadPool, Signal, Slot
from tafrigh import Config, farrigh

from domain.config import AppConfig, CaseSensitiveConfigParser
from domain.progress import Progress
from domain.threadpool import Worker, WorkerSignals

from domain.token_manager import TokenManager



# BACKEND
class Backend(QObject):

    """Backend object."""

    result = Signal(dict)
    progress = Signal(int, int)
    error = Signal(tuple)
    finish = Signal()

    def __init__(self, parent: QObject | None = None) -> None:
        """Initialize backend object."""
        super().__init__(parent=parent)
        self.signals = WorkerSignals()
        self.threadpool = QThreadPool()
        self.token_manager = TokenManager()
        self._is_running = False
        self._urls: list[str] = []

    def on_error(self, error: tuple[str, int, str]) -> None:
        self.error.emit(error)
        self._is_running = False

    def on_result(self, result: dict[str, Any]) -> None:
        self.result.emit(result)

    def on_progress(self, progress: Progress) -> None:
        self.progress.emit(progress.value, progress.remaining_time)

    def on_finish(self) -> None:
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
    def urls(self) -> list[str]:
        return self._urls

    @urls.setter  # type: ignore[no-redef]
    def urls(self, value: list[str]):
        self._urls = [x.replace("file:///", "") for x in value]

    def run(self, *args: Any, **kwargs: Any) -> Any:
        app_config: AppConfig = CaseSensitiveConfigParser.read_config()

        config = Config(
            urls_or_paths=self.urls,
            playlist_items="",
            verbose=False,
            skip_if_output_exist=True,
            model_name_or_path=app_config.whisper_model,
            task="transcribe",
            language=app_config.convert_language,
            use_whisper_jax=False,
            use_faster_whisper=True,
            beam_size=5,
            ct2_compute_type="default",
            wit_client_access_token=app_config.wit_convert_key
            if app_config.is_wit_engine
            else None,
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
    def open_folder(path: str) -> None:
        if system() == "Windows":
            from os import startfile  # type: ignore[attr-defined]

            startfile(path)  # noqa: S606
        elif system() == "Darwin":
            Popen(["open", path], shell=False)  # noqa: S603, S607
        else:
            Popen(["xdg-open", path], shell=False)  # noqa: S603, S607

    @Slot(str, str)
    def save_convert_token(self, language: str, token: str):
        tokens = self.token_manager.read_tokens()
        tokens[language] = token
        self.token_manager.save_tokens(tokens)

    @Slot(str, result=str)
    def get_convert_token(self, language: str) -> Optional[str]:
        tokens = self.token_manager.read_tokens()
        return tokens.get(language, None)

    @Slot(result=list)
    def get_languages(self) -> list:
        try:
            root_path = Path(__file__).parent.parent
            with open(f"{root_path}/resources/languages.json", encoding="utf-8") as rf:
                languages_dict = json.load(rf, object_pairs_hook=OrderedDict)
                data = [{"text": text, "value": value} for value, text in languages_dict.items()]
            return data
        except FileNotFoundError:
            return []
