@echo off
set url=https://www.techpowerup.com/download/techpowerup-nvcleanstall/
curl %url% | find "<title>NVCleanstall v" > tmp
for /f "tokens=2" %%a in (tmp) do set "latest=%%a"
for /f "tokens=1 delims=v" %%a in ("%latest%") do set "latest=%%a"
del tmp
set installer=NVCleanstall_%latest%.exe
if exist %installer% (
	start %installer%
	echo ��Ϊ���������°氲װ����%latest%����5����˳�...
	ping 127.0.0.1 -n 5 >nul
	exit
) else echo ��װ�������ڣ�����������...
set mirror=https://gitee.com/hogum/setup-windows/releases/download/Tools/%installer%
set curl="%{http_code}"
curl -LIw %curl% %mirror% | find "HTTP/1.1" > tmp
for /f "tokens=2" %%a in (tmp) do set "state=%%a"
del tmp
if %state%==200 (
	echo.
	echo �����������°棨%latest%��...
	curl -# %mirror% -Lo %installer%
	start %installer%
	exit
)else echo ��������°棨%latest%������Ϊ�������ص�ַ
start %url%
pause