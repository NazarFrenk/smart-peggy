cmake_minimum_required(VERSION 3.16)

project(smart-peggy VERSION 1.0.0 LANGUAGES CXX)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS
    Core
    Quick
    REQUIRED)

qt_standard_project_setup(REQUIRES 6.9)

list(APPEND ResourcesSource "resources/resources.qrc")
qt6_add_resources(RESOURCES ${ResourcesSource})

set(CMAKE_AUTORCC ON)

cmake_path(GET PROJECT_SOURCE_DIR PARENT_PATH PARENT_DIR)
file(GLOB_RECURSE SOURCE_FILES ${PROJECT_SOURCE_DIR} src/*.cpp src/*.hpp)
file(GLOB_RECURSE QML_FILES RELATIVE "${PROJECT_SOURCE_DIR}" ui/*.qml)

# QML singletons
file(GLOB_RECURSE QML_SINGLETONS RELATIVE ${PROJECT_SOURCE_DIR} ui/singletons/*.qml)
set_source_files_properties(
    ${QML_SINGLETONS}
    PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_executable(${PROJECT_NAME}
    ${SOURCE_FILES}
    ${RESOURCES}
)

target_link_libraries(smart-peggy PRIVATE Qt6::Core)

qt_add_qml_module(${PROJECT_NAME}
    URI smartpeggy
    VERSION 1.0

    QML_FILES
        ${QML_FILES}
)

# extract C++ classes to be visible to QML
# https://www.qt.io/blog/compiling-qml-to-c-making-types-visible
qt_extract_metatypes(${PROJECT_NAME})

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(smart-peggy PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appsmartpeggy
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if (ANDROID)
  set_target_properties(${PROJECT_NAME} PROPERTIES
      QT_ANDROID_PACKAGE_SOURCE_DIR ${PROJECT_SOURCE_DIR}/android
  )
endif ()

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Core
    PRIVATE Qt6::Quick
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
    ${PROJECT_SOURCE_DIR}/src/controllers
)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
