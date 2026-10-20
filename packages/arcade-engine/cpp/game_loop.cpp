#include "game_loop.hpp"
#include "engine_core.hpp"
#include "lua_vm.hpp"

// C-ABI imports exported by Haskell FFI
extern "C"
{
    void *step_sokoban(void *ptr, int dirCode);
    void *step_jigsaw(void *ptr, int dirCode);
}

void engine_tick(int dir_code)
{
    if (g_engine.active_haskell_ptr != nullptr && dir_code >= 0)
    {
        if (g_engine.active_game == GAME_SOKOBAN)
        {
            g_engine.active_haskell_ptr = step_sokoban(g_engine.active_haskell_ptr, dir_code);
        }
        else if (g_engine.active_game == GAME_JIGSAW)
        {
            g_engine.active_haskell_ptr = step_jigsaw(g_engine.active_haskell_ptr, dir_code);
        }
    }

    // Call Lua VM frame hooks to render current scene
    render_lua_frame();
}