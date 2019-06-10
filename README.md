This script patches the default Tales Of Androgyny Android application with the wonderful Jorja's RedHead Mod (or any other graphical overhaul)
___
To do this you will need:
* a working GNU/Linux OS (may work on Mac too)
* the default Tales Of Androgyny apk
* Jorja's .jar file (possibly of the same version)

And you also need to have installed:
* unzip
* apktool
* [apk-signer](https://github.com/beevelop/apk-signer)
* zipalign (included in android-sdk-build-tools)
* image-magick
___
To use the script:
* `git clone https://github.com/sKrTtR/TOA_Android_RedHead_patcher`
* `cd /path/to/the/script/directory`
* `chmod +x TOA_Android_RedHead_patcher.sh`
* `./TOA_Android_ReadHead_patcher.sh /path/to/the/file.apk /path/to/the/file.jar`

This will produce a working apk with Jorja's mod.
___
Also:
* If you don't desire to use the custom fonts included with the mod, just set `patch_fonts="yes"` to `no` at the very beginning of the script.
* It is necessary to uninstall the default TOA application before installing the patched one since the signature as been modified.
* Google Play will probably give a warning while trying to install but that can be ignored.



