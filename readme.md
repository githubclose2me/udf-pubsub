#Writing to a named Pipe in UDF
##Problem
You want to emit an event when you perform an operation a single record, but there is no in-built
way to do this in Aerospike.
##Solution
Perform the operation via a [UDF](https://docs.aerospike.com/display/V3/User-Defined+Function+Guide), and write and event message to a named pipe. 
Construct a shared library in C that writes to a named pipe, 
this library will be called from the Lua UDF. See [Calling C from a UDF](https://docs.aerospike.com/pages/viewpage.action?pageId=3807960#LuaUDF–DevelopingLuaModules-ModuleswritteninC).
Construct a reader for the named pipe to process the event.
### Build steps
#### Step 1
Clone the GitHub repositry at <some place>
#### Step 2
Build the as_publish.so by running the script:
```
./build_linux.sh
```
#### Step 4
Copy the shared library ```as_publish.so``` to the directory ```/opt/citrusleaf/usr/udf/lua``` on each node in your cluster. 
__Important__ C modules are not automatically registered or propogated to all nodes in the cluster, you need to do it manually.
#### Step 5
Register the UDF module located at lua/send_message.lua, by using the following command from the project root directory
```
ascli udf-put lua/send_message.lua
``` 

### Running the example
You could write and application using the Aerospike APIs to test this example, but rather than writing code, you can use the commandline utility of [ASCLI](https://docs.aerospike.com/pages/viewpage.action?pageId=3807525).
Run the following ASCLI command from the root directory of the project
```
ascli udf-record-apply test test "peter001" send_message notify "Hello World!"
```
This will invoke the function ```notify``` in the package ```send_message```, on the namespace ```test```, the set ```test``` and key ```"peter001"```, and pass it the parameter ```"hello World!"```
##Discussion

