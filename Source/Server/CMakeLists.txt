cmake_minimum_required(VERSION 3.5)

project(weatherstationserver)

set(SRC
    include/sensors/i2cdevice.hpp
    include/sensors/hts221.hpp
    include/sensors/lps25h.hpp
    include/wsthread.hpp
    include/wumanager.hpp
    include/wsserver.hpp
    src/sensors/i2cdevice.cpp
    src/sensors/hts221.cpp
    src/sensors/lps25h.cpp
    src/wsthread.cpp
    src/wumanager.cpp
    src/wsserver.cpp
    src/main.cpp
)

include_directories(
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include/sensors

)

add_executable(${PROJECT_NAME}
  ${SRC}
)

target_link_libraries(${PROJECT_NAME}
                      Qt5::Core
                      Qt5::Network 
)
