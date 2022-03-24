#!/usr/bin/env bash
########################################################################################################################
# NOTE:
# 
# The demos settings file contains an array of modules that need to be enabled to make the Next.js+Drupal connection
#   work, which are outlined in https://next-drupal.org/learn/quick-start/enable-modules.
#
########################################################################################################################
printf "    ✔ Enabing modules (see https://next-drupal.org/learn/quick-start/enable-modules).\n"

# 1. Get the modules.
MODULES=$(cat $ENV_SETTINGS | jq -r '.project.modules | join(" ")')
for row in $(cat $ENV_SETTINGS | jq -r '.project.modules [] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode
    }
printf "        * $(_jq '.')\n"
done 

# 2. Enable them.
drush -q pm:enable $MODULES -y
