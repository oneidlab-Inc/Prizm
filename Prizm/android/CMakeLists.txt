cmake_minimum_required(VERSION 3.4.1) # for example
add_library(
    native
    SHARED
    IMPORTED
    GLOBAL
)

set_target_properties(native PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI}/libnative.so)
