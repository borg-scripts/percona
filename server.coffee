module.exports = ->
  @import __dirname, 'apt_repo'

  @then @install, "percona-server-server-5.5"
