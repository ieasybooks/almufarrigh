import QtQuick 2.6
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12

import "Themes"
ApplicationWindow {

    width: 400
    height: 800
    visible: true
    color: "#CCCCCC"
    property bool isLightTheme: false
    property var theme: isLightTheme ? LightTheme : DarkTheme

    Column {
        spacing: 10
        padding: 10
        FontLoader {
            id: poppinsFontLoader
            source: "Fonts/Poppins-Regular.ttf" // Adjust the path to the correct location of the font file
            
        }
        Switch {
            id: themeSwitch
            text: "Dark/ Light"
            onToggled: {
                isLightTheme = themeSwitch.checked
                theme = isLightTheme ? LightTheme : DarkTheme
            }
        }
        Text {
            text: theme.theme_name
            font.family: 'Poppins'
            font.pointSize: 24
        }
        Rectangle {
            width: 100
            height: 30
            color: theme.primary
        }

        Text {
            text: "primary: " + theme.primary
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.background
        }

        Text {
            text: "background: " + theme.background
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.card
        }

        Text {
            text: "card: " + theme.card
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.stroke
        }

        Text {
            text: "stroke: " + theme.stroke
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.error
        }

        Text {
            text: "error: " + theme.error
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.fontPrimary
        }

        Text {
            text: "fontPrimary: " + theme.fontPrimary
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.fontSecondary
        }

        Text {
            text: "fontSecondary: " + theme.fontSecondary
        }

        Rectangle {
            width: 100
            height: 30
            color: theme.fontThirty
        }

        Text {
            text: "fontThirty: " + theme.fontThirty
        }
    }
}
