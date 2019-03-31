echo "installing npm global packages..."
while read -r line; do
    npm install -g "$line"
done < "apps/npm_global_packages.txt"