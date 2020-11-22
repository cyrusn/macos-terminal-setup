set files (ls ./jpg)
# set files log

for file in $files
  mv jpg/$file ./Done/ ^/dev/null
  if test $status -eq 0  
    convert ./Done/$file/*.jpg ./PDF/$file.pdf
    echo "converted file: "$file.pdf  
  end
end

echo "Mission completed"