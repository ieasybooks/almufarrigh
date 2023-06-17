//TODO need further validation 
    //what if it's a valid string but the video doesn't exist
export function isYoutubeLink(text) {
    // Perform further actions with the clipboard text
    console.log("Clipboard text changed:", text)
    let youtubeUrlRegex = /^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$/
    if (!youtubeUrlRegex.test(text)) {
        return
    }
    return true
}

export function extractTextIdentifier(text) {
    if (isYoutubeLink(text))
        return text
    else
        return text.substring(text.lastIndexOf("/") + 1)
}

export function getFileIcon(file) {
    var videoExtensions = ["mp4", "mov", "avi", "mkv"];
    var audioExtensions = ["mp3", "wav", "ogg", "m4a"];
    var extension = file.substring(file.lastIndexOf(".") + 1).toLowerCase()

    if (videoExtensions.includes(extension))
        return "qrc:/video"
    else if (audioExtensions.includes(extension))
        return "qrc:/audio"
    else
        return "qrc:/link"
}
