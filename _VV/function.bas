//*************************************************************************8
//Subroutine for Valves and Pumps

//INPUTS
//&VVstatus1 = &VVXXstatus1 // ..|VVout, |VVmotFault, |VVman
//&VVstatus2 = &VVXXstatus2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable, |VVautoInterlock, |VVmanInterlock, |VVmanOFFInterlock, |VVmanONInterlock 
//&VVcmd = &VVXXcmd
//&VVdelayTimerAcc = &VVXXdelayTimerAcc
//&VVfaultTimerAcc = &VVXXfaultTimerAcc
//&VVmotFaultTimerAcc = &VVXXmotFaultTimerAcc
//&VVdelayTimerEngPre = &VVXXdelayTimerEngPre
//&VVdelayTimerDeengPre = &VVXXdelayTimerDeengPre
//&VVfaultTimerEngPre = &VVXXfaultTimerEngPre
//&VVfaultTimerDeengPre = &VVXXfaultTimerDeengPre

//OUTPUTS
//&VVXXstatus1 = &VVstatus1
//&VVXXstatus2 = &VVstatus2
//IF (&VVXXcmd = &VVcmd) THEN
//  &VVXXcmd = 0
//ENDIF
//&VVXXdelayTimerAcc = &VVdelayTimerAcc
//&VVXXfaultTimerAcc = &VVfaultTimerAcc
//&VVXXmotFaultTimerAcc = &VVmotFaultTimerAcc
//


// An interlock has to be on in order to allow the feature to be accessible.  
// For example, to turn a valve to automatic, the interlock for automatic has
// to be on.

// The interlocks seem to be a way of quickly checking if that action is 
// available.  So if the interlock for manual is on, you can select manual mode.

VV:
  // ??? If manual mode is allowed and we're in manual mode then turn on the 
  // interlock for automatic, otherwise turn it off 
  IF ((|VVmanEnable = ON) AND (|VVman = ON)) THEN
    |VVautoInterlock = ON
  ELSE
    |VVautoInterlock = OFF 
  ENDIF
    
  // 
  IF ((|VVmanEnable = ON) AND (|VVman = OFF)) THEN
    |VVmanInterlock = ON
  ELSE
    |VVmanInterlock = OFF 
  ENDIF

  IF ((|VVman = ON) AND (|VVout = ON)) THEN
    |VVmanOFFInterlock = ON
  ELSE
    |VVmanOFFInterlock = OFF 
  ENDIF
    
  IF ((|VVman = ON) AND (|VVout = OFF)) THEN
    |VVmanONInterlock = ON
  ELSE
    |VVmanONInterlock = OFF 
  ENDIF


  //cmd 0=none 1=auto 2=manual 3=manualOff 4=manualOn
  SELECT &VVcmd
    CASE 0:
      //No action

    CASE 1:
      IF (|VVautoInterlock = ON) THEN
        |VVman = OFF
      ENDIF
    
    CASE 2:
      IF (|VVmanInterlock = ON) THEN
        |VVman = ON
      ENDIF 

    CASE 3:
      IF (|VVmanOFFInterlock = ON) THEN
        |VVout = OFF
      ENDIF
    
    CASE 4:
      IF (|VVmanONInterlock = ON) THEN
        |VVout = ON
      ENDIF   
    
    CASE 5:
      |VVeng = OFF
    
    CASE 6:
      |VVeng = ON
    
    CASE 7:
      |VVdeeng = OFF
    
    CASE 8:
      |VVdeeng = ON    
    
    CASE 9:
      |VVautoOut = OFF
     
    CASE 10:
      |VVautoOut = ON
    
    CASE 11:
      IF (|VVfaultResetEnable = ON) THEN
        |VVfault= OFF
      ENDIF          
        
    DEFAULT:
      // Do nothing

  ENDSEL

  IF (|VVautoOut = ON) THEN
    IF ((&VVdelayTimerEngPre = 0) OR (|VVdelayedAutoOut = ON) OR (|VVout = ON)) THEN
      |VVdelayedAutoOut = ON
      &VVdelayTimerAcc = 0 
    ELSE
      &VVdelayTimerAcc = &VVdelayTimerAcc + &lastScanTimeFast  //Delay Eng
      IF (&VVdelayTimerAcc > &VVdelayTimerEngPre) THEN
        |VVdelayedAutoOut = ON
        &VVdelayTimerAcc = 0  
      ENDIF
    ENDIF   
  ELSE
    // AutoOut is off
    IF ((&VVdelayTimerDeengPre = 0) OR (|VVdelayedAutoOut = OFF) OR (|VVout = OFF)) THEN
      |VVdelayedAutoOut = OFF
      &VVdelayTimerAcc = 0 
    ELSE
      &VVdelayTimerAcc = &VVdelayTimerAcc + &lastScanTimeFast  //Delay Deeng
      IF (&VVdelayTimerAcc > &VVdelayTimerDeengPre) THEN
        |VVdelayedAutoOut = OFF
        &VVdelayTimerAcc = 0 
      ENDIF
    ENDIF
  ENDIF
   
  IF (|VVman = OFF) THEN
    |VVout = |VVdelayedAutoOut
  ELSIF (|VVmanEnable = OFF) THEN
    |VVman = OFF
  ENDIF

  IF (|VVout = ON) THEN
    IF (|VVdelayedOut = ON) THEN
      IF (&VVfaultTimerAcc >= &VVfaultTimerEngPre) THEN
        IF ((|VVengEnable = ON) AND (|VVeng = OFF)) THEN
          |VVfault = ON
        ELSIF ((|VVdeengEnable = ON) AND (|VVdeeng = ON)) THEN
          |VVfault = ON
        ELSE
          IF (|VVfaultResetEnable = OFF) THEN
            |VVfault = OFF
          ENDIF  
        ENDIF
      ELSE
        &VVfaultTimerAcc = &VVfaultTimerAcc + &lastScanTimeFast
        |VVfault = OFF
      ENDIF
    ELSE
      &VVfaultTimerAcc = 0
      |VVdelayedOut = ON
      |VVfault = OFF
    ENDIF   
  ELSE
    IF (|VVdelayedOut = OFF) THEN
      IF (&VVfaultTimerAcc >= &VVfaultTimerDeengPre) THEN
        IF ((|VVdeengEnable = ON) AND (|VVdeeng = OFF)) THEN
          |VVfault = ON
        ELSIF ((|VVengEnable = ON) AND (|VVeng = ON)) THEN
          |VVfault = ON
        ELSE
          IF (|VVfaultResetEnable = OFF) THEN
            |VVfault = OFF
          ENDIF 
        ENDIF
      ELSE
        &VVfaultTimerAcc = &VVfaultTimerAcc + &lastScanTimeFast
        |VVfault = OFF
      ENDIF
    ELSE
      &VVfaultTimerAcc = 0
      |VVdelayedOut = OFF
      |VVfault = OFF
    ENDIF
  ENDIF
   
  IF (|VVfault = ON) THEN
    |VVmotFault = ON
  ENDIF
    
  IF (|VVmotFault = ON) AND (&VVmotFaultTimerAcc < 500)  THEN
    &VVmotFaultTimerAcc = &VVmotFaultTimerAcc + &lastScanTimeFast
  ELSIF (|VVfault = OFF) THEN
    |VVmotFault = OFF
    &VVmotFaultTimerAcc = 0
  ENDIF
   
return

