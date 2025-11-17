
#!/bin/bash
# by dejavudf/alexsandro farias - github.com/dejavudf
# version 1.0 17/11/2025
# calc md5 has on all files and folders - subtree
# debian/ubuntu/mint

#variables
VAR_DATE=$(date '+%Y_%m_%d_%H_%M_%S')

#script
find ./ -type f -name '*' -exec md5sum {} \; >> ./"$VAR_DATE""_md5.txt"

exit 0

