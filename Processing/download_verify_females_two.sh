###By Jaclyn Eissman, 2021

#!/bin/bash
cd /data/h_vmac/eissmajm/UKBB/females
while read line ; do
wget_command=`echo $line | cut -f3 -d","`
$wget_command &> /dev/null
if [[ "$?" != 0 ]]; then
echo $line,"Error" >> UKBB_Manifest_201807_females_two_updated.csv
else
echo $line,"Success" >> UKBB_Manifest_201807_females_two_updated.csv
fi
done < UKBB_Manifest_201807_females_two.csv
