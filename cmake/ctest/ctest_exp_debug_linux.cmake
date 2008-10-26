#------------------------------------------------
# Experimental LINUX tests
# Debug with Coverage and MemoryCheck
#------------------------------------------------
SET (CTEST_SOURCE_NAME Trilinos)
SET (TEST_TYPE nightly)
SET (BUILD_TYPE debug)

SET (CTEST_DASHBOARD_ROOT /var/dashboards)
SET (CTEST_CMAKE_COMMAND "\"${CMAKE_EXECUTABLE_NAME}\"")

# Options for Nightly builds
SET (CTEST_BACKUP_AND_RESTORE TRUE)
SET (CTEST_START_WITH_EMPTY_BINARY_DIRECTORY TRUE)
SET (CTEST_CVS_CHECKOUT
  "cvs -Q -d :ext:$ENV{USER}@software.sandia.gov:/space/CVS co -d \"${CTEST_SOURCE_NAME}\" ${CTEST_SOURCE_NAME}"
)

SET (CTEST_BINARY_NAME Trilinos-${TEST_TYPE}-${BUILD_TYPE})
SET (CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${CTEST_SOURCE_NAME}")
SET (CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${CTEST_BINARY_NAME}")

SET (CTEST_COMMAND 
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalStart"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalUpdate"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalConfigure"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalBuild"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalSubmit"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalTest"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalCoverage"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalSubmit"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalMemCheck"
  "\"${CTEST_EXECUTABLE_NAME}\" -D ExperimentalSubmit"
)

SET (CTEST_INITIAL_CACHE "

Trilinos_ENABLE_ALL_PACKAGES:BOOL=ON
Trilinos_ENABLE_TESTS::BOOL=ON
Trilinos_ENABLE_EXAMPLES::BOOL=ON
Trilinos_ENABLE_DEPENCENCY_UNIT_TESTS::BOOL=OFF
#Trilinos_ENABLE_FORTRAN:BOOL=ON
#Teuchos_ENABLE_COMPLEX:BOOL=ON
#Teuchos_ENABLE_EXTENDED:BOOL=ON

Trilinos_ENABLE_MPI:BOOL=ON
MPI_EXTRA_LIBRARY:STRING=" "

BUILDNAME:STRING=$ENV{HOSTTYPE}-${TEST_TYPE}-${BUILD_TYPE}

CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE}

CMAKE_CXX_FLAGS:STRING=-g -O0 -Wall -W -Wshadow -Wunused-variable -Wunused-function -Wno-system-headers -Wno-deprecated -Woverloaded-virtual -Wwrite-strings -fprofile-arcs -ftest-coverage -fexceptions

CMAKE_C_FLAGS:STRING=-g -O0 -Wall -W -fprofile-arcs -ftest-coverage -fexceptions

CMAKE_EXE_LINKER_FLAGS:STRING=-fprofile-arcs -ftest-coverage

MAKECOMMAND:STRING=gmake -j 4
")


