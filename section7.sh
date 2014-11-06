#!/bin/bash
# by: Michael Contino
# This is all of the scripts for section 7

#exercise 1
year=`date +%Y`

if [ $[$year % 400] -eq 0 ]; then
  echo "This is a leap year.  February has 29 days."
elif [ $[$year % 4] -eq 0 ]; then
        if [ $[$year % 100] -ne 0 ]; then
          echo "This is a leap year, February has 29 days."
        else
          echo "This is not a leap year.  February has 28 days."
        fi
else
  echo "This is not a leap year.  February has 28 days."
fi

#exercise 2
space="$1"

temp=$((space % 400))
temptwo=$((space % 4))
tempthree=$((space % 100))

case $temp in
0)
  Message="This is a leap year.  February has 29 days."
  ;;
*)
  Message="This is not a leap year.  February has 28 days."
  ;;
esac

case $temptwo in
0)
  Message="This is a leap year.  February has 29 days."
  ;;
*)
  Message="This is not a leap year.  February has 28 days."
  ;;
esac
case $tempthree in
0)
  Message="This is not a leap year.  February has 28 days."
  ;;
*)
  Message="This is a leap year.  February has 29 days."
  ;;
esac
echo $Message

#exercise 5
init=`ps -al |grep -v "grep" |grep "init"`
httpd=`ps -al |grep -v "grep" |grep "httpd"`

if [[ (! $httpd) && (! $init)  ]] ; then
  echo "httpd and init are not running"
elif [[ ($httpd) && (! $init) ]]; then
  echo "httpd is running and init is not running"
elif [[ (! $httpd) && ($init) ]]; then
  echo "httpd is not running and init is running"
elif [[ ($httpd) && ($init) ]]; then
  echo "httpd and init are running"
else
  echo "Wat"
fi

remote="localhost"

#exercise 6
tar vcf /backup/$USER.tar.bz2 $HOME >> backup.log
scp /backup/$USER.tar.bz2 $USER@$remote:/backup/$HOSTNAME/$USER.tar.bz2 >>backup.log

#exercise 7
file="test.txt"
remotesrv="localhost"
remotedir="/backup"

space=`df -h |head -2 | awk '{print $5}' | grep % | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -`

case $space in
[0-9])
  Message="We are doing damn good"
  ;;  
[1-6]*)
  Message="All is quiet."
  ;;
[7-8]*)
  Message="Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
  ;;
90)
  Message="Better hurry with that new disk...  One partition is $space % full."
  tarfile=`ls |grep -v "grep"| grep "$file.tar"`
  if [[ $tarfile ]]; then
    rm $tarfile
  fi
  tar cf $file.tar.bz2 $file
  scp $file.tar.bz2 $USER@$remotesrv:$remotedir/$file.tarfile.tar.bz2
  rm $file.tar.bz2
  ;;
9[1-8])
  Message="I'm drowning here!  There's a partition at $space %!"
  exit 1
  ;;
*)
  Message="Wat"
  ;;
esac
echo $Message
