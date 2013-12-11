//******************************************************************************
//PID Subroutine
// |PIDmodeRev, |PIDmodeMan, |PIDmodePID, |PIDmodeSpRamp, |PIDmodeSpRampLast, |PIDprogOutModePID, |PIDmodeManEnable, |PIDautoInterlock, |PIDmanInterlock, |PIDsetOutputInterlock, |PIDpidInterlock, |PIDspRampOFFInterlock, |PIDspRampONInterlock, |PIDcalcMode, |PIDcalc

//&PIDspRampTarget = &XXspRampTarget
//&PIDspRampRate = &XXspRampRate
//&PIDspRampMaxErr = &XXspRampMaxErr

PID:
  IF ((|PIDmodeManEnable = ON) AND (|PIDmodeMan = ON)) THEN
    |PIDautoInterlock = ON
  ELSE
    |PIDautoInterlock = OFF 
  ENDIF
    
  IF ((|PIDmodeManEnable = ON) AND (|PIDmodeMan = OFF)) THEN
    |PIDmanInterlock = ON
  ELSE
    |PIDmanInterlock = OFF 
  ENDIF

  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = ON)) THEN
    |PIDsetOutputInterlock = ON
  ELSE
    |PIDsetOutputInterlock = OFF 
  ENDIF
    
  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = OFF)) THEN
    |PIDpidInterlock = ON
  ELSE
    |PIDpidInterlock = OFF 
  ENDIF
    
  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = ON) AND (|PIDmodeSpRamp = ON)) THEN
    |PIDspRampOFFInterlock = ON
  ELSE
    |PIDspRampOFFInterlock = OFF 
  ENDIF
    
  IF ((|PIDmodeMan = ON) AND (|PIDmodePID = ON) AND (|PIDmodeSpRamp = OFF)) THEN
    |PIDspRampONInterlock = ON
  ELSE
    |PIDspRampONInterlock = OFF 
  ENDIF

   
  //cmd 0=none 1=auto 2=manualSO 3=manualPID
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
    |PIDmodePID = |PIDprogOutModePID
  ELSIF (|PIDmodeManEnable = OFF) THEN
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
      IF (((|PIDcalcMode=ON) AND (|PIDcalc=ON)) OR ((|PIDcalcMode=OFF) AND (&PIDtacc >= 100))) THEN
        &PIDtacc = 0
        IF (|PIDmodeSpRamp = ON) THEN
          //IF (|PIDmodeSpRampLast = OFF) THEN                                    //To do
          // |PIDmodeSpRampLast = ON
          // &PIDsp = &PIDpv 
          //ENDIF
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
          &PIDspRampTarget = &PIDsp
          // &PIDsp = &PIDspRampTarget
          // |PIDmodeSpRampLast = OFF
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
      
    CASE 2: //SO mode
      &PIDtacc = 0
      |PIDmodeSpRampLast = OFF
      |PIDmodeSpRamp = OFF   
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

  IF (&PIDcv > 10000) THEN
    &PIDcv = 10000
  ELSIF (&PIDcv < 0) THEN
    &PIDcv = 0 
  ENDIF
return

