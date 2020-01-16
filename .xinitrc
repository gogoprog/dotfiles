xrandr --auto
[[ -f ~/.screenlayout/default.sh ]] && .screenlayout/default.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap uscode
setxkbmap -option ctrl:nocaps
xmodmap ~/.xmodmap
xbindkeys
numlockx &
serve-code &
exec awesome
