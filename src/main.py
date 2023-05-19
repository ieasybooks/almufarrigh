"""Entry point for the application."""
import sys
from pathlib import Path

from PySide6.QtCore import QObject, QUrl, Slot
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication


class Bridge(QObject):

    """Bridge class."""

    @Slot(str, result="str")
    def getColor(self, s: str) -> str:
        if s.lower() == "red":
            return "#ef9a9a"
        if s.lower() == "green":
            return "#a5d6a7"
        if s.lower() == "blue":
            return "#90caf9"
        return "white"

    @Slot(float, result="int")
    def getSize(self, s: int) -> int:
        size = int(s * 34)
        if size <= 0:
            return 1
        return size

    @Slot(str, result="str")
    def getItalic(self, s: str) -> bool:
        return s.lower() == "italic"

    @Slot(str, result="str")
    def getBold(self, s: str) -> bool:
        return s.lower() == "bold"

    @Slot(str, result="str")
    def getUnderline(self, s: str) -> bool:
        return s.lower() == "underline"


if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    bridge = Bridge()

    # Expose the Python object to QML
    engine.rootContext().setContextProperty("con", bridge)
    qml_file: Path = Path(__file__).parent / "qml/main.qml"
    engine.load(QUrl.fromLocalFile(qml_file))
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
