import os
import cPickle


class App():

    def __init__(self):
        self.stdin_path = '/dev/null'
        self.stdout_path = '/dev/tty'
        self.stderr_path = '/dev/tty'
        self.pidfile_path = '/var/run/mydaemon.pid'
        self.pidfile_timeout = 5

filepath = '/Users/peter/aspub'
try:
    os.mkfifo(filepath)
except OSError:
    pass

pipe_fd = open(filepath, "r") 
for line in pipe_fd:
    print( line )
pipe_fd.close()

