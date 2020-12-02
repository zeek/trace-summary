cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
project(trace-summary NONE)
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

########################################################################
## Install Files

include(InstallShellScript)

if ( NOT ZEEK_MAN_INSTALL_PATH )
    set(ZEEK_MAN_INSTALL_PATH ${CMAKE_INSTALL_PREFIX}/share/man)
endif ()

InstallShellScript(bin trace-summary)
install(FILES trace-summary.1 DESTINATION ${ZEEK_MAN_INSTALL_PATH}/man1)

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
