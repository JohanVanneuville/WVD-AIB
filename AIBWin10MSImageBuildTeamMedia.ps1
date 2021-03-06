#Script to setup golden image with Azure Image Builder

#Create temp folder
New-Item -Path 'C:\temp' -ItemType Directory -Force | Out-Null

#Install VSCode
Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?Linkid=852157' -OutFile 'c:\temp\VScode.exe'
Invoke-Expression -Command 'c:\temp\VScode.exe /verysilent'

#Start sleep
Start-Sleep -Seconds 10

#Start sleep
Start-Sleep -Seconds 10

#InstallTeamsMachinemode Preview Media Optimisations - Reg pre-reqs
New-Item -Path HKLM:\SOFTWARE\Microsoft\Teams -Force | Out-Null
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Teams -name IsWVDEnvironment -Value “1” -Force | Out-Null

#Install VC++ & WebSocket Service then Teams with media optimisations
Invoke-WebRequest -Uri 'https://support.microsoft.com/help/2977003/the-latest-supported-visual-c-downloads' -OutFile 'c:\temp\vc.msi'
Invoke-Expression -Command 'c:\temp\vc.msi /quiet'
#Start sleep
Start-Sleep -Seconds 10
Invoke-WebRequest -Uri 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4vkL6' -OutFile 'c:\temp\websocket.msi'
Invoke-Expression -Command 'c:\temp\websocket.msi /quiet'
#Start sleep
Start-Sleep -Seconds 10
Invoke-WebRequest -Uri 'https://statics.teams.cdn.office.net/production-windows-x64/1.3.00.4461/Teams_windows_x64.msi' -OutFile 'c:\temp\Teams.msi'
Invoke-Expression -Command 'msiexec /i C:\temp\Teams.msi /quiet /l*v C:\temp\teamsinstall.log ALLUSER=1 ALLUSERS=1'

#Run the VDI GUYS optimization script
Invoke-WebRequest -URi'https://github.com/ProximusAzure/WVD-Azure-Image-Builder/blob/main/Virtual-Desktop-Optimization-Tool-master.zip' -OutFile 'c:\temp\Virtual-Desktop-Optimization-Tool-master.zip'
Expand-Archive -Path 'C:\temp\VDIGUYS\Virtual-Desktop-Optimization-Tool-master -DestinationPath 'C:\optimize
cd c:\optimize
Set-ExecutionPolicy -ExecutionPolicy ByPass
.\Win10_VirtualDesktop_Optimize.ps1 -WindowsVersion 2004 -Verbose
Restart-Computer -Force
Set-ExecutionPolicy -ExecutionPolicy ByPass
