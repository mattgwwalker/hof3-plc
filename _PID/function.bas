//******************************************************************************
//PID Subroutine
// |PIDmodeRev, |PIDmodeMan, |PIDmodePID, |PIDmodeSpRamp, |PIDmodeSpRampLast, |PIDprogOutModePID, |PIDmodeManEnable, |PIDautoInterlock, |PIDmanInterlock, |PIDsetOutputInterlock, |PIDpidInterlock, |PIDspRampOFFInterlock, |PIDspRampONInterlock, |PIDcalcMode, |PIDcalc

//&PIDspRampTarget = &XXspRampTarget
//&PIDspRampRate = &XXspRampRate
//&PIDspRampMaxErr = &XXspRampMaxErr




// Do not write directly to the setpoint, instead write to the ramp-target and 
// the set point will be decided automatically.


CONST PIDtacc_UPDATE_FREQ = 100 // update PID controller every one second


PID:
  // **********
  // Interlocks
  // **********

  // These are ON if the action is allowed.  You can think of them as whether
  // a button, such as "Go to Manual mode" should be greyed-out (interlock OFF)
  // or active (interlock ON).

  IF ((|PIDmodeManEnable = ON) AND (|PIDmodeMan = ON)) THEN
    // Manual mode is allowed and we're in manual mode, so allow us to go 
    // back to auto
    |PIDautoInterlock = ON
  ELSE
    // Otherwise, don't allow us to change to auto
    |PIDautoInterlock = OFF 
  ENDIF
    
  IF ((|PIDmodeManEnable = ON) AND (|PIDmodeMan = OFF)) THEN
    // Manual mode's allowed but we're in auto, so allow manual mode
    |PIDmanInterlock = ON
  ELSE
    // Otherwise, don't allow us to change to manual
    |PIDmanInterlock = OFF 
  ENDIF

  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = ON)) THEN
    // We're in manual and in PID-mode, so allow us to go to set-output mode
    |PIDsetOutputInterlock = ON
  ELSE
    |PIDsetOutputInterlock = OFF 
    // Otherwise, don't allow us to change to set-output mode
  ENDIF
    
  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = OFF)) THEN
    // We're in manual but PID-mode's off, so allow us to go to PID-mode 
    |PIDpidInterlock = ON
  ELSE
    // Otherwise, don't allow us to change to PID-mode
    |PIDpidInterlock = OFF 
  ENDIF
    
  // (|PIDmodeMan = ON) AND <-- I can't see a reason for this
  IF |PIDmodeSpRamp = ON THEN
    // Ramping is on, so allow us to turn off ramping
    |PIDspRampOFFInterlock = ON
    |PIDspRampONInterlock = OFF
  ELSE
    // Otherwise, allow us to turn on ramping
    |PIDspRampOFFInterlock = OFF 
    |PIDspRampONInterlock = ON 
  ENDIF
    

   
  // ********
  // Commands
  // ********
  
  SELECT &PIDcmd
    CASE 0:
      //No action
    
    CASE 1:
      // Auto
      IF (|PIDautoInterlock = ON) THEN
        |PIDmodeMan = OFF
      ENDIF
      
    CASE 2:
      // Manual
      IF (|PIDmanInterlock = ON) THEN
        |PIDmodeMan = ON
      ENDIF 
    
    CASE 3:
      // Set output mode
      IF (|PIDsetOutputInterlock = ON) THEN
        |PIDmodePID = OFF
      ENDIF

    CASE 4:
      // PID mode
      IF (|PIDpidInterlock = ON) THEN
        &PIDsp = &PIDpv
        &PIDspRampTarget = &PIDpv 
        |PIDmodePID = ON
      ENDIF    
    
    CASE 5:
      // Set PID controller to be in normal mode (not reverse)
      |PIDmodeRev = OFF
     
    CASE 6:
      // Set PID controller to be in reverse mode
      |PIDmodeRev = ON 
     
    CASE 7:
      // Disable manual operation
      |PIDmodeManEnable = OFF
     
    CASE 8:
      // Enable manual operation
      |PIDmodeManEnable = ON
     
    CASE 9:
      // Turn off setpoint ramping
      IF (|PIDspRampOFFInterlock = ON) THEN
        |PIDmodeSpRamp = OFF
      ENDIF 
     
    CASE 10:
      // Turn on setpoint ramping
      IF (|PIDspRampONInterlock = ON) THEN
        |PIDmodeSpRamp = ON
      ENDIF        
        
    DEFAULT:
  ENDSEL
  
  
  IF (|PIDmodeMan = OFF) THEN
    // We're in auto mode, so set the desired PID mode based on what the 
    // program is calling for
    |PIDmodePID = |PIDprogOutModePID
  ELSIF (|PIDmodeManEnable = OFF) THEN
    // Force manual mode to off if manual mode isn't allowed
    |PIDmodeMan = OFF
  ENDIF  
  
  &PIDstateNew = &PIDstate  
  SELECT &PIDstate
    CASE 0:
      &PIDtacc = 0   
      //Transistion Conditions   
      IF (|PIDmodePID = ON) THEN
        &PIDstateNew = 1
      ELSE
        &PIDstateNew = 2
      ENDIF      
             
    CASE 1: //PID mode
      &PIDtacc =  &PIDtacc + &lastScanTimeFast
      IF (((|PIDcalcMode=ON) AND (|PIDcalc=ON)) OR ((|PIDcalcMode=OFF) AND (&PIDtacc >= PIDtacc_UPDATE_FREQ))) THEN
        // We're in calc mode and we're asking to do the calculation, 
        // or we're not in calc mode and sufficient time has passed since the
        // last update
        &PIDtacc = 0
        IF (|PIDmodeSpRamp = ON) THEN
          IF (|PIDmodeSpRampLast = OFF) THEN
            // We just beinging setpoint ramping, so we'll start off at the
            // current value.
            |PIDmodeSpRampLast = ON
            &PIDsp = &PIDpv 
          ENDIF

          // Set the setpoint based on the ramp target, the ramp rate, and the
          // maximum error.
          IF ((&PIDspRampTarget - &PIDsp) >= &PIDspRampRate) THEN
            IF ((&PIDsp - &PIDpv) < &PIDspRampMaxErr) THEN
              &PIDsp = &PIDsp + &PIDspRampRate
            ENDIF 
          ELSIF ((&PIDspRampTarget - &PIDsp) > 0) THEN
            IF ((&PIDsp - &PIDpv) < &PIDspRampMaxErr) THEN
              &PIDsp = &PIDspRampTarget
            ENDIF
          ELSIF ((&PIDsp - &PIDspRampTarget) >= &PIDspRampRate) THEN
            IF ((&PIDpv - &PIDsp) < &PIDspRampMaxErr) THEN
              &PIDsp = &PIDsp - &PIDspRampRate
            ENDIF 
          ELSIF ((&PIDsp - &PIDspRampTarget) > 0) THEN
            IF ((&PIDpv - &PIDsp) < &PIDspRampMaxErr) THEN
              &PIDsp = &PIDspRampTarget
            ENDIF
          ENDIF
        ELSE
          // Setpoint ramping is off, so copy the ramp target directly into the
          // setpoint
          &PIDsp = &PIDspRampTarget
          |PIDmodeSpRampLast = OFF
        ENDIF
        IF (|PIDmodeRev = ON) THEN   
          &PIDerr = &PIDpv - &PIDsp
        ELSE
          &PIDerr = &PIDsp - &PIDpv
        ENDIF       
        &PIDcalc01 = &PIDerr * (&PIDi / 100.0)
        &PIDcalc02 = (&PIDerr - &PIDerrLast) * (&PIDp / 100.0)
        &PIDcv = &PIDcv + &PIDcalc01
        &PIDcv = &PIDcv + &PIDcalc02
        &PIDerrLast = &PIDerr
        &PIDerrLastLast = &PIDerrLast
      ENDIF
      //Transistion Conditions    
      IF (|PIDmodePID = ON) THEN
        &PIDstateNew = 1
      ELSE
        &PIDstateNew = 2
      ENDIF    
      
    CASE 2: // Set-output mode
      &PIDtacc = 0
      |PIDmodeSpRampLast = OFF
      IF (|PIDmodeRev = ON) THEN   
        &PIDerr = &PIDsp - &PIDpv
      ELSE
        &PIDerr = &PIDpv - &PIDsp
      ENDIF
      &PIDerrLast = &PIDerr
      &PIDerrLastLast = &PIDerrLast

      //Transistion Conditions    
      IF (|PIDmodePID = ON) THEN
        &PIDstateNew = 1
      ELSE
        &PIDstateNew = 2
      ENDIF     
            
    DEFAULT:
   
  ENDSEL

  IF &PIDstateNew <> &PIDstate THEN
    &PIDstate = &PIDstateNew  
  ENDIF

  // Ensure the control variable (the output of the PID controller) is 
  // between 0.00% and 100.00%
  IF (&PIDcv > 10000) THEN
    &PIDcv = 10000
  ELSIF (&PIDcv < 0) THEN
    &PIDcv = 0 
  ENDIF
return

