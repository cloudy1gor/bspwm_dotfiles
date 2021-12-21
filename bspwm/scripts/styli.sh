#!/usr/bin/env bash

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    XDG_CONFIG_HOME="${HOME}/.config"
fi
if [ -z ${XDG_CACHE_HOME+x} ]; then
    XDG_CACHE_HOME="${HOME}/.cache"
fi
confdir="${XDG_CONFIG_HOME}/styli.sh"
if [ ! -d "${confdir}" ]; then
    mkdir -p "${confdir}"
fi
cachedir="${XDG_CACHE_HOME}/styli.sh"
if [ ! -d "${cachedir}" ]; then
    mkdir -p "${cachedir}"
fi

wallpaper="${cachedir}/wallpaper.jpg"

die() {
    printf "ERR: %s\n" "$1" >&2
    exit 1
}

usage(){
    echo "Usage: styli.sh [-s | --search <string>]
    [-b | --fehbg <feh bg opt>]
    [-c | --fehopt <feh opt>]
    [-d | --directory]
    [-m | --monitors <monitor count (nitrogen)>]
    [-n | --nitrogen]
    "
    exit 2
}

type_check() {
    mime_types=("image/bmp" "image/jpeg" "image/gif" "image/png" "image/heic")
    isType=false
    
    for requiredType in "${mime_types[@]}"
    do
        imageType=$(file --mime-type ${wallpaper} | awk '{print $2}')
        if [ "$requiredType" = "$imageType" ]; then
            isType=true
            break
        fi
    done
    
    if [ $isType = false ]; then
        echo "MIME-Type missmatch. Downloaded file is not an image!"
        exit 1
    fi
}

select_random_wallpaper () {
    wallpaper=$(find $dir -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.svg" -o -iname "*.gif" \) -print | shuf -n 1)
}

sway_cmd() {
    if [ ! -z $bgtype ]; then
        if [ $bgtype == 'bg-center'  ]; then
            mode="center"
        fi
        if [ $bgtype == 'bg-fill' ]; then
            mode="fill"
        fi
        if [ $bgtype == 'bg-max' ]; then
            mode="fit"
        fi
        if [ $bgtype == 'bg-scale'	]; then
            mode="stretch"
        fi
        if [ $bgtype == 'bg-tile'  ]; then
            mode="tile"
        fi
    else
        mode="stretch"
    fi
    swaymsg output "*" bg "${wallpaper}" "${mode}"
    
}

nitrogen_cmd() {
    for ((monitor=0; monitor < $monitors; monitor++))
    do
        local nitrogen=(nitrogen --save --head=${monitor})
        
        if [ ! -z $bgtype ]; then
            if [ $bgtype == 'bg-center' ]; then
                nitrogen+=(--set-centered)
            fi
            if [ $bgtype == 'bg-fill' ]; then
                nitrogen+=(--set-zoom-fill)
            fi
            if [ $bgtype == 'bg-max' ]; then
                nitrogen+=(--set-zoom)
            fi
            if [ $bgtype == 'bg-scale' ]; then
                nitrogen+=(--set-scaled)
            fi
            if [ $bgtype == 'bg-tile' ]; then
                nitrogen+=(--set-tiled)
            fi
        else
            nitrogen+=(--set-scaled)
        fi
        
        if [ ! -z $custom ]; then
            nitrogen+=($custom)
        fi
        
        nitrogen+=(${wallpaper})
        
        "${nitrogen[@]}"
    done
}

feh_cmd() {
    local feh=(feh)
    if [ ! -z $bgtype ]; then
        if [ $bgtype == 'bg-center' ]; then
            feh+=(--bg-center)
        fi
        if [ $bgtype == 'bg-fill' ]; then
            feh+=(--bg-fill)
        fi
        if [ $bgtype == 'bg-max' ]; then
            feh+=(--bg-max)
        fi
        if [ $bgtype == 'bg-scale' ]; then
            feh+=(--bg-scale)
        fi
        if [ $bgtype == 'bg-tile' ]; then
            feh+=(--bg-tile)
        fi
    else
        feh+=(--bg-scale)
    fi
    
    if [ ! -z $custom ]; then
        feh+=($custom)
    fi
    
    feh+=(${wallpaper})
    
    "${feh[@]}"
}

nitrogen=false
sway=false
monitors=1

PARSED_ARGUMENTS=$(getopt -a -n $0 -o h:w:s:l:b:r:a:c:d:m:pLknxgy:sa --long search:,height:,width:,fehbg:,fehopt:,artist:,subreddit:,directory:,monitors:,termcolor:,lighwal:,kde,nitrogen,xfce,gnome,sway,save -- "$@")

VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
    usage
    exit
fi
while :
do
    case "${1}" in
        -b | --fehbg)     bgtype=${2} ; shift 2 ;;
        -c | --fehopt)    custom=${2} ; shift 2 ;;
        -m | --monitors)  monitors=${2} ; shift 2 ;;
        -n | --nitrogen)  nitrogen=true ; shift ;;
        -d | --directory) dir=${2} ; shift 2 ;;
        -y | --sway)      sway=true ; shift ;;
        -- | '') shift; break ;;
        *) echo "Unexpected option: $1 - this should not happen." ; usage ;;
    esac
done

if [ ! -z $dir ]; then
    select_random_wallpaper
fi

type_check

if [ $nitrogen = true ]; then
    nitrogen_cmd
elif [ $sway = true ]; then
    sway_cmd
else
    feh_cmd
fi
