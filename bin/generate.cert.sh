
  set -u -e

  thisName=`basename $0 .sh`

  rhrequire() {
    file=$1
    install=$2
    [ -r $file ] ||
      curl -s https://raw.githubusercontent.com/evanx/redishub/master/bin/install.$install.sh | # TODO from master to stable
        bash /dev/stdin force
  }

  rhrequire ~/.rhrequire/evanx/redishub/tree/master/bin/rhlogging.sh rhlogging
  rhrequire ~/.bashbin/ttl/days/7 ttl

  . ~/.rhrequire/evanx/redishub/tree/master/bin/rhlogging.sh 

  [ $# -eq 1 ] || rhabort ENV "Usage: <telegramUser> (authoritative telegram.org user name for RedisHub account)"

  debugWarning='Debugging present (remove before committing)'
  cat $0 | grep 'Z[Z]' && rhwarning "$debugWarning"

  service=${service-redishub.com}
  telegramUser=${1-''} # the authoritative Telegram.org user
  echo "$telegramUser" | grep -q '^[a-z]\S*$' || rhabort PARAM 'Invalid account name' 
  curl -s https://cli.redishub.com/verify-user-telegram/$telegramUser || rhabort PARAM 'Invalid telegram user' 
  account=${telegramUser} # use as RedisHub account name
  echo "$account" | grep -q '^[a-z]\S*$' || rhabort 'Invalid account name' 
  domain=`hostname` # my host or domain of this user
  user=$USER # the user id on the host/domain
  role='admin' # the RedhisHub role this user/cert

  tmp=~/.bashbin/days/7/`basename $0/$$`
  mkdir $tmp && cd $tmp && rhinfo `pwd`

  CN="$user@$domain"
  OU="$role%$account@redishub.com"

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=$CN/OU=$OU" \
    -keyout privkey.pem -out cert.pem
  cat privkey.pem cert.pem > privcert.pem

  prefix=$role-$user@$domain-$account@redishub
  cp privcert.pem $prefix.privcert.pem
  ls -l $prefix.privcert.pem
  rhinfo "Try:"
  rhinfo "openssl x509 -text -in `pwd`/$prefix.privcert.pem | grep 'CN='"
  openssl x509 -text -in $prefix.privcert.pem | grep 'CN='

  if [ -d ~/.redishub/live ]
  then
    if [ "${1-}" = 'force' ]
    then
      timestamp=`date +%s`
      archive=~/.bashbin/ttl/days/7/$thisName/live/$timestamp
      echo "Archiving ~/.redishhub/live et al to $archive"
      mkdir -p $archive
      ls -l ~/.redishub/live
      mv ~/.redishub/live/* $archive
    else
      rhabort ENV "Try param 'force' to overwrite existing ~/.redishub/live PEM files"
    fi
  else
    mkdir -p ~/.redishub/live
  fi
 
  cd ~/.redishub/live
  [ ! -f privcert.pem ] || rhabort APP "Exists: ~/.redishub/privcert.pem"
  [ ! -f account ] || rhabort APP "Exists: ~/.redishub/privcert.pem"
  echo "$account" > account
  rhinfo `GenerateCert` `cat account` $CN/OU=$OU ~/.redishub/privcert.pem OK

