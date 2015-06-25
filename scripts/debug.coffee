# Description:
#   Debug Info
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.hear /DEBUG: (.*)/, (msg) ->
    for msgKey, msgVal of msg.message
        msg.send "#{msgKey} is #{msgVal}"
        for itmKey, itmVal of msgVal
            msg.send "#{itmKey} is #{itmVal}"
        