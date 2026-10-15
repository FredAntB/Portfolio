cmake_minimum_required(VERSION 3.18)
project(arcade_engine C)

# 1. Source files for C / Lua
set(C_SOURCES
    cpp/main.c
    # cpp/lua_bindings.c
    # add lua source files here if compiling lua from source
)

# 2. Compile C/Lua using Emscripten target
add_executable(arcade_engine ${C_SOURCES})

# Specify output format (e.g., generates dist/arcade_engine.js and .wasm)
set_target_properties(arcade_engine PROPERTIES
    OUTPUT_NAME "arcade_engine"
    SUFFIX ".js"
)

# Pass custom Emscripten flags
target_link_options(arcade_engine PRIVATE
    -sWASM=1
    -sALLOW_MEMORY_GROWTH=1
    # -sEXPORTED_FUNCTIONS=['_main']
)

# 3. Haskell Target via ghc-wasm
find_program(HASKELL_WASM_GHC wasm32-wasi-ghc REQUIRED)

add_custom_target(haskell_wasm_module ALL
    COMMAND ${HASKELL_WASM_GHC} -O2 -o ${CMAKE_BINARY_DIR}/haskell_core.wasm ${CMAKE_SOURCE_DIR}/src/Main.hs
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Compiling Haskell core to WebAssembly via ghc-wasm..."
)