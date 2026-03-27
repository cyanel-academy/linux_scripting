#!/bin/bash

printf "Play again ? (yes/no) :  "
# read input value
read user_input

case "$user_input" in
    yes|y)
        #printf -- "----- NEW GAME -----\n"
        ./main_wordle.sh
        ;;
    no|n)
        printf -- "\n----- END OF GAME -----\n\n" # -- to say no option and let the - in the printf
        ;;
    *)
        printf -- "\n----- INVALID INPUT/END OF GAME -----\n\n"
        ;;
esac

exit 0
