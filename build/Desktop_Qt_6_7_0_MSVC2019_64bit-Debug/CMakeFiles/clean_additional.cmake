# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appResponsiveQML_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appResponsiveQML_autogen.dir\\ParseCache.txt"
  "appResponsiveQML_autogen"
  )
endif()
