
set "cwd=%cd%"

set "LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%"
set "MINGWBIN=%LIBRARY_PREFIX%/mingw-w64/bin"

set BUILD_TYPE=Release

rmdir build_shared /s /q
mkdir build 
cd build

cmake -LAH -G "NMake Makefiles" ^
  %CMAKE_ARGS% ^
  -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
  -D CMAKE_BUILD_TYPE=%BUILD_TYPE% ^
  -D CMAKE_C_COMPILER:PATH=%MINGWBIN%/gcc.exe ^
  -D CMAKE_Fortran_COMPILER:PATH=%MINGWBIN%/gfortran.exe ^
  -D CMAKE_GNUtoMS:BOOL=ON ^
  -D GRIB=ON ^
  -D NCDF=ON ^
  -D OPENGL=OFF ^
  %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --target install --config %BUILD_TYPE%
if errorlevel 1 exit 1
