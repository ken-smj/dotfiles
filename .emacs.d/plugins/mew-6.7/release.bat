if "%1" == "" (
	echo Usage: release.bat DIRVER ARCVER
	goto END
)
if "%2" == "" (
	echo Usage: release.bat DIRVER ARCVER
	goto END
)

set DIRVER=mew-%1
set ARCVER=%2

rm -rf %DIRVER%
mkdir %DIRVER%
git archive HEAD | tar -x -C %DIRVER%
cp mew.exe %DIRVER%
cp bin/*.exe %DIRVER%/bin

zip -9r MEW%ARCVER%.ZIP %DIRVER%
sha1sum MEW%ARCVER%.ZIP > MEW%ARCVER%.ZIP.sha1

rem git tag v6.7+w0
rem git push origin refs/heads/v6.7rc1+w0:v6.7rc1+w0
rem git push --tags

:END
