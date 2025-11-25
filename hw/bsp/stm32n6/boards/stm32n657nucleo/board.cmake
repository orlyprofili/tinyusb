set(MCU_VARIANT stm32n657xx)
set(JLINK_DEVICE stm32n6xx)

# Use our custom linker script that utilizes full 4.2MB RAM
# Located in project root's linker/ directory
# Path: stm32n657nucleo -> boards -> stm32n6 -> bsp -> hw -> tinyusb -> project_root
set(LD_FILE_GNU ${CMAKE_CURRENT_LIST_DIR}/../../../../../../linker/STM32N657XX_RAM_ONLY.ld)

function(update_board TARGET)
  target_compile_definitions(${TARGET} PUBLIC
    STM32N657xx
    )
  target_sources(${TARGET} PUBLIC
    ${ST_TCPP0203}/tcpp0203.c
    ${ST_TCPP0203}/tcpp0203_reg.c
    )
  target_include_directories(${TARGET} PUBLIC
    ${ST_TCPP0203}
    )
endfunction()
