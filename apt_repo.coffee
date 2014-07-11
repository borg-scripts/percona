module.exports = ->
  @then (cb) =>
    @test "grep 'repo.percona.com' /etc/apt/sources.list", code: 1, (necessary) =>
      return @skip "Percona apt repos already installed.", cb unless necessary
      @execute "apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A", sudo: true, =>
        @execute 'echo "deb http://repo.percona.com/apt \`lsb_release -a 2>&1 | grep Codename | awk \'{print $2}\'\` main" | sudo tee -a /etc/apt/sources.list 2>&1 >/dev/null', =>
          @execute 'echo "deb-src http://repo.percona.com/apt \`lsb_release -a 2>&1 | grep Codename | awk \'{print $2}\'\` main" | sudo tee -a /etc/apt/sources.list 2>&1 >/dev/null', =>
            @execute "apt-get update", sudo: true, =>
              @install "percona-server-client-5.5", cb
