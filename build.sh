#!/bin/sh
# Wraps portfolio.html (the artifact source, which has no <html>/<head> of its own)
# into a standalone index.html you can host anywhere.
set -e
cd "$(dirname "$0")"
site="https://logic-abhijith.github.io/"
desc=$(sed -n 's/.*<meta name="description" content="\([^"]*\)".*/\1/p' portfolio.html)
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top);padding-bottom:env(safe-area-inset-bottom)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '<link rel="icon" href="favicon.svg" type="image/svg+xml">\n'
  printf '<meta name="theme-color" content="#0c120f">\n'
  printf '<link rel="canonical" href="%s">\n' "$site"
  printf '<meta property="og:type" content="website">\n<meta property="og:url" content="%s">\n' "$site"
  printf '<meta property="og:title" content="Abhijith S">\n<meta property="og:description" content="%s">\n' "$desc"
  sed '/<!-- \/head -->/,$d' portfolio.html
  printf '</head>\n<body>\n'
  sed '1,/<!-- \/head -->/d' portfolio.html
  printf '</body>\n</html>\n'
} > index.html
echo "wrote $(pwd)/index.html"
