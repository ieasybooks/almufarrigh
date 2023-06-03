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

        StackLayout {
            id: stackLayout
            width: parent.width - sidebar.width
            height: parent.height

            ConvertPage {
                
            }
            SettingsPage {
                id: settingsPage
                onSwitchToggledSignal: (state) => isLightTheme = !state
            }
        }
    }
