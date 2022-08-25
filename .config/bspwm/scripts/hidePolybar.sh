#!/usr/bin/env bash

#	Simple script to hide/unhide polybar
#   Author: z0mbi3
#	url: https://github.com/gh0stzk


function hide() {
	
	if [[ "${RICETHEME}" == @(emilia|jan|aline|cynthia|silvia|pamela) ]]; then
		polybar-msg cmd hide | bspc config top_padding 5
		
	elif [[ "${RICETHEME}" == @(isabel|cristina) ]]; then
		polybar-msg cmd hide | bspc config bottom_padding 5
		
	elif [[ "${RICETHEME}" == melissa ]]; then
		polybar-msg cmd hide | bspc config top_padding 5 | bspc config bottom_padding 5
		
	else 
		echo "Error: This is eww not polybar dud..."
	fi
}

function unhide() {
	
	if [[ "${RICETHEME}" == @(emilia|jan) ]]; then
		polybar-msg cmd show | bspc config top_padding 60
		
	elif [[ "${RICETHEME}" == aline ]]; then
		polybar-msg cmd show | bspc config top_padding 50
		
	elif [[ "${RICETHEME}" == @(cynthia|silvia) ]]; then
		polybar-msg cmd show | bspc config top_padding 45
		
	elif [[ "${RICETHEME}" == pamela ]]; then
		polybar-msg cmd show | bspc config top_padding 60
		
	elif [[ "${RICETHEME}" == isabel ]]; then
		polybar-msg cmd show | bspc config bottom_padding 45
		
	elif [[ "${RICETHEME}" == melissa ]]; then
		polybar-msg cmd show | bspc config top_padding 42 | bspc config bottom_padding 40
		
	elif [[ "${RICETHEME}" == cristina ]]; then
		polybar-msg cmd show | bspc config bottom_padding 60
		
	else 
		echo "Error: This is eww not polybar dud..."
		
	fi
}

   case $1 in
		-h | --hide | hide)
			hide
			exit;;
		-u | --unhide | unhide)
			unhide
			exit;;
			*) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
