function convert_A3_to_A4 -d="transform A3 exam paper to A4. "
    _check_imagick

    set -l options (fish_opt -s d -l dpi --required-val)
    set options $options (fish_opt -s r -l reverse)
    set options $options (fish_opt -s h -l help)

    argparse --name="convert_A3_to_A4" $options -- $argv
    or return

    if set -q _flag_help
        _convert_A3_to_A4_help
        return
    end

    set -q _flag_dpi; or set _flag_dpi 200
    set dpi $_flag_dpi

    rm -rf ./output
    mkdir ./output

    if ! count $argv >/dev/null
        echo "PDFs files are required as an argument." >&2
        return
    end

    # using identify to find the geometry of the image, e.g. identify filename.png
    # use +repage to completely remove/reset the virtual canvas meta-data from the images.

    for file in $argv
        echo converting $file ...

        set filename $file
        set rootname (echo $filename | sed 's/\.[^.]*$//')

        rm -rf ./tmp
        mkdir tmp

        # split each pages in pdf to png
        convert -density $dpi "$filename" -strip ./tmp/tmp%03d.png

        cd tmp

        # sort the png with page number
        set tmpFiles (ls tmp*.png)
        set totalNo (count $tmpFiles)

        # read the width and height of the image
        set width (math (identify -format "%w " $tmpFiles[1]) / 2)
        set height (identify -format "%h " $tmpFiles[1])

        # re-order pages
        for i in (seq (count $tmpFiles))
            if test (math $i % 2) -ne 0
                set pageNo (math "($i + 1) / 2")
            else
                set pageNo (math "$totalNo + 1 - $i / 2")
            end
            set paddedPageNo (string pad --char 0 -w 3 $pageNo)
            mv $tmpFiles[$i] rearranged$paddedPageNo.png
        end

        cd ../
        rm -rf ./tmp/output
        mkdir ./tmp/output

        # crop the png to right and left page
        convert ./tmp/rearranged*.png -crop "$width"x"$height"+"$width"+0 +repage ./tmp/output/right%03d.png
        convert ./tmp/rearranged*.png -crop "$width"x"$height"+0+0 +repage ./tmp/output/left%03d.png

        cd ./tmp/output

        # merge right number page and left page together
        set rightPages (ls right*.png)
        for i in (seq (count $rightPages))
            set -l index (math "$i x 2 - 1")
            _rename $rightPages[$i] $index
        end

        set leftPages (ls left*.png)
        for i in (seq (count $leftPages))
            set index (math "($totalNo - $i + 1) x 2 ")
            _rename $leftPages[$i] $index
        end

        # reverse order
        if set -q _flag_reverse
            echo 'reversing pages'

            set -l pngs (ls *.png)
            set -l noOfFile (count $pngs)
            for i in (seq $noOfFile)
                set newIndex (string pad --char 0 -w 3 (math "$noOfFile - $i + 1"))
                mv $pngs[$i] r$newIndex.png
            end

            echo reversed
        end

        cd ../..

        # combine the png to a pdf
        convert ./tmp/output/*.png ./output/"$rootname"_result.pdf
        rm -rf ./tmp
        echo "$rootname"_result.pdf is ready.
    end
end

function _rename
    set index (string pad --char 0 -w 3 $argv[2])
    mv $argv[1] $index.png
end


function _convert_A3_to_A4_help
    echo "Convert A3 to A4"
    echo ""
    echo "This script is to transform scanned folded A3 paper to A4 PDF."
    echo "User should scan the paper with the page 1 first, otherwise use option [r/reverse]"
    echo ""
    echo "Usage: convert_A3_to_A4 files [Options]"
    echo ""
    echo "Options:"
    echo "    -d, --dpi          The dpi value for the converted file. default 200"
    echo "    -r, --reverse      Reverse the scan order"
    echo ""
    echo "Version: 1.0.0"
end
