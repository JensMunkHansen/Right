find_package(Qt5 COMPONENTS Core Gui Widgets Quick Qml Concurrent Network DBus PrintSupport QuickControls2 REQUIRED)

find_package(VTK CONFIG REQUIRED)
include(${VTK_USE_FILE})

set(APP_SRCS
  main.cpp
)

qt5_add_resources(RESOURCES ../../res.qrc)

add_executable(MyApp ${APP_SRCS} ${RESOURCES})

target_link_libraries(MyApp Qt5::Quick Qt5::Widgets Qt5::Qml Qt5::QuickControls2 ${VTK_LIBRARIES} ${SYSTEM_LIBS})
