import QtQuick 2.0
import QtQml
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs
import "../../utils/audiohelper.mjs" as AudioHelper
DropArea {
    id: dropArea
    height: 305
    width: parent.width
    signal addedNewAudio(url audio)
    Rectangle {
        anchors.fill: parent
        color: theme.card

        radius: 10
                    Canvas{
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    var borderRadius = 10;

                    ctx.strokeStyle = theme.primary;
                    ctx.lineWidth = 3;
                    ctx.setLineDash([5, 5]);

                    ctx.beginPath();
                    ctx.moveTo(0, 0);
                    ctx.lineTo(width - borderRadius, 0);
                    ctx.arcTo(width, 0, width, borderRadius, borderRadius);
                    ctx.lineTo(width, height - borderRadius);
                    ctx.arcTo(width, height, width - borderRadius, height, borderRadius);
                    ctx.lineTo(borderRadius, height);
                    ctx.arcTo(0, height, 0, height - borderRadius, borderRadius);
                    ctx.lineTo(0, borderRadius);
                    ctx.arcTo(0, 0, borderRadius, 0, borderRadius);

                    ctx.stroke();
                }
            }
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        Image  {
            source: "../../resources/AddTask.png"
            Layout.alignment: Qt.AlignCenter

        }
        Text {
            text: "اســحب  وأفلت هنا أو اختر من كمبيوترك"
            font.pixelSize: 24
            color: theme.fontSecondary
            Layout.alignment: Qt.AlignCenter
        }
        Text {
            text: "أو الصق رابطاً"
            font.pixelSize: 24
            color: theme.fontThirty
            Layout.alignment: Qt.AlignCenter
        }
        CustomButton {
            implicitWidth: 150
            Layout.alignment: Qt.AlignCenter
            text: "+ إضافة"
            onClicked: fileDialog.open()
        }
        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            nameFilters: ["Audio Files (*.mp3 *.wav *.m4a)"]
            onAccepted: {

                addedNewAudio(selectedFile)

            }
            onRejected: {
                console.log("Canceled")
            }
        }

    }
//Drag Drop logic 
    onDropped: dragEvent => {
        console.log(dragEvent.urls)
        console.log(dropArea.data)
        for (let file of dragEvent.urls) {
            let path = file.toString()
            let extension = path.substring(path.lastIndexOf(".") + 1).toLowerCase();
            console.log(extension)
            if (extension === "mp3" || extension === "m4a") {
                // File is an audio file, process it
                console.log("Audio file dropped:", file);
                addedNewAudio(file)
            } else {
                // File is not supported, show an error message or ignore it
                //TODO add warning pop
                console.log("Unsupported file format:", file);
            }
        }
    }
    PasteConfirm {
        id: pasteConfirm
        onPasteConfirmed: addedNewAudio(urlStr)
    }
    // 
    Connections {
        target: clipboard
        enabled: parent.visible
        onTextChanged: {
            let text = clipboard.getClipboardText()
            if(AudioHelper.isYoutubeLink(text))
                pasteConfirm.openWithUrl(text)
    }

    }
 
   

}