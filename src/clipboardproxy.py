"""Clipboard Warapper for sys clipboard so that it can be accessed from qml."""
from PySide6.QtCore import QObject, Signal, Slot


class ClipboardProxy(QObject):

    """The proxy class.

    params:
        QObject (QObject): used by pyside
    """

    def __init__(self, clipboard: QObject):
        """Initialize and connect signal for the clipboard.

        params:
            clipboard (QClipboard): System clipboard module
        """
        super().__init__()
        self._clipboard = clipboard
        self._clipboard.dataChanged.connect(self.onClipboardDataChanged)

    @Slot(None, result=str)
    def getClipboardText(self) -> str:
        """Get the latest string from the clipboard.

        Returns
        -------
            str: _description_
        """
        return str(self._clipboard.text())

    text_changed = Signal()

    def onClipboardDataChanged(self) -> None:
        self.text_changed.emit()
