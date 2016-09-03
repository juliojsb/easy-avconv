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

avconv -i "$1" -c copy $currentfolder/../converted/"$justfilename".mp4
