
  set -u -e

  thisName=`basename $0 .sh`

  install=${install-~/.bashbin}

  if [ -t 1 ] 
  then 
    echo "This script will create: $install"
    echo "Including TTL sub dirs:"
    echo "  ttl/minutes/1"
    echo "  ttl/minutes/600"
    echo "  ttl/days/1"
    echo "  ttl/days/365"
    echo "These are intended to simplify tmp file creation by other scripts"
    echo "and facilitate their cleanup via cron e.g. using find -mmin and -mtime"
    echo "Press Ctrl-C to abort or Enter to confirm"
    read _confirm
  fi

  for days in 1 2 5 10 14 28 60 90 180 365
  do
    mkdir -p $install/ttl/days/$days
  done

  for minutes in 1 2 5 10 15 30 55 60 65 90 120 180 300 360 600
  do
    mkdir -p $install/ttl/minutes/$minutes
  done

  echo; echo "$install"
  ls -l $install/ttl/*
  echo "Installed $install OK"
