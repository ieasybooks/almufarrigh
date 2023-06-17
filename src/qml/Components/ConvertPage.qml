import "../utils/audiohelper.mjs" as AudioHelper
import "convert"
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Dialogs
import QtQuick.Layouts 6.4

Rectangle {
    //audioUrls must be in jsonstring format
    signal convertRequested(string audioUrls)

    color: theme.background

    FontLoader {
        id: poppinsFontLoader
        source: theme.font.source
    }

    ListModel {
        id: audioFilesModel
    }

    Text {
        id: title
        color: theme.fontPrimary
        font.pixelSize: 40
        font.weight: Font.Bold
        horizontalAlignment: Text.AlignRight
        text: qsTr('تحــــويل مقــطع صوتي <br>إلى')
        Layout.alignment: Qt.AlignRight
        textFormat: Text.RichText
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 64
            rightMargin: 75
        }
    }

    Image {
        id: textBackground
        source: mainWindow.isLightTheme ? "qrc:/text_background_light" : "qrc:/text_background_dark"
        anchors {
            top: parent.top
            right: title.right
            topMargin: title.anchors.topMargin + 48
            rightMargin: 60
        }

        width: 128
    }

    Text {
        color: "#fff"
        font.pixelSize: 40
        horizontalAlignment: Text.AlignRight
        text: qsTr('نـــص')
        font.weight: Font.Bold
        Layout.alignment: Qt.AlignRight
        textFormat: Text.RichText

        anchors {
            top: textBackground.top
            bottom: textBackground.bottom
            left: textBackground.left
            right: textBackground.right
            topMargin: 6
            rightMargin: 10
        }
    }

    Text {
        id: subtitle
        color: theme.fontSecondary
        font.pixelSize: 28
        text: qsTr("تلقائياً ومجاناً")
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignRight
        Layout.alignment: Qt.AlignRight
        anchors {
            top: title.bottom
            right: title.right
            topMargin: 16
        }
    }

    AcceptTasks {
        id: acceptTasks
        anchors {
            top: title.bottom
            right: subtitle.left
            left: parent.left
            rightMargin: 72
            leftMargin: 72
        }
        onAddedNewAudio: audio => {
                             console.log('From ConverPage ', audio)
                             console.log("The list ", audioFilesModel.count)
                             audioFilesModel.append({
                                                        "audioUrl": audio
                                                    })
                         }
    }

    Rectangle {
        id: audioDeck
        anchors {
            top: acceptTasks.bottom
            right: acceptTasks.right
            left: acceptTasks.left
            topMargin: 16
        }
        visible: audioFilesModel.count > 0
        width: parent.width
        height: 200
        color: theme.card
        radius: 10

        ListView {
            anchors.fill: parent
            anchors.margins: 10
            model: audioFilesModel
            spacing: 10

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }

            delegate: AudioTask {
                fileName: AudioHelper.extractTextIdentifier(modelData.toString())
                onRemoveAudioRequested: {
                    audioFilesModel.remove(index) // Remove the audio file from the model
                }
            }
        }
    }

    RowLayout {
        anchors {
            top: audioDeck.bottom
            right: audioDeck.right
            left: audioDeck.left
            topMargin: 16
        }
        visible: audioFilesModel.count > 0
        Layout.fillWidth: true
        layoutDirection: Qt.RightToLeft
        height: 50

        CustomButton {
            text: qsTr("البــــدء")
            Layout.fillWidth: true
            onClicked: {
                let convertData = {
                    "audioUrlList": []
                }
                for (var i = 0; i < audioFilesModel.count; i++) {
                    convertData.audioUrlList.push(audioFilesModel.get(i))
                }
                let jsonString = JSON.stringify(convertData)
                convertRequested(jsonString)
            }
        }

        CustomButton {
            text: qsTr("الغــاء")
            backColor: theme.card
            Layout.fillWidth: true
            onClicked: audioFilesModel.clear()
        }
    }

}
