cmake_minimum_required(VERSION 3.26)

project(cub_test)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
enable_language(CXX CUDA)

# On some Windows systems, arch75 can not work
# so we set it to native
# set(CMAKE_CUDA_ARCHITECTURES 75)
set(CMAKE_CUDA_ARCHITECTURES native)
add_executable(device_select device_select.cu)
set_target_properties(device_select PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(device_select PROPERTIES CUDA_RESOLVE_DEVICE_SYMBOLS ON)
target_compile_options(device_select PRIVATE 
    $<$<COMPILE_LANGUAGE:CUDA>:--expt-relaxed-constexpr>
    $<$<COMPILE_LANGUAGE:CUDA>:--extended-lambda>
    $<$<COMPILE_LANGUAGE:CUDA>:-rdc=true>)