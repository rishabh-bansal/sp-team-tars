# Description:
#   Query Discourse for User Information
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_DISCOURSE_URL
#
# Commands:
#   hubot show <username> info [from discourse]
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /show (.+) info( from discourse)?/i, (res) ->
    user_url = process.env.HUBOT_DISCOURSE_URL + "/users/#{encodeURIComponent(res.match[1])}.json"
    res.http(user_url)
    .get() (err, _, body) ->
      return res.send "Sorry, the tubes are broken." if err
      data = JSON.parse(body.toString("utf8"))
      return unless data
      username = data.user.username
      last_seen = data.user.last_seen_at
      last_posted = data.user.last_posted_at
      res.send "Discourse Info: User #{username} was last seen on #{last_seen} and posted on #{last_posted}"
