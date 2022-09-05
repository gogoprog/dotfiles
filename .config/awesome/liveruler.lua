local liveruler = {}

local naughty
local awful

function liveruler.init(_naughty, _awful)
  naughty = _naughty
  awful = _awful
  naughty.notify({ text = "liveruler is loading"})
end

function liveruler.apply(klass, screen_index, tag_index)

  for i,v in ipairs(awful.rules.rules) do
    if v.rule ~= nil and v.rule.class == klass then
      if v.properties ~= nil and v.properties.screen == screen_index then
        if v.properties.tag == screen[screen_index].tags[tag_index] then
          naughty.notify({ text = "liveruler remove rule: " .. klass .. " " .. screen_index ..  " " .. tag_index})
          table.remove(awful.rules.rules, i)
          return
        end
      end
    end
  end

  naughty.notify({ text = "liveruler add rule: " .. klass .. " " .. screen_index ..  " " .. tag_index})
  table.insert(awful.rules.rules, { rule = { class = klass }, properties = { screen = screen_index, tag = screen[screen_index].tags[tag_index]} })
end

function liveruler.save(c)
  local tag = c:tags()[1].index
  local screen = c.screen.index

  liveruler.apply(c.class, screen, tag)
end

return liveruler
