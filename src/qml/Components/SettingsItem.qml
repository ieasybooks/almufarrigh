import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {
    Layout.fillWidth: true
    Layout.fillHeight: false
    
        spacing: 10
        layoutDirection: Qt.RightToLeft
        FontLoader {
            id: poppinsFontLoader
            source: "src/qml/resources/Fonts/Poppins-Regular.ttf" // Replace with the actual path to the font file
        }

        Image {
            source: iconSource
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
            // spacer item
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer
        }



    

    property string iconSource: ""
    property string labelText: ""

}
