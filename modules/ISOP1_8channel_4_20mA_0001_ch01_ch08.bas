// To calibrate the scale factor and offset values, use the current
// output feature of PT01 and the TexMate Configuration Utility.
// 
// First, connect to the controller using the Configuration Utility
// (meter type ICC402 16x2LCD, TCP/IP 192.168.1.91, port 10001).  This
// connection process takes at least a few seconds and looks like it
// hangs.  Press the "Calibration" button to open the page showing
// details for all analogue channels.
// 
// Next, at PT01, take off the screw face.  Press the PROG key.  Press
// the UP key until "110" is displayed.  Press the PROG key.  The text
// "Curr" (for current simulation) is displayed.  Press the PROG key.
// Use the UP and DOWN arrows to select the desired current (say, 4mA or
// 20mA).  Press the PROG key.  The text "PROG" will be displayed in the
// upper left corner and PT01 will be outputting the displayed current.
// Press the PROG key again to terminate current simulation mode and
// return to normal.
// 
// Set the current simulation, using the above method, to 4mA.  On the
// Configuration Utility press the "Capture" button associated with both
// the channel and the "First Calibration Point".  Leave the Display
// value at 0.
// 
// Set the current simulation, using the above method, to 20mA.  On the
// Configuration Utility press the "Capture" button associated with both
// the channel and the "Second Calibration Point".  Leave the Display
// value at 10000.
// 
// Press the "Calibrate =>" button associated with the channel.  The
// configuration utility will display two calculated values, the Scale
// Factor and the Offset.  Enter them as the values for the channel's
// constants below.




//***ch1 calibration values - Calibrated using the current output feature of PT01
CONST CH01_CalScaledMax = 10000.0
CONST CH01_CalScaledMin = 0.0
CONST CH01_CalScaleFactor = 3.35121 //Float
CONST CH01_CalOffset = -3907 //Integer

//***ch2 calibration values
CONST CH02_CalScaledMax = 10000.0
CONST CH02_CalScaledMin = 0.0
CONST CH02_CalScaleFactor = 3.37041 //Float
CONST CH02_CalOffset = -2436 //Integer 

//***ch3 calibration values
CONST CH03_CalScaledMax = 10000.0
CONST CH03_CalScaledMin = 0.0
CONST CH03_CalScaleFactor = 3.36814 //Float
CONST CH03_CalOffset = -2438 //Integer

//***ch4 calibration values
CONST CH04_CalScaledMax = 10000.0
CONST CH04_CalScaledMin = 0.0
CONST CH04_CalScaleFactor = 3.36587 //Float
CONST CH04_CalOffset = -2436 //Integer 

//***ch5 calibration values
CONST CH05_CalScaledMax = 10000.0
CONST CH05_CalScaledMin = 0.0
CONST CH05_CalScaleFactor = 1.18892 //Float
CONST CH05_CalOffset = -2050 //Integer  -- Updated 2018-01-12 by Matthew

//***ch6 calibration values
CONST CH06_CalScaledMax = 10000.0
CONST CH06_CalScaledMin = 0.0
CONST CH06_CalScaleFactor = 1.18106 //Float
CONST CH06_CalOffset = -2475 //Integer

//***ch7 calibration values
CONST CH07_CalScaledMax = 10000.0
CONST CH07_CalScaledMin = 0.0
CONST CH07_CalScaleFactor = 1.18483 //Float  -- Updated 2018-01-12 by Matthew
CONST CH07_CalOffset = -2470 //Integer   -- Updated 2018-01-12 by Matthew

//***ch8 calibration values
CONST CH08_CalScaledMax = 10000.0
CONST CH08_CalScaledMin = 0.0
CONST CH08_CalScaleFactor = 1.18078 //Float
CONST CH08_CalOffset = -2475 //Integer
