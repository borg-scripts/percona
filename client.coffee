module.exports = ->
  @import __dirname, 'apt_repo'

  @then @install "percona-server-client-5.5"
