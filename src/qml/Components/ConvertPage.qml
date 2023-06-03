import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs
import "ConvertComponents"
Rectangle {
    color: mainWindow.theme.background
    //audioUrls must be in jsonstring format
    signal convertRequested(string audioUrls)
    FontLoader {
        id: poppinsFontLoader
        source: "../resources/Fonts/Poppins-Regular.ttf" 
    }
    ListModel {
        id: audioFilesModel
    }
    ColumnLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.rightMargin: 90
        Text {
            color: theme.fontPrimary
            font.pixelSize: 42
            horizontalAlignment: Text.AlignRight
            text: "تحويل مقطع صوتي <br>إلي <Item>نص</Item>"
            Layout.alignment: Qt.AlignRight
        
            textFormat: Text.RichText

            }

        Text {
            color: theme.fontSecondary
            font.pixelSize: 30
            text: "تلقائياً ومجاناً"
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignRight
            

        }

    }
    ColumnLayout {
        width: 487
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin:165
        anchors.leftMargin:200
        spacing: 10

        AcceptTasks {
            id: acceptTasks
            onAddedNewAudio: (audio) => {
                console.log('From ConverPage ', audio)
                console.log("The list ", audioFilesModel.count)

                audioFilesModel.append({audioUrl: audio})
            }
        }
        Rectangle {
            visible: audioFilesModel.count > 0
            id: audioDeck
            width: parent.width
            height: 198
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
                    //! This don't show full youtube link
                    fileName: modelData.toString().substring(modelData.toString().lastIndexOf("/") + 1)
                    onRemoveAudioRequested: {
                        audioFilesModel.remove(index)  // Remove the audio file from the model
                    }
                }
            }

        }

        RowLayout {
            visible: audioFilesModel.count > 0
            Layout.fillWidth: true
            layoutDirection: Qt.RightToLeft

            height: 50
            CustomButton {
                text: "البدء" 
                Layout.fillWidth: true
                onClicked: {
                    let convertData = {audioUrlList: []}
                    for (var i = 0; i < audioFilesModel.count; i++) {
                        convertData.audioUrlList.push(audioFilesModel.get(i))
                    }
                    let jsonString = JSON.stringify(convertData)

                    convertRequested(jsonString)
                }
            }
            CustomButton {
                text: "الغاء"
                back_color: theme.card
                Layout.fillWidth: true

            }

        }
    }

}