import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12

Button {
    property string buttonText: "" // Define a custom property for the button's text

    id: coloredButton

    text: buttonText
    highlighted: true
    Material.accent: Material.Red
    onClicked: {
        // Use the imported ColorProvider component to set the label's color
        leftlabel.color = con.getColor(buttonText)
    }
}