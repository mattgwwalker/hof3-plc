//Display USER_MEMORY registers
//** &USER_MEMORY_200 to &USER_MEMORY_204 currently allocated **
REG &displayStepNumber = &USER_MEMORY_200
MEM &displayStepNumber = 0

REG &displayFD100StepNumber = &USER_MEMORY_201
MEM &displayFD100StepNumber = 0

REG &upDownButtonState = &USER_MEMORY_202
BITREG &upDownButtonState = [|up1, |up2, |down1, |down2]
CONST noAction = 0
CONST UpArrowPressed = 1
CONST DownArrowPressed = 4


