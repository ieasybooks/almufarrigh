import QtQuick 6.4
import QtQuick.Controls 6.4

Item {
    id: progressBar
    property int value: 0
    property int labelValue
    property int animationDuration: 1000
    property color foregroundColor: "#2196F3"
    property color backgroundColor: "#d1d1d1"

    width: 256
    height: 256

    onValueChanged: {
        canvas.degree = value;
        labelValue = value;
    }

    Canvas {
        id: canvas
        antialiasing: true
        anchors.fill: parent
        property int degree: 0

        onDegreeChanged: {
            requestPaint();
        }

        onPaint: {
            const centerX = width / 2;
            const centerY = height / 2;
            const radius = Math.min(width, height) * 0.4;
            const startAngle = -90; // Start angle at the top (-90 degrees)
            const endAngle = startAngle + (degree / 100) * 360; // Calculate the end angle based on progress
            const ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height); // Clear the canvas

            // Draw the background circle
            ctx.strokeStyle = progressBar.backgroundColor;
            ctx.lineWidth = 20;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.stroke();

            // Draw the progress circle
            ctx.strokeStyle = progressBar.foregroundColor;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle * Math.PI / 180, endAngle * Math.PI / 180);
            ctx.stroke();
        }

        Behavior on degree  {
            NumberAnimation {
                duration: progressBar.animationDuration
            }
        }
    }

    Row {
        anchors.centerIn: parent
        Text {
            text: progressBar.labelValue
            font.pixelSize: 64
            color: theme.fontSecondary
            font.bold: true
        }

        Text {
            text: "%"
            font.pixelSize: 64
            color: theme.fontThirty
            font.bold: true
        }
    }

    Behavior on labelValue  {
        NumberAnimation {
            duration: progressBar.animationDuration
        }
    }
}
