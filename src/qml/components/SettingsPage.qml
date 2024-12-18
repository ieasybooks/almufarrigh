import QtCore
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Controls.impl
import QtQuick.Dialogs
import QtQuick.Layouts 6.4
import "custom"
import "settings"

Rectangle {
    id: root

    property bool isWitEngine: true
    property alias saveLocation: saveLocation.value

    signal themeChanged(bool state)

    color: theme.background
    Component.onCompleted: {
        backend.get_languages().forEach(function(language) {
            convertLanguage.dropdownModel.append(language);
        });
    }

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

            property string value: convertLanguage.selectedValue

            onChangedSelection: (index, selected) => {
                value = selected;
                witConvertKey.value = backend.get_convert_token(selected);
            }
            iconSource: "qrc:/convert_language"
            labelText: qsTr("لــغة التحـويل")
            currentIndex: 0
        }

        SettingsDropDown {
            id: convertEngine

            property string value: convertEngine.selectedValue

            iconSource: "qrc:/convert_engine"
            labelText: qsTr("محرك التحـويل")
            onChangedSelection: (index, selected) => {
                isWitEngine = index === 0;
                value = selected;
            }

            dropdownModel: ListModel {
                ListElement {
                    text: "Wit.ai"
                    value: "Wit"
                }

                ListElement {
                    text: "Whisper"
                    value: "Whisper"
                }

            }

        }

        SettingsDropDown {
            id: whisperModel

            property string value: whisperModel.selectedValue

            visible: !root.isWitEngine
            iconSource: "qrc:/select_model"
            labelText: qsTr("تحديد النموذج")
            onChangedSelection: (index, selected) => {
                value = selected;
            }

            dropdownModel: ListModel {
                ListElement {
                    text: qsTr("أساسي")
                    value: "base"
                }

                ListElement {
                    text: qsTr("صغير")
                    value: "small"
                }

                ListElement {
                    text: qsTr("متوسط")
                    value: "medium"
                }

                ListElement {
                    text: qsTr("نحيف (أقل دقة)")
                    value: "tiny"
                }

                ListElement {
                    text: qsTr("كبير (أفضل دقة)")
                    value: "large-v2"
                }

            }

        }

        SettingsItem {
            id: witConvertKey

            property alias value: inputText.text

            visible: root.isWitEngine
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
                onTextChanged: {
                    const token = inputText.text;
                    const language = convertLanguage.value;
                    backend.save_convert_token(language, token);
                }

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

            property alias value: countInput.text

            iconSource: "qrc:/word_count"
            labelText: qsTr("عدد كلمات الجزء")

            TextField {
                id: countInput

                implicitHeight: 40
                text: "0"
                color: theme.fontPrimary
                font.pixelSize: 16 // Sets the font size to a small value
                selectByMouse: true // Allows selecting the text with the mouse
                inputMethodHints: Qt.ImhDigitsOnly // Restricts input to digits only
                width: Math.max(countInput.contentWidth + 4, 40)

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

            property alias value: slider.value

            visible: root.isWitEngine
            iconSource: "qrc:/part_max"
            labelText: qsTr("أقصى مدة للجزء")

            Slider {
                id: slider

                from: 3
                to: 17
                implicitWidth: parent.width / 3
            }

        }

        SettingsItem {
            id: dropEmptyParts

            property alias checked: checkbox.checked

            visible: root.isWitEngine
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            iconSource: "qrc:/drop_empty"
            labelText: qsTr("إسقاط الأجزاء الفارغة")

            CustomCheckBox {
                id: checkbox
            }

        }

        SettingsItem {
            id: exportFormats

            iconSource: "qrc:/export"
            labelText: qsTr("صيغ المخرجات")

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                CustomCheckBox {
                    id: srt

                    text: "srt"
                    checked: true
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

            property string value

            iconSource: "qrc:/folder"
            labelText: qsTr("مجلـد الحفــظ")

            Rectangle {
                id: openFileDialogButton

                width: Math.max(120, path.contentWidth + 64)
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

                Text {
                    id: path

                    text: "/ " + saveLocation.value.split("/").slice(-1)
                    color: theme.fontPrimary
                    font.weight: Font.Medium
                    font.pixelSize: 22
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    x: 8
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        folderDialog.open();
                    }
                }

                FolderDialog {
                    id: folderDialog

                    selectedFolder: saveLocation.value
                    title: qsTr("Please choose a file")
                    onAccepted: {
                        saveLocation.value = selectedFolder;
                    }
                    onRejected: {
                        console.log("Canceled");
                    }
                }

            }

        }

        SettingsItem {
            id: jsonLoad

            property alias checked: jsonCheck.checked

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

                checked: !mainWindow.isLightTheme
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

    Settings {
        id: settings

        property alias isWitEngine: root.isWitEngine
        property alias downloadJson: jsonCheck.checked
        property alias saveLocation: saveLocation.value
        property alias exportSrt: srt.checked
        property alias exportTxt: txt.checked
        property alias exportVtt: vtt.checked
        property alias dropEmptyParts: dropEmptyParts.checked
        property alias maxPartLength: maxPartLength.value
        property alias wordCount: wordCount.value
        property alias witConvertKey: witConvertKey.value
        property alias whisperModel: whisperModel.value
        property alias convertEngine: convertEngine.value
        property alias convertLanguage: convertLanguage.value

        category: "config"
        location: "file:settings.ini"
    }

    Settings {
        property alias whisperModelIndex: whisperModel.currentIndex
        property alias convertEngineIndex: convertEngine.currentIndex
        property alias convertLanguageIndex: convertLanguage.currentIndex

        category: "app"
        location: "file:settings.ini"
    }

    Connections {
        target: backend
        enabled: root.visible
    }

}
