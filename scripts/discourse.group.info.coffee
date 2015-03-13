# Description:
#   Query Discourse for Group Information
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_DISCOURSE_URL
#
# Commands:
#   hubot show <group> group info [from discourse]
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /show (.+) group info( from discourse)?/i, (res) ->
    groupname = res.match[1]
    user_url = process.env.HUBOT_DISCOURSE_URL + "/groups/#{encodeURIComponent(groupname)}/members.json"
    res.http(user_url)
    .get() (err, _, body) ->
      return res.send "Sorry, the tubes are broken." if err
      try
        data = JSON.parse(body.toString("utf8"))
        output = "Discourse Info: #{groupname}\r\n"
        for own key, user of data
          username = user.username
          last_seen = user.last_seen_at
          output += "     User #{username} was last seen on #{last_seen}\r\n"
        res.send output
      catch e
        res.send "Discourse data for #{groupname} group is unavailable."
