/////////////////////////////////////////////
//Temp Float_Variables

//****************************************** 
REG &TempFloat1 = &FLOAT_VARIABLE1
//PID Subroutine
REG &PIDcalc01 = &TempFloat1

//****************************************** 
REG &TempFloat2 = &FLOAT_VARIABLE2
//PID Subroutine
REG &PIDcalc02 = &TempFloat2

REG &R01 = &FLOAT_VARIABLE3
MEM &R01 = 1.0
REG &R01_last = &FLOAT_VARIABLE4
MEM &R01_last = 1.0
REG &V1 = &FLOAT_VARIABLE5
MEM &V1 = 0.0
REG &V1x_last = &FLOAT_VARIABLE6
MEM &V1x_last = 0.0
REG &V2x = &FLOAT_VARIABLE7
MEM &V2x = 0.0
REG &V3x = &FLOAT_VARIABLE8
MEM &V3x = 0.0
