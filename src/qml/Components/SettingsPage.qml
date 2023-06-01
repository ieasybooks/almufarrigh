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
                implicitWidth : 30
                implicitHeight: 30
                background: Rectangle {
                    color: theme.background
                    border.color: "gray"
                    border.width: 1
                    radius: 4
                }
                text: "0"
                placeholderText: "Enter number"
                validator: IntValidator { bottom: 0; top: 999 } // Limits input to positive integers between 0 and 999
                font.pixelSize: 16 // Sets the font size to a small value
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only

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
        SettingsDropDown {
            iconSource: "../resources/SettingsIcons/GUILanguage.png"
            labelText: "لغة الواجهة"
            dropdownModel: ListModel {
                ListElement { text: "العربية" }
                ListElement { text: "الانجليزية" }
            }
            dropdownIndex: 0
        }
        SettingsItem {
            iconSource: "../resources/SettingsIcons/SaveLocation.png"
            labelText: "مجلد الحفظ"
            Rectangle {
                id: openFileDialogButton
                width: 120
                height: 40
                Text {
                    text: "<"
                    font.pixelSize: 16
                    
                    anchors.verticalCenter: parent.verticalCenter 
                    anchors.left: parent.left
                }
                
                radius: 10
                border.color: theme.stroke // Replace with your custom border color
                border.width: 2
                color: theme.background // Replace with your custom background color
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                                folderDialog.open()
                            }
                }
       

                FolderDialog {
                    id: folderDialog
                    title: "Please choose a file"
                    onAccepted: {

                        console.log(selectedFolder  )
                    }
                    onRejected: {
                        console.log("Canceled")
                    }
                }
            }
        }
        SettingsItem {
            iconSource: "../resources/SettingsIcons/JsonLoad.png"
            labelText: "تحميل ملف json"
            CheckBox {

            }

        }
        SettingsItem {
            iconSource: "../resources/SettingsIcons/Theme.png"
            labelText: "الثيم"
            Switch {}

        }
    }
    //End of common box

}