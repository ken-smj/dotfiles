@REM dotfiles link
@REM require administrator
@ECHO OFF
CD %HOME%
SET mklinks=.emacs.d .bash_profile .gitconfig .inputrc .mew.el .minttyrc .vimrc
FOR %%i IN (%mklinks%) DO (
    ECHO check %%i ...
    IF EXIST %%i\nul (
       RMDIR %%i
       ECHO delete %%i directory.
    ) ELSE (
    IF EXIST .\%%i (
       DEL %%i
       ECHO delete %%i file.
    ))
    IF EXIST %HOME%\dotfiles\%%i\nul (
       MKLINK /D %%i %HOME%\dotfiles\%%i
       IF NOT "%ERRORLEVEL%" == "0" EXIT 1
    ) ELSE (
    IF EXIST %HOME%\dotfiles\%%i (
       MKLINK %%i %HOME%\dotfiles\%%i
       IF NOT "%ERRORLEVEL%" == "0" EXIT 1
    ))
)
