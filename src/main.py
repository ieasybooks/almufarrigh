import os
import sys
from PySide2.QtCore import QObject, Slot

from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine

class Bridge(QObject):

    @Slot(str, result=str)
    def getColor(self, s):
        if s.lower() == "red":
            return "#ef9a9a"
        elif s.lower() == "green":
            return "#a5d6a7"
        elif s.lower() == "blue":
            return "#90caf9"
        else:
            return "white"

    @Slot(float, result=int)
    def getSize(self, s):
        size = int(s * 34)
        if size <= 0:
            return 1
        else:
            return size

    @Slot(str, result=bool)
    def getItalic(self, s):
        if s.lower() == "italic":
            return True
        else:
            return False

    @Slot(str, result=bool)
    def getBold(self, s):
        if s.lower() == "bold":
            return True
        else:
            return False

    @Slot(str, result=bool)
    def getUnderline(self, s):
        if s.lower() == "underline":
            return True
        else:
            return False


if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    bridge = Bridge()

    # Expose the Python object to QML
    context = engine.rootContext()
    context.setContextProperty("con", bridge)
    qml_file = os.path.join(os.path.dirname(__file__), "qml/main.qml")

    engine.load(qml_file)
    sys.exit(app.exec_())
