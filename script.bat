@echo off
:: Verifica se foi chamado com o argumento correto
IF "%1" NEQ "token123" (
    echo Acesso negado. Fechando...
    timeout /t 2 >nul
    exit /b
)

@echo off
setlocal EnableDelayedExpansion

:: Inicializa a variável com uma string vazia
set "serialBoard="

:: Gera 10 dígitos aleatórios
for /L %%i in (1,1,10) do (
    set /A rand=!random! %% 10
    set "serialBoard=!serialBoard!!rand!"
)

title Enigma Permanent
color 0A

echo -----------------------------------------
echo     Enigma Permanent - Made by Ace       
echo -----------------------------------------
echo free perm that matches ANY paid perm easily
echo Made with help from ChatGPT and common sense
echo.

:: Verifica se está rodando como Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Execute como administrador.
    pause
    exit /b
)

:: Pergunta sobre fabricante e modelo
echo [INFO] Digite as informacoes do sistema:
set /p fabricante=Fabricante da placa-mae (ex: ASRock): 
set /p modelo=Modelo da placa-mae: 
set versao=1.0
set serial=AENIDJCIINOAOD

:: Perguntas sobre sistema
set /p isAsus=Voce esta em uma placa Asus? (Yes/No): 
set /p isLocked=Sua placa-mae e bloqueada? (Yes/No): 

:: Gera strings aleatorias
cd /d "%~dp0"
for /f "delims=" %%i in ('call randstr.bat 10') do set "output9=%%i"
for /f "delims=" %%i in ('call randstr.bat 14') do set "output91=%%i"
for /f "delims=" %%i in ('call randstr.bat 10') do set "output92=%%i"

cd AMI

if /i "%isLocked%" == "No" (
    echo [*] Spoofando BaseBoard Manufacturer
    AMIDEWINx64.EXE /BM "%fabricante%"

timeout /t 5 >nul

    
    echo [*] Spoofando BaseBoard Product
    AMIDEWINx64.EXE /BP "%modelo%"

timeout /t 5 >nul

    echo [*] Aplicando spoof via AMIDEWIN...
    echo [*] Aplicando spoof via AMIDEWIN...
    AMIDEWINx64.EXE /IVN "%fabricante%"
    AMIDEWINx64.EXE /SM "%fabricante%"
    AMIDEWINx64.EXE /SP "%modelo%"
    AMIDEWINx64.EXE /SV "%versao%"
    AMIDEWINx64.EXE /SS %output9%
    AMIDEWINx64.EXE /SU AUTO
    AMIDEWINx64.EXE /SK "To Be Filled By O.E.M"
    AMIDEWINx64.EXE /SF "To Be Filled By O.E.M."
    AMIDEWINx64.EXE /BS "%serialBoard%"
    AMIDEWINx64.EXE /BT "Default string"
    AMIDEWINx64.EXE /BLC "Default string"
    AMIDEWINx64.EXE /CM "Default string"
    AMIDEWINx64.EXE /CV "Default string"
    AMIDEWINx64.EXE /CS %output92%
    AMIDEWINx64.EXE /CA "Default string"
    AMIDEWINx64.EXE /CSK "SKU"
    AMIDEWINx64.EXE /PSN "%serial%"
    AMIDEWINx64.EXE /PAT "To Be Filled By O.E.M."
    AMIDEWINx64.EXE /PPN "To Be Filled By O.E.M."
    echo [✓] AMIDEWIN spoof aplicado!
)

if /i "%isAsus%" == "Yes" (
    echo [*] Aplicando spoof via AFUWIN...
    AFUWINx64.exe BIOS.rom /o
    AFUWINx64.exe BIOS.rom /p
    echo [✓] AFUWIN spoof aplicado!
)

