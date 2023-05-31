import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Rectangle {
    color: mainWindow.theme.background
    ColumnLayout {
        width: parent.width / 1.1
        height: parent.height / 1.1
        anchors.centerIn: parent
            //top line border            
    Rectangle{
        Layout.fillWidth: true
        height: 1
        color: "black"
    }
        SettingsDropDown {
            iconSource: "../resources/Open.png"
            labelText: "Dropdown Component"
            dropdownModel: ListModel {
                ListElement { text: "Option 1" }
                ListElement { text: "Option 2" }
                ListElement { text: "Option 3" }
            }
            dropdownIndex: 0
        }
        SettingsDropDown {
            iconSource: "../resources/icon.png"
            labelText: "Dropdown Component"
            dropdownModel: ListModel {
                ListElement { text: "Option 1" }
                ListElement { text: "Option 2" }
                ListElement { text: "Option 3" }
            }
            dropdownIndex: 0
            Button{}
        }
    }
 

}