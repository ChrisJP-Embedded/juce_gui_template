cmake_minimum_required(VERSION 3.22)

project(juce_app VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Optional place for shared project config later
list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_SOURCE_DIR}/modules/cmake-includes"
)
include(JuceProject OPTIONAL)

# JUCE lives here (as submodule)
set(JUCE_PATH "${CMAKE_SOURCE_DIR}/modules/JUCE")
add_subdirectory(${JUCE_PATH} JUCE)

# JUCE GUI app target
juce_add_gui_app(juce_app
    PRODUCT_NAME "app"
    VERSION "0.1.0"
)

juce_generate_juce_header(juce_app)

target_sources(juce_app
    PRIVATE
        app/src/Main.cpp
        app/src/MainComponent.cpp
        app/inc/MainComponent.h
)

target_include_directories(juce_app
    PRIVATE
        app/inc
)

target_compile_definitions(juce_app
    PRIVATE
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:juce_app,JUCE_PRODUCT_NAME>"
        JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:juce_app,JUCE_VERSION>"
)

target_link_libraries(juce_app
    PRIVATE
        juce::juce_gui_extra
        juce::juce_gui_basics
        juce::juce_graphics
        juce::juce_core
)
