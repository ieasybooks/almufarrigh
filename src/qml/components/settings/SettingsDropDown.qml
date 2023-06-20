import "."
import QtQuick 6.4
import QtQuick.Controls 6.4

SettingsItem {
    property alias selectedText: combo.currentText
    property alias currentIndex: combo.currentIndex
    property ListModel dropdownModel

    signal changedSelection(int index, string value)

    ComboBox {
        id: combo

        textRole: "text"
        valueRole: "value"
        font.family: poppinsFontLoader.font.family
        model: dropdownModel
        onActivated: (index) => {
            var selectedValue = model.get(index)[combo.valueRole];
            console.log(selectedValue);
            changedSelection(index, selectedValue);
            combo.currentIndex = index;
        }

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
                text: model[combo.textRole]
                color: theme.fontPrimary
                font.family: theme.font.name
                font.pixelSize: 16
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

        popup: Popup {
            y: combo.height - 1
            width: combo.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: combo.popup.visible ? combo.delegateModel : null
                currentIndex: combo.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {
                }

            }

            background: Rectangle {
                color: theme.field
                radius: 8
            }

        }

    }

    dropdownModel: ListModel {
    }

}
