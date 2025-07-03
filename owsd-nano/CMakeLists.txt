cmake_minimum_required(VERSION 3.9)
project(owsd C)

add_definitions(-Os -std=gnu11 -D_XOPEN_SOURCE=700)

set(CMAKE_INTERPROCEDURAL_OPTIMIZATION FALSE)

set(SOURCES
    src/main.c
    src/ws_http.c
    src/ws_http_serve.c
    src/wsubus.c
    src/rpc.c
    src/rpc_call.c
    src/rpc_list.c
    src/rpc_sub.c
    src/access_check.c
    src/util_jsonrpc.c
    src/ubusx_acl.c
)

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBWEBSOCKETS REQUIRED libwebsockets)
pkg_check_modules(LIBUBOX REQUIRED libubox)
pkg_check_modules(JSON_C REQUIRED json-c)
pkg_check_modules(UBUS REQUIRED ubus)

include_directories(
    ${LIBWEBSOCKETS_INCLUDE_DIRS}
    ${LIBUBOX_INCLUDE_DIRS}
    ${JSON_C_INCLUDE_DIRS}
    ${UBUS_INCLUDE_DIRS}
)

add_executable(owsd ${SOURCES})

target_link_libraries(owsd
    ${LIBWEBSOCKETS_LIBRARIES}
    ${LIBUBOX_LIBRARIES}
    ${JSON_C_LIBRARIES}
    ${UBUS_LIBRARIES}
)

install(TARGETS owsd RUNTIME DESTINATION usr/bin)
