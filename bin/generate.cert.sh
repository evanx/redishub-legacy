
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
  rhrequire ~/.bashbin/ttl/days/14 ttl

  . ~/.rhrequire/evanx/redishub/tree/master/bin/rhlogging.sh 

  [ $# -ge 1 ] || rhabort ENV "Usage: <telegramUser> (authoritative telegram.org user name for RedisHub account)"

  service=${service-redishub.com}
  telegramUser=${1-''} # the authoritative Telegram.org user
  echo "$telegramUser" | grep -q '^[a-z]\S*$' || rhabort PARAM 'Invalid account name' 
  curl -s https://cli.redishub.com/verify-user-telegram/$telegramUser || rhabort PARAM 'Invalid telegram user' 
  account=${telegramUser} # use as RedisHub account name
  echo "$account" | grep -q '^[a-z]\S*$' || rhabort 'Invalid account name' 
  domain=`hostname` # my host or domain of this user
  user=$USER # the user id on the host/domain
  role='admin' # the RedhisHub role this user/cert

  tmp=~/.bashbin/days/14/$thisName/$$
  mkdir -p $tmp && cd $tmp && rhinfo `pwd`

  CN="$user@$domain"
  OU="$role%$account@redishub.com"

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=$CN/OU=$OU" \
    -keyout privkey.pem -out cert.pem
  cat privkey.pem cert.pem > privcert.pem
  openssl x509 -text -in privcert.pem | grep 'CN='

  dt=`date +'%Y%m%d'`
  prefix=$role.$account.$user.$domain.$dt
  cp privcert.pem $prefix.privcert.pem
  ls -l $prefix.privcert.pem

  if [ -d ~/.redishub/live ]
  then
    if [[ "${2:-}" =~ force ]]
    then
      timestamp=`date +%s`
      archive=~/.bashbin/ttl/days/30/$thisName/archive/live/$timestamp
      echo "Archiving ~/.redishhub/live et al to $archive"
      mkdir -p $archive
      ls -l ~/.redishub/live
      mv ~/.redishub/live/* $archive
    else
      rhabort ENV "Try second param 'force' to overwrite existing ~/.redishub/live PEM files"
    fi
  else
    mkdir -p ~/.redishub/live
  fi
 
  cd ~/.redishub/live
  [ ! -f privcert.pem ] || rhabort APP "Exists: ~/.redishub/privcert.pem"
  [ ! -f account ] || rhabort APP "Exists: ~/.redishub/privcert.pem"
  echo "$account" > account
  cp -i $tmp/* .
  pwd
  ls -l
  echo account `cat account`
  rhinfo "openssl x509 -text -in ~/.redishub/live/privcert.pem | grep 'CN='"
  openssl x509 -text -in ~/.redishub/live/privcert.pem | grep 'CN='
  rhinfo 'Generated cert:' ~/.redishub/privcert.pem 'OK'


