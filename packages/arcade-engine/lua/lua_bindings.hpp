#ifndef LUA_BINDINGS_HPP
#define LUA_BINDINGS_HPP

struct lua_State;

// Registers native C++ drawing and input querying functions into the Lua global environment
void register_lua_bindings(lua_State *L);

#endif