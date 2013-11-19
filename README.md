hof3-plc
========

PLC Code for HOF3, a Membrane Filtration Plant

Due to a limitation in the compliler, include files must be given their full path.  Thus we have to pre-process the file HOF3.template to produce HOF3.bas, which is the file to compile.  

This pre-processing is automated in the script setroot.bat.  Using the command prompt, change to the directory that contains the file HOF3.template and execute the command setroot.  For this to be successful sed must be installed and accessible from the current path.

To install sed, head to http://gnuwin32.sourceforge.net/packages/sed.htm.  After installing, be sure to add the bin directory to the PATH variable.
