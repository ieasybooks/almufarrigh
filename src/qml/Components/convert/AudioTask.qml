import "../../utils/audiohelper.mjs" as AudioHelper
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4

RowLayout {
    property string fileName

    signal removeAudioRequested()

    width: parent ? parent.width : 0
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    spacing: 5

    IconImage {
        width: 20
        height: 20
        source: AudioHelper.getFileIcon(fileName)
        color: theme.fontSecondary
    }

    Text {
        id: audioText

        property var maxLength: 50

        text: fileName.length > maxLength ? fileName.substring(0, maxLength) + '...' : fileName
        font.family: theme.font.name
        font.pixelSize: 20
        color: theme.fontSecondary
        horizontalAlignment: (Qt.locale().textDirection === Qt.RightToLeft) ? Text.AlignRight : Text.AlignLeft
        Layout.fillWidth: true
        LayoutMirroring.enabled: true
    }

    Rectangle {
        width: 32
        height: 24
        color: "transparent"

        IconImage {
            source: "qrc:/close_circle"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: removeAudioRequested()
        }

    }

}
