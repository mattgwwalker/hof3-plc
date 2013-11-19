//Analog Out Setup

//PP01speed,PC01CV
MEM &DATA_SOURCE_ANALOG1 = ADDR(&PC01cv)
MEM &D2A_AOP1_FULL_SCALE = 10000 //Default Value
MEM &D2A_AOP1_ZERO = 0 //Default Value

//CV01,3,PC05CV
MEM &DATA_SOURCE_ANALOG2 = ADDR(&PC05cv)
MEM &D2A_AOP2_FULL_SCALE = 20000 //12mA Control Valve Fully Open
MEM &D2A_AOP2_ZERO = 0 //Default Value

//CV02,RC01CV
MEM &DATA_SOURCE_ANALOG3 = ADDR(&RC01cv)
MEM &D2A_AOP3_FULL_SCALE = 20000 //12mA Control Valve Fully Open
MEM &D2A_AOP3_ZERO = 0 //Default Value

//CV05,PC03CV
MEM &DATA_SOURCE_ANALOG4 = ADDR(&PC03cv)
MEM &D2A_AOP4_FULL_SCALE = 10000 //Default Value
MEM &D2A_AOP4_ZERO = 0 //Default Value
