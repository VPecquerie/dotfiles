#!/bin/zsh
i3_config_file="$HOME/.config/i3/config"
i3_includes_file="$HOME/.config/i3/configs/includes.conf"

if [[ -f "$i3_includes_file" ]]; then
  [[ -f "$i3_config_file" ]] && rm "$i3_config_file"

  touch "$i3_config_file"

  echo "#### DO NOT EDIT THIS FILE, IT IS GENERATED." >> "$i3_config_file"
  echo "#### EDIT THE FILES HERE: $i3_config_file" >> "$i3_config_file"

  include_file() {
    cat "$HOME/.config/i3/configs/$1" >> "$i3_config_file"
  }

  get_file_name_from_line () {
    removed_semicolon="${1%;*}"
    removed_import="${removed_semicolon#import}"
    stripped_file_name="$(echo $removed_import | sed 's/ //')"
    echo "$stripped_file_name"
  }

  exec 3< "$i3_includes_file"

  until [ "$done" ]
  do
    read <&3 config_line

    if [ $? != 0 ]; then
      done=1
      continue
    else
      if [[ "$config_line[1,7]" == "import " ]]; then
        file_name="$(get_file_name_from_line $config_line)"
        include_file "$file_name"
      fi
    fi
  done

  if [[ "$1" == "restart" || "$1" == "reload" ]]; then
    i3-msg "$1"
  fi
else
  echo "ERROR:"
  echo "Please create the configs import file:"
  echo "$i3_includes_file"
fi