requires "pipe"

  pfd = pipe.connect("/tmp/aspub")
  pipe.write(pfd, "cats")
  pipe.disconnect(pfd)
