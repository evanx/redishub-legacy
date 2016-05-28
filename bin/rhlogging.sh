
rhinit() {
  if [ -z "${BASH-}" ] 
  then
    >&2 echo 'Please use bash shell!'
    return 3
  fi
  RH_WIDTH=`tput cols`
}

rhinit

rhnone() {
  return 0
}

rhnote() {
  if [ -t 1 ]
  then
    >&2 echo -e "\e[90m${@}\e[39m"
  else
    >&2 echo "DEBUG ${@}"
  fi
}

rhdebug() {
  if [ "${RHLEVEL-}" = 'debug' ]
  then
    rhnote "$@"
  fi
}

rhinfo() {
  if [ -t 1 ]
  then
    >&2 echo -e "\e[1m\e[94m${@}\e[39m\e[0m"
  else
    >&2 echo "INFO ${@}"
  fi
}

rhprop() {
   if [ -t 1 ]
   then
     >&2 echo -e "\e[1m\e[36m${1}\e[0m \e[39m${2}\e[39m\e[0m"
   else
     >&2 echo "$1 $2"
   fi
}

rhwarn() {
   if [ -t 1 ]
   then
     >&2 echo -e "\e[1m\e[33m${@}\e[39m\e[0m"
   else
     >&2 echo "WARNING ${@}"
   fi
}

rherror() {
   if [ -t 1 ]
   then
     >&2 echo -e "\e[1m\e[91m${@}\e[39m\e[0m"
   else
     >&2 echo "ERROR ${@}"
   fi
}

rhsection() {
  echo
  rhwarn `printf '%200s\n' | cut -b1-${RH_WIDTH} | tr ' ' -`
  rhwarn "$@"
}

rhsub() {
  echo
  rhnote `printf '%200s\n' | cut -b1-${RH_WIDTH} | tr ' ' \.`
  rhinfo "$@"
}

# command: rhabort $code $*
# example: rhabort 1 @$LINENO "error message" $some
# specify 1 (default) to limit 254. 
# Ideally use 3..63 for custom codes
# returns nonzero code e.g. for scripts with set -e 
rhabort() {
  local code=3
  local lineno=''
  if [ $# -gt 0 ]
  then
    if [ "$1" = 'SETUP' ]
    then
       code=3
    elif echo "$1" | grep -q '^[0-9]'
    then
      code=$1
      if shift
      then
        if echo "$1" | grep -q '^[0-9][0-9]*$'
        then
          lineno=$1
          rhdebug "Abort line number: $lineno"
          shift
        fi 
      fi
    fi
  fi
  local errorName=''
  [ $code -eq 3 ] && errorName=SETUP
  if [ $# -gt 0 ]
  then
    if echo "$1" | grep -q 'Try: '
    then
      rhinfo 'Try: '
      rhinfo "`echo "$1" | cut -b6-199`" 
      shift
    fi
  fi
  rherror "Aborting. Reason: [${*}] (code $code [$errorName])"
  [ $code -eq 0 ] && return 1
  [ $code -ge 255 ] && code=254
  return $code
}
