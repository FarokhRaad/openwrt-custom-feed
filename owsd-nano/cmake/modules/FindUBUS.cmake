find_package(PkgConfig)
pkg_check_modules(PC_UBUS QUIET ubus)

find_path(UBUS_INCLUDE_DIR ubus.h
  HINTS ${PC_UBUS_INCLUDEDIR} ${PC_UBUS_INCLUDE_DIRS}
)

find_library(UBUS_LIBRARY ubus
  HINTS ${PC_UBUS_LIBDIR} ${PC_UBUS_LIBRARY_DIRS}
)

set(UBUS_LIBRARIES ${UBUS_LIBRARY})
set(UBUS_INCLUDE_DIRS ${UBUS_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(UBUS DEFAULT_MSG UBUS_LIBRARIES UBUS_INCLUDE_DIRS)

mark_as_advanced(UBUS_INCLUDE_DIRS UBUS_LIBRARIES)
