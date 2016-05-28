
  set -u -e

  thisName=`basename $0 .sh`

  requireLibVersion='master' # TODO tag

  requireLibRepo='evanx/redishub'
  requireLibFile='bin/rhlogging.sh'

  requireLibUri="$requireLibRepo/tree/$libVersion/$requireLibFile"
  requireLibUrl="https://raw.githubusercontent.com/$requireLibUri"

  tmpl=~/.ttl.forever/$thisName/$requireLibVersion
  if [ ! -d $tmpl ] 
  then
    if [ ! -t 1 ]
    then
      echo "Missing $tmpl"
      exit 3
    fi
    echo "This script wants to create a working dir: $tmpl"
    echo "and install logging utils therein from:"
    echo "https://github.com/$requiredLibUri"
    echo "Press Ctrl-C to abort, or Enter to continue" 
    read _confirm 
    mkdir $tmpl && cd $tmpl && pwd
    mkdir -p `dirname $requireLibFile`
    curl $requireLibUrl -o $requireLibFile
    ls -l $requireLibFile 
    sha1sum $requireLibFile | tee $requireLibFile.fimhook.sha1sum
  else
    cd $tmpl
  fi
  
  . 
 
  debugWarning='Debugging present (remove before committing)'
  cat $0 | grep 'Z[Z]' && rhwarn "$debugWarning"

  telegramUser='<telegram user>' # the authoritative Telegram.org user
telegramUser=evanxsummers # ZZ
  echo $telegramUser | grep -q '^[a-z]' || rhabort 'Invalid telegram user' 
  account="$telegramUser" # use as RedisHub account name
  domain=`hostname` # my host or domain of this user
  user=$USER # the user id on the host/domain
  role='admin' # the RedhisHub role this user/cert

  tmp=$tmpl/`basename $0/$$`
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

