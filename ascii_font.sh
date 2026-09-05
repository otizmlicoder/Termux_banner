#!/data/data/com.termux/files/usr/bin/bash
# =============================================================
#  ASCII Font Kütüphanesi
#  Girilen metni 5 satırlık blok harflere çevirir.
#  A-Z, 0-9 ve boşluk destekler. Harici pakete gerek yoktur.
# =============================================================

declare -A FONT

FONT[A]=".███.;█...█;█████;█...█;█...█"
FONT[B]="████.;█...█;████.;█...█;████."
FONT[C]=".████;█....;█....;█....;.████"
FONT[D]="████.;█...█;█...█;█...█;████."
FONT[E]="█████;█....;████.;█....;█████"
FONT[F]="█████;█....;████.;█....;█...."
FONT[G]=".████;█....;█..██;█...█;.████"
FONT[H]="█...█;█...█;█████;█...█;█...█"
FONT[I]="█████;..█..;..█..;..█..;█████"
FONT[J]="█████;...█.;...█.;█..█.;.██.."
FONT[K]="█...█;█..█.;███..;█..█.;█...█"
FONT[L]="█....;█....;█....;█....;█████"
FONT[M]="█...█;██.██;█.█.█;█...█;█...█"
FONT[N]="█...█;██..█;█.█.█;█..██;█...█"
FONT[O]=".███.;█...█;█...█;█...█;.███."
FONT[P]="████.;█...█;████.;█....;█...."
FONT[Q]=".███.;█...█;█.█.█;█..██;.████"
FONT[R]="████.;█...█;████.;█..█.;█...█"
FONT[S]=".████;█....;.███.;....█;████."
FONT[T]="█████;..█..;..█..;..█..;..█.."
FONT[U]="█...█;█...█;█...█;█...█;.███."
FONT[V]="█...█;█...█;█...█;.█.█.;..█.."
FONT[W]="█...█;█...█;█.█.█;██.██;█...█"
FONT[X]="█...█;.█.█.;..█..;.█.█.;█...█"
FONT[Y]="█...█;.█.█.;..█..;..█..;..█.."
FONT[Z]="█████;...█.;..█..;.█...;█████"

FONT[0]="█████;█...█;█...█;█...█;█████"
FONT[1]="..█..;.██..;..█..;..█..;█████"
FONT[2]="█████;....█;█████;█....;█████"
FONT[3]="█████;....█;█████;....█;█████"
FONT[4]="█...█;█...█;█████;....█;....█"
FONT[5]="█████;█....;█████;....█;█████"
FONT[6]="█████;█....;█████;█...█;█████"
FONT[7]="█████;....█;...█.;..█..;..█.."
FONT[8]="█████;█...█;█████;█...█;█████"
FONT[9]="█████;█...█;█████;....█;█████"

FONT[' ']="     ;     ;     ;     ;     "
FONT[-]="     ;     ;█████;     ;     "
FONT[_]="     ;     ;     ;     ;█████"
FONT[!]="..█..;..█..;..█..;.....;..█.."
FONT[.]="     ;     ;     ;     ;..█.."
FONT[?]=".███.;█...█;..██.;.....;..█.."

# render_ascii_text <metin> <renk_kodu>
# Girilen metni büyük harfe çevirip 5 satırlık blok harflerle ekrana basar.
render_ascii_text() {
    local input="$1"
    local color="${2:-\033[1;36m}"
    local reset='\033[0m'
    input=$(echo "$input" | tr 'a-z' 'A-Z')

    local row0="" row1="" row2="" row3="" row4=""
    local i ch data
    local l0 l1 l2 l3 l4

    for (( i=0; i<${#input}; i++ )); do
        ch="${input:$i:1}"
        data="${FONT[$ch]:-${FONT[' ']}}"
        IFS=';' read -r l0 l1 l2 l3 l4 <<< "$data"
        row0+="${l0} "
        row1+="${l1} "
        row2+="${l2} "
        row3+="${l3} "
        row4+="${l4} "
    done

    echo -e "${color}${row0}${reset}"
    echo -e "${color}${row1}${reset}"
    echo -e "${color}${row2}${reset}"
    echo -e "${color}${row3}${reset}"
    echo -e "${color}${row4}${reset}"
}

# =============================================================
#  Kalın/Pikselli Stil + İki Renkli Render (HIDDENEYE tarzı)
# =============================================================

# repeat_char <karakter> <sayı> -> karakteri N kez tekrarlar
_repeat_char() {
    local ch="$1"
    local count="$2"
    local out=""
    local i
    for (( i=0; i<count; i++ )); do
        out+="$ch"
    done
    printf '%s' "$out"
}

# render_big_text <metin> <scale> <renk1> <renk2>
# Metni büyük harfe çevirir, kalınlaştırır (scale kat), ilk kelimeyi renk1
# ikinci kelime/kelimeleri renk2 ile basar (tek kelimeyse hepsi renk1).
render_big_text() {
    local input="$1"
    local scale="${2:-2}"
    local color1="${3:-\033[1;36m}"
    local color2="${4:-\033[1;31m}"
    local reset='\033[0m'

    input=$(echo "$input" | tr 'a-z' 'A-Z')

    local first_word="${input%% *}"
    local first_len=${#first_word}
    local n=${#input}

    local row0="" row1="" row2="" row3="" row4=""
    local i ch data col
    local l0 l1 l2 l3 l4

    for (( i=0; i<n; i++ )); do
        ch="${input:$i:1}"
        data="${FONT[$ch]:-${FONT[' ']}}"
        IFS=';' read -r l0 l1 l2 l3 l4 <<< "$data"

        if (( i < first_len )); then
            col="$color1"
        else
            col="$color2"
        fi

        local out0="" out1="" out2="" out3="" out4=""
        local c cw
        for (( c=0; c<${#l0}; c++ )); do
            out0+="$(_repeat_char "${l0:$c:1}" "$scale")"
            out1+="$(_repeat_char "${l1:$c:1}" "$scale")"
            out2+="$(_repeat_char "${l2:$c:1}" "$scale")"
            out3+="$(_repeat_char "${l3:$c:1}" "$scale")"
            out4+="$(_repeat_char "${l4:$c:1}" "$scale")"
        done
        local gap
        gap="$(_repeat_char ' ' "$scale")"

        row0+="${col}${out0}${gap}"
        row1+="${col}${out1}${gap}"
        row2+="${col}${out2}${gap}"
        row3+="${col}${out3}${gap}"
        row4+="${col}${out4}${gap}"
    done

    local r
    for r in "$row0" "$row1" "$row2" "$row3" "$row4"; do
        local v
        for (( v=0; v<scale; v++ )); do
            echo -e "${r}${reset}"
        done
    done
}
