import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    color: mainWindow.theme.primary
                signal sidebarButtonClicked(int index)
            width: 80
            height:1000

    ColumnLayout {
        spacing: 20

        
        Image {
            source: "../resources/Logo.png"
            Layout.maximumWidth: 79
            Layout.maximumHeight: 79
            Layout.topMargin: 10
        }
    

        Item {
            id: spacer
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 450
        }

        Image {
            source: "../resources/Resize.png"
            Layout.alignment:Qt.AlignHCenter

            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (mainWindow.visibility !== Window.Maximized) {
                                mainWindow.visibility = Window.Maximized
                            } else {
                                mainWindow.width = 1024
                                mainWindow.height = 1024
                            }
                            controller.resize()
                        }

            }
        }


        Image {
            source: "../resources/Open.png"

            Layout.alignment:Qt.AlignHCenter

            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sidebarButtonClicked(0)

            }
        }
        
        Image {
            source: "../resources/Settings.png"

            Layout.alignment:Qt.AlignHCenter

            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sidebarButtonClicked(1)

            }
        }
        
        Image {
            source: "../resources/Power.png"

            Layout.alignment:Qt.AlignHCenter

            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.quit()

            }
        }
    
    }

}