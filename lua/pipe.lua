local posix = require("posix_c")
-- Define the table that will hold the functions to be exported.
local pipe = {};
  
function pipe.exists(fileName)
  local file = posix.open(fileName, posix.O_WRONLY, "")
  if file ~= nil then
    io.close(file)
    print(fileName.." exists")
    return true
  else
    print(fileName.." does not exist")
    return false
  end
end

function pipe.create(name)
  print("Creating the pipe: " .. name)
  local handle, msg = posix.mkfifo(name)

  if handle == nil then
    print("[Error] Couldn't open "..name.." pipe. "..msg)
    return false
  else
    return true
  end
end


-- ======================================================================
-- Function connect: Connects to a named pipe. 
-- Parms 
-- (1) name: The fully qualified name of the pipe
--
-- Return:
-- true if created successfully
-- false is unsuccessful
-- ======================================================================
function pipe.connect(name)
    print("Opening the "..name.." pipe...")
    local pipefd, err_msg = posix.open(fileName, posix.O_WRONLY)-- + posix.O_NONBLOCK)
    if pipefd == nil then
      print ("Cannot open pipe "..name)
    else
      print("Opened the "..name.." pipe successfully")
    end
    return pipefd
end

-- ======================================================================
-- Function write: Writes to a named pipe.
-- Parms 
-- (1) pipefd: File descriptor of a named pipe
-- (2) value: The value to be writtern to the pipe

-- Return:
-- file descriptor to the named pipe if successful
-- nil is unsuccessful
-- ======================================================================
function pipe.write(pipefd, value)
  posix.write(pipefd, value)
end

-- ======================================================================
-- Function disconnect: Disconnects to a named pipe.
-- Parms 
-- (1) pipefd: File descriptor of a named pipe
--
-- ======================================================================
function pipe.disconnect(pipefd)
  pipefd:flush()
  posix.close(pipefd)
end
-- ======================================================================
-- Export the Table for those who want to import this module and its
-- functions.
-- ======================================================================
return pipe