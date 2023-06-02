from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import QClipboard
from PySide6.QtWidgets import QApplication


class ClipboardProxy(QObject):
    def __init__(self, clipboard):
        super().__init__()
        self._clipboard = clipboard
        self._clipboard.dataChanged.connect(self.onClipboardDataChanged)

    @Slot(None, result=str)
    def getClipboardText(self):
        print(self._clipboard.text())
        return self._clipboard.text()

    textChanged = Signal()

    def onClipboardDataChanged(self):
        self.textChanged.emit()
