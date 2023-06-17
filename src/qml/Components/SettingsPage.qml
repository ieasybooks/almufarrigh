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

            iconSource: "qrc:/convert_language"
            labelText: qsTr("لــغة التحـويل")
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

            iconSource: "qrc:/convert_engine"
            labelText: qsTr("محرك التحـويل")
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
            iconSource: "qrc:/select_model"
            labelText: qsTr("تحديد النموذج")
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
            iconSource: "qrc:/key"
            labelText: qsTr("مفتاح التحـويل")

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

            iconSource: "qrc:/word_count"
            labelText: qsTr("عدد كلمات الجزء")

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
            iconSource: "qrc:/part_max"
            labelText: qsTr("أقصى مدة للجزء")

            Slider {
                id: slider

                implicitWidth: parent.width / 3
            }

        }

        SettingsItem {
            id: dropEmptyParts

            property alias selectedValue: checkbox.checked

            visible: isWitEngine
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            iconSource: "qrc:/drop_empty"
            labelText: qsTr("إسقاط الأجزاء الفارغة")

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

            iconSource: "qrc:/export"
            labelText: qsTr("صيغ المخرجات")

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

            iconSource: "qrc:/folder"
            labelText: qsTr("مجلـد الحفــظ")

            Rectangle {
                id: openFileDialogButton

                width: 120
                height: 40
                radius: 10
                border.color: theme.stroke // Replace with your custom border color
                border.width: 2
                color: theme.background // Replace with your custom background color

                IconImage {
                    source: "qrc:/arrow_left"
                    color: theme.fontPrimary
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

            iconSource: "qrc:/download"
            labelText: qsTr("تحميل ملف json")

            CheckBox {
                id: jsonCheck
            }

        }

        SettingsItem {
            iconSource: "qrc:/theme"
            labelText: qsTr("الثـــيـــم")

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
