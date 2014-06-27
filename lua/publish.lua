require "pipe"

function notify(rec, value)
  pfd = pipe.connect("/tmp/aspub")
  pipe.write(pfd, value)
  pipe.disconnect(pfd)
end