function download_yt_audio --description 'Download audio from Youtube and output to ~/Music' 

    set video_url (gum input --placeholder "URL of Youtube video")

    # Check if a URL was entered
    if test -z "$video_url"
        echo "No URL entered. Aborting."
        return 1
    end

    # Run the yt-dlp command to download the audio
    yt-dlp -f "bestaudio/best" --extract-audio --audio-format best --embed-thumbnail --output "~/Music/%(title)s.%(ext)s" $video_url

    # Check if the command succeeded
    if test $status -eq 0
        echo "Download completed successfully! File saved to ~/Music."
    else
        echo "Download failed. Please check the URL and try again."
    end
end
