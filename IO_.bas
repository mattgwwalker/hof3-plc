//IO Mapping
// The variables CI_1 to CI_10 are bits stored in register 4103 (see
// page 88 of ICC402-REG-MAN.pdf).  
BIT |ES01_I1 = |CI_1    //OK when ES01 ON=OK OFF=NotOK
BIT |PB01_I = |CI_2     //OK Pushbutton
BIT |PS01_I = |CI_3     //OK Water Pressure ON=OK OFF= No Water
BIT |PS02_I = |CI_4     //OK High Pressure Air ON=OK OFF=No Air
BIT |PS03_I = |CI_5     //OK Low Presuure Air ON=OK OFF=No Air
BIT |FS01_I_Raw = |CI_6 //OK Seal Water Flow switch
BIT |PP01E_I = |CI_7    //OK - PP01 Run
BIT |ES01_I2 = |CI_8    //OK ES01 ON=NotOK OFF=OK

//|DI_1 not in use
BIT |CP01_I = |DI_2    //OK
BIT |CP02_I = |DI_3    //OK
BIT |IV02D_I = |DI_4    //OK
BIT |IV02E_I = |DI_5    //OK
BIT |IV03D_I = |DI_6    //OK
BIT |IV03E_I = |DI_7    //OK
BIT |IV04D_I = |DI_8    //OK
BIT |IV04E_I = |DI_9    //OK
BIT |IV07D_I = |DI_10   //OK
BIT |IV07E_I = |DI_11   //OK
//|DI_12 not in use
//|DI_13 not in use
//|DI_14 not in use
//|DI_15 not in use
//|DI_16 not in use
BIT |DV01E_I = |DI_17    //OK
BIT |DV01D_I = |DI_18    //OK
BIT |DV02E_I = |DI_19    //OK
BIT |DV02D_I = |DI_20    //OK
BIT |DV03E_I = |DI_21    //OK
BIT |DV03D_I = |DI_22    //OK
BIT |DV04E_I = |DI_23    //OK
BIT |DV04D_I = |DI_24    //OK
BIT |DV05E_I = |DI_25    //OK
BIT |DV05D_I = |DI_26    //OK
BIT |DV06E_I = |DI_27    //OK
BIT |DV06D_I = |DI_28    //OK
BIT |IV16E_I = |DI_29    //OK
BIT |IV16D_I = |DI_30    //OK
//|DI_31 not in use
//|DI_32 not in use
BIT |IV01E_I = |DI_33    //OK
BIT |IV01D_I = |DI_34    //OK
BIT |IV05E_I = |DI_35    //OK
BIT |IV05D_I = |DI_36    //OK
BIT |IV06E_I = |DI_37    //OK
BIT |IV06D_I = |DI_38    //OK
BIT |IV08E_I = |DI_39    //OK
BIT |IV08D_I = |DI_40    //OK
//|DI_41 not in use
//|DI_42 not in use
//|DI_43 not in use
//|DI_44 not in use
//|DI_45 not in use
//|DI_46 not in use
//|DI_47 not in use
//|DI_48 not in use


BIT |IL01_O = |SP5 //OK
BIT |PP01_O1 = |SP6 //OK
BIT |EL01_O = |SP7 //OK
BIT |CP02_O = |SP8 //OK
BIT |PP01_O2 = |SP9 //OK
BIT |PP04_O2 = |SP10 //OK to KM2 Future Pump
BIT |CP01_O = |SP11 //OK
//|SP12 not in use

BIT |EL01_PWM1 = |DO_1 //OK
BIT |EL01_PWM2 = |DO_2 //OK
BIT |EL01_PWM3 = |DO_3 //OK
BIT |PP03_O = |DO_4 //OK
BIT |PP02_O = |DO_5 //OK
//|DO_6 Not in use
//|DO_7 Not in use
//|DO_8 Not in use
//|DO_9 Not in use
BIT |IV10_O = |DO_10 //OK
BIT |IV02_O = |DO_11 //OK
BIT |IV04_O = |DO_12 //OK
BIT |IV07_O = |DO_13 //OK
//BIT |IV14_O = |DO_14
BIT |IV15_O = |DO_15 //OK
BIT |IV16_O = |DO_16 //OK
BIT |DV01_O = |DO_17 //OK
BIT |DV02_O = |DO_18 //OK
BIT |DV03_O = |DO_19 //OK
BIT |DV04_O = |DO_20 //OK
BIT |DV05_O = |DO_21 //OK
BIT |DV06_O = |DO_22 //OK
BIT |DV07_O = |DO_23 //OK
BIT |DV08_O = |DO_24 //OK
BIT |BF01_O = |DO_25 //OK
//|DO_26 Not in use
//|DO_27 Not in use
//|DO_28 Not in use
//|DO_29 Not in use
//|DO_30 Not in use
//|DO_31 Not in use
//|DO_32 Not in use
BIT |IV01_O = |DO_33 //OK
BIT |IV05_O = |DO_34 //OK
BIT |IV06_O = |DO_35 //OK
BIT |IV08_O = |DO_36 //OK
BIT |IV09_O = |DO_37 //OK
//|DO_38 Not in use
//|DO_39 Not in use
//|DO_40 Not in use
//|DO_41 Not in use
//|DO_42 Not in use
//|DO_43 Not in use
//|DO_44 Not in use
//|DO_45 Not in use
//|DO_46 Not in use
//|DO_47 Not in use
//|DO_48 Not in use


