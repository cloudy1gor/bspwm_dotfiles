#!/bin/bash

if [[ $(bspc config bottom_padding) -eq 0 ]]; then
  polybar-msg cmd show || exit 1
  bspc config bottom_padding 34 || exit 1
else
  polybar-msg cmd hide || exit 1
  bspc config bottom_padding 0 || exit 1
fi
