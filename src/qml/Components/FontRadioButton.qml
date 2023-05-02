
import QtQuick 2.0
import QtQuick.Controls 2.12

RadioButton {
    property string fontStyle: "" // Define a custom property for the button's text

    id: bold
    text: fontStyle
    function updateFontStyle(styleText) {
    leftlabel.font.italic = con.getItalic(styleText)
    leftlabel.font.bold = con.getBold(styleText)
    leftlabel.font.underline = con.getUnderline(styleText)
}
    onToggled: updateFontStyle(bold.text)

}