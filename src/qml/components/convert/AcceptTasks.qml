import "../../utils/audiohelper.mjs" as AudioHelper
import QtQml
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Dialogs
import QtQuick.Layouts 6.4

DropArea {
    id: dropArea

    signal addedNewAudio(url audio)

    height: 350
    width: parent.width
    onDropped: dragEvent => {
        //Drag Drop logic
        console.log(dragEvent.urls);
        console.log(dropArea.data);
        for (let file in dragEvent.urls) {
            let path = file.toString();
            let extension = path.substring(path.lastIndexOf(".") + 1).toLowerCase();
            console.log(extension);
            if (extension === "mp3" || extension === "m4a") {
                // File is an audio file, process it
                console.log("Audio file dropped:", file);
                addedNewAudio(file);
            } else {
                // File is not supported, show an error message or ignore it
                //TODO add warning pop
                console.log("Unsupported file format:", file);
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 24
        color: theme.card

        Canvas {
            anchors.fill: parent
            onPaint: {
                const ctx = getContext("2d");
                const borderRadius = 24;
                const halfBorderWidth = 1.5; // Half the desired border width for proper positioning
                ctx.strokeStyle = theme.primary;
                ctx.lineWidth = 3;
                ctx.setLineDash([5, 5]);
                ctx.beginPath();
                ctx.moveTo(borderRadius + halfBorderWidth, halfBorderWidth); // Start slightly offset to correctly position the border
                ctx.lineTo(width - borderRadius - halfBorderWidth, halfBorderWidth);
                ctx.arcTo(width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, borderRadius + halfBorderWidth, borderRadius);
                ctx.lineTo(width - halfBorderWidth, height - borderRadius - halfBorderWidth);
                ctx.arcTo(width - halfBorderWidth, height - halfBorderWidth, width - borderRadius - halfBorderWidth, height - halfBorderWidth, borderRadius);
                ctx.lineTo(borderRadius + halfBorderWidth, height - halfBorderWidth);
                ctx.arcTo(halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - borderRadius - halfBorderWidth, borderRadius);
                ctx.lineTo(halfBorderWidth, borderRadius + halfBorderWidth);
                ctx.arcTo(halfBorderWidth, halfBorderWidth, borderRadius + halfBorderWidth, halfBorderWidth, borderRadius);
                ctx.closePath(); // Close the path for better rendering
                ctx.stroke();
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        IconImage {
            source: "qrc:/add_task"
            Layout.alignment: Qt.AlignCenter
            width: 100
            height: 100
            color: theme.fontThirty
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Text {
                text: qsTr("كمبيوترك")
                color: theme.primary
                font.pixelSize: 22
                font.weight: Font.Medium
            }

            Text {
                text: qsTr("اســحب وأفلت هنا أو اختر من")
                color: theme.fontSecondary
                font.pixelSize: 22
                font.weight: Font.Medium
            }
        }

        Text {
            text: qsTr("أو الصق رابطاً")
            font.pixelSize: 22
            font.weight: Font.Medium
            color: theme.fontThirty
            Layout.alignment: Qt.AlignCenter
        }

        CustomButton {
            implicitWidth: 148
            Layout.alignment: Qt.AlignCenter
            text: qsTr("+ إضـــافة")
            onClicked: fileDialog.open()
        }

        FileDialog {
            id: fileDialog

            title: qsTr("Please choose a file")
            nameFilters: ["Audio Files (*.mp3 *.wav *.m4a *.ogg)"]
            onAccepted: {
                addedNewAudio(selectedFile);
            }
            onRejected: {
                console.log("Canceled");
            }
        }
    }

    PasteConfirm {
        id: pasteConfirm

        onPasteConfirmed: addedNewAudio(urlStr)
    }

    Connections {
        function onTextChanged() {
            let text = clipboard.getClipboardText();
            if (AudioHelper.isYoutubeLink(text))
                pasteConfirm.openWithUrl(text);
        }

        target: clipboard
        enabled: parent.visible
    }
}
