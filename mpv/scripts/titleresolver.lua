local utils = require("mp.utils")
-- resolve url title and send it back to playlistmanager
mp.register_script_message("resolveurltitle", function(filename)
  local args = { 'youtube-dl', '--no-playlist', '--flat-playlist', '-sJ', filename }
  local res = utils.subprocess({ args = args })
  if res.status == 0 then
    local json, err = utils.parse_json(res.stdout)
    if not err then
      local is_playlist = json['_type'] and json['_type'] == 'playlist'
      local title = (is_playlist and '[playlist]: ' or '') .. json['title']
      mp.commandv('script-message', 'playlistmanager', 'addurl', filename, title)
    end
  end
end)
