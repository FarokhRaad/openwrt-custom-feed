# LIBUBUS_FOUND - true if library and headers were found
# LIBUBUS_INCLUDE_DIRS - include directories
# LIBUBUS_LIBRARIES - library directories

# Try pkg-config first, but don't fail if not found
find_package(PkgConfig)
pkg_check_modules(PC_LIBUBUS QUIET ubus)

if(PC_LIBUBUS_FOUND)
  set(LIBUBUS_INCLUDE_DIRS ${PC_LIBUBUS_INCLUDEDIR} ${PC_LIBUBUS_INCLUDE_DIRS})
  find_library(LIBUBUS_LIBRARY NAMES ubus libubus HINTS ${PC_LIBUBUS_LIBDIR} ${PC_LIBUBUS_LIBRARY_DIRS})
else()
  # Manually specify known OpenWrt staging paths (adjust as needed)
  set(LIBUBUS_INCLUDE_DIRS "${CMAKE_SYSROOT}/usr/include")
  find_library(LIBUBUS_LIBRARY NAMES ubus libubus HINTS "${CMAKE_SYSROOT}/usr/lib")
endif()

set(LIBUBUS_LIBRARIES ${LIBUBUS_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBUBUS DEFAULT_MSG LIBUBUS_LIBRARIES LIBUBUS_INCLUDE_DIRS)

mark_as_advanced(LIBUBUS_INCLUDE_DIRS LIBUBUS_LIBRARIES)
