function split_pdf -a pdf -d "split a PDF file"
    set -l options (fish_opt -s n -l noOfPages --required-val)
    set options $options (fish_opt -s l -l list --required-val)
    set options $options (fish_opt -s d -l dpi --required-val)
    set options $options (fish_opt -s h -l help)

    argparse --name="split_pdf" $options -- $argv
    or return

    if set -q _flag_help
        _split_pdf_with_name_help
        return
    end

    if ! test -e "$pdf"
        echo "A path of a PDF file is required as an argument."
        return
    end

    if ! type -f convert >/dev/null
        echo "Please install imagick before using this function"
        echo "Ref: https://imagemagick.org/index.php"
        return
    end



    set -q _flag_dpi; or set _flag_dpi 200
    set -q _flag_noOfPages; or set noOfPages 1
    set dpi $_flag_dpi
    set noOfPages $_flag_noOfPages

    # split each pages in pdf to png
    _clean_up
    echo 'converting pdf ...'
    convert -density $dpi "$pdf" -strip ./tmp/tmp%03d.png

    if set -q _flag_list
        set list (cat $_flag_list)
    else
        set list (_no_list $noOfPages)
    end


    for i in (seq (count $list))
        set start (math "($i - 1) x $noOfPages")
        set last (math $start + $noOfPages - 1)
        set tempFiles (string pad -w 3 --char=0 (seq $start $last))

        set outputName (echo $list[$i].pdf)

        convert ./tmp/tmp$tempFiles.png ./output/$outputName
        echo $outputName is ready.
    end

    rm -rf ./tmp
end

function _split_pdf_with_name_help
    echo "Split PDF "
    echo "v1.0.0"
    echo ""
    echo "Split PDF splits a given PDF file by the no of page provided (default is 1)."
    echo "If users have the list of output filenames, use -l --list option."
    echo ""
    echo "Usage: split_pdf file [options]"
    echo ""
    echo "Options:"
    echo "    -n, --noOfPages    The number of page of each splited PDF. default 1"
    echo "    -l, --list         The path of a txt file which stores the output filenames."
    echo "                       If this option is omited, the output filename is `output_%3d.pdf`"
    echo "    -d, --dpi          The dpi value for the converted file. default 200"
end

function _clean_up
    rm -rf tmp output
    mkdir tmp output
end

function _no_list -a noOfPages -d="create a output file list"
    set totalPages (count ./tmp/tmp*.png)
    set noOfFile (math "floor($totalPages / $noOfPages)")
    for i in (seq $noOfFile)
        echo output_(string pad -w 3 --char=0 $i)
    end
end
