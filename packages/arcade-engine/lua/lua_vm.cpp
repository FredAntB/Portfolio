#include "lua_vm.hpp"
#include "lua_bindings.hpp"
#include <lua.hpp>
#include <stdio.h>

static lua_State *L = nullptr;

void init_lua_vm()
{
    L = luaL_newstate();
    luaL_openlibs(L);
    register_lua_bindings(L);

    if (luaL_dofile(L, "/lua/bootstrap.lua") != LUA_OK)
    {
        printf("[Lua Error] %s\n", lua_tostring(L, -1));
        lua_pop(L, 1);
    }
}

void load_game_lua_script(const char *script_path)
{
    if (!L)
        return;
    if (luaL_dofile(L, script_path) != LUA_OK)
    {
        printf("[Lua Error] Failed loading %s: %s\n", script_path, lua_tostring(L, -1));
        lua_pop(L, 1);
    }
}

void render_lua_frame()
{
    if (!L)
        return;
    lua_getglobal(L, "draw");
    if (lua_isfunction(L, -1))
    {
        if (lua_pcall(L, 0, 0, 0) != LUA_OK)
        {
            printf("[Lua Draw Error] %s\n", lua_tostring(L, -1));
            lua_pop(L, 1);
        }
    }
    else
    {
        lua_pop(L, 1);
    }
}

void shutdown_lua_vm()
{
    if (L)
    {
        lua_close(L);
        L = nullptr;
    }
}