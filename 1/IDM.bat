@echo off
set url=https://lrepacks.net/repaki-programm-dlya-interneta/56-internet-download-manager-repack.html
set dir=C:\Program Files (x86)\Internet Download Manager\IDMan.exe
curl --ssl-no-revoke %url% | find "(Repack)</h2>" > tmp
for /f "delims=>( tokens=2" %%a in (tmp) do set "latest=%%a"
for /f "tokens=4" %%a in ("%latest%") do set "latest=%%a"
powershell "(Get-Item -path '%dir%').VersionInfo.ProductMajorPart" > tmp
for /f %%a in (tmp) do set "a=%%a"
powershell "(Get-Item -path '%dir%').VersionInfo.ProductMinorPart" > tmp
for /f %%b in (tmp) do set "b=%%b"
powershell "(Get-Item -path '%dir%').VersionInfo.ProductBuildPart" > tmp
for /f %%c in (tmp) do set "c=%%c"
set current=%a%.%b%.%c%
del tmp
if %latest%==%current% (
	echo.
	echo ��ʹ�õ������°棨%latest%��
	ping 127.0.0.1 -n 5 >nul
	exit
)else echo ��δ��װ���°棨%latest%�������԰�װ��...
set installer="Internet Download Manager %latest%.exe"
if exist %installer% (
	if exist "%dir%" (
		%installer% /SILENT /UPDATE=1
	) else %installer% /SILENT
	del %installer%
	exit
) else echo ��װ�������ڣ�����������...
set mirror=https://gitee.com/hogum/setup-windows/releases/download/Software/Internet%%20Download%%20Manager%%20%latest%.exe
set curl="%{http_code}"
curl -LIw %curl% %mirror% | find "HTTP/1.1" > tmp
for /f "tokens=2" %%a in (tmp) do set "state=%%a"
del tmp
if %state%==200 (
	echo.
	echo �������ز���װ���°�...
	curl -# %mirror% -Lo %installer%
	if exist "%dir%" (
		%installer% /SILENT /UPDATE=1
	) else %installer% /SILENT
	del %installer%
	exit
)else echo ��������°棬��Ϊ�������ص�ַ
start %url%
pause