/////////////////////////////////////////////
//Setup Points to be logged
MEM &LOG_REG1 = ADDR(&EventID)
MEM &LOG_REG2 = ADDR(&PT01_1000)
MEM &LOG_REG3 = ADDR(&PT02_1000)
MEM &LOG_REG4 = ADDR(&PT03_1000)
MEM &LOG_REG5 = ADDR(&PT04_1000)
MEM &LOG_REG6 = ADDR(&FT01_100)
MEM &LOG_REG7 = ADDR(&FT02_100) 
MEM &LOG_REG8 = ADDR(&FT03_100)
MEM &LOG_REG9 = ADDR(&TT01_100)
MEM &LOG_REG10 = ADDR(&LT01_100)
MEM &LOG_REG11 = ADDR(&PH01_100)
MEM &LOG_REG12 = ADDR(&R01_1000)
MEM &LOG_REG13 = ADDR(&fd101_BW_PT03max)
MEM &LOG_REG14 = 0
MEM &LOG_REG15 = 0
MEM &LOG_REG17 = 0
MEM &LOG_REG18 = 0
MEM &LOG_REG19 = 0
MEM &LOG_REG20 = 0
MEM &LOG_REG21 = 0
MEM &LOG_REG22 = 0
MEM &LOG_REG23 = 0
MEM &LOG_REG24 = 0
MEM &LOG_REG25 = 0
MEM &LOG_REG26 = 0
MEM &LOG_REG27 = 0
MEM &LOG_REG28 = 0
MEM &LOG_REG29 = 0
MEM &LOG_REG30 = 0
MEM &LOG_REG31 = 0
MEM &LOG_REG32 = 0



// Code 8 (Data Logging)
// Source: Page 63 of ICC402-REG-MAN.pdf
// First digit
// 0: No data-logging
// 1: Cyclic buffer
// 2: Linear FIFO buffer
// 3: Reset buffer number to zero
// Second digit
// 0: Printer format, no time stamp
// 4: Spreadsheet format, no time stamp
// 6: Spreadsheet format, time stamp day-mth-year hh:mm:ss
// Third digit
// 0: No trigger
MEM &CODE8 = 160
