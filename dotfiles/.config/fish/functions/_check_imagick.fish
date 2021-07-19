function _check_imagick
    if ! type -f convert >/dev/null
        echo "Please install imagick before using this function" >&2
        echo "Ref: https://imagemagick.org/index.php" >&2
        return
    end
end
