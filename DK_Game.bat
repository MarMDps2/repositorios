@echo off
:: Desmutear el volumen usando PowerShell
"%NIRCMD_PATH%" mutesysvolume 0
"%NIRCMD_PATH%" setsysvolume 65535
set "script_dir=%~dp0"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://media.tenor.com/mcPlflbf1p0AAAAM/monkey-deal-with-it.gif', '%script_dir%imagen.gif')"
echo ¡¡¡¡¡¡¡¡¡¡¡¡¡TROLEADO!!!!!!!!!!!!!! > "%script_dir%Troliado.txt"
start "" "%script_dir%imagen.gif"
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://www.youtube.com/watch?v=I8p89Xun5L0&ab_channel=Player2"
timeout /t 2
:loop
start notepad "%script_dir%Troliado.txt"
timeout /t 1
goto loop
