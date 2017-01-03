cmake_minimum_required(VERSION 3.5)

project(weatherstationgui)

set(CMAKE_AUTORCC ON) # for QT

file(GLOB_RECURSE SRC
            "./src/*.cpp"
            "./include/*.hpp"
            "./include/*.h"
            )

include_directories(
  ${PROJECT_SOURCE_DIR}/include
)


if(ANDROID)
  add_library(${PROJECT_NAME} SHARED 
              ${SRC}
              ${PROJECT_SOURCE_DIR}/resources/gui.qrc
  )
  include(${PROJECT_SOURCE_DIR}/../thirdparty/qt-android-cmake/AddQtAndroidApk.cmake)
  add_qt_android_apk(
    weatherstationgui-android ${PROJECT_NAME}
    NAME "WeatherStation"
  )

  target_link_libraries(${PROJECT_NAME}
                        Qt5::Core 
                        Qt5::Quick 
                        Qt5::Qml
                        Qt5::AndroidExtras
  )
else()
  add_executable(${PROJECT_NAME}
                   ${SRC}
                   ${PROJECT_SOURCE_DIR}/resources/gui.qrc
  )
  target_link_libraries(${PROJECT_NAME}
                      Qt5::Core 
                      Qt5::Quick 
                      Qt5::Qml
  )
endif()