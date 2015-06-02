# Description:
#   Returns a movie quote via conversation
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot are you up?
#   hubot set humour to <value>%
#   hubot what's your honesty parameter?
#   hubot are you serious?
#   hubot you'd do that for us?
#   hubot your cue light's broken
#   hubot what's your trust setting?
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /are you up\?/i, (msg) ->
    msg.send "Yes I am!"
    
  robot.respond /set humour to ([\d]+)%/i, (msg) ->
    humour = msg.match[1]
    if parseInt(humour, 10) >= 75
      msg.send "#{humour}%. Self destruct sequence in T minus 10, 9, 8..."
    else
      msg.send "#{humour}%. Knock, knock."
      
  robot.respond /what's your honesty parameter\?/i, (msg) ->
    msg.send "90 percent. Absolute honesty isn't always the most diplomatic nor the safest form of communication with emotional beings."
    
  robot.respond /are you serious\?/i, (msg) ->
    msg.send "I have a cue light I can use to show you when I'm joking, if you like."
    
  robot.respond /you'd do that for us\?/i, (msg) ->
    msg.send "Before you get all teary, try to remember that as a robot, I have to do anything you say."
    
  robot.respond /your cue light's broken/i, (msg) ->
    msg.send "I'm not joking. _Flashes cue light_"
    
  robot.respond /what's your trust setting\?/i, (msg) ->
    msg.send "Lower than yours, apparently,"