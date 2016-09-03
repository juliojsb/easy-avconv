#!/bin/bash
#
# Author        :Julio Sanz
# Website       :www.elarraydejota.com
# Email         :juliojosesb@gmail.com
# Tested in     :Debian Wheezy/Jessie
# Description   :Script to make easier the recording of video/audio with avconv
# Dependencies  :pulseaudio, libav-tools
# Usage         :./avconv_recording.sh [recording_filename] [format]
# License       :GPLv3
#

#
# VARIABLES
#

format="$2"
# You can get a list of available resolutions in your desktop with "xrandr" command
resolution=$(xrandr | awk -F "current" '{print $2}' | head -1 | cut -d "," -f1 | tr -d " ")
# input_audio can change depending on the system, check "pactl" command for the right output device
# that needs to be redirected as input for avconv
input_audio="alsa_output.pci-0000_00_1b.0.analog-stereo.monitor"
video_framerate="60"
video_folder="recorded_video"
audio_folder="recorded_audio"
recording_file="$1_$(date +%Y%m%d%S).${format}"
display=":0.0"

#
# FUNCTIONS
#

record_mp4(){
	avconv -f pulse \
		-i $input_audio \
		-f x11grab \
		-r $video_framerate \
		-s $resolution \
		-i $display \
		-vcodec libx264 \
		-preset ultrafast \
		-threads 4 \
		-strict experimental \
		-y $video_folder/$recording_file
}

record_mp3(){
	avconv -f alsa \
		-ac 2 \
		-ar 48000 \
		-f pulse \
		-i $input_audio \
		-acodec libmp3lame \
		-aq 0 \
		-y $audio_folder/$recording_file
}

record_ogg(){
	avconv -f alsa \
		-ac 2 \
		-ar 48000 \
		-f pulse \
		-i $input_audio \
		-acodec libvorbis \
		-aq 6 \
		-y $audio_folder/$recording_file
}

how_to_use(){
	echo "This is not the way this script is meant to work"
	echo "It needs two parameters:"
	echo "./avconv_recording.sh [ recording_filename ] [ format ]"
	echo "Format can be mp3,mp4 or ogg"
}

#
# MAIN
# 

if [ $# -ne 2 ];then
	how_to_use
else
	case $format in
		"mp4") record_mp4 ;;
		"mp3") record_mp3 ;;
		"ogg") record_ogg ;;
		*) how_to_use ;;
	esac
fi
