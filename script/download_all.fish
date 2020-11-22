set links (cat $argv[1] | jq -r '.[]')

cdh jpg 

for link in $links
  echo $link
  echo $link >> ../log
  set settings (curl -sL $link | pup 'head meta json{}'| jq -r '.[] | select(.property =="og:title" or .property =="og:image") | .content')

  set name $settings[1]
  set src (echo $settings[2] | sed -e 's/p[0-9]*.jpg//')
  
  mkdir $name
  cdh $name

  set n 1
  set ok "p1.jpg"
  while test -n "$ok"
    curl -sSfO "$src"p"$n".jpg ^/dev/null
    set ok (ls p"$n".jpg ^/dev/null)
    set n (math $n + 1)
  end
  cdh ../
end
echo Misson complete