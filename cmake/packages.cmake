cmake_minimum_required(VERSION 2.8)

function(YodaLocalPackage NAME)
set(PATH ${NAME})
if(ARGC GREATER 1)
set(PATH ${ARGV1})
endif()

ExternalProject_Add(${NAME}
  SOURCE_DIR packages/${PATH}
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INCLUDE_DIR=${CMAKE_INCLUDE_DIR}
    -DCMAKE_INSTALL_DIR=${CMAKE_INSTALL_DIR}/usr/lib/node_modules/${PATH}
    -DJSRUNTIME_SOURCE_DIR=${JSRUNTIME_SOURCE_DIR}
    -DCMAKE_SYSROOT=${CMAKE_EXTERNAL_SYSROOT}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
endfunction()

function(YodaGitPackage NAME REPO TAG)
set(PATH ${NAME})
if(ARGC GREATER 3)
set(PATH ${ARGV3})
endif()
ExternalProject_Add(${NAME}
  PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/packages/${PATH}
  GIT_REPOSITORY ${REPO}
  GIT_TAG ${TAG}
  TIMEOUT 10
  UPDATE_COMMAND ${GIT_EXECUTABLE} pull
  LOG_DOWNLOAD ON
  CMAKE_ARGS
    -DLIBFFI_LINK_EXTERNAL=YES
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_EXTERNAL_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}
    -DCMAKE_INCLUDE_DIR=${CMAKE_INCLUDE_DIR}
    -DCMAKE_INCLUDE_PATH=${CMAKE_STAGING_PREFIX}/usr/include
    -DCMAKE_INSTALL_DIR=${CMAKE_INSTALL_DIR}/usr/lib/node_modules/${PATH}
    -DCMAKE_SYSROOT=${CMAKE_EXTERNAL_SYSROOT}
    -DCMAKE_SYSTEM_PERFIX_PATH=${CMAKE_SYSTEM_PREFIX_PATH}
    -DCMAKE_STAGING_PERFIX=${CMAKE_STAGING_PREFIX}
    -DCMAKE_LIBRARY_PATH=${CMAKE_LIBRARY_PATH}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
endfunction()

# remote packages
YodaGitPackage(ffi https://github.com/shadow-node/ffi.git master)
YodaGitPackage(node-flock https://github.com/shadow-node/node-flock.git master)
YodaGitPackage(node-caps https://github.com/shadow-node/node-caps.git master @yoda/caps)

# local packages
YodaLocalPackage(yoda-audio @yoda/audio)
YodaLocalPackage(yoda-httpdns @yoda/httpdns)
YodaLocalPackage(yoda-battery @yoda/battery)
YodaLocalPackage(yoda-bluetooth @yoda/bluetooth)
YodaLocalPackage(yoda-bolero @yoda/bolero)
YodaLocalPackage(yoda-cloudgw @yoda/cloudgw)
YodaLocalPackage(yoda-exodus @yoda/exodus)
YodaLocalPackage(yoda-httpsession @yoda/httpsession)
YodaLocalPackage(yoda-input @yoda/input)
YodaLocalPackage(yoda-light @yoda/light)
YodaLocalPackage(yoda-manifest @yoda/manifest)
YodaLocalPackage(yoda-oh-my-little-pony @yoda/oh-my-little-pony)
YodaLocalPackage(yoda-multimedia @yoda/multimedia)
YodaLocalPackage(yoda-ota @yoda/ota)
YodaLocalPackage(yoda-property @yoda/property)
YodaLocalPackage(yoda-system @yoda/system)
YodaLocalPackage(yoda-util @yoda/util)
YodaLocalPackage(yoda-wifi @yoda/wifi)
YodaLocalPackage(yoda-network @yoda/network)
YodaLocalPackage(yoda-env @yoda/env)
YodaLocalPackage(yoda-flora @yoda/flora)
YodaLocalPackage(yodaos-application @yodaos/application)
YodaLocalPackage(yodaos-mediakit @yodaos/mediakit)
YodaLocalPackage(yodaos-effect @yodaos/effect)
YodaLocalPackage(yodaos-keyboard @yodaos/keyboard)
YodaLocalPackage(yodaos-speech-synthesis @yodaos/speech-synthesis)
YodaLocalPackage(yodaos-storage @yodaos/storage)

# root scope packages
YodaLocalPackage(logger)
YodaLocalPackage(lru-cache)
YodaLocalPackage(step)

# Tools
ExternalProject_Add(rklogger
  SOURCE_DIR tools/rklogger
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_DIR}/usr
    -DCMAKE_INCLUDE_DIR=${CMAKE_INCLUDE_DIR}
    -DCMAKE_SYSROOT=${CMAKE_EXTERNAL_SYSROOT}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})

# Activation Service
ExternalProject_Add(activation
  SOURCE_DIR runtime/services/activation
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_DIR}/usr
    -DCMAKE_INCLUDE_DIR=${CMAKE_INCLUDE_DIR}
    -DCMAKE_SYSROOT=${CMAKE_EXTERNAL_SYSROOT}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