if /i "%isLocked%" == "Yes" (
    echo [*] Criando script EFI para placas bloqueadas...

    cd USB\efi\boot
    (
    echo echo -off
    echo AMIDEEFIx64.efi /IVN "AMI"
    echo AMIDEEFIx64.efi /SM "%fabricante%"
    echo AMIDEEFIx64.efi /SP "%modelo%"
    echo AMIDEEFIx64.efi /SV "%versao%"
    echo AMIDEEFIx64.efi /SS "%output9%"
    echo AMIDEEFIx64.efi /SU AUTO
    echo AMIDEEFIx64.efi /SK "To Be Filled By O.E.M"
    echo AMIDEEFIx64.efi /SF "To Be Filled By O.E.M."
    echo AMIDEEFIx64.efi /BS "%output91%"
    echo AMIDEEFIx64.efi /BT "Default string"
    echo AMIDEEFIx64.efi /BLC "Default string"
    echo AMIDEEFIx64.efi /CM "Default string"
    echo AMIDEEFIx64.efi /CV "Default string"
    echo AMIDEEFIx64.efi /CS "%output92%"
    echo AMIDEEFIx64.efi /CA "Default string"
    echo AMIDEEFIx64.efi /CSK "SKU"
    echo AMIDEEFIx64.efi /PSN "%serial%"
    echo AMIDEEFIx64.efi /PAT "To Be Filled By O.E.M."
    echo AMIDEEFIx64.efi /PPN "To Be Filled By O.E.M."
    echo exit
    ) > startup.nsh

    cd ..\..\..

    echo [✓] EFI script gerado. Copie os arquivos da pasta AMI\USB para seu pendrive FAT32.
    pause
)

:: VolumeID Spoof
echo [*] Spoofing VolumeID...
cd ..\VOLUME
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "v1=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "v2=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "v3=%%i"
for /f "delims=" %%i in ('call randstr.bat 4 /v') do set "v4=%%i"
Volumeid64.exe C: %v1%-%v2% /accepteula
Volumeid64.exe D: %v3%-%v4% /accepteula
echo [✓] VolumeID spoof concluído.

 @ECHO OFF
 SETLOCAL ENABLEDELAYEDEXPANSION
 SETLOCAL ENABLEEXTENSIONS

 FOR /F "tokens=1" %%a IN ('wmic nic where physicaladapter^=true get deviceid ^| findstr [0-9]') DO (
 CALL :MAC
 FOR %%b IN (0 00 000) DO (
 REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a >NUL 2>NUL && REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a /v NetworkAddress /t REG_SZ /d !MAC!  /f >NUL 2>NUL
 )
 )

 FOR /F "tokens=1" %%a IN ('wmic nic where physicaladapter^=true get deviceid ^| findstr [0-9]') DO (
 FOR %%b IN (0 00 000) DO (
 REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a >NUL 2>NUL && REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\%%b%%a /v PnPCapabilities /t REG_DWORD /d 24 /f >NUL 2>NUL
 )
 )

 FOR /F "tokens=2 delims=, skip=2" %%a IN ('"wmic nic where (netconnectionid like '%%') get netconnectionid,netconnectionstatus /format:csv"') DO (
 netsh interface set interface name="%%a" disable >NUL 2>NUL
 netsh interface set interface name="%%a" enable >NUL 2>NUL
 )

 GOTO :EOF
 :MAC
 SET COUNT=0
 SET GEN=ABCDEF0123456789
 SET GEN2=26AE
 SET MAC=
 :MACLOOP
 SET /a COUNT+=1
 SET RND=%random%
 SET /A RND=RND%%16
 SET RNDGEN=!GEN:~%RND%,1!
 SET /A RND2=RND%%4
 SET RNDGEN2=!GEN2:~%RND2%,1!
 IF "!COUNT!"  EQU "2" (SET MAC=!MAC!!RNDGEN2!) ELSE (SET MAC=!MAC!!RNDGEN!)
 IF !COUNT!  LEQ 11 GOTO MACLOOP 
echo [✓] MAC spoof concluído.

:: Network Reset
echo [*] Resetando configuracoes de rede...
netsh winsock reset
netsh winsock reset catalog
netsh int ip reset
netsh advfirewall reset
netsh int reset all
netsh int ipv4 reset
netsh int ipv6 reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ipconfig /flushdns
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL DISABLE >nul 2>&1
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL ENABLE >nul 2>&1
arp -d
net stop winmgmt /y
net start winmgmt
echo [✓] Configuracoes de rede resetadas.

:: SID Spoof




color 0a

echo [INFO] Iniciando spoof de SID...
cd /d %windir%\System32\Sysprep

echo [INFO] Executando sysprep em modo silencioso...
start /wait sysprep.exe /quiet /generalize /oobe /shutdown

:: Verifica o código de saída
if %errorlevel%==0 (
    echo [SUCESSO] Sysprep executado com sucesso. O SID será alterado após o reboot.
) else (
    echo [ERRO] Sysprep falhou com código de erro: %errorlevel%
    echo [DICA] Verifique se o Windows já foi syspreppado muitas vezes ou se você tem permissões de administrador.
)





echo [✓] SID spoof concluído.

pause

