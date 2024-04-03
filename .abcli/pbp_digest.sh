#! /usr/bin/env bash
# source: Pro Bash Programming: Scripting the GNU/Linux Shell
https://cfajohnson.com/books/cfajohnson/pbp/

# digested by pbp.digest.3.19.1
# 📚 mirror of Pro Bash Programming: Scripting the GNU/Linux Shell.
# 02 April 2024, 18:38:18

# ch11-Programming_for_the_Command_Line/functions::59:101
menu()
{
  local IFS=$' \t\n'                            ## Use default setting of IFS
  local num n=1 opt item cmd
  echo

  ## Loop though the command-line arguments
  for item
  do
     printf " %3d. %s\n" "$n" "${item%%:*}"
     n=$(( $n + 1 ))
  done
  echo

  ## If there are fewer than 10 items, set option to accept key without ENTER
  if [ $# -lt 10 ]
  then
     opt=-sn1
  else
     opt=
  fi

  read -p " (1 to $#) ==> " $opt num          ## Get response from user

  ## Check that user entry is valid
  case $num in
     [qQ0] | "" ) return ;;                   ## q, Q or 0 or "" exits
     *[!0-9]* | 0*)                           ## invalid entry
        printf "\aInvalid response: %s\n" "$num" >&2
        return 1
        ;;
  esac
  echo

  if [ "$num" -le "$#" ]    ## Check that number is <= to the number of menu items
  then
     eval "${!num#*:}"      ## Execute it using indirect expansion
  else
     printf "\aInvalid response: %s\n" "$num" >&2
     return 1
  fi
}
