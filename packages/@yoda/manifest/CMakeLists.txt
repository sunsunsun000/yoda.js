cmake_minimum_required(VERSION 3.0)
project(node-manifest CXX)
set(CMAKE_CXX_STANDARD 11)

install(FILES index.js DESTINATION ${CMAKE_INSTALL_DIR})
