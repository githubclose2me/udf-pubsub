
#include <lua.h>                               /* Always include this */
#include <lauxlib.h>                           /* Always include this */
#include <lualib.h>                            /* Always include this */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <limits.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <aerospike/aerospike.h>
#include <aerospike/aerospike_key.h>
#include <aerospike/as_error.h>
#include <aerospike/as_key.h>
#include <aerospike/as_record.h>
#include <aerospike/as_record_iterator.h>
#include <aerospike/as_iterator.h>
#include <aerospike/as_status.h>

static int connect(lua_State *L){
	const char *fifo_name = luaL_checkstring(L, 1);
	int pipe_fd;
	int res = 0;
	int err_code;
	char *err_msg;

	if (access(fifo_name, W_OK)== -1){
		res = mkfifo(fifo_name, 0777);
		if (res != 0){
			err_code = res;
			err_msg = strerror( errno );
		}
	}

	if (res == 0)
		pipe_fd =  open(fifo_name, O_WRONLY | O_NONBLOCK);


	/* Push the return */
	lua_pushnumber(L, errno);
	lua_pushstring(L, strerror( errno ));
	lua_pushlightuserdata(L, pipe_fd);
	return 3;
}

static int disconnect(lua_State *L){
	int pipe_fd = lua_touserdata(L, 1);

	close(pipe_fd);

	/* Push the return */
	lua_pushnumber(L, errno);
	return 2;
}


static const struct luaL_Reg publish [] = {
		{"connect", connect},
		{"disconnect", disconnect},
		{NULL, NULL}
};

extern int luaopen_as_lua(lua_State *L){
	luaL_register(L, "publish", publish);
	return 0;
}

