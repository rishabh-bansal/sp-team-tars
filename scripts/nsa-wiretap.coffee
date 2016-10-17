# Description:
#   Listens and pushes all messages to a logger
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_LOGGER_API_KEY
#   HUBOT_LOGGER_URL
#
# Commands:
#   None
#
# Author:
#   cpradio

WHITELIST_ROOMS = /(general|bot-experiments|testing|disaster-control|spf-advisors|spf-mentors)/ig

module.exports = (robot) ->
  robot.hear /(.*)/, (msg) ->
    data = JSON.stringify( {
        'api_key': process.env.HUBOT_LOGGER_API_KEY,
        'user_id': msg.message.user.id.toUpperCase(),
        'room': msg.message.user.room,
        'username': msg.message.user.name,
        'real_name': msg.message.user.real_name,
        'message': msg.message.text
    })

    if WHITELIST_ROOMS.test(msg.message.user.room)
      console.log('Success: ' + msg.message.user.room)
      msg.http(process.env.HUBOT_LOGGER_URL)
          .header('Content-Type', 'application/json')
          .post(data) (err, res, body) ->
              return
    else
      console.log('Failure: ' + msg.message.user.room)
