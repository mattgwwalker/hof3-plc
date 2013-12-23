//Analog Out Setup

//PP01speed,PC01CV
MEM &DATA_SOURCE_ANALOG1 = ADDR(&PP01_RawSpeed)
MEM &D2A_AOP1_FULL_SCALE = 10000 //Default Value
MEM &D2A_AOP1_ZERO = 0 //Default Value

//CV01,3,PC05CV
// Note this is reversed: when the PID controller gives an output of 100%,
// CV01 will be fully closed (as the i2p will be giving just 20% of its 
// 0 - 2 bar output).
// It is reversed because the PID controller defaults to 0% output, and we wish
// CV01 to be normally open.
// The i2p's range is restricted from 20% to 45% as within that range CV01 goes
// from fully closed to fully open. 
CONST AO2_MIN = 4500 // The minimum output of the i2p converter is 45%
CONST AO2_MAX = 2000 // The maximum output of the i2p converter is 20% 

MEM &DATA_SOURCE_ANALOG2 = ADDR(&PC05cv)
MEM &D2A_AOP2_FULL_SCALE = (10000-AO2_MIN) / ((AO2_MAX-AO2_MIN)/10000.0)
MEM &D2A_AOP2_ZERO = (0-AO2_MIN) / ((AO2_MAX-AO2_MIN)/10000.0)

//CV02,RC01CV
MEM &DATA_SOURCE_ANALOG3 = ADDR(&RC01cv)
MEM &D2A_AOP3_FULL_SCALE = 20000 //12mA Control Valve Fully Open
MEM &D2A_AOP3_ZERO = 0 //Default Value

//CV05,PC03CV
MEM &DATA_SOURCE_ANALOG4 = ADDR(&PC03cv)
MEM &D2A_AOP4_FULL_SCALE = 10000 //Default Value
MEM &D2A_AOP4_ZERO = 0 //Default Value
