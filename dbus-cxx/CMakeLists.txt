cmake_minimum_required(VERSION 3.2)

project(dbus-cxx)

include(ExternalProject)

# Build dbus-cxx
execute_process(COMMAND ${PROJECT_SOURCE_DIR}autogen.sh
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE cmd_output
    ERROR_VARIABLE cmd_error)
message(STATUS "Generating configuration: ${cmd_output} ${cmd_error}")

ExternalProject_Add(dbuscxx
    PREFIX ${PROJECT_SOURCE_DIR}
    SOURCE_DIR ${PROJECT_SOURCE_DIR}
    # DBUS_CXX_BUILD_DIR should be defined
    CONFIGURE_COMMAND ${PROJECT_SOURCE_DIR}/configure --prefix=${DBUS_CXX_BUILD_DIR}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)