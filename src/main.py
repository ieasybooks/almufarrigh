"""Entry point for the application."""
import sys
from pathlib import Path

from PySide6.QtCore import QUrl
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication

from controller import Controller

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    controller = Controller()
    # Expose the Python object to QML
    engine.rootContext().setContextProperty("controller", controller)
    qml_file: Path = Path(__file__).parent / "qml/main.qml"
    # to Work with qmldir
    engine.load(QUrl.fromLocalFile(qml_file))
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
