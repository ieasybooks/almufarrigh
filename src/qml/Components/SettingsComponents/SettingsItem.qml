import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string iconSource: ""
    property string labelText: ""
    default property alias children: myRow.children

    color: theme.card
    Layout.fillWidth: true
    implicitHeight: 50
    radius: 10

    RowLayout {
        id: myRow

        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        // anchors.margins: 10
        spacing: 20
        layoutDirection: Qt.RightToLeft

        FontLoader {
            id: poppinsFontLoader

            source: "../../resources/Fonts/Poppins-Regular.ttf"
        }

        Image {
            source: `../${iconSource}`
            width: 20
            height: 20
        }

        Text {
            text: labelText
            font.family: poppinsFontLoader.font.family
            font.pixelSize: 30
            color: theme.fontPrimary
        }

        Item {
            // Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer

            // spacer item
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

    }

}
