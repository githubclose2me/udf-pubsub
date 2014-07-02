local p = require "pipe"

  local pipe_name = "/Users/peter/aspub"
--  if not p.exists(pipe_name) then
    p.create(pipe_name)
--  end
  local pfd = p.connect(pipe_name)
  if (pfd ~= nill) then
    p.write(pfd, "cats")
    p.disconnect(pfd)
  end


