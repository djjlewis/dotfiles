find . -type f -printf "%f\n" | sed -e "p;s/\.//g" | xargs -n2 echo
#find . -type f -printf "%f\n" | sed -e "p;s/\.//g" | xargs -n2 mv
