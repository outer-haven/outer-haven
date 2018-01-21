@echo off
REM Get the documents folder from the registry.
for /f "tokens=3* delims= " %%a in (
    'reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"'
) do (
    set documents=%%a %%b
)
<<<<<<< HEAD
REM Copy assets to the BYOND cache
cmd /c copy assets\* "%documents%\BYOND\cache" /y
=======
REM Copy to tmp subdirectories
FOR /D %%G in ("%DocumentsFolder%\BYOND\cache\tmp*") DO (cmd /c copy assets\* %%G /y)
>>>>>>> 982b225... Fixes tgui reload script (#34632)
