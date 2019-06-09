#!/bin/bash

#set this to "no" to use the default font instead
patch_fonts="yes" 	


usage() {
	cat <<EOF
usage: 
        ./TOA_Android_RedHead_patcher.sh [path/to/file.apk] [path/to/file.jar]
EOF
}


#check if dependencies are installed
deps=('unzip' 'apktool' 'apk-signer' 'zipalign' 'magick' 'base64')
for i in "${deps[@]}"; do
	if command -v $i >/dev/null; then
		:
	else 
		echo "$i not found"
		exit 1
	fi
done


#check if parameters have been passed, if not print the help and exit
if [[ -z $1 ]] || [[ -z $2 ]]; then
	usage
	exit 1
fi


#check if parameters are correct and are files
if [[ -f $1 ]] && [[ -f $2 ]]; then
	apk_path="$1"
	jar_path="$2"
else 
	echo "$1 and $2 are not correct"
	exit 1
fi


#create a directory for the extracted files
main_dir="TOA_patched"
mkdir -p $main_dir


#extract the files
folder_apk="$main_dir/toa_apk_extracted"
folder_jar="$main_dir/toa_jar_extracted"
mkdir -p  "$folder_jar"
unzip "$jar_path" -d "$folder_jar"
apktool decode "$apk_path" -o "$folder_apk"


#change the default icon
icons=( 'res/mipmap-hdpi/toa_launcher.png' 
	'res/mipmap-mdpi/toa_launcher.png' 
	'res/mipmap-xhdpi/toa_launcher.png' 
	'res/mipmap-xxhdpi/toa_launcher.png' 
	'assets/icon16.png' 
	'assets/icon32.png' 
	'assets/icon128.png')
	
	
for i in "${icons[@]}"; do
	icon_path="$folder_apk/$i"
	if [[ -f $icon_path ]]; then
		convert\
		$icon_path\
		-channel R -gamma 1.5\
		-channel B -gamma 1.2\
		-channel G -gamma 0\
		-channel RGB -brightness-contrast 7x10\
		$icon_path
		echo "$icon_path changed"
	fi
done


#move the files between folders
while read -r filename; do
	if [[ -e "$folder_jar/$filename" ]]; then
		rm "$folder_apk/assets/$filename"
		cp "$folder_jar/$filename" "$folder_apk/assets/$filename" 
	fi
done <<< $(cd $folder_apk/assets/; find * -type f | grep '.png\|.jpg' | grep -v "ArgosGeorge.png\|Bevan.png")


#moving fonts manually
if [[ $patch_fonts == "yes" ]]; then
	font_files=( 	'ui/ArgosGeorge.fnt' 
			'ui/ArgosGeorge.png' 
			'ui/ArgosGeorge.ttf' 
			'battle/ui/Bevan.fnt' 
			'battle/ui/Bevan.png')

	for i in "${font_files[@]}"; do
		font_path_apk="$folder_apk/assets/$i"
		font_path_jar="$folder_jar/$i"
		if [[ -f "$font_path_apk" ]]; then
			rm "$font_path_apk"
		fi
		if [[ -f "$font_path_jar" ]]; then
			cp -v "$font_path_jar" "$font_path_apk"
		fi
	done
fi


#now rebuild the apk
rebuilt_apk="$main_dir/unsigned_apk.apk"
apktool build "$folder_apk" -o "$rebuilt_apk"


#recreate the keystore
keystore_txt="$main_dir/skrttr_key.txt"
keystore="$main_dir/skrttr_key.keystore"
echo "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" > $keystore_txt

base64 -d < "$keystore_txt" > "$keystore"


#sign the apk
apk_signed="$main_dir/Tales_of_Androgyny_RedHead_Android.apk"
apk-signer -f "$rebuilt_apk" -a "skrttrkey" -k "$keystore" -s "xyzfoobarxyz" -o "$apk_signed"


#clean leftover files
rm -r "$keystore" "$keystore_txt" "$rebuilt_apk" "$folder_apk" "$folder_jar"





