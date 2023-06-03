import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12

import "Components"
import "Themes"

ApplicationWindow {
    id: mainWindow
    width: 1200
    height: 1320
    visible: true

    property bool isLightTheme: true
    property var theme: isLightTheme ? LightTheme : DarkTheme
    RowLayout {
        anchors.fill:parent
        SideBar {
            id: sidebar
            onSidebarButtonClicked: (index)=> {
                stackLayout.currentIndex = index
                console.log("lol index changed")
            }
        }
        Button {
            onClicked: {
                
                console.log( JSON.stringify(settingsPage.getSettingsData(), null, 2))
            }
        }
        StackLayout {
        id: stackLayout
        width: parent.width - sidebar.width
        height: parent.height

        ConvertPage {
            
        }
        SettingsPage {
            id: settingsPage
            onThemeChanged: (state) => isLightTheme = !state
        }

    }
    
    }
}