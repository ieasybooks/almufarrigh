import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    property alias fileName: audioText.text

    signal removeAudioRequested()

    spacing: 5
    width: parent ? parent.width * 0.95 : 0

    Image {
        width: 20
        height: 20
        source: "../../resources/AudioIcon.png"
    }

    Text {
        id: audioText

        text: "Unnamed audio"
        font.family: "Poppins"
        font.pixelSize: 20
        color: theme.fontSecondary
    }

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    Image {
        source: "../../resources/CancelAudio.png"

        MouseArea {
            anchors.fill: parent
            onClicked: removeAudioRequested()
        }

    }

}
