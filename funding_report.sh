COPI=$( grep note Co-I_Funding.bib | sed 's/note={\\\$//' | sed 's/}//' | sed 's/,//' | paste -sd+ - | bc )
PI=$( grep note PI_Funding.bib | sed 's/note={\\\$//' | sed 's/}//' | sed 's/,//' | paste -sd+ - | bc )
TOTAL=$(($PI+$COPI))
COPI_PRETTY=$( echo $COPI | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' )
PI_PRETTY=$( echo $PI | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' )
TOTAL_PRETTY=$( echo $TOTAL | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' )
echo "Co-PI: $COPI_PRETTY"
echo "PI: $PI_PRETTY"
echo "Total: $TOTAL_PRETTY" 
