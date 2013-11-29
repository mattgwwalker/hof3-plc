
//TT01 Data
//** &USER_MEMORY_230 to &USER_MEMORY_239 currently allocated ** 

REG &TT01SP01 = &USER_MEMORY_230 //Desired Temperature
MEM &TT01SP01 = 4000 //40 degC
REG &TT01SP02 = &USER_MEMORY_231 //ON/OFF Hysteresis .. Start Heat @ SP01-SP02 .. Stop Heat @ SP01+SP02 
MEM &TT01SP02 = 100 //1 degC
REG &TT01SP03 = &USER_MEMORY_232 //Low Temperature Fault 
MEM &TT01SP03 = 400 //4 degC
REG &TT01SP04 = &USER_MEMORY_233 //High Temperature Fault 
MEM &TT01SP04 = 5000 //50 degC

