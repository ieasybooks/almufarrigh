import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    width: 200
    height: 40

    RowLayout {
        // anchors.fill: parent
        spacing: 10
        layoutDirection: Qt.RightToLeft
        Item { Layout.fillWidth: true ; height: 1 }

        Image {
            source: iconSource
            width: 20
            height: 20
        }

        Text {
            text: labelText
            font.pixelSize: 14
        }
               Item {
                    // spacer item
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer
                }

        ComboBox {
            model: dropdownModel
            currentIndex: dropdownIndex
            width: 100
        }

    }

    property string iconSource: ""
    property string labelText: ""
    property ListModel dropdownModel: ListModel {}
    property int dropdownIndex: -1
}
