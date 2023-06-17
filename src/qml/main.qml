import "components"
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Controls.Material 6.4
import QtQuick.Layouts 6.4
import QtQuick.Window 6.4
import "themes"

ApplicationWindow {
    id: mainWindow

    // REMOVE TITLE BAR
    flags: (Qt.FramelessWindowHint | Qt.Window)

    property bool isLightTheme: true
    property var theme: isLightTheme ? LightTheme : DarkTheme

    width: 1024
    height: 840
    visible: true

    Material.accent: theme.primary
    Material.primary: theme.primary

    // Dragging functionality
    MouseArea {
        id: dragArea
        anchors.fill: parent
        hoverEnabled: true

        property point clickPos

        onPressed: mouse => {
                       clickPos = Qt.point(mouse.x, mouse.y)
                   }

        onMouseXChanged: mouse => {
                             if (mouse.buttons === Qt.LeftButton) {
                                 mainWindow.x += (mouse.x - clickPos.x)
                             }
                         }

        onMouseYChanged: mouse => {
                             if (mouse.buttons === Qt.LeftButton) {
                                 mainWindow.y += (mouse.y - clickPos.y)
                             }
                         }
    }

    SideBar {
        id: sidebar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onSidebarButtonClicked: index => {
                                    stackLayout.currentIndex = index
                                    console.log("lol index changed")
                                }
    }

    StackLayout {
        id: stackLayout
        anchors {
            left: sidebar.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        ConvertPage {
            onConvertRequested: audioUrls => {
                                    controller.setAudioUrls(audioUrls)
                                    controller.setSettings(
                                        JSON.stringify(
                                            settingsPage.getSettingsData()))
                                }
        }

        SettingsPage {
            id: settingsPage
            onThemeChanged: state => isLightTheme = !state
        }
    }
}
