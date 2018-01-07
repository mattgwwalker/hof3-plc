// General setup code for the 8-channel analogue input module
// Sourced from the Way Back Machine 2017-12-12 from: 
// https://web.archive.org/web/20100117034323/http://www.texmate.co.nz:80/downloads/macros/ISOP1_config.bas

// 2/11/2007
// V1.1 - R.G.Mulder
//
// Further documentation by Matthew Walker
//
//
//  Input Module Type: ISOP1
//  Smart 8 channel process input module
//
//  &SMART_RESULT1 = Current input 1
//  &SMART_RESULT2 = Current input 2
//  &SMART_RESULT3 = Current input 3
//  &SMART_RESULT4 = Current input 4
//  &SMART_RESULT5 = Current input 5
//  &SMART_RESULT6 = Current input 6
//  &SMART_RESULT7 = Current input 7
//  &SMART_RESULT8 = Current input 8
//
//******************************************************************************
//

// When reading or writing to these code registers the data is treated in 
// octal format. The 1st digit of each Code register is stored in bits 6 and 7.
// The 2nd digit of each Code register is stored in bits 3, 4, and 5. The 3rd 
// digit of each Code register is stored in bits 0, 1, and 2.
// For example:
// If the setup for Code 4 shows 241 on the display, then reading register 8197
// in ASCII mode results in a value of 241. Converting this octal value to a 
// binary equivalent of 10100001 or hexadecimal equivalent of 0A1.
// Source: Page 52 of ICC402-REG-MAN.pdf



// Code 1
// Source: Page 56 of ICC402-REG-MAN.pdf
// First digit (Front panel annunicators; the LEDs)
// 0: On when setpoints are on
// 1: On when setpoints are off
// 2: Always off
// 3:
// Second digit
// 0: Normal display mode
// Third digit
// Unused with normal display mode
MEM &CODE1 = 200


// Code 2 (Channel 1) 
// Source: Page 58 of ICC402-REG-MAN.pdf
// Provides the settings to select noise rejection, analog sampling rate, and
// output rate for all input channels. It also allows you to select the input
// signal type and range setting for CH1.
// First digit
// 0: Sample rate of 10 samples/second (divided by the number of channels),
//    thus 1.25 samples/second/channel.
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
MEM &CODE2 = 070

// Code 3 (Channel 1):
// Source: Page 59 of ICC402-REG-MAN.pdf
// First digit
// 0: No processing on channel 1
// 1: Square root of channel 1
// 2: Inverse of channel 1
// Second digit
// 0: No linearization
// Third digit:
// Not used
MEM &CODE3=000

// Code 4 (Channel 2):
// Source: Page 60 of ICC402-REG-MAN.pdf
// First digit
// 0: Voltage, Current
// Second Digit
// 4: Averaged signal 1
// 5: Averaged signal 2
// 6: Averaged signal 3
// 7: Averaged signal 4
// Third digit
// 0: No linearization
MEM &CODE4=050

// Code 5 (Channel 3):
// Source: Page 61 of ICC402-REG-MAN.pdf
// First digit
// 0: No processing of channel 3
// 1: Square root of channel 3
// 2: Inverse of channel 3
// 3: 32-point linearization of channel 3 using table 3
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
MEM &CODE5=072

// Code 6 (Channel 4):
// Source: Page 62 of ICC402-REG-MAN.pdf
// First digit
// 0: No processing of channel 4
// 1: Square root of channel 4
// 2: Inverse of channel 4
// 3: 32-point linearization of channel 4 using table 4
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
MEM &CODE6=073


// Code 7 (Result):
// Source: Page 63 of ICC402-REG-MAN.pdf
// First digit
// 0: No processing of Result
// 1: Square root of Result
// 2: Inverse of Result
// Second digit
// 0: No linearization
// Third digit
// 0: Result register not updated
// 7: Result = Parameter at result source register (DATA_SOURCE_RESULT, #4450)
MEM &CODE7 = 007


// Code 9
// Source: Page 64 of ICC402-REG-MAN.pdf
// Set the functions for the DISPLAY TEST, HOLD, and LOCK pins located at the
// rear of the controller.
// First Digit
// 0: Display test only
// Second Digit
// 0: Display hold
// Third digit
// 0: Key lock
MEM &CODE9 = 000


// 1st digit = frequency select
// 0 =
// 1 = 60hz
// 2 =
// 3 = 50hz
//
// 2nd digit=voltage range
// 0 =
// 1 =
// 2 =
// 3 =
// 4 =
// 5 =
// 6 =
//
// 3rd digit= output rate
// 0 =
// 1 =
// 2 =
// 3 =
// 4 =
// 5 =
MEM &SMART_SETUP1=0300 // For some reason the zero at the front is
                       // important for the compiler.


MEM &DATA_SOURCE_CH5 = ADDR (&SMART_RESULT5 )
MEM &DATA_SOURCE_CH6 = ADDR (&SMART_RESULT6 )
MEM &DATA_SOURCE_CH7 = ADDR(&SMART_RESULT7 )
MEM &DATA_SOURCE_RESULT = ADDR(&SMART_RESULT8 )






// This is configuration for the other smart controller; it's just a test.
// Matthew 2017-12-13

MEM &SMART3_SETUP1 = 0322
MEM &SMART3_SETUP2 = 0222