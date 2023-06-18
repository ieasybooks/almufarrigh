import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Dialogs
import QtQuick.Layouts 6.4
import "custom"
import "settings"

Rectangle {
    id: rectangle

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

    color: theme.background

    ColumnLayout {
        spacing: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: copyRights.top
        anchors.rightMargin: 24
        anchors.topMargin: 48
        anchors.leftMargin: 24
        anchors.bottomMargin: 48

        SettingsDropDown {
            id: convertLanguage

            iconSource: "qrc:/convert_language"
            labelText: qsTr("لــغة التحـويل")
            dropdownIndex: 0

            dropdownModel: ListModel {
                ListElement {
                    text: qsTr("العــربية")
                }

                ListElement {
                    text: qsTr("الانجليزية")
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

                color: theme.fontPrimary
                implicitWidth: parent.width * (2 / 3)
                implicitHeight: 40
                font.pixelSize: 16
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only

                background: Rectangle {
                    color: theme.field
                    border.color: theme.stroke
                    border.width: 1
                    radius: 8
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

                implicitHeight: 40
                text: "0"
                color: theme.fontPrimary
                font.pixelSize: 16 // Sets the font size to a small value
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only
                width: Math.max(textInput.contentWidth + 4, 40)
                background: Rectangle {
                    color: theme.field
                    border.color: theme.stroke
                    border.width: 1
                    radius: 8
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

            CustomCheckBox {
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
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                CustomCheckBox {
                    id: srt

                    text: "srt"
                }

                CustomCheckBox {
                    id: txt

                    text: "txt"
                }

                CustomCheckBox {
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
                radius: 8
                border.color: theme.stroke
                border.width: 2
                color: theme.field

                IconImage {
                    source: "qrc:/arrow_left"
                    color: theme.fontPrimary
                    anchors.left: parent.left
                    y: 8
                    anchors.leftMargin: 8
                    Layout.alignment: Qt.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        folderDialog.open();
                    }
                }

                FolderDialog {
                    id: folderDialog

                    title: qsTr("Please choose a file")
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

            CustomCheckBox {
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

    }

    ColumnLayout {
        id: copyRights

        spacing: 0
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottomMargin: 28
        Layout.alignment: Qt.AlignHCenter

        Text {
            text: "Copyright © 2022-2023 almufaragh.com."
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            color: theme.fontPrimary
        }

        Text {
            text: qsTr("الإصدار 1.0.6")
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            color: theme.fontPrimary
        }

    }

}
