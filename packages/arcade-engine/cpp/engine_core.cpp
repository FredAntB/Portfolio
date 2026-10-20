#include "engine_core.hpp"

EngineState g_engine;

void init_engine_core(uint32_t width, uint32_t height)
{
    g_engine.screen_width = width;
    g_engine.screen_height = height;
    g_engine.framebuffer.assign(width * height, 0xFF000000);
    g_engine.active_game = GAME_NONE;
    g_engine.active_haskell_ptr = nullptr;
}

void clear_framebuffer(uint32_t color)
{
    std::fill(g_engine.framebuffer.begin(), g_engine.framebuffer.end(), color);
}

void draw_pixel_raw(int x, int y, uint32_t color)
{
    if (x >= 0 && x < (int)g_engine.screen_width && y >= 0 && y < (int)g_engine.screen_height)
    {
        g_engine.framebuffer[y * g_engine.screen_width + x] = color;
    }
}