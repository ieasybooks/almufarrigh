import QtQuick
import QtQuick.Controls

Button {
    FontLoader {
        id: poppinsFontLoader
        source: "../resources/Fonts/Poppins-Regular.ttf" // Replace with the actual path to the font file
    }
    id: control
    text: qsTr("Button")
    font.family: poppinsFontLoader.font.family
    font.pixelSize: 24
    property var back_color
    flat: true

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        // color: control.down ? "#17a81a" : "#21be2b"
        color: back_color? theme.fontPrimary: Qt.rgba(255, 255, 255, 0.87)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: back_color? back_color: theme.primary

        opacity: enabled ? 1 : 0.3
        radius: 15
    }
}