if (NOT DEFINED CORTEX_M55_ENABLE_CMSE)
  set(CORTEX_M55_ENABLE_CMSE ON CACHE BOOL "Enable the CMSE instructions (-mcmse/--cmse) for Cortex-M55 builds")
endif ()

set(_cm55_cmse_flag "")

if (TOOLCHAIN STREQUAL "gcc")
  set(TOOLCHAIN_COMMON_FLAGS
    -mthumb
    -mcpu=cortex-m55
    -mfloat-abi=hard
    #TODO: check this -mfpu=fpv5-d16
    )
  set(_cm55_cmse_flag "-mcmse")
  set(FREERTOS_PORT GCC_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

elseif (TOOLCHAIN STREQUAL "clang")
  set(TOOLCHAIN_COMMON_FLAGS
    --target=arm-none-eabi
    -mcpu=cortex-m55
    -mfpu=fpv5-d16
    )
  set(_cm55_cmse_flag "-mcmse")
  set(FREERTOS_PORT GCC_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

elseif (TOOLCHAIN STREQUAL "iar")
  set(TOOLCHAIN_COMMON_FLAGS
    --cpu cortex-m55
    --fpu VFPv5_D16
    )
  set(_cm55_cmse_flag "--cmse")
  set(FREERTOS_PORT IAR_ARM_CM55_NTZ_NONSECURE CACHE INTERNAL "")

endif ()

if (NOT CORTEX_M55_ENABLE_CMSE)
  set(_cm55_cmse_flag "")
endif ()

set(CORTEX_M55_CMSE_FLAG "${_cm55_cmse_flag}" CACHE INTERNAL "Cortex-M55 CMSE compile option" FORCE)
