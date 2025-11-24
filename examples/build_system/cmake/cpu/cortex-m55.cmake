if (NOT DEFINED CORTEX_M55_ENABLE_CMSE)
  set(CORTEX_M55_ENABLE_CMSE OFF CACHE BOOL "Enable the CMSE instructions (-mcmse) for Cortex-M55 builds")
endif ()

set(_cmse_flag "-mcmse")

if (TOOLCHAIN STREQUAL "gcc")
  set(TOOLCHAIN_COMMON_FLAGS
    -mthumb
    -mcpu=cortex-m55
    -mfloat-abi=hard
    #TODO: check this -mfpu=fpv5-d16
    )
  if (CORTEX_M55_ENABLE_CMSE)
    list(APPEND TOOLCHAIN_COMMON_FLAGS ${_cmse_flag})
  endif ()
  set(FREERTOS_PORT GCC_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

elseif (TOOLCHAIN STREQUAL "clang")
  set(TOOLCHAIN_COMMON_FLAGS
    --target=arm-none-eabi
    -mcpu=cortex-m55
    -mfpu=fpv5-d16
    )
  set(FREERTOS_PORT GCC_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

elseif (TOOLCHAIN STREQUAL "iar")
  set(TOOLCHAIN_COMMON_FLAGS
    --cpu cortex-m55
    --fpu VFPv5_D16
    )
  set(FREERTOS_PORT IAR_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

endif ()

foreach(_lang IN ITEMS C CXX ASM)
  if (DEFINED CMAKE_${_lang}_FLAGS)
    if (CORTEX_M55_ENABLE_CMSE)
      if (CMAKE_${_lang}_FLAGS MATCHES "-mcmse")
        continue()
      endif ()
      set(_new_flags "${CMAKE_${_lang}_FLAGS} ${_cmse_flag}")
      string(STRIP "${_new_flags}" _new_flags)
      set(CMAKE_${_lang}_FLAGS "${_new_flags}" CACHE STRING "" FORCE)
    else()
      if (NOT CMAKE_${_lang}_FLAGS MATCHES "-mcmse")
        continue()
      endif ()
      string(REPLACE "-mcmse" "" _new_flags "${CMAKE_${_lang}_FLAGS}")
      string(REGEX REPLACE "[ ]+" " " _new_flags "${_new_flags}")
      string(STRIP "${_new_flags}" _new_flags)
      set(CMAKE_${_lang}_FLAGS "${_new_flags}" CACHE STRING "" FORCE)
    endif ()
  endif ()
endforeach()
