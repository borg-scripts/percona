module.exports = ->
  @then @execute "grep 'repo.percona.com' /etc/apt/sources.list", ({code}) =>
    return @then @log "Percona apt repos already installed.", cb if code is 0

    @then @execute "apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A", sudo: true
    @then @execute 'echo "deb http://repo.percona.com/apt \`lsb_release -a 2>&1 | grep Codename | awk \'{print $2}\'\` main" | sudo tee -a /etc/apt/sources.list 2>&1 >/dev/null'
    @then @execute 'echo "deb-src http://repo.percona.com/apt \`lsb_release -a 2>&1 | grep Codename | awk \'{print $2}\'\` main" | sudo tee -a /etc/apt/sources.list 2>&1 >/dev/null'
    @then @execute "apt-get update", sudo: true
