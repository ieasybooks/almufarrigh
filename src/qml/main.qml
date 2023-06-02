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
                spacing: 0
                anchors.fill:parent
                SideBar {
                    id: sidebar
                    onSidebarButtonClicked: (index)=> {
                    stackLayout.currentIndex = index
                    console.log("lol index changed")
                }
            }

            StackLayout {
                id: stackLayout
                width: Layout.fillWidth
                height: parent.height

                Rectangle {
                    color: "lightgray"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                SettingsPage {
                    id: settingsPage
                    onSwitchToggledSignal: (state) => isLightTheme = !state
                }
            }
        }
    }
