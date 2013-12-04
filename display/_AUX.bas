// The display's startup text occurs on boot-up for a second or so.  
// There are two lines of up to 16 characters each.
//                         1234567890123456
MEM &STARTUP_TEXT_LINE1 = "      HOF3      "
MEM &STARTUP_TEXT_LINE2 = "                "


// We allocate registers AUX10 to 13 for the display of zero through to three 
// decimal places.  This is necessary as we seem unable to specify this on
// the fly: &CURRENT_DISPLAY_FORMAT does not seem to work as documented.
REG &Display_0DP = &AUX10
REG &Display_1DP = &AUX11
REG &Display_2DP = &AUX12
REG &Display_3DP = &AUX13

// Clear the text associated with AUX10 to 13.  Unfortunately an empty string
// produces a quote mark on the display, hence we use a space instead.
MEM &AUX10_TEXT = " "
MEM &AUX11_TEXT = " "
MEM &AUX12_TEXT = " "
MEM &AUX13_TEXT = " "

// Sets the displays for each of AUX10 to 13 to their appropriate number of 
// decimal places.  These octal codes are documented in the ICC-402 manual on
// page 106. 
MEM &DISPLAY_FORMAT_AUX10 = 000
MEM &DISPLAY_FORMAT_AUX11 = 006
MEM &DISPLAY_FORMAT_AUX12 = 005
MEM &DISPLAY_FORMAT_AUX13 = 004
