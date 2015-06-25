# Description:
#   Listens and pushes all messages to a logger
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_LOGGER_URL
#   HUBOT_LOGGER_USERNAME
#   HUBOT_LOGGER_PASSWORD
#
# Commands:
#   None
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.hear /(.*)/, (msg) ->
    data = JSON.stringify( {
        'user_id': msg.message.user.id.toUpperCase(),
        'room': msg.message.user.room,
        'username': msg.message.user.name,
        'real_name': msg.message.user.real_name,
        'message': msg.message.text
    })
    msg.http(process.env.HUBOT_LOGGER_URL)
        .header('Content-Type', 'application/json')
        .post(data) (err, res, body) ->
            return
        