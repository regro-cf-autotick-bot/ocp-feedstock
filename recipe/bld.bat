set CONDA_PREFIX=%PREFIX%
if errorlevel 1 exit 1

cmake -B build -S "%SRC_DIR%\src" ^
	-G Ninja ^
	-DCMAKE_BUILD_TYPE=Release ^
	-DPython3_FIND_STRATEGY=LOCATION ^
	-DPython3_ROOT_DIR=%CONDA_PREFIX% ^
	-DCMAKE_LINKER=lld-link.exe ^
	-DCMAKE_MODULE_LINKER_FLAGS="/machine:x64 /FORCE:MULTIPLE"
if errorlevel 1 exit 1

cmake --build build -- -v -k 0
cmake --build build -- -v -k 0
if errorlevel 1 exit 1

cmake --install build --prefix "%STDLIB_DIR%"
if errorlevel 1 exit 1
