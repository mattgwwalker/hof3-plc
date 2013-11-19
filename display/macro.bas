CONST DISPLAY_STEP_MIN = 1
CONST DISPLAY_STEP_MAX = 9

//Display 
IF (|DOWN_BUTTON = ON) THEN
 IF (|down1 = OFF) THEN
  |down1 = ON
  |down2 = OFF
 ELSE
  |down1 = ON
  |down2 = ON
 ENDIF
ELSE
  |down1 = OFF
  |down2 = OFF
ENDIF

IF (|UP_BUTTON = ON) THEN
 IF (|up1 = OFF) THEN
  |up1 = ON
  |up2 = OFF
 ELSE
  |up1 = ON
  |up2 = ON
 ENDIF
ELSE
  |up1 = OFF
  |up2 = OFF
ENDIF

&tempStepNum = &displayStepNumber

// Check to see if the state should be changed
select &tempStepNum
case  0: //Powerup and Reset State
 IF (&upDownButtonState=noAction) THEN
  &tempStepNum = DISPLAY_STEP_MIN
 ENDIF

default: // All other display states
 // Check to see if the up or down buttons have been pressed
 IF (&upDownButtonState=UpArrowPressed) THEN
  &tempStepNum = &tempStepNum - 1
 ELSIF (&upDownButtonState=DownArrowPressed) THEN
  &tempStepNum = &tempStepNum + 1
 ENDIF
 
 // Check to ensure the new state is within bounds
 IF &tempStepNum > DISPLAY_STEP_MAX THEN
  &tempStepNum = DISPLAY_STEP_MIN
 ELSIF &tempStepNum < DISPLAY_STEP_MIN THEN
  &tempStepNum = DISPLAY_STEP_MAX
 ENDIF 
endsel


select &tempStepNum
  case  0: //Powerup and Reset State

  case  1: // Description of current state
   if &tempStepNum != &displayStepNumber or &fd100StepNum != &displayFD100StepNumber then
     &DATA_SOURCE_DISPLAY1 = 0 // Clear the top line
     &DATA_SOURCE_DISPLAY2 = 0 // Clear the second line
     WRITE 2 ""
     &displayFD100StepNumber = &fd100StepNum // A copy so that we know what we're currently displaying
   endif
   WRITE 2 fd100MsgArray[&displayFD100StepNumber]
    
  case  2: // FT02
   WRITE 1 ""
   WRITE 1 "FT02 (l/h)"
   &Display_2DP = &FT02_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  3: // FT03
   WRITE 1 ""
   WRITE 1 "FT03 (l/h)"
   &Display_2DP = &FT03_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  4: // LT01
   WRITE 1 ""
   WRITE 1 "LT01 (%)"
   &Display_2DP = &LT01_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  5: // TT01
   WRITE 1 ""
   WRITE 1 "TT01 (deg C)"
   &Display_2DP = &TT01_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  6: // PT01
   WRITE 1 ""
   WRITE 1 "PT01 (bar)"
   &Display_3DP = &PT01_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)

  case  7: // PT02
   WRITE 1 ""
   WRITE 1 "PT02 (bar)"
   &Display_3DP = &PT02_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)

  case  8: // Step details
   WRITE 1 "" // Clear both lines as otherwise the screen update takes extra time
   WRITE 2 ""
   &DATA_SOURCE_DISPLAY1 = ADDR(&fd100StepNum)
   &DATA_SOURCE_DISPLAY2 = ADDR(&fd100StepTimeAcc)

  case 9:
   WRITE 2 ""
   WRITE 2 "CPU Usage "+&CPU_LOADING+"%"
   &DATA_SOURCE_DISPLAY1 = 0 // Clear other line
       
endsel


&displayStepNumber = &tempStepNum
