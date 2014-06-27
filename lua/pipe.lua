-- Define the table that will hold the functions to be exported.
local pipe = {};

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
  print("Creating the pipe: " .. name)
  --TODO check existence
  local cmd_status = os.execute("mkfifo "..name)

  if cmd_status == nil then
    print("[Error] Couldn't "..name.." Pipe")
    return nil
  else
    print("Opening the "..name.." pipe...")
    local pipefd, _, _ = io.open(name, "w")
    if not pipefd then
        print("[Error] Couldn't open "..name.." pipe.")
    else
        print(name.." pipe has opened successfully.")
    end
    return pipefd
  end
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
  pipefd:write(value)
end

-- ======================================================================
-- Function disconnect: Disconnects to a named pipe.
-- Parms 
-- (1) pipefd: File descriptor of a named pipe
--
-- ======================================================================
function pipe.disconnect(pipefd)
  pipefd:flush()
  io.close(pipefd)
end
-- ======================================================================
-- Export the Table for those who want to import this module and its
-- functions.
-- ======================================================================
return pipe