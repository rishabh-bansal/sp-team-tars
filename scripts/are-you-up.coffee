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
#   hubot are you there?
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /are you up\?/i, (msg) ->
    msg.send "For you sir, always."
    
  robot.respond /are you there\?/i, (msg) ->
    msg.send "At your service sir."