if [ $# -eq 1 ]
then
  DOCUMENT_NAME=$1
else
  DOCUMENT_NAME=CV_FULL
fi
echo "pdflatex $DOCUMENT_NAME backend=bibtex"
pdflatex $DOCUMENT_NAME
if [ $? -eq 0 ]; then
  citation=$(cat $DOCUMENT_NAME.aux | grep '\citation')
  bibdata=$(cat $DOCUMENT_NAME.aux | grep '\bibdata')
  bibstyle=$(cat $DOCUMENT_NAME.aux | grep '\bibstyle')
  bibtexneeded=0
  if [ -n "$citation" ]; then
    echo "Citation: "$citation
    bibtexneeded=1
  fi
  if [ -n "$bibdata" ]; then
    echo "Bibdata: "$bibdata
    bibtexneeded=2
  fi
  if [ $bibtexneeded -gt 0  ]; then
    echo $bibtexneeded
    echo "bibtex $DOCUMENT_NAME"
    bibtex $DOCUMENT_NAME
    if [ $? -eq 0 ]; then
      echo "pdflatex $DOCUMENT_NAME"
      pdflatex $DOCUMENT_NAME
      if [ $? -eq 0 ]; then
        echo "pdflatex $DOCUMENT_NAME"
        pdflatex $DOCUMENT_NAME
      else
        exit $?
      fi
    else
      exit $?
    fi
  fi
else
  exit $?
fi
open $DOCUMENT_NAME.pdf
