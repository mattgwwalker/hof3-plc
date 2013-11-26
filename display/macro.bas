CONST DISPLAY_STEP_MIN = 1   // The case number of the first display page
CONST DISPLAY_STEP_MAX = 13  // The case number of the last display page 

// Handle the pressing of the Down button.
// Once it has been pressed for two scans, both down1 and down2 will be set
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


// Handle the pressing of the Up button.
// Once it has been pressed for two scans, both up1 and up2 will be set
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
    if (&upDownButtonState=noAction) then
      &tempStepNum = DISPLAY_STEP_MIN
    endif

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

  case  1: // Description of the plant's current state
   if &tempStepNum != &displayStepNumber or &fd100StepNum != &displayFD100StepNumber then
     &DATA_SOURCE_DISPLAY1 = 0 // Clear the top line
     &DATA_SOURCE_DISPLAY2 = 0 // Clear the second line
     WRITE 2 ""
     &displayFD100StepNumber = &fd100StepNum // A copy so that we know what we're currently displaying
   endif
   // Check if the plant's paused
   if |fd100Fault_fd100_Pause = ON then
     WRITE 2 "     Paused     "
     &displayFD100StepNumber = -1 // Paused isn't technically a step, so we're making our own one step number
   else 
     WRITE 2 fd100MsgArray[&displayFD100StepNumber]
   endif

  case  2: // FT01
   WRITE 1 ""
   WRITE 1 "FT01 (l/h)"
   &Display_2DP = &FT01_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)
    
  case  3: // FT02
   WRITE 1 ""
   WRITE 1 "FT02 (l/h)"
   &Display_2DP = &FT02_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  4: // FT03
   WRITE 1 ""
   WRITE 1 "FT03 (l/h)"
   &Display_2DP = &FT03_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  5: // LT01
   IF &LT01_100 > 300 THEN
     WRITE 1 ""
     WRITE 1 "LT01 (%)"
     &Display_2DP = &LT01_100
     &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)
   ELSE
     &DATA_SOURCE_DISPLAY1 = 0
     WRITE 2 ""
     WRITE 2 "LT01 is below 3%"
   ENDIF

  case  6: // TT01
   WRITE 1 ""
   WRITE 1 "TT01 (deg C)"
   &Display_2DP = &TT01_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case  7: // PT01
   WRITE 1 ""
   WRITE 1 "PT01 (bar)"
   &Display_3DP = &PT01_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)

  case  8: // PT02
   WRITE 1 ""
   WRITE 1 "PT02 (bar)"
   &Display_3DP = &PT02_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)

  case  9: // PT03
   WRITE 1 ""
   WRITE 1 "PT03 (bar)"
   &Display_3DP = &PT03_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)

  case  10: // PT04
   WRITE 1 ""
   WRITE 1 "PT04 (bar)"
   &Display_3DP = &PT04_1000
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_3DP)


  case  11: // PH01
   WRITE 1 ""
   WRITE 1 "PH01"
   &Display_2DP = &PH01_100
   &DATA_SOURCE_DISPLAY2 = ADDR(&Display_2DP)

  case 12: // Step details
   WRITE 1 "" // Clear both lines as otherwise the screen update takes extra time
   WRITE 2 ""
   &DATA_SOURCE_DISPLAY1 = ADDR(&fd100StepNum)
   &DATA_SOURCE_DISPLAY2 = ADDR(&fd100StepTimeAcc)

  case 13:
   WRITE 2 ""
   WRITE 2 "CPU Usage "+&CPU_LOADING+"%"
   &DATA_SOURCE_DISPLAY1 = 0 // Clear other line
       
endsel


&displayStepNumber = &tempStepNum
