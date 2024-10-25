"""Custom thread class and signals emitted by worker threads."""

import sys
import traceback
from collections.abc import Callable, Generator
from typing import Any

from PySide6.QtCore import QObject, QRunnable, Signal

from domain.progress import Progress


class WorkerSignals(QObject):

    """Signals emitted by worker threads."""

    finished = Signal()
    error = Signal(tuple)
    result = Signal(dict)
    progress = Signal(Progress)


class Worker(QRunnable):

    """Custom thread class."""

    def __init__(
        self, func: Callable[..., Generator[dict[str, int], None, None]], *args: Any, **kwargs: Any
    ) -> None:
        """Initialize worker object."""
        super().__init__()
        self.func = func
        self.args = args
        self.kwargs = kwargs
        self.signals = WorkerSignals()

    def run(self) -> None:
        try:
            results = self.func(args=self.args, kwargs=self.kwargs)
            for result in results:
                progress_value, remaining_time = (
                    result["progress"],
                    result["remaining_time"],
                )
                progress = Progress(
                    value=progress_value,
                    remaining_time=remaining_time,
                )
                self.signals.progress.emit(progress)
                self.signals.result.emit(result)
        except Exception:  # noqa: BLE001
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
