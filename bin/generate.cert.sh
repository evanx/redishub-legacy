
  set -u -e

  thisName=`basename $0 .sh`

  [ -r ~/.rhrequire/evanx/redishub/tree/master/bin/rhlogging.sh ] ||
    curl -s https://raw.githubusercontent.com/evanx/redishub/master/bin/install.rhlogging.sh | 
      bash /dev/stdin force

  . ~/.rhrequire/evanx/redishub/tree/master/bin/rhlogging.sh 

  [ -r ~/.bashbin/ttl/days/7 ] ||
    curl -s https://raw.githubusercontent.com/evanx/redishub/master/bin/install.ttl.sh | 
      bash /dev/stdin force

  debugWarning='Debugging present (remove before committing)'
  cat $0 | grep 'Z[Z]' && rhwarn "$debugWarning"

  telegramUser='<telegram user>' # the authoritative Telegram.org user
telegramUser=evanxsummers # ZZ
  echo $telegramUser | grep -q '^[a-z]' || rhabort 'Invalid telegram user' 
  account="$telegramUser" # use as RedisHub account name
  domain=`hostname` # my host or domain of this user
  user=$USER # the user id on the host/domain
  role='admin' # the RedhisHub role this user/cert

  tmp=~/.bashbin/days/7/`basename $0/$$`
  mkdir $tmp && cd $tmp && rhinfo `pwd`

  cn="$user@$domain"
  ou="$role%$account@redishub.com"

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=$cn/OU=$ou" \
    -keyout privkey.pem -out cert.pem
  cat privkey.pem cert.pem > privcert.pem

  prefix=$role.$user.$account.redishub
  cp privcert.pem $prefix.privcert.pem
  ls -l $prefix.privcert.pem
  rhinfo "Try:"
  rhinfo "openssl x509 -text -in `pwd`/$prefix.privcert.pem | grep 'CN='"
  openssl x509 -text -in $prefix.privcert.pem | grep 'CN='
  rhinfo OK `pwd`/$prefix.privcert.pem

