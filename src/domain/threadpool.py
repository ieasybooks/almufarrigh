from typing import Callable, Generator, Dict

from PySide6.QtCore import Signal, QObject, QRunnable
import traceback
import sys

from domain.progress import Progress


# THREAD SIGNALS
class WorkerSignals(QObject):
    finished = Signal()
    error = Signal(tuple)
    result = Signal(dict)
    progress = Signal(Progress)


# CUSTOM THREAD CLASS
class Worker(QRunnable):
    def __init__(
            self,
            func: Callable[..., Generator[Dict[str, int], None, None]],
            *args,
            **kwargs
    ) -> None:
        super(Worker, self).__init__()
        self.func = func
        self.args = args
        self.kwargs = kwargs
        self.signals = WorkerSignals()

    def run(self) -> None:
        try:
            results = self.func(args=self.args, kwargs=self.kwargs)
            for result in results:
                progress_value, remaining_time = result["progress"], result["remaining_time"]
                progress = Progress(value=progress_value, remaining_time=remaining_time, )
                self.signals.progress.emit(progress)
                self.signals.result.emit(result)
        except Exception:
            traceback.print_exc()
            exc_type, value = sys.exc_info()[:2]
            self.signals.error.emit((exc_type, value, traceback.format_exc()))
        finally:
            try:
                self.signals.finished.emit()
            except RuntimeError:
                return

    def stop(self) -> None:
        self.terminate()
