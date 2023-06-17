import "."
import QtQuick 6.4
import QtQuick.Controls 6.4

SettingsItem {
    property alias selectedText: combo.currentText
    property ListModel dropdownModel
    property int dropdownIndex: -1

    //TODO instead of all this hustle extract into its own style
    //TODO Look here https://doc.qt.io/qtforpython-6.2/overviews/qtquickcontrols-flatstyle-example.html#qt-quick-controls-flat-style
    signal changedSelection(int index)

    ComboBox {
        id: combo

        font.family: poppinsFontLoader.font.family
        model: dropdownModel
        currentIndex: dropdownIndex
        onCurrentIndexChanged: changedSelection(combo.currentIndex)

        FontLoader {
            id: poppinsFontLoader

            source: theme.font.source
        }

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            radius: 8
            border.color: theme.stroke
            border.width: 2
            color: theme.field
        }

        delegate: ItemDelegate {
            width: combo.width
            height: 80
            highlighted: combo.highlightedIndex === index

            contentItem: Text {
                anchors.centerIn: parent
                text: combo.textRole ? (Array.isArray(combo.model) ? modelData[combo.textRole] : model[combo.textRole]) : modelData
                color: theme.fontPrimary
                // font: combo.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

        }

        contentItem: Text {
            leftPadding: combo.indicator.width + combo.spacing + 24
            text: combo.displayText
            font.family: theme.font.name
            font.pixelSize: 22
            color: combo.pressed ? theme.fontSecondary : theme.fontPrimary
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        indicator: IconImage {
            source: "qrc:/arrow_down"
            color: theme.fontPrimary
            anchors.left: parent.left
            y: (combo.background.implicitHeight / 2) - 4
            anchors.leftMargin: 16
        }

    }

    dropdownModel: ListModel {
    }

}
