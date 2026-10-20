#include <emscripten.h>
#include <stdio.h>
#include "engine_core.hpp"
#include "game_loop.hpp"
#include "lua_vm.hpp"

extern "C"
{

    EMSCRIPTEN_KEEPALIVE
    void init_engine(int width, int height)
    {
        init_engine_core(width, height);
        init_lua_vm();
        printf("[C++ Host] Engine initialized (%dx%d)\n", width, height);
    }

    EMSCRIPTEN_KEEPALIVE
    void update_engine(int dir_code)
    {
        engine_tick(dir_code);
    }

    EMSCRIPTEN_KEEPALIVE
    uint32_t *get_framebuffer_ptr()
    {
        return g_engine.framebuffer.data();
    }
}

int main()
{
    printf("[C++ Host] Main WASM loaded.\n");
    return 0;
}