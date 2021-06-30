#!/usr/bin/env fish
# This script is to transform A3 exam paper to A4. 
# The middle pages are facing up while scan the exam paper

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
  # split each pages in pdf to png
  convert "$filename" ./tmp/tmp%03d.png
  
  cd tmp

  # sort the png with page number
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
  
  # crop the png to odd and even page
  convert ./tmp/rearranged*.png -crop "$width"x"$height"+"$width"+0 +repage ./tmp/output/odd%03d.png
  convert ./tmp/rearranged*.png -crop "$width"x"$height"+0+0 +repage ./tmp/output/even%03d.png
  
  cd ./tmp/output

  function movePage
    set pIndex (string pad --char 0 -w 3 $argv[2])
    mv $argv[1] $pIndex.png
  end
  
  # merge odd number page and even page together
  set oddPages (ls odd*.png)
  for i in (seq (count $oddPages))
    set index (math (math $i) x 2)
    movePage $oddPages[$i] $index
  end 

  set evenPages (ls even*.png)
  for i in (seq (count $evenPages))
    set index (math (math $totalNo - $i + 1) x 2 + 1 )
    movePage $evenPages[$i] $index
  end 

  cd ../..

  # combine the png to a pdf
  convert ./tmp/output/*.png ./output/"$rootname"_result.pdf
  rm -rf ./tmp
  echo ./output/"$rootname"_result.pdf is ready.

end