import "../utils/audiohelper.mjs" as AudioHelper
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Dialogs
import QtQuick.Layouts 6.4
import "convert"

Rectangle {
    id: progressPage
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
        width: 128

        anchors {
            top: parent.top
            right: title.right
            topMargin: title.anchors.topMargin + 48
            rightMargin: 60
        }
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

    CircularProgressBar {
        id: progressBar
        anchors.centerIn: parent
        width: 290
        height: 290
        foregroundColor: theme.primary
        backgroundColor: "#00000000"
    }

    Connections {
        target: backend
        enabled: progressPage.visible

        function onProgress(progress, remaingTime) {
            progressBar.value = progress;
        }
    }
}
