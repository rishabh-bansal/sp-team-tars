# Description:
#   Returns information for the given timezone
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot show timezone <timezone>
#
# Author:
#   cpradio

module.exports = (robot) ->
  robot.respond /show timezone (.*)/i, (msg) ->
    searchMe msg, "current time in #{msg.match[1]} site:worldtimezone.com", (text) ->
      msg.send text

searchMe = (msg, query, cb) ->
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  msg.http('http://ajax.googleapis.com/ajax/services/search/web')
    .query(q)
    .get() (err, res, body) ->
      searchResults = JSON.parse(body)
      searchResults = searchResults.responseData?.results
      if searchResults?.length > 0
        cb searchResults[0].content.replace(/(<([^>]+)>)/ig, '')
