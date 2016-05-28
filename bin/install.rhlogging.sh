
  set -u -e

  thisName=`basename $0 .sh`

  cmd="${1-}" # e.g. force

  repo=${repo-'evanx/redishub'}
  tree=${tree-'master'} # TODO 'stable' branch as default

  file=${file-'bin/rhlogging.sh'}

  uri="$repo/tree/$tree"
  url="https://raw.githubusercontent.com/$repo/$tree"

  home=~/.ghbash/require
  dir=$home/$uri
  path=$dir/$file

  if [ "$cmd" != 'force' ] 
  then
    if [ -f $path ] 
    then
      >&2 echo "Already exists: $path"
      echo "Try:"
      echo "$0 force"
      exit 3
    elif [ ! -t 1 ]
    then
      echo "Missing $path"
      echo "Try:"
      echo "$0 force"
      exit 3
    else
      echo "This script wants to:"
      echo "- Create an evanx/bashbin dir including:"
      echo "     $path"
      echo "- Install logging utils therein from:"
      echo "     https://github.com/$uri/$file"
      echo "- Create other TTL dirs including:"
      echo "    ~/.bashbin/ttl/minutes/1"
      echo "    ~/.bashbin/ttl/minutes/600"
      echo "    ~/.bashbin/ttl/days/1"
      echo "    ~/.bashbin/ttl/days/365"
      echo "  These are intended to simplify tmp file creation"
      echo "  and cleanup via cron e.g. using find -mmin and -mtime"
      echo "Try:"
      echo "$0 force"
      exit 3
    fi
  fi

  for days in 1 2 5 10 14 28 60 90 180 365
  do
    mkdir -p ~/.bashbin/ttl/days/$days
  done
  for minutes in 1 2 5 10 15 30 55 60 65 90 120 180 300 360 600
  do
    mkdir -p ~/.bashbin/ttl/minutes/$minutes
  done

  mkdir -p $dir 
  cd $dir
  pwd
  fileDir=`dirname $file`
  mkdir -p $fileDir
  mkdir -p $fileDir
  ls -l 
  >&2 echo "curl -s $url/$file -o $file"
  if ! curl -s $url/$file -o $file
  then
    echo "Curl error code $?"
    exit 4 
  fi
  ls -l $file 
  sha1sum $file | tee $file.`date +%Y%m%d`.sha1sum
  echo "$url" `cat $file.fimhook.sha1sum` 'OK'

  . $file 
  rhinfo `pwd`
  rhinfo "Installed $file OK"
