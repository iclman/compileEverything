alias agitVoncGitHub='alias git="${H}/sbin/wgit u VonC,vonc@laposte.net,github.com"'
alias agitBjensenItsvcprdgit='alias git="${H}/sbin/wgit u bjensen,bjensen@example.com,itsvcprdgit.world.company,bjensen"'
alias agitBjensenItsvc='alias git="${H}/sbin/wgit u bjensen,bjensen@example.com,itsvc,bjensen"'
alias agitGitoliteadm='alias git="${H}/sbin/wgit u gitoliteadm,gitoliteadm@mail.com,itsvc"'
alias gl='git lg -20'
alias glb='git lg -20 --branches'
alias gla='git lga -20'
alias glab='git lga -20 --branches'
alias gstlast='git ls-files --other --modified --exclude-standard|while read filename; do  echo -n "$(stat -c%y -- $filename 2> /dev/null) "; echo $filename;  done|sort'
