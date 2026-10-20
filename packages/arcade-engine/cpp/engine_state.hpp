#ifndef ENGINE_STATE_HPP
#define ENGINE_STATE_HPP

#include <stdint.h>
#include <vector>

enum GameType {
    GAME_NONE = 0,
    GAME_SOKOBAN = 1,
    GAME_JIGSAW = 2
};

struct EngineState {
    GameType active_game;
    void* active_haskell_ptr; // Holds Ptr ActiveGameState from Haskell FFI
    uint32_t screen_width;
    uint32_t screen_height;
    std::vector<uint32_t> framebuffer;
};

extern EngineState g_engine;

#endif