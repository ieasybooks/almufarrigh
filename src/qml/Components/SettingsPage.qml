import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Rectangle {
    color: mainWindow.theme.background

    ColumnLayout {
            spacing: 20

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top        

        anchors.margins: 50
        SettingsDropDown {
                iconSource: "../resources/SettingsIcons/ConvertLanguage.png"
                labelText: "لغة التحويل"
                dropdownModel: ListModel {
                    ListElement { text: "العربية" }
                    ListElement { text: "الانجليزية" }
                }
                dropdownIndex: 0
        }

        SettingsDropDown {
            iconSource: "../resources/SettingsIcons/ConvertEngine.png"
            labelText: "محرك التحويل"
            dropdownModel: ListModel {
                ListElement { text: "Option 1" }
                ListElement { text: "Option 2" }
                ListElement { text: "Option 3" }
            }
            dropdownIndex: 0
        }
        SettingsItem {
            iconSource: "../resources/SettingsIcons/WordCount.png"
            labelText: "عدد كلمات الجزء"
            TextField {
            
                placeholderText: "Enter text"
            }
        }
        SettingsItem {
            iconSource: "../resources/SettingsIcons/ExportExtentions.png"
            labelText: "صيغ المخرجات"
            RowLayout {
                spacing: 10

                CheckBox {
                    text: "srt"
                }

                CheckBox {
                    text: "txt"
                }

                CheckBox {
                    text: "vat"
                }
            }
        }
        
    }
 

}