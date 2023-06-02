import QtQuick.Dialogs
MessageDialog {
    id: pasteConfirmationDialog
    title: "Paste Confirmation"
    buttons: MessageDialog.Ok | MessageDialog.Cancel
    text: "Do you want to paste the text?"
    signal pasteConfirmed()
    property url urlStr
    function openWithUrl(_url) {
        urlStr = _url
        text = "Do you want to paste the following YouTube URL?\n" + _url
        open()
    }
    onAccepted: {
        // User clicked "Yes" button
        console.log("User clicked 'Yes'")
        // Emit a signal to indicate the user wants to paste the text
        pasteConfirmed()
    }
    
    onRejected: {
        // User clicked "No" button
        console.log("User clicked 'No'")
        // Emit a signal to indicate the user doesn't want to paste the text
        pasteRejectedSignal()
    }
}
