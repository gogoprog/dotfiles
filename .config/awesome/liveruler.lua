local liveruler = {}

local naughty
local awful

function liveruler.init(_naughty, _awful)
  naughty = _naughty
  awful = _awful
  naughty.notify({ text = "liveruler is loading"})
end

function liveruler.apply(klass, screen_index, tag)
  naughty.notify({ text = "liveruler saving: " .. klass .. " " .. screen_index ..  " " .. tag})
  table.insert(awful.rules.rules, { rule = { class = klass }, properties = { screen = screen_index, tag = screen[screen_index].tags[tag]} })
end

function liveruler.save(c)
  local tag = c:tags()[1].name
  local screen = c.screen.index

  liveruler.apply(c.class, screen, tag)
end

return liveruler
