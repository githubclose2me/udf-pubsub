LOG_PIPE = "/tmp/aspub"
--- Create the logs pipe
function create_pipe()
    print("Creating the pipe...")
 
    local cmd_status = os.execute("rm -f " .. LOG_PIPE .. ";" ..
        "mkfifo " .. LOG_PIPE)
 
    if cmd_status == nil then
        print("[Error] Couldn't create the  Pipe")
    else
        print("Logs' pipe was created")
    end
end
 
--- Open the logs' pipe
-- @return the logs' pipe descriptor
function open_pipe()
    print("Opening the Logs' pipe...")
 
    local logfd = assert( io.open(LOG_PIPE, "w") )
 
    if not logfd then
        print("[Error] Couldn't open the Logs' pipe.")
    else
        print("Logs' pipe has opened successfully.")
    end
 
    return logfd
end
 
---create_pipe()
pipe = open_pipe()
 
for count = 1, 1000, 1 do
    pipe:write(pipe, "cats\n"); print("line:", count)
end
