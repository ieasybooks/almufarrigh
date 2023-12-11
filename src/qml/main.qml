import QtCore
import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Controls.Material 6.4
import QtQuick.Layouts 6.4
import QtQuick.Window 6.4
import "components"
import "components/convert"
import "themes"

ApplicationWindow {
    id: mainWindow

    property bool isLightTheme: true
    property var theme: isLightTheme ? LightTheme : DarkTheme

    // REMOVE TITLE BAR
    flags: (Qt.FramelessWindowHint | Qt.Window)
    width: 1024
    height: 840
    visible: true
    Material.accent: theme.primary
    Material.primary: theme.primary

    // Dragging functionality
    MouseArea {
        id: dragArea

        property point clickPos

        anchors.fill: parent
        hoverEnabled: true
        onPressed: (mouse) => {
            clickPos = Qt.point(mouse.x, mouse.y);
        }
        onMouseXChanged: (mouse) => {
            if (mouse.buttons === Qt.LeftButton)
                mainWindow.x += (mouse.x - clickPos.x);

        }
        onMouseYChanged: (mouse) => {
            if (mouse.buttons === Qt.LeftButton)
                mainWindow.y += (mouse.y - clickPos.y);

        }
    }

    SideBar {
        id: sidebar

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onFolderClick: {
            backend.open_folder(settingsPage.saveLocation);
        }
        onSidebarButtonClicked: (index) => {
            stackLayout.currentIndex = index;
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
            id: convertPage

            function clearAudioFiles() {
                audioFilesModel.clear();
            }

            onConvertRequested: (urls) => {
                backend.urls = urls;
                backend.start();
                stackLayout.currentIndex = 2;
            }
            // Connect to the signal and update completionTextDisplayed
            onStartConversionClicked: {
                processPage.completionTextDisplayed = false;
            }
        }

        SettingsPage {
            id: settingsPage

            onThemeChanged: (state) => {
                let isLightTheme = !state;
            }
        }

        ProcessPage {
            id: processPage
        }

        Connections {
            target: processPage
            onClearAudioFiles: {
                convertPage.clearAudioFiles();
            }
        }

    }

    Settings {
        id: settings

        property alias isLightTheme: mainWindow.isLightTheme

        category: "app"
        location: "file:settings.ini"
    }

    Connections {
        function onFinish() {
            timer.start();
        }

        target: backend
        enabled: mainWindow.visible
    }

    Timer {
        id: timer

        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            timer.stop();
            stackLayout.currentIndex = 0;
        }
    }

}
