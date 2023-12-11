import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4

Rectangle {
    property string iconSource: ""
    property string labelText: ""
    default property alias children: myRow.children

    Layout.alignment: Qt.AlignVCenter
    color: theme.card
    Layout.fillWidth: true
    implicitHeight: 50
    radius: 8

    RowLayout {
        id: myRow

        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 20
        layoutDirection: Qt.RightToLeft
        Layout.fillHeight: true

        FontLoader {
            id: poppinsFontLoader

            source: theme.font.source
        }

        IconImage {
            source: iconSource
            width: 20
            height: 20
            color: theme.fontPrimary
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: labelText
            font.family: poppinsFontLoader.font.family
            font.pixelSize: 24
            color: theme.fontPrimary
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
        }

        Item {
            // Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer

            // spacer item
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

    }

}
