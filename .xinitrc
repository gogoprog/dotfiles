xrandr --output eDP1 --brightness 0.8 
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap uscode
setxkbmap -option ctrl:nocaps
xmodmap ~/.xmodmap
xbindkeys
numlockx &
exec awesome
#exec startlxde

