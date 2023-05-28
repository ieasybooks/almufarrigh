"""The main entrypoint from UI to the business logic.

When needed the necessary job will be delegated to another objects.
"""

from PySide6.QtCore import QObject, Slot


class Controller(QObject):

    """Controller for the UI."""

    @Slot(None, result=None)
    def resize(self) -> None:
        print("resizing... ")  # noqa: T201
