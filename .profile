# Note: Bash on Windows does not currently apply umask properly.
if [[ "$(umask)" = "0000" ]]; then
  umask 0022
fi
