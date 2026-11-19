-- Register every nvim as an nvs session for the directory it was started in,
-- so ~/scripts/nvs (and clicking paths in urxvt) can send files to it.
-- Socket naming must match sock_for() in ~/scripts/nvs.

local dir = (vim.env.XDG_RUNTIME_DIR or '/tmp') .. '/nvs'

local function sock_for(root)
  local name = root:gsub('/', '%%')
  if #dir + #name > 100 then
    local hash = vim.fn.system({ 'md5sum' }, root):sub(1, 8)
    name = vim.fn.fnamemodify(root, ':t') .. '-' .. hash
  end
  return dir .. '/' .. name
end

local function write(path, text)
  local f = io.open(path, 'w')
  if f then f:write(text); f:close() end
end

local function in_use(sock)
  if vim.fn.getftype(sock) ~= 'socket' then return false end
  local ok, ch = pcall(vim.fn.sockconnect, 'pipe', sock, { rpc = true })
  if ok and ch > 0 then vim.fn.chanclose(ch); return true end
  return false
end

local root = vim.fn.getcwd()
local sock = sock_for(root)

-- already started by `nvs start` with --listen on the right socket
for _, addr in ipairs(vim.fn.serverlist()) do
  if addr == sock then return end
end

-- another nvim already owns this directory: leave it alone
if in_use(sock) then return end

vim.fn.mkdir(dir, 'p')
os.remove(sock)
if pcall(vim.fn.serverstart, sock) then
  write(sock .. '.root', root)
  write(sock .. '.pid', tostring(vim.fn.getpid()))
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      os.remove(sock .. '.root'); os.remove(sock .. '.pid')
    end,
  })
end
