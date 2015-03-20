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

last_checkin_date = new Date();
last_checkin_date.setHours(0,0,0,0);
dif = (last_checkin_date.getDay() + 6) % 7;
last_checkin_date = new Date(last_checkin_date - dif * 24*60*60*1000);

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
      
      last_seen_as_date = new Date(last_seen)
      checked_in = last_seen_as_date > last_checkin_date
      checkin_date_str = last_checkin_date.toDateString()
      checked_in_str = if checked_in then "(checked in, last check-in date: #{checkin_date_str})" else "(not checked in, last check-in date: #{checkin_date_str})"
      prefix_suffix = if checked_in then "" else "*"
      
      res.send "Discourse Info: User #{username}\r\n     #{prefix_suffix}Last seen on #{last_seen} #{checked_in_str}#{prefix_suffix}\r\n     Last posted on #{last_posted}"
