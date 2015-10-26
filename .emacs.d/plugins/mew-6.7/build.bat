cd bin
nmake -f Makefile.w32
cd instsrc
nmake
copy mew.exe ..\..
cd ..
cd hs
cabal --extra-include-dirs=C:/usr/local/include --extra-lib-dirs=C:/bin32 install
rmdir /s /q dist
cd ..
copy %APPDATA%\cabal\bin\smew.exe .
copy %APPDATA%\cabal\bin\cmew.exe .
cd ..
