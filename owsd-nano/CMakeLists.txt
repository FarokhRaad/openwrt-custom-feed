cmake_minimum_required(VERSION 3.10)
project(owsd-nano C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

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

# Find packages
find_package(LIBWEBSOCKETS REQUIRED)
find_package(LIBUBOX REQUIRED)
find_package(LIBUBUS REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(JSONC REQUIRED json-c)

include_directories(
    ${CMAKE_SOURCE_DIR}/src
    ${LIBWEBSOCKETS_INCLUDE_DIRS}
    ${LIBUBOX_INCLUDE_DIRS}
    ${UBUS_INCLUDE_DIRS}
    ${JSONC_INCLUDE_DIRS}
)

add_executable(owsd-nano ${SRC_FILES})

target_compile_options(owsd-nano PRIVATE -Os -Wall -Wextra)

target_link_libraries(owsd-nano
    ${LIBWEBSOCKETS_LIBRARIES}
    ${LIBUBOX_LIBRARIES}
    ${UBUS_LIBRARIES}
    ${JSONC_LIBRARIES}
)

install(TARGETS owsd-nano RUNTIME DESTINATION bin)