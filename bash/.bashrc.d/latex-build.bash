function onetex {
    if [ "$1" != "" ]
    then
        filename=$1
    else
        filename=main
    fi
    pdflatex $filename
    bibtex $filename
    pdflatex $filename
    pdflatex $filename
}
