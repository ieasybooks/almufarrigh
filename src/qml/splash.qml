import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Controls.Material 6.4
import QtQuick.Layouts 6.4
import "themes"

ApplicationWindow {
    id: splash

    property bool isLightTheme: true
    property var theme: isLightTheme ? LightTheme : DarkTheme

    width: 600
    height: 400
    visible: true
    flags: Qt.SplashScreen

    Rectangle {
        anchors.fill: parent
        color: theme.field
        radius: 16

        IconImage {
            id: logo

            source: "qrc:/logo"
            fillMode: Image.PreserveAspectFit
            height: 180
            width: 180

            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
                topMargin: 64
            }

        }

        Text {
            id: appName

            color: theme.fontPrimary
            text: qsTr('الـــمــفرغ')
            font.pointSize: 24
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter

            anchors {
                top: logo.bottom
                left: logo.left
                right: logo.right
                topMargin: 16
            }

        }

        Column {
            id: copyRights

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 28
            }

            Text {
                text: "Copyright © 2022-2023 almufaragh.com."
                color: theme.fontThirty
                font.pointSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: qsTr("الإصدار") + " 1.0.6 "
                color: theme.fontThirty
                font.pointSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }

    }

    Timer {
        id: timer

        interval: 3500
        running: true
        repeat: false
        onTriggered: {
            timer.stop();
            splash.close();
        }
    }

}
