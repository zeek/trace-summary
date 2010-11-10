########################################################################
## CMake Configuration

cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

# Prohibit in-source builds.
if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "In-source CMake builds are not allowed.  CMake "
                        "is not required to build trace-summary, you "
                        "may choose to simply copy it to a directory in "
                        "your PATH")
endif ()

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

########################################################################
## Project/Build Configuration

project(trace-summary)

########################################################################
## Dependency Configuration

find_package(PythonInterp REQUIRED)

execute_process(COMMAND ${PYTHON_EXECUTABLE} -c "import SubnetTree"
                RESULT_VARIABLE SUBNETTREE_IMPORT_RESULT)

if (SUBNETTREE_IMPORT_RESULT)
    message(FATAL_ERROR "Could not find required dependency: SubnetTree")
endif ()

# Check cache value first to avoid displaying "Found" messages everytime
if (NOT IPSUMDUMP_EXE)
    find_program(IPSUMDUMP_EXE ipsumdump)
    if (NOT IPSUMDUMP_EXE)
        message(FATAL_ERROR "Could not find required dependency: ipsumdump")
    else ()
        message(STATUS "Found ipsumdump: ${IPSUMDUMP_EXE}")
    endif ()
endif ()

########################################################################
## Install Files

install(PROGRAMS trace-summary DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

########################################################################
## Build Summary

message(
    "\n=============|  trace-summary Install Summary  |================"
    "\n"
    "\nInstall desination:    ${CMAKE_INSTALL_PREFIX}/bin"
    "\n"
    "\n================================================================\n"
)
