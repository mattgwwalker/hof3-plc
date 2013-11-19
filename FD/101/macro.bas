//FD101 Route Sequence

//Clear Sequence Outputs... these are then set on below
&fd101ProgOut01 = 0
&tempStepNum = &fd101StepNum

select &tempStepNum
 case  fd101StepNum_RESET:
  &tempStepNum = fd101StepNum_BYPASS
  
 case  fd101StepNum_BYPASS:
  if (|fd100_fd101_recirc=ON) then
   &tempStepNum = fd101StepNum_RECIRC_TOP
  endif
  if (|fd100_fd101_drain=ON) then
   &tempStepNum = fd101StepNum_DRAIN_TOP
  endif
  
 case  fd101StepNum_RECIRC_TOP:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m) \
  and (&fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_TO_BOTTOM
  endif
  if ((&fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m) \
  and (&fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10)\
  and (&fd101BWTimePre_RECIRC_s10 > -1)) then
   &tempStepNum = fd101StepNum_RECIRC_BW_TOP
  endif
   
 case fd101StepNum_RECIRC_TO_BOTTOM:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TO_BOTTOM_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TO_BOTTOM_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_BOTTOM
  endif
   
 case  fd101StepNum_RECIRC_BOTTOM:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m) \
  and (&fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_TO_TOP
  endif
  if ((&fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m) \
  and (&fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10)\
  and (&fd101BWTimePre_RECIRC_s10 > -1)) then
   &tempStepNum = fd101StepNum_RECIRC_BW_BOTTOM
  endif
   
 case  fd101StepNum_RECIRC_TO_TOP:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TO_TOP_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TO_TOP_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_TOP
  endif
   
 case  fd101StepNum_RECIRC_BW_TOP:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_TOP_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_TOP_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_TOP
   &fd101_BW_count = &fd101_BW_count + 1
   |fd101_PC03calc = ON
  endif
    
 case  fd101StepNum_RECIRC_BW_BOTTOM:
  if (|fd100_fd101_recirc=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_BOTTOM_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_BOTTOM_s10)) then
   &tempStepNum = fd101StepNum_RECIRC_BOTTOM
   &fd101_BW_count = &fd101_BW_count + 1
   |fd101_PC03calc = ON
  endif
  
 case fd101StepNum_DRAIN_TOP:
  if (|fd100_fd101_drain=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif 
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_DRAIN_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_DRAIN_s10)) then
   &tempStepNum = fd101StepNum_DRAIN_BOTTOM
  endif 
 
 case fd101StepNum_DRAIN_BOTTOM:
  if (|fd100_fd101_drain=OFF) then
   &tempStepNum = fd101StepNum_BYPASS
  endif
  if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_DRAIN_m) \
  and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_DRAIN_s10)) then
   &tempStepNum = fd101StepNum_DRAIN_TOP
  endif   
        
 default:
  &tempStepNum = fd101StepNum_RESET
endsel

IF (&tempStepNum != &fd101StepNum) THEN
 &fd101StepNum = &tempStepNum
 &fd101StepTimeAcc_s10 = 0
 &fd101StepTimeAcc_m = 0
 select &tempStepNum
  case fd101StepNum_RESET:
  case fd101StepNum_BYPASS:
  case fd101StepNum_RECIRC_TOP:
  case fd101StepNum_RECIRC_TO_BOTTOM:
  case fd101StepNum_RECIRC_BOTTOM:
  case fd101StepNum_RECIRC_TO_TOP:
  case fd101StepNum_RECIRC_BW_TOP:
   &fd101_BW_PT03max=0
  case fd101StepNum_RECIRC_BW_BOTTOM:
   &fd101_BW_PT03max=0
  case fd101StepNum_DRAIN_TOP:
  case fd101StepNum_DRAIN_BOTTOM:          
  default:
 endsel
ENDIF

