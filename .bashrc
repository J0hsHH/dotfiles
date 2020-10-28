alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vimr="open /Applications/VimR.app"
alias starwars="telnet towel.blinkenlights.nl"
alias browser="open /Applications/Firefox.app"
alias irc="Irssi"
alias whether="curl http://wttr.in/"
alias myip="curl -s ifconfig.me | shuf"
alias rr="curl -L http://bit.ly/10hA8iC | bash"
alias cheat="curl cheat.sh/"
alias bitcoin="curl rate.sx"
alias parrot="curl parrot.live"
alias mutt="neomutt"
alias email="neomutt"
alias map="telnet mapscii.me"
alias mpvt=" mpv --no-config --vo=tct"
alias vuln="nmap --script vuln"
alias v="nmap --script vuln"
alias cmatrix="cmatrix -Bas -C cyan"
alias sayhelp="say -v '?'"
alias say="say -v Alex --interactive=/blue"
alias vimconfig="vim ~/.vimrc"
alias bp="cd /Users/04johhov/scripts/ ; ./booksplit.sh"
alias nrk1="mpv https://tv.nrk.no/direkte/nrk1"
alias nrk2="mpv https://tv.nrk.no/direkte/nrk2"
alias nrk3="mpv https://tv.nrk.no/direkte/nrk3"
alias bbcnews="mpv https://www.bbc.com/news/av/10462520"
alias neofetch="neofetch  --ascii_distro windows10"
alias kveldsnytt="mpv https://tv.nrk.no/serie/kveldsnytt"
alias 21="mpv https://tv.nrk.no/serie/dagsrevyen-21"
alias dagsrevyen="mpv https://tv.nrk.no/serie/dagsrevyen"
alias covid-19="curl -L covid19.trackercli.com/norway"
alias edit="open -a TextEdit"
alias vimrconfig="vim .config/nvim/init.vim .vimrc"
#alias 1=""

uke() {
      curl --silent http://hvilkenuke.no/ | grep '<font style="font-size: 120px">' | sed 's/<font style="font-size: 120px">//g'
}



# bp made bye luke smith
bp() {
#!/bin/sh

# Requires ffmpeg (audio splitting) and my `tag` wrapper script.

[ ! -f "$2" ] && printf "The first file should be the audio, the second should be the timecodes.\\n" && exit

echo "Enter the album/book title:"; read -r booktitle

echo "Enter the artist/author:"; read -r author

echo "Enter the publication year:"; read -r year

inputaudio="$1"

# Get a safe file name from the book.
escbook="$(echo "$booktitle" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed "s/-\+/-/g;s/\(^-\|-\$\)//g")"

! mkdir -p "$escbook" && echo "Do you have write access in this directory?" && exit 1

# As long as the extension is in the tag script, it'll work.
ext="opus"
#ext="${1#*.}"

# Get the total number of tracks from the number of lines.
total="$(wc -l < "$2")"

while read -r x;
do
	end="$(echo "$x" | cut -d' ' -f1)"

	[ -n "$start" ] &&
	echo "From $start to $end; $track $title"
	file="$escbook/$(printf "%.2d" "$track")-$esctitle.$ext"
	[ -n "$start" ] && echo "Splitting \"$title\"..." &&
   	ffmpeg -nostdin -y -loglevel -8 -i "$inputaudio" -ss "$start" -to "$end" -vn -c copy "$file" &&
	echo "Tagging \"$title\"..." && tag -a "$author" -A "$booktitle" -t "$title" -n "$track" -N "$total" -d "$year" "$file"
	title="$(echo "$x" | cut -d' ' -f 2-)"
	esctitle="$(echo "$title" | iconv -cf UTF-8 -t ASCII//TRANSLIT | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed "s/-\+/-/g;s/\(^-\|-\$\)//g")"
	track="$((track+1))"
	start="$end"
done < "$2"
# The last track must be done outside the loop.
echo "From $start to the end: $title"
file="$escbook/$(printf "%.2d" "$track")-$esctitle.$ext"
echo "Splitting \"$title\"..." && ffmpeg -nostdin -y -loglevel -8 -i "$inputaudio" -ss "$start" -vn -c copy "$file" &&
		echo "Tagging \"$title\"..." && tag -a "$author" -A "$booktitle" -t "$title" -n "$track" -N "$total" -d "$year" "$file"
}
