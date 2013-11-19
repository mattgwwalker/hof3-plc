@echo off
echo This batch file replaces the template text "{ROOT}" in the file HOF3.template 
echo with the path to the current directory.  The file HOF3.bas is created.
echo This script depends on sed being available in the current PATH.  To get sed,
echo head to http://gnuwin32.sourceforge.net/packages/sed.htm
echo.
echo Setting {ROOT} to %CD%
echo.

set "cwd=%cd%"
sed -e "s/{ROOT}/%cwd:\=\\%/" HOF3.template > HOF3.bas

echo HOF3.bas has been written.
