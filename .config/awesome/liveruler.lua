local liveruler = {}

local naughty
local awful

function liveruler.init(_naughty, _awful)
  naughty = _naughty
  awful = _awful
  naughty.notify({ text = "liveruler is loading"})
end

function liveruler.apply(klass, screen_index, tag_index)
  naughty.notify({ text = "liveruler saving: " .. klass .. " " .. screen_index ..  " " .. tag_index})
  table.insert(awful.rules.rules, { rule = { class = klass }, properties = { screen = screen_index, tag = screen[screen_index].tags[tag_index]} })
end

function liveruler.save(c)
  local tag = c:tags()[1].index
  local screen = c.screen.index

  liveruler.apply(c.class, screen, tag)
end

return liveruler
