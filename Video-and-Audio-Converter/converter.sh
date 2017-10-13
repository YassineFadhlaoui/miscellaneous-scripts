echo "**********************************************************"
echo "*                                                        *"
echo "*                   Shell Video Converter                *"
echo "*                                                        *"
echo "**********************************************************"
echo "____________________(c) Yassine Fadhlaoui__________________"
test -d "$1"
case "$?" in
  *0*) echo "entering source directory"
      cd "$1"
      echo "do you like to convert all files in this directory (y/one/n) ?"
      read answer
      case $answer in
        *y|yes*) echo "All files in this directory will be renamed(original name without spaces)"
              echo "to which format you want to convert your files (mp3,mp4,mkv,avi...) ?"
              read format
              for file in *;do
                test -f "$file"
                case "$?" in
                  *0*) echo "converting $file"
                       mv "$file" "${file//[[:space:]]}"
                       new="${file//[[:space:]]}".$format
                       ffmpeg -stats -v 0 -i "${file//[[:space:]]}" "$new";;
                  *) echo "$file is a directory";;
                esac
              done;;
        *one*) echo "You want to convert one file ?"
               echo "Type the file name"
               read name
               echo "type a format (mp3,mp4...)"
               read format
               test -f "$name"
               case "$?" in
                 *0*) echo "converting $file"
                      mv "$name" "${name//[[:space:]]}"
                      new="${name//[[:space:]]}".$format
                      ffmpeg -stats -v 0 -i "${name//[[:space:]]}" "$new";;
                 *) echo "$name is a directory";;
               esac;;
        *) echo "operation will be abroted" ;;
      esac ;;
  *) echo "$1 is not a valid directory" ;;
esac
echo "********************(c)YassineFadhlaoui****************************"
