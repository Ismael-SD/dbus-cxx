cmake_minimum_required(VERSION 3.2)

project(demo)

include(ExternalProject)

# Build dbus-cxx
execute_process(COMMAND ${PROJECT_SOURCE_DIR}/dbus-cxx/autogen.sh
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/dbus-cxx
    OUTPUT_VARIABLE cmd_output
    ERROR_VARIABLE cmd_error)
message(STATUS "Generating configuration: ${cmd_output} ${cmd_error}")

ExternalProject_Add(dbuscxx
    PREFIX ${PROJECT_SOURCE_DIR}/dbus-cxx
    SOURCE_DIR ${PROJECT_SOURCE_DIR}/dbus-cxx
    # Should install includes to ./include/dbus-cxx-XXX and libs to ./lib/
    CONFIGURE_COMMAND ${PROJECT_SOURCE_DIR}/dbus-cxx/configure --prefix=${PROJECT_SOURCE_DIR}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)

set(PKG_CONFIG_PATH "${PROJECT_SOURCE_DIR}/lib/pkgconfig")

find_package(PkgConfig)
pkg_check_modules(DBUS REQUIRED "dbus-cxx-1.0")

add_executable(server quickstart_server_0.cpp)
add_executable(client quickstart_client_0.cpp)

message(STATUS "dbus libs: ${DBUS_LIBRARIES}")
target_link_libraries(server ${DBUS_LIBRARIES})
target_link_libraries(client ${DBUS_LIBRARIES})

message(STATUS "dbus includes: ${DBUS_INCLUDE_DIRS}")
target_include_directories(server PUBLIC ${DBUS_INCLUDE_DIRS})
target_include_directories(client PUBLIC ${DBUS_INCLUDE_DIRS})

message(STATUS "dbus cflags other: ${DBUS_CFLAGS_OTHER}")
target_compile_options(server PUBLIC ${DBUS_CFLAGS_OTHER})
target_compile_options(client PUBLIC ${DBUS_CFLAGS_OTHER})