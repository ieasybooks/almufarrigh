import QtQuick.Dialogs

MessageDialog {
    id: pasteConfirmationDialog

    property url urlStr

    signal pasteConfirmed()

    function openWithUrl(_url) {
        urlStr = _url;
        text = qsTr("Do you want to paste the following YouTube URL?\n") + "\n" + _url;
        open();
    }

    title: qsTr("Paste Confirmation")
    buttons: MessageDialog.Ok | MessageDialog.Cancel
    text: qsTr("Do you want to paste the text?")
    onAccepted: {
        // User clicked "Yes" button
        console.log("User clicked 'Yes'");
        // Emit a signal to indicate the user wants to paste the text
        pasteConfirmed();
    }
    onRejected: {
        // User clicked "No" button
        console.log("User clicked 'No'");
        // Emit a signal to indicate the user doesn't want to paste the text
        pasteRejectedSignal();
    }
}
