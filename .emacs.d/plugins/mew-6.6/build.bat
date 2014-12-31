cd bin
nmake -f Makefile.w32
del *.obj
del config.h
cd hs
cabal install
rmdir /s /q dist
cd ..
copy %APPDATA%\cabal\bin\smew.exe .
copy %APPDATA%\cabal\bin\cmew.exe .
cd ..

