"""The Clipboard proxy class."""
from PySide6.QtCore import QObject, Signal, Slot


class ClipboardProxy(QObject):

    """Wrapper for the clipboard module as it doesn't exist natively in QML."""

    def __init__(self, clipboard):
        """Initialize the ClipboardProxy.

        Args:
        ----
            clipboard (QClipboard): The clipboard object.
        """
        super().__init__()
        self._clipboard = clipboard
        self._clipboard.dataChanged.connect(self.onClipboardDataChanged)

    @Slot(result=str)
    def get_text(self):
        """Get the text from the clipboard.

        Returns
        -------
            str: The text from the clipboard.
        """
        return self._clipboard.text()

    text_changed = Signal()

    def onClipboardDataChanged(self):
        """Signal handler for clipboard data change event."""
        self.text_changed.emit()
