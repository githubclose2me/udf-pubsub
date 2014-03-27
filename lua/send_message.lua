local as_pub = require "as_publish"

function notify(rec, value)
    pipe = as_pub.connect("/tmp/aspub")
    as_pub.push(pipe, value)
    as_pub.disconnect(pipe)
end