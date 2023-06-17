import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4

Rectangle {
    signal sidebarButtonClicked(int index)
    property int index: 0

    color: theme.primary
    width: 80
    height: parent.height

    Image {
        source: "qrc:/logo"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        width: 80
        height: 80
        Layout.topMargin: 10
    }

    ColumnLayout {
        spacing: 20

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            bottomMargin: 24
        }

        IconImage {
            source: index == 0 ? "qrc:/home_selected" : "qrc:/home_unselected"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    index = 0
                    sidebarButtonClicked(0)
                }
            }
        }

        IconImage {
            source: index == 1 ? "qrc:/settings_selected" : "qrc:/settings_unselected"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    index = 1
                    sidebarButtonClicked(1)
                }
            }
        }

        Rectangle {
            height: 1
            color: theme.background
            Layout.fillWidth: true
        }

        IconImage {
            source: "qrc:/folder"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {

                }
            }
        }

        IconImage {
            source: "qrc:/minimize"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: mainWindow.showMinimized()
            }
        }

        IconImage {
            source: "qrc:/quit"
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }
    }
}
