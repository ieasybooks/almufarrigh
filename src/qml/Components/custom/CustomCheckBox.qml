import QtQuick 6.4
import QtQuick.Controls 6.4

CheckBox {
    id: checkbox

    font.pixelSize: 16

    contentItem: Text {
        text: qsTr(checkbox.text)
        font: checkbox.font
        opacity: enabled ? 1 : 0.3
        color: theme.fontPrimary
        verticalAlignment: Text.AlignVCenter
        leftPadding: checkbox.indicator.width + checkbox.spacing
    }

    indicator: Rectangle {
        implicitWidth: 26
        implicitHeight: 26
        x: checkbox.leftPadding
        y: parent.height / 2 - height / 2
        radius: 8
        color: "transparent"
        border.color: checkbox.checked ? theme.primary : "#CACACA"
        border.width: 2

        IconImage {
            x: 6
            y: 6
            width: 14
            height: 14
            source: "qrc:/checked"
            color: theme.primary
            visible: checkbox.checked
        }

    }

}
