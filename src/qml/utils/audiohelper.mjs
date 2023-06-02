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