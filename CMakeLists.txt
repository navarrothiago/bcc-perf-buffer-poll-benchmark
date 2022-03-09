cmake_minimum_required(VERSION 3.0.0)
project(perf-buffer-bench VERSION 0.1.0)

set (CMAKE_CXX_STANDARD 11)

include(CTest)
enable_testing()

# add_library(hook_lib SHARED hook.c)
add_executable(hook hook.c)

# target_link_libraries(hook hook_lib)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
