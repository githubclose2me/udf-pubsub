
#include <lua.h>                               /* Always include this */
#include <lauxlib.h>                           /* Always include this */
#include <lualib.h>                            /* Always include this */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

typedef struct pipe_s {
	char* name;
	int fd;
} push_pipe;

static int connect(lua_State *L){

	push_pipe* p_pipe = malloc(sizeof(pipe));
	p_pipe->name = luaL_checkstring(L, 1);

	/*make the FIFO named pipe*/
	mkfifo(p_pipe->name, 0666);

	/* open it */
	p_pipe->fd = open(p_pipe->name, O_WRONLY | O_NONBLOCK);
	/* Push the return */
	lua_pushlightuserdata(L, p_pipe);
	return 1;
}


static int disconnect(lua_State *L){
	push_pipe* p_pipe = lua_touserdata(L, 1);
	close(p_pipe->fd);
	unlink(p_pipe->name);
	free(p_pipe);
	return 0;
}


static int push(lua_State *L){
	push_pipe* p_pipe = lua_touserdata(L, 1);
	char* message = luaL_checkstring(L, 2);
	int ret = write(p_pipe->fd, message, sizeof(message));
	lua_pushnumber(L, ret);
	return 1;
}

static const struct luaL_Reg as_publish [] = {
		{"connect", connect},
		{"disconnect", disconnect},
		{"push", push},
		{NULL, NULL}
};

extern int luaopen_as_publish(lua_State *L){
	luaL_register(L, "as_publish", as_publish);
	return 0;
}
