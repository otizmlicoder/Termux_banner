#!/data/data/com.termux/files/usr/bin/bash
# =============================================================
#  Hacker Logo Modülü
#  Orijinal, gradyan renkli (mor -> kırmızı) kurukafa ASCII art.
#  256 renk destekleyen terminallerde gradyan efekti verir.
# =============================================================

HACKER_ART=(
"               .:+oxkkOOOOkkxo+:.              "
"           .:oOXXXXXXXXXXXXXXXXXOo:.           "
"         :oOXXXXXXXXXXXXXXXXXXXXXXXOo:         "
"       :OXXXXXXXOxol:,,,,:loxOXXXXXXXXO:       "
"     :OXXXXXXOl,.              .,lOXXXXXXO:    "
"  lXXXXXXO,    .oOOOo.   .oOOOo.    ,OXXXXXXl  "
" oXXXXXXd    .OXXXXXXO. .OXXXXXXO.    dXXXXXXo "
"oXXXXXXd     OXXXXXXXX. OXXXXXXXX.     dXXXXXXo"
"kXXXXXk      'oOXXXXd'   'oOXXXXd'      kXXXXXk"
"kXXXXXk         ....         ....       kXXXXXk"
" oXXXXXXo      ,:'          ':,        oXXXXXXo"
"  oXXXXXXOl,      ':cccccc:'       ,lOXXXXXXo  "
"     lXXXXXXXXOxoc:,........,:coxOXXXXXXXXl    "
"       :OXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXO:      "
"         :OXXXXXXXXXXXXXXXXXXXXXXXXXXO:        "
"         .lOXXXX.  #XXXXXXXX#  .XXXXOl.        "
"           'lOXk.  '+kOOkk+'  .kXOl'           "
"              'lo,            ,ol'             "
"                ':.          .:'               "
)

# 256-renk gradyan paleti: mor/magenta'dan kırmızıya geçiş
HACKER_GRADIENT=(201 201 200 199 198 197 196 196 160 160 124 124 88 88 52 52 196 160 124)

# print_hacker_logo: kurukafayı satır satır gradyan renkte basar, ortalar
print_hacker_logo() {
    local reset='\033[0m'
    local i line color
    local total=${#HACKER_ART[@]}
    local termwidth pad

    termwidth=$(tput cols 2>/dev/null || echo 58)
    art_width=${#HACKER_ART[0]}
    pad=$(( (termwidth - art_width) / 2 ))
    (( pad < 0 )) && pad=0

    for (( i=0; i<total; i++ )); do
        line="${HACKER_ART[$i]}"
        color="${HACKER_GRADIENT[$i]:-196}"
        printf '%*s' "$pad" ''
        echo -e "\033[1;38;5;${color}m${line}${reset}"
    done
}
