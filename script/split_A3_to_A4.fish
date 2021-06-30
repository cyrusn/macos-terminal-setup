#!/usr/bin/env fish

set files (ls *.pdf)
rm -rf ./output
mkdir ./output

# using identify to find the geometry of the image, e.g. identify filename.png
# use 1190x841 as an example
# use +repage to completely remove/reset the virtual canvas meta-data from the images.

for file in $files

  set filename $file
  set rootname (echo $filename | sed 's/\.[^.]*$//')

  rm -rf ./tmp
  mkdir tmp
  convert "$filename" ./tmp/tmp%03d.png
  
  cd tmp

  set tmpFiles (ls tmp*.png)
  set totalNo (count $tmpFiles)
  set width (math (identify -format "%w " $tmpFiles[1]) / 2)
  set height (identify -format "%h " $tmpFiles[1])

  for i in (seq (count $tmpFiles))
    if test (math $i % 2) -eq 0
      set pageNo (math (math $totalNo - (math $i)) / 2 )
    else 
      set ceil (math $totalNo / 2 )
      set pageNo (math "ceil($ceil)" + (math $i / 2))
    end
    set paddedPageNo (string pad --char 0 -w 3 $pageNo)
    mv $tmpFiles[$i] rearranged$paddedPageNo.png
  end

  cd ../

  mkdir ./tmp/output
  
  convert ./tmp/rearranged*.png -crop "$width"x"$height"+"$width"+0 +repage ./tmp/output/odd%03d.png
  convert ./tmp/rearranged*.png -crop "$width"x"$height"+0+0 +repage ./tmp/output/even%03d.png
  
  # rm ./tmp/*.png
  cd ./tmp/output
  
  set oddPages (ls odd*.png)
  for i in (seq (count $oddPages))
    set index (math (math $i) x 2)
    set pIndex (string pad --char 0 -w 3 $index)
    mv $oddPages[$i] $pIndex.png
  end 

  set evenPages (ls even*.png)
  set i 0
  for evenPage in $evenPages
    set index (math (math $totalNo - $i) x 2 + 1 )
    set pIndex (string pad --char 0 -w 3 $index)
    mv $evenPage $pIndex.png
    set i (math $i + 1)
  end 

  cd ../..

  convert ./tmp/output/*.png ./output/"$rootname"_result.pdf
  rm -rf ./tmp
  echo ./output/"$rootname"_result.pdf is ready.

end