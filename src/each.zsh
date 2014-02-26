each() {
  eval "$initDocs"
  usage "<lambda-function> [list...]"
  example "'(( \$1 >= 5 )) && echo \$1'" 5 1 7 4
  example "'(( \$1 >= 5 )) && echo \$1 || true'" 5 1 7 4
  eval "$doneDocs"

  typeset f="$1"; shift
  typeset result=0
  each_() {
    eval ${(e)==f}
  }
  eval "$loopNow" each_ "'local res=\$?; (( \$res != 0 )) && return \$res'"
  return $?
}

eachf() {
  echo_twice () { echo $1 $1 }
  eval "$initDocs"
  usage "<function> [list...]"
  example "echo_twice" a b c
  eval "$doneDocs"

  typeset f="$1 \"\$1\""; shift
  each "$f" "$@"
}
