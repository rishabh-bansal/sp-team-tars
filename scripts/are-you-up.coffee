# Description:
#   Returns a response if he is up
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot are you up?
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /are you up\?/i, (msg) ->
    msg.send "For you sir, always."