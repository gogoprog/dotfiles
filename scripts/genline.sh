for f in *.hx
do
    f="${f%.*}"
    ff="$(tr '[:upper:]' '[:lower:]' <<< ${f:0:1})${f:1}"
    echo "format.swf.lite.SWFLite.classes.set(\"graphics_fla.$ff\", $f);"
done
