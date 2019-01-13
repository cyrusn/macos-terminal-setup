echo "installing npm global packages..."
while read -r line; do
    npm install -g "$line"
done < "npm_global_packages.txt"