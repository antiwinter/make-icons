#!/bin/bash

if [ -z "$1" ]; then
    echo "./make-icons.sh xxx.svg"
    exit
fi

FILE=`basename $1 .svg`

mkdir -p icons

# for Win
echo "generating for Windows..."
magick convert -density 384 $1 -define icon:auto-resize icons/icon.ico

# for MacOS
echo "generating for MacOS..."
mkdir macos.iconset
for i in 16 32 128 256 512; do
   magick convert $1 -resize ${i}x${i} macos.iconset/icon_${i}x${i}.png
   magick convert $1 -resize $((i*2))x$((i*2)) macos.iconset/icon_${i}x${i}@2x.png
done
iconutil -c icns macos.iconset/
mv macos.icns icons/icon.icns
magick convert $1 -resize 256x256 icons/256x256.png
cp $1 icons/icon.svg
rm -rf macos.iconset
echo "done! (find the icons in ./icons)"
 
