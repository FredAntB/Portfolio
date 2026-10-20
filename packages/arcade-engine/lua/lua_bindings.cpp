#include "lua_bindings.hpp"
#include "engine_core.hpp"
#include <lua.hpp>

static int l_draw_pixel(lua_State *L)
{
    int x = (int)luaL_checkinteger(L, 1);
    int y = (int)luaL_checkinteger(L, 2);
    uint32_t color = (uint32_t)luaL_checkinteger(L, 3);
    draw_pixel_raw(x, y, color);
    return 0;
}

static int l_clear_screen(lua_State *L)
{
    uint32_t color = (uint32_t)luaL_checkinteger(L, 1);
    clear_framebuffer(color);
    return 0;
}

void register_lua_bindings(lua_State *L)
{
    lua_register(L, "draw_pixel", l_draw_pixel);
    lua_register(L, "clear_screen", l_clear_screen);
}