select &tempStepNum
 case  fd101StepNum_RESET: 
 
 case  fd101StepNum_BYPASS:
  
 case  fd101StepNum_RECIRC_TOP:
  if (|fd100Fault_fd101_Pause=OFF) then
   &fd101DirTimeAcc_s10 = &fd101DirTimeAcc_s10 + &lastScanTimeShort
   &fd101BWTimeAcc_s10 = &fd101BWTimeAcc_s10 + &lastScanTimeShort
   &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  endif 
  |fd101_IV05=ON
  |fd101_IV06=ON
  if ((&fd101StepTimeAcc_m = 0) \
  and (&fd101StepTimeAcc_s10 < 100)) then       
   |fd101_DPC01pidHold=ON
   |fd101_PC01pidHold=ON
   |fd101_PC05pidHold=ON  
   |fd101_RC01pidHold=ON
  endif  
 
 case  fd101StepNum_RECIRC_TO_BOTTOM:
  &fd101DirTimeAcc_s10 = 0
  &fd101DirTimeAcc_m = 0
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  |fd101_DV01=ON
  |fd101_DV02=ON
  |fd101_DV03=ON
  |fd101_IV05=ON  
  |fd101_DPC01pidHold=ON
  |fd101_PC01pidHold=ON
  |fd101_PC05pidHold=ON  
  |fd101_RC01pidHold=ON   
 
 case  fd101StepNum_RECIRC_BOTTOM:
  if (|fd100Fault_fd101_Pause=OFF) then 
   &fd101DirTimeAcc_s10 = &fd101DirTimeAcc_s10 + &lastScanTimeShort
   &fd101BWTimeAcc_s10 = &fd101BWTimeAcc_s10 + &lastScanTimeShort
   &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  endif 
  |fd101_DV01=ON
  |fd101_DV02=ON
  |fd101_DV03=ON
  |fd101_IV05=ON
  |fd101_IV06=ON
  if ((&fd101StepTimeAcc_m = 0) \
  and (&fd101StepTimeAcc_s10 < 100)) then     
   |fd101_DPC01pidHold=ON
   |fd101_PC01pidHold=ON
   |fd101_PC05pidHold=ON  
   |fd101_RC01pidHold=ON
  endif

 case  fd101StepNum_RECIRC_TO_TOP:
  &fd101DirTimeAcc_s10 = 0
  &fd101DirTimeAcc_m = 0
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  |fd101_IV05=ON  
  |fd101_DPC01pidHold=ON
  |fd101_PC01pidHold=ON
  |fd101_PC05pidHold=ON  
  |fd101_RC01pidHold=ON
   
 case  fd101StepNum_RECIRC_BW_TOP:
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  &fd101BWTimeAcc_s10 = 0
  &fd101BWTimeAcc_m = 0
  |fd101_BF01=ON
  |fd101_IV05=ON
  |fd101_DPC01pidHold=ON
  |fd101_PC01pidHold=ON
  |fd101_PC05pidHold=ON  
  |fd101_RC01pidHold=ON
  FORCE_LOG
  if (&fd101_BW_PT03max < &PT03_1000) then
   &fd101_BW_PT03max = &PT03_1000
  endif

     
 case  fd101StepNum_RECIRC_BW_BOTTOM:
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  &fd101BWTimeAcc_s10 = 0
  &fd101BWTimeAcc_m = 0
  |fd101_BF01=ON
  |fd101_DV01=ON
  |fd101_DV02=ON
  |fd101_DV03=ON  
  |fd101_IV05=ON
  |fd101_DPC01pidHold=ON
  |fd101_PC01pidHold=ON
  |fd101_PC05pidHold=ON  
  |fd101_RC01pidHold=ON
  FORCE_LOG
  if (&fd101_BW_PT03max < &PT03_1000) then
   &fd101_BW_PT03max = &PT03_1000
  endif
    
 case fd101StepNum_DRAIN_TOP:
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  |fd101_IV01=ON
  |fd101_IV02=ON
  |fd101_IV04=ON
  |fd101_IV05=ON 
 
 case fd101StepNum_DRAIN_BOTTOM:
  &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  |fd101_DV01=ON
  |fd101_DV02=ON
  |fd101_DV03=ON 
  |fd101_IV01=ON
  |fd101_IV02=ON
  |fd101_IV04=ON
  |fd101_IV05=ON  
         
 default:
endsel

if (&fd101StepTimeAcc_s10 > 599) then
  &fd101StepTimeAcc_s10 = 0
  &fd101StepTimeAcc_m = &fd101StepTimeAcc_m + 1
endif
if (&fd101StepTimeAcc_m > 32000) then
  &fd101StepTimeAcc_m = 32000
endif

if (&fd101BWTimeAcc_s10 > 599) then
  &fd101BWTimeAcc_s10 = 0
  &fd101BWTimeAcc_m = &fd101StepTimeAcc_m + 1
endif
if (&fd101BWTimeAcc_m > 32000) then
  &fd101BWTimeAcc_m = 32000
endif

if (&fd101DirTimeAcc_s10 > 599) then
  &fd101DirTimeAcc_s10 = 0
  &fd101DirTimeAcc_m = &fd101DirTimeAcc_m + 1
endif
if (&fd101DirTimeAcc_m > 32000) then
  &fd101DirTimeAcc_m = 32000
endif

