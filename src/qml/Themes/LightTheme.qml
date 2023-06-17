import QtQuick 6.4
pragma Singleton

QtObject {
    property string theme_name: "فاتح"
    property color primary: "#4ED7A4"
    property color background: "#F1F1F1"
    property color card: "#FFFFFF"
    property color stroke: "#CCCCCC"
    property color field: "#F1F1F1"
    property color error: "#E06D6D"
    property color fontPrimary: Qt.rgba(0, 0, 0, 0.87)
    property color fontSecondary: Qt.rgba(0, 0, 0, 0.6)
    property color fontThirty: Qt.rgba(0, 0, 0, 0.37)

    property var font: {
        name: "Poppins"
        source: "qrc:/poppins"
    }
}
