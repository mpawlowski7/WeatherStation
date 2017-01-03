cmake_minimum_required(VERSION 3.5)

project(weatherstation)

set(CMAKE_BUILD_TYPE "DEBUG")
set(CMAKE_AUTOMOC ON)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++11")

if(ANDROID)
  set(CMAKE_PREFIX_PATH $ENV{HOME}/Qt/5.7/android_armv7/lib/cmake)
endif()

find_package(Qt5Core REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Qml REQUIRED)

if(ANDROID)
  find_package(Qt5AndroidExtras REQUIRED)
  add_subdirectory(gui)
else()
  add_subdirectory(gui)
  add_subdirectory(server)
endif()

