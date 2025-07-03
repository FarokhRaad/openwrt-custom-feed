cmake_minimum_required(VERSION 3.10)
project(owsd-nano C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
add_definitions(-Os -Wall -Wextra -std=gnu11)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules" ${CMAKE_MODULE_PATH})

set(SRC_FILES
    src/main.c
    src/access_check.c
    src/rpc.c
    src/rpc_call.c
    src/rpc_list.c
    src/rpc_sub.c
    src/ubusx_acl.c
    src/util_jsonrpc.c
    src/wsubus.c
    src/ws_http.c
    src/ws_http_serve.c
)

find_package(libwebsockets REQUIRED)
find_package(LIBUBOX REQUIRED)
find_package(UBUS REQUIRED)
find_library(JSONC_LIBRARY NAMES json-c json)
find_path(JSONC_INCLUDE_DIR json-c/json.h)

if(NOT JSONC_LIBRARY OR NOT JSONC_INCLUDE_DIR)
    message(FATAL_ERROR "libjson-c not found")
endif()

include_directories(
    ${CMAKE_SOURCE_DIR}/src
    ${LIBWEBSOCKETS_INCLUDE_DIRS}
    ${LIBUBOX_INCLUDE_DIRS}
    ${UBUS_INCLUDE_DIRS}
    ${JSONC_INCLUDE_DIR}
)

add_executable(owsd-nano ${SRC_FILES})

target_link_libraries(owsd-nano
    ${LIBWEBSOCKETS_LIBRARIES}
    ${LIBUBOX_LIBRARIES}
    ${UBUS_LIBRARIES}
    ${JSONC_LIBRARY}
)

install(TARGETS owsd-nano RUNTIME DESTINATION bin)
