import "../utils/audiohelper.mjs" as AudioHelper
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Dialogs
import QtQuick.Layouts 6.4
import "convert"

Rectangle {
    id: progressPage

    property int index: 0
    property bool completionTextDisplayed: false

    signal sidebarButtonClicked(int index)
    signal clearAudioFiles()

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
    // Add this property to track text display

    CustomButton {
        id: stopButton

        text: qsTr("توقــف")
        Layout.fillWidth: true
        onClicked: {
            backend.stop(); // Call a method in the backend to stop the process
            clearAudioFiles(); // Emit a signal to clear audioFilesModel in ConvertPage.qml
            stackLayout.currentIndex = 0; // Go back to ConvertPage.qml
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: progressBar.bottom
            topMargin: 16
        }

    }

    Text {
        //   Component.onCompleted: {
        // Set the flag to true when the text is first displayed
        //   completionTextDisplayed = true;
        // }

        id: completionText

        text: qsTr(". . . جاري تهيــئة الملـــــــفات . . .")
        color: theme.black
        font.pixelSize: 25
        visible: progressBar.value === 0 && !completionTextDisplayed

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: stopButton.bottom
            topMargin: 8
        }

    }

    Connections {
        function onProgress(progress, remainingTime) {
            progressBar.value = progress;
        }

        function onFinish() {
            progressBar.value = 0;
            // Reset the completionTextDisplayed flag when the process finishes
            let completionTextDisplayed = true;
        }

        target: backend
        enabled: progressPage.visible
    }

}
