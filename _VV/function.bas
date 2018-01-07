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



// mot stands for "Minimum on Time".  This is the minimum time that a fault
// is latched up.
CONST VV_FAULT_MINIMUM_ON_TIME = 500 // ms


VV:
  // *** Interlocks ***

  // An interlock has to be on in order to allow the feature to be accessible.  
  // For example, to turn a valve to automatic, the interlock for automatic has
  // to be on.

  // The interlocks are a way of quickly checking if that action is available.
  // So if the interlock for manual is on, you can select manual mode.
  
  IF ((|VVmanEnable = ON) AND (|VVman = ON)) THEN
    |VVautoInterlock = ON
  ELSE
    |VVautoInterlock = OFF 
  ENDIF
    
  IF ((|VVmanEnable = ON) AND (|VVman = OFF)) THEN
    |VVmanInterlock = ON
  ELSE
    |VVmanInterlock = OFF 
  ENDIF

  // If the valve is currently in manual and on, then allow it to be manually
  // turned off.
  IF ((|VVman = ON) AND (|VVout = ON)) THEN
    |VVmanOFFInterlock = ON
  ELSE
    |VVmanOFFInterlock = OFF 
  ENDIF
    
  // If the valve is currently in manual and off, then allow it to be manually
  // turned on.
  IF ((|VVman = ON) AND (|VVout = OFF)) THEN
    |VVmanONInterlock = ON
  ELSE
    |VVmanONInterlock = OFF 
  ENDIF


  // *** Commands *** 

  // Handle the actioning of a command.
  // 0=none 1=auto 2=manual 3=manualOff 4=manualOn
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
      // If the valve is allowed to be turned off manually, turn it off.
      IF (|VVmanOFFInterlock = ON) THEN
        |VVout = OFF
      ENDIF
    
    CASE 4:
      // If the valve is allowed to be turned on manually, turn it on.
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

  // Handle the delaying of automatic changes to the item's state.
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


  // Fault checking: if the valve is being asked to go to one state, but it's 
  // not in that state, check how long has this been been going on.  If it's
  // longer than the item's preset then this is a fault. 
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

  // If the item is in a fault state then latch up the fault for a minimum time.   
  IF (|VVfault = ON) THEN
    |VVmotFault = ON
  ENDIF
    
  // Handle the timer for the minimum on time. 
  IF (|VVmotFault = ON) AND (&VVmotFaultTimerAcc < VV_FAULT_MINIMUM_ON_TIME) THEN
    &VVmotFaultTimerAcc = &VVmotFaultTimerAcc + &lastScanTimeFast
  ELSIF (|VVfault = OFF) THEN
    |VVmotFault = OFF
    &VVmotFaultTimerAcc = 0
  ENDIF
   
return

