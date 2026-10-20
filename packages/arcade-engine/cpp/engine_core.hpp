#ifndef ENGINE_CORE_HPP
#define ENGINE_CORE_HPP

#include "engine_state.hpp"

void init_engine_core(uint32_t width, uint32_t height);
void clear_framebuffer(uint32_t color);
void draw_pixel_raw(int x, int y, uint32_t color);

#endif