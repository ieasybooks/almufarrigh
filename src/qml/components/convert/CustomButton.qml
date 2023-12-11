import QtQuick 6.4
import QtQuick.Controls 6.4

Button {
    id: control

    property var backColor

    text: qsTr("Button")
    font.family: poppinsFontLoader.font.family
    font.pixelSize: 22
    font.weight: Font.Bold
    flat: true

    // Set hand cursor on hover
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: control.clicked()
    }

    FontLoader {
        id: poppinsFontLoader

        source: theme.font.source
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1 : 0.3
        // color: control.down ? "#17a81a" : "#21be2b"
        color: backColor ? theme.fontPrimary : Qt.rgba(255, 255, 255, 0.87)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: backColor ? backColor : theme.primary
        opacity: enabled ? 1 : 0.3
        radius: 15
    }

}
