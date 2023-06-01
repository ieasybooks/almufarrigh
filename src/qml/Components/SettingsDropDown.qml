import QtQuick 2.15
import QtQuick.Controls 

import "."
SettingsItem {
        //TODO instead of all this hustle extract into its own style 
        //TODO Look here https://doc.qt.io/qtforpython-6.2/overviews/qtquickcontrols-flatstyle-example.html#qt-quick-controls-flat-style
        
        ComboBox {
            id: combo
            font.family: poppinsFontLoader.font.family
            model: dropdownModel
            currentIndex: dropdownIndex
            background: Rectangle {
                    radius: 10
                    border.color: theme.stroke // Replace with your custom border color
                    border.width: 2
                    color: theme.background // Replace with your custom background color
                }
  
            
            delegate: ItemDelegate {
                    width: combo.width
                    contentItem: Text {
                        anchors.centerIn: parent
                        text: combo.textRole
                            ? (Array.isArray(combo.model) ? modelData[combo.textRole] : model[combo.textRole])
                            : modelData
                        color: theme.fontPrimary
                        // font: combo.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: combo.highlightedIndex === index
                }
            contentItem: Text {
                leftPadding: 0
                rightPadding: combo.indicator.width + combo.spacing

                text: combo.displayText
                font.family: "Poppins"
                font.pixelSize: 24
                color: combo.pressed ?   theme.fontSecondary : theme.fontPrimary
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            indicator: Canvas {
                id: canvas

                // x: combo.width - width - combo.leftPadding 
                x: combo.leftPadding + (combo.availableWidth - width) * (combo.LayoutMirroring.enabled ? 1 : 0)


                y: combo.topPadding + (combo.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: combo
                    function onPressedChanged() { canvas.requestPaint(); }
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    // context.lineTo(width, 0);
                    context.lineTo(width / 2, height - 1);  // Omit the bottom line
                    context.lineTo(width, 0);

                    // context.closePath();
                    context.strokeStyle = "black";
                    context.lineWidth = 1;
                    context.stroke();

                }
                            }
        }


        
    

        
        
    property ListModel dropdownModel: ListModel {}
    property int dropdownIndex: -1
}
