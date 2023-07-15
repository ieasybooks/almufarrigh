pragma Singleton
import QtQuick 6.4

QtObject {
    property string theme_name: "غامق"
    property color primary: "#23A173"
    property color background: "#2C2C2C"
    property color card: "#363636"
    property color stroke: "#797979"
    property color field: "#575757"
    property color error: "#363636"
    property color fontPrimary: Qt.rgba(1, 1, 1, 0.87)
    property color fontSecondary: Qt.rgba(1, 1, 1, 0.6)
    property color fontThirty: Qt.rgba(1, 1, 1, 0.37)
    property var font: {
        name: "Poppins";
        source: "qrc:/poppins";
    }
}
