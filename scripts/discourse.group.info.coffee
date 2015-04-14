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

last_checkin_date = new Date();
last_checkin_date.setHours(0,0,0,0);
dif = (last_checkin_date.getDay() + 6) % 7;
last_checkin_date = new Date(last_checkin_date - dif * 24*60*60*1000);

module.exports = (robot) ->
  robot.respond /show (.+) group info( from discourse)?/i, (res) ->
    groupname = res.match[1]
    user_url = process.env.HUBOT_DISCOURSE_URL + "/groups/#{encodeURIComponent(groupname)}/members.json"
    res.http(user_url)
    .get() (err, _, body) ->
      return res.send "Sorry, the tubes are broken." if err
      try
        data = JSON.parse(body.toString("utf8"))
        checkin_date_str = last_checkin_date.toDateString()
        output = "Discourse Info: #{groupname} (last check-in date: #{checkin_date_str})\r\n"
        for own key, user of data.members
          username = user.username
          last_seen = new Date(user.last_seen_at)
      
          last_seen_as_date = new Date(last_seen)
          checked_in = last_seen_as_date > last_checkin_date
          checked_in_str = if checked_in then "(checked in)" else "(not checked in)"
          prefix_suffix = if checked_in then "" else "*"
      
          output += "     #{prefix_suffix}User #{username} was last seen on #{last_seen} #{checked_in_str}#{prefix_suffix}\r\n"
        res.send output
      catch e
        res.send "Discourse data for #{groupname} group is unavailable."
