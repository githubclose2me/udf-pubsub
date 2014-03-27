gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/as_publish.d" -MT"src/as_publish.d" -o "./src/as_publish.o" "src/udf_push.c" -std=gnu99 -g -rdynamic -Wall -fno-common -fno-strict-aliasing -fPIC -DMARCH_x86_64 -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_GNU_SOURCE -DMEM_COUNT
gcc -shared -o "as_publish.so"  ./src/as_publish.o -laerospike -lssl -lcrypto -lpthread -lrt -llua -lm
