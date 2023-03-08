`dirname $0`/get_audio_metadata.sh | zscroll -l 31 -d 0.3 \
        -M "`dirname $0`/get_audio_status.sh" \
        -m "Paused" " --scroll 0" \
        -m "Playing" " --scroll 1" \
        -u true "`dirname $0`/get_audio_metadata.sh" \

wait
