// To calibrate the scale factor and offset values, use the current
// output feature of PH01 and the TexMate Configuration Utility.
// 
// First, connect to the controller using the Configuration Utility
// (meter type ICC402 16x2LCD, TCP/IP 192.168.1.91, port 10001).  This
// connection process takes at least a few seconds and looks like it
// hangs.  Press the "Calibration" button to open the page showing
// details for all analogue channels.
// 
// Next, at PH01, press and hold the PGM button.  Press the DOWN arrow to
// select the "ADIMINISTR. LEVEL" menu option.  Press PGM.  Press the UP
// arrow until 300 is displayed as the password.  Press the PGM button.
// Press the PGM button again to select "PARAMETER LEVEL".  Press the
// DOWN button to select "ANALOG OUTPUT 1".  Press the PGM button.  Press
// the DOWN button to get to the "SIMULATION" menu.  Press the PGM
// button.  Press the DOWN button to change the state to "ON".  Press the
// PGM button.  Press the DOWN button to select the "SIMULATION VALUE"
// menu.  Press the PGM button.  Use the UP and DOWN arrows to select the
// desired simulation value.  Press the PGM button when you have the
// desired value; PH01 is now simulating that value.  Remember to turn
// the simulation off again at the end of the process.
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



//***ch9 calibration values
CONST CH09_CalScaledMax = 10000.0
CONST CH09_CalScaledMin = 0.0
CONST CH09_CalScaleFactor = 0.00232682 //Float  -- Updated 2018-01-12 by Matthew
CONST CH09_CalOffset = -1295 //Integer  -- Updated 2018-01-12 by Matthew

//***ch10 calibration values
CONST CH10_CalScaledMax = 10000.0
CONST CH10_CalScaledMin = 0.0
CONST CH10_CalScaleFactor = 0.00230642 //Float
CONST CH10_CalOffset = -2500 //Integer 
