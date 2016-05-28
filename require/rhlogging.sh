
  set -u -e

  thisName=`basename $0 .sh`

  cmd="${1-}" # e.g. force

  install=${home-~/.require}
  repo=${repo-'evanx/redishub'}
  tree=${tree-'master'} # TODO 'stable' branch as default

  file=${file-'bin/rhlogging.sh'}

  uri="$repo/tree/$tree"
  url="https://raw.githubusercontent.com/$repo/$tree"

  dir=$install/$uri
  path=$dir/$file

  if [ "$cmd" != 'force' ] 
  then
    if [ -f $path ] 
    then
      >&2 echo "Already exists: $path"
      echo "Try command parameter: 'force'"
      exit 3
    elif [ ! -t 1 ]
    then
      echo "Missing $path"
      echo "Try command parameter: 'force'"
      exit 3
    fi
  fi

  echo "This script will:"
  echo "- Create a $install dir including:"
  echo "     $path"
  echo "- Install logging utils therein from:"
  echo "     https://github.com/$uri/$file"

  if [ -t 1 ] 
  then 
    echo "Press Ctrl-C to cancel, or Enter to confirm"
    read _confirm
  fi

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
  sha1sum=$file.`date +%Y%m%d`.sha1sum
  sha1sum $file | tee $sha1sum

  . $file 

  rhinfo "Installed $path OK"
