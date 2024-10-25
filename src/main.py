# ruff: noqa
"""Entry point for the application."""

import sys
from pathlib import Path

from PySide6.QtCore import QTimer, QUrl
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from PySide6.QtWidgets import QApplication

# noinspection PyUnresolvedReferences
import resources_rc
from domain.backend import Backend
from domain.clipboardproxy import ClipboardProxy

QQuickStyle.setStyle("Material")


def load_main_window() -> None:
    engine.load(QUrl.fromLocalFile((path / "main.qml")))
    if not engine.rootObjects():
        sys.exit(-1)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setOrganizationName("ieasybooks")
    app.setOrganizationDomain("https://almufaragh.com/")
    app.setApplicationName("Almufaragh")

    engine = QQmlApplicationEngine()
    backend = Backend()
    clipboard = QApplication.clipboard()
    clipboard_proxy = ClipboardProxy(clipboard)

    # Expose the Python object to QML
    engine.quit.connect(app.quit)
    engine.rootContext().setContextProperty("backend", backend)
    engine.rootContext().setContextProperty("clipboard", clipboard_proxy)
    path: Path = Path(__file__).parent / "qml"

    # Load splash screen
    engine.load(QUrl.fromLocalFile(path / "splash.qml"))
    if not engine.rootObjects():
        sys.exit(-1)

    # Delay loading the main window
    QTimer.singleShot(1, load_main_window)  # Adjust the delay time as needed

    app.exec()
