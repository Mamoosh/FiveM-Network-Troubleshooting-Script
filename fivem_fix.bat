@echo off
echo FiveM Network Troubleshooting Script               
:menu
echo.
echo 1. Reset DNS
echo 2. Fix join be server
echo 3. Rename host file to host.bkp    
echo 4. Rename host file to host
echo 5. Delete host file and create new file named host with empty data
echo 6. Set CloudFlare DNS
echo 7. Exit
echo.
color 30
set /p choice="Lotfan yeki az option ha ra vared konid: "

if "%choice%"=="1" goto refreshDNS
if "%choice%"=="2" goto modifyHost
if "%choice%"=="3" goto renameHostBkp
if "%choice%"=="4" goto renameHost
if "%choice%"=="5" goto deleteCreateHost
if "%choice%"=="6" goto cloudflaredns
if "%choice%"=="7" goto end

:refreshDNS
ipconfig /flushdns
goto menu

:modifyHost
setlocal
set "file=C:\Windows\System32\drivers\etc\hosts"
attrib -r "%file%"
(
    echo 78.157.42.100 runtime.fivem.net
    echo 50.7.87.85 users.cfx.re
    echo 78.157.42.100 metrics.fivem.net
    echo 78.157.42.100 registry-internal.fivem.net
    echo 78.157.42.100 status.fivem.net
    echo 78.157.42.100 servers-frontend.fivem.net
    echo 50.7.87.85 cnl-hb-live.fivem.net
    echo 50.7.87.85 policy-live.fivem.net
    echo 78.157.42.100 synapse.fivem.net
    echo 78.157.42.100 status.cfx.re
    echo 78.157.42.100 content.cfx.re
    echo 50.7.87.85 sentry.fivem.net
    echo 50.7.87.85 lambda.fivem.net
    echo 78.157.42.100 changelogs-live.fivem.net
    echo 78.157.42.100 servers-frontend.fivem.net
    echo 50.7.87.85 cnl-hb-live.fivem.net
    echo 50.7.87.85 policy-live.fivem.net
    echo 50.7.87.85 keymaster.fivem.net
    echo 50.7.87.85 myip.is
) >> "%file%"
endlocal
goto menu

:renameHostBkp
ren C:\Windows\System32\drivers\etc\hosts host.bkp
goto menu

:renameHost
ren C:\Windows\System32\drivers\etc\host.bkp hosts
goto menu

:deleteCreateHost
del C:\Windows\System32\drivers\etc\hosts
echo. > C:\Windows\System32\drivers\etc\hosts
goto menu

:cloudflaredns
:: Get a list of all network interfaces
for /f "tokens=4" %%a in ('netsh interface show interface ^| findstr /C:"Enabled"') do (
    echo CHANGING DNS FOR INTERFACE: %%a
    netsh interface ip set dns "%%a" static 1.1.1.1 primary
    netsh interface ip add dns "%%a" 1.1.1.1 index=2
    echo DNS CHANGED SUCCESSFULLY FOR INTERFACE: %%a
    echo   -
)
goto menu

:end
pause