
set -u -e

. ~/redishub/bin/rhlogging.sh

tmp=~/.bashbin/ttl/minutes/1
[ -d $tmp ] || mkdir -p $tmp

rhcurl() {
  openssl x509 -text -in ~/.redishub/live/privcert.pem > $tmp.certInfo
  CN=`cat "$tmp.certInfo" | grep 'CN=' | sed -n 's/.*CN=\(\S*\),.*/\1/p' | head -1`
  OU=`cat "$tmp.certInfo" | grep 'OU=' | sed -n 's/.*OU=\(\S*\).*/\1/p' | head -1`
  local account=`cat ~/.redishub/live/account`
  if ! echo $OU | grep -q "%${account}@"
  then
    echo "ERROR $OU does not match Telegram user $account"
    return 3
  fi
  local url=''
  if [ $# -eq 1 ]
  then
    if echo "$1" | grep '^https'
    then
      url="$1"
    elif echo "$1" | grep '^[a-z]*\.redishub.com'
    then
      url="https://$1"
    fi
    if [ -n "$url" ] 
    then
      rhdebug "CN=$CN OU=$OU https://$domain/ak/$account/$keyspace/$cmd"
      curl -s -E ~/.redishub/live/privcert.pem "https://$domain/ak/$account/$keyspace/$cmd"
      return $?
    fi
  fi
  local domain=${RHCLI-cli.redishub.com}
  rhdebug domain=$domain account=$account
  if [ $# -eq 0 ]
  then
    rhinfo "Try: rh <keyspace> reg"
    rhdebug "curl -s -E ~/.redishub/live/privcert.pem https://$domain/ak/$account/:keyspace/register-keyspace"
    return 1
  elif [ $# -eq 1 ]
  then
    if [ "$1" = 'routes' ]
    then
      rhinfo "curl -s -E ~/.redishub/live/privcert.pem https://$domain/routes"
      curl -s -E ~/.redishub/live/privcert.pem https://$domain/routes
      return $?
    elif [ "$1" = 'register-cert' ]
    then
      rhinfo "curl -s -E ~/.redishub/live/privcert.pem https://$domain/register-cert"
      curl -s -E ~/.redishub/live/privcert.pem https://$domain/register-cert
      return $?
    elif [ "$1" = 'register-account' ]
    then
      rhinfo "curl -s -E ~/.redishub/live/privcert.pem https://$domain/register-account-telegram/$account"
      curl -s -E ~/.redishub/live/privcert.pem https://$domain/register-account-telegram/$account
      return $?
    fi
    local keyspace="$1"
    rhinfo "Try the following cmds:"
    rhinfo "rh $keyspace register-keyspace"
    rhinfo "rh $keyspace keys # scan keys"
    rhinfo "rh $keyspace <cmd> # e.g. set, get, sadd, hgetall et al"
    rhdebug "curl -s -E ~/.redishub/live/privcert.pem https://$domain/ak/$account/$keyspace"
    return 1
  fi
  local keyspace="$1"
  shift
  local cmd="$1"
  shift
  if echo "$cmd" | grep '^reg$\|^register$\|^register-keyspace$'
  then
    cmd='register-keyspace'
  fi
  while [ $# -gt 0 ]
  do
    cmd="$cmd/$1"
    shift
  done
  rhdebug "CN=$CN OU=$OU https://$domain/ak/$account/$keyspace/$cmd"
  curl -s -E ~/.redishub/live/privcert.pem "https://$domain/ak/$account/$keyspace/$cmd"
}

rhcurl $@

