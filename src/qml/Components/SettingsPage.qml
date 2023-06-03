import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs
import "SettingsComponents"
Rectangle {
    color: mainWindow.theme.background
    property bool isWitEngine: true
        signal themeChanged(bool state)
    function getSettingsData() {
        console.log("hi ",convertLanguage.currentText)
        let settingsData = {
            convertLanguage: convertLanguage.selectedText,
            engineSelector: engineSelector.selectedText,
            modelSelector: modelSelector.selectedText,
            convertKey: convertKey.selectedText,
            wordCount: wordCount.selectedText,
            maxPartLength: maxPartLength.selectedText,
            dropEmptyParts: dropEmptyParts.selectedValue,
            exportFormats: exportFormats.getSelectedValue(),
            guiLanguage: guiLanguage.selectedText,
            saveLocation: saveLocation.selectedValue,
            jsonLoad: jsonLoad.selectedValue

        }
        return settingsData
    }
    ColumnLayout {
            spacing: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            // anchors.fill: parent
            anchors.margins: 50
            SettingsDropDown {
                id: convertLanguage
                iconSource: "../resources/SettingsIcons/ConvertLanguage.png"
                labelText: "لغة التحويل"
                dropdownModel: ListModel {
                    ListElement { text: "العربية" }
                    ListElement { text: "الانجليزية" }
                }
                dropdownIndex: 0
            }

            SettingsDropDown {
                id: engineSelector
                iconSource: "../resources/SettingsIcons/ConvertEngine.png"
                labelText: "محرك التحويل"
                dropdownModel: ListModel {
                    ListElement { text: "wit.ai" }
                    ListElement { text: "whisper" }
                }
                dropdownIndex: 0
                onChangedSelection: index => {
                isWitEngine = index === 0
                console.log(isWitEngine, index)
            }
            }

            SettingsDropDown {
                id: modelSelector
                visible: !isWitEngine
                iconSource: "../resources/SettingsIcons/SelectModel.png"
                labelText: "تحديد النموذج"
                dropdownModel: ListModel {
                    ListElement { text: "Option 1" }
                    ListElement { text: "Option 2" }
                    ListElement { text: "Option 3" }
                }
                dropdownIndex: 0
            }

            SettingsItem {
                id: convertKey
                visible: isWitEngine
                iconSource: "../resources/SettingsIcons/ConvertKey.png"
                labelText: "مفتاح التحويل"
                property alias selectedText: inputText.text
                TextField {
                    id: inputText
                    implicitWidth : parent.width * (2/3)
                    implicitHeight: 30
                    background: Rectangle {
                        color: theme.background
                        border.color: "gray"
                        border.width: 1
                        radius: 4
                    }
                    font.pixelSize: 16 // Sets the font size to a small value
                    selectByMouse: true // Allows selecting the text with the mouse
                    inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only
                }
            }

            SettingsItem {
                id: wordCount
                iconSource: "../resources/SettingsIcons/WordCount.png"
                labelText: "عدد كلمات الجزء"
                property alias selectedText: count.text

                TextField {
                    id: count
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
                id: maxPartLength
                visible: isWitEngine
                iconSource: "../resources/SettingsIcons/PartMax.png"
                labelText: "أقصي مدة للجزء"
                property alias selectedText: slider.value
                Slider {
                    id: slider
                    implicitWidth: parent.width /3
                }
            }

            SettingsItem {
                id: dropEmptyParts
                visible: isWitEngine
                iconSource: "../resources/SettingsIcons/DropEmptyParts.png"
                labelText: "اسقاط الأجزاء الفارغة"
                property alias selectedValue: checkbox.checked
                CheckBox {
                    id: checkbox
                }
            }

            SettingsItem {
                id: exportFormats
                iconSource: "../resources/SettingsIcons/ExportExtentions.png"
                labelText: "صيغ المخرجات"

                function getSelectedValue() {
                    return {
                        srt: srt.checked,
                        txt: txt.checked,
                        vtt: vtt.checked
                    }
                }
                RowLayout {
                    spacing: 10
                    CheckBox {
                        id: srt
                        text: "srt"
                    }
                    CheckBox {
                        id: txt
                        text: "txt"
                    }
                    CheckBox {
                        id: vtt
                        text: "vtt"
                    }
                }
            }

            SettingsDropDown {
                id: guiLanguage
                iconSource: "../resources/SettingsIcons/GUILanguage.png"
                labelText: "لغة الواجهة"
                dropdownModel: ListModel {
                    ListElement { text: "العربية" }
                    ListElement { text: "الانجليزية" }
                }
                dropdownIndex: 0
            }

            SettingsItem {
                id: saveLocation
                iconSource: "../resources/SettingsIcons/SaveLocation.png"
                labelText: "مجلد الحفظ"
                property alias selectedValue: folderDialog.selectedFolder
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
                            console.log(selectedFolder )
                        }
                        onRejected: {
                            console.log("Canceled")
                        }
                    }
                }
            }

            SettingsItem {
                id: jsonLoad
                iconSource: "../resources/SettingsIcons/JsonLoad.png"
                labelText: "تحميل ملف json"
                property alias selectedValue: jsonCheck.checked
                CheckBox {
                    id: jsonCheck
                }
            }

            SettingsItem {
                iconSource: "../resources/SettingsIcons/Theme.png"
                labelText: "الثيم"
                Switch {
                    id: themeSwitch
                    onToggled: {
                        themeChanged(checked)
                    }
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
            Text {
                text: "Copyright © 2022-2023 almufaragh.com."
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter

            }

            Text {
                text: "الاصدار 1.0.6"
                Layout.alignment: Qt.AlignHCenter

                horizontalAlignment: Text.AlignHCenter
            }
        }    
    }

}