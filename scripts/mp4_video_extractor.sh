#!/bin/bash
#
# Author        :Julio Sanz
# Website       :www.elarraydejota.com
# Email         :juliojosesb@gmail.com
# Tested in     :Debian Wheezy/Jessie
# Description   :Format conversor
# Dependencies  :libav-tools
# License       :GPLv3
#

fullfilename=$(basename "$1")
justfilename="${fullfilename%.*}"
currentfolder=$(dirname $0)

avconv -i "$1" -vcodec libx264 -an -f mp4 $currentfolder/../converted/"$justfilename".mp4
