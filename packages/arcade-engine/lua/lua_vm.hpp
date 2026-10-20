#ifndef LUA_VM_HPP
#define LUA_VM_HPP

void init_lua_vm();
void load_game_lua_script(const char *script_path);
void render_lua_frame();
void shutdown_lua_vm();

#endif