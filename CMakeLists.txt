project(trace-summary NONE)
# Python is checked as a dependency below
cmake_minimum_required(VERSION 2.6.3 FATAL_ERROR)
include(cmake/CommonCMakeConfig.cmake)

########################################################################
## Dependency Configuration

find_package(PythonInterp)

if (NOT PYTHON_EXECUTABLE)
    message(FATAL_ERROR "A Python installation is required.")
endif ()

if (NOT SUBNETTREE_FOUND)
    # the check for SubnetTree is ignored if SubnetTree_FOUND is set
    # in the cache or by another project that is including this one
    execute_process(COMMAND ${PYTHON_EXECUTABLE} -c "import SubnetTree"
                    RESULT_VARIABLE SUBNETTREE_IMPORT_RESULT)

    if (SUBNETTREE_IMPORT_RESULT)
        message(FATAL_ERROR "Could not find required dependency: SubnetTree")
    endif ()
endif ()

# Check cache value first to avoid displaying "Found" messages everytime
if (NOT IPSUMDUMP_EXE)
    find_program(IPSUMDUMP_EXE ipsumdump)
    if (NOT IPSUMDUMP_EXE)
        message(WARNING "Could not find dependency: 'ipsumdump', "
                        "trace-summary will not be able to read pcap traces")
    else ()
        message(STATUS "Found ipsumdump: ${IPSUMDUMP_EXE}")
    endif ()
endif ()

########################################################################
## Install Files

install(PROGRAMS trace-summary DESTINATION bin)

########################################################################
## Build Summary

message(
    "\n=============|  trace-summary Install Summary  |================"
    "\n"
    "\nInstall destination:    ${CMAKE_INSTALL_PREFIX}/bin"
    "\n"
    "\n================================================================\n"
)

include(UserChangedWarning)
