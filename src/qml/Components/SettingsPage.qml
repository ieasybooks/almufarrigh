import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs
import QtQuick.Layouts 1.12
import "SettingsComponents"

Rectangle {
    property bool isWitEngine: true

    signal themeChanged(bool state)

    function getSettingsData() {
        console.log("hi ", convertLanguage.currentText);
        let settingsData = {
            "convertLanguage": convertLanguage.selectedText,
            "engineSelector": engineSelector.selectedText,
            "modelSelector": modelSelector.selectedText,
            "convertKey": convertKey.selectedText,
            "wordCount": wordCount.selectedText,
            "maxPartLength": maxPartLength.selectedText,
            "dropEmptyParts": dropEmptyParts.selectedValue,
            "exportFormats": exportFormats.getSelectedValue(),
            "saveLocation": saveLocation.selectedValue,
            "jsonLoad": jsonLoad.selectedValue
        };
        return settingsData;
    }

    color: mainWindow.theme.background

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
            dropdownIndex: 0

            dropdownModel: ListModel {
                ListElement {
                    text: "العربية"
                }

                ListElement {
                    text: "الانجليزية"
                }

            }

        }

        SettingsDropDown {
            id: engineSelector

            iconSource: "../resources/SettingsIcons/ConvertEngine.png"
            labelText: "محرك التحويل"
            dropdownIndex: 0
            onChangedSelection: (index) => {
                isWitEngine = index === 0;
                console.log(isWitEngine, index);
            }

            dropdownModel: ListModel {
                ListElement {
                    text: "wit.ai"
                }

                ListElement {
                    text: "whisper"
                }

            }

        }

        SettingsDropDown {
            id: modelSelector

            visible: !isWitEngine
            iconSource: "../resources/SettingsIcons/SelectModel.png"
            labelText: "تحديد النموذج"
            dropdownIndex: 0

            dropdownModel: ListModel {
                ListElement {
                    text: "Option 1"
                }

                ListElement {
                    text: "Option 2"
                }

                ListElement {
                    text: "Option 3"
                }

            }

        }

        SettingsItem {
            id: convertKey

            property alias selectedText: inputText.text

            visible: isWitEngine
            iconSource: "../resources/SettingsIcons/ConvertKey.png"
            labelText: "مفتاح التحويل"

            TextField {
                id: inputText

                implicitWidth: parent.width * (2 / 3)
                implicitHeight: 30
                font.pixelSize: 16
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only

                background: Rectangle {
                    color: theme.background
                    border.color: "gray"
                    border.width: 1
                    radius: 4
                }
                // Sets the font size to a small value

            }

        }

        SettingsItem {
            id: wordCount

            property alias selectedText: count.text

            iconSource: "../resources/SettingsIcons/WordCount.png"
            labelText: "عدد كلمات الجزء"

            TextField {
                id: count

                implicitWidth: 30
                implicitHeight: 30
                text: "0"
                placeholderText: "Enter number"
                font.pixelSize: 16 // Sets the font size to a small value
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only

                background: Rectangle {
                    color: theme.background
                    border.color: "gray"
                    border.width: 1
                    radius: 4
                }

                // Limits input to positive integers between 0 and 999
                validator: IntValidator {
                    bottom: 0
                    top: 999
                }

            }

        }

        SettingsItem {
            id: maxPartLength

            property alias selectedText: slider.value

            visible: isWitEngine
            iconSource: "../resources/SettingsIcons/PartMax.png"
            labelText: "أقصي مدة للجزء"

            Slider {
                id: slider

                implicitWidth: parent.width / 3
            }

        }

        SettingsItem {
            id: dropEmptyParts

            property alias selectedValue: checkbox.checked

            visible: isWitEngine
            iconSource: "../resources/SettingsIcons/DropEmptyParts.png"
            labelText: "إسقاط الأجزاء الفارغة"

            CheckBox {
                id: checkbox
            }

        }

        SettingsItem {
            id: exportFormats

            function getSelectedValue() {
                return {
                    "srt": srt.checked,
                    "txt": txt.checked,
                    "vtt": vtt.checked
                };
            }

            iconSource: "../resources/SettingsIcons/ExportExtentions.png"
            labelText: "صيغ المخرجات"

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
        SettingsItem {
            id: saveLocation

            property alias selectedValue: folderDialog.selectedFolder

            iconSource: "../resources/SettingsIcons/SaveLocation.png"
            labelText: "مجلد الحفظ"

            Rectangle {
                id: openFileDialogButton

                width: 120
                height: 40
                radius: 10
                border.color: theme.stroke // Replace with your custom border color
                border.width: 2
                color: theme.background // Replace with your custom background color

                Text {
                    text: "<"
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        folderDialog.open();
                    }
                }

                FolderDialog {
                    id: folderDialog

                    title: "Please choose a file"
                    onAccepted: {
                        console.log(selectedFolder);
                    }
                    onRejected: {
                        console.log("Canceled");
                    }
                }

            }

        }

        SettingsItem {
            id: jsonLoad

            property alias selectedValue: jsonCheck.checked

            iconSource: "../resources/SettingsIcons/JsonLoad.png"
            labelText: "تحميل ملف json"

            CheckBox {
                id: jsonCheck
            }

        }

        SettingsItem {
            iconSource: "../resources/SettingsIcons/Theme.png"
            labelText: "السمة"

            Switch {
                id: themeSwitch

                onToggled: {
                    themeChanged(checked);
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
                text: "الإصدار 1.0.6"
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }

    }

}
