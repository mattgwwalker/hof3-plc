
//LT01 Data
//** &USER_MEMORY_210 to &USER_MEMORY_224 currently allocated ** 

CONST LT01_MIN_RELIABLE_LEVEL = 400 // 4%  Warning: display code converts this
                                    //              to an integer during compilation
                                    //              so will not accurately display
                                    //              anything below decimal point 

REG &LT01SP01 = &USER_MEMORY_210 //Fill Feedtank Level
MEM &LT01SP01 = 4000 //40%
REG &LT01SP02 = &USER_MEMORY_211 //Fill Feedtank Hysteresis .. Start Fill @ SP01-SP02 .. Stop Fill @ SP01+SP02 
MEM &LT01SP02 = 500 //5%
REG &LT01SP03 = &USER_MEMORY_212 //Feedtank Level To Run Pump
MEM &LT01SP03 = 2000 //20%
REG &LT01SP04 = &USER_MEMORY_213 //Run Pump Hysteresis .. Start @ SP03+SP04 .. Stop @ SP03-SP04
MEM &LT01SP04 = 200 //2%
REG &LT01SP05 = &USER_MEMORY_214 //Empty Feedtank To Site Min Level
MEM &LT01SP05 = 1000 //10%
REG &LT01SP06 = &USER_MEMORY_215 //Empty Feedtank To Site Min Level
MEM &LT01SP06 = 500//5%
REG &LT01SP07 = &USER_MEMORY_216 //Level for Heating enable
MEM &LT01SP07 = 3750 //40%
REG &LT01SP08 = &USER_MEMORY_217 //Heating Hysteresis .. Start Heating @ SP07+SP08 .. Stop Heating @ SP07-SP08
MEM &LT01SP08 = 250 //2.5%
REG &LT01SP09 = &USER_MEMORY_218
MEM &LT01SP09 = 0

