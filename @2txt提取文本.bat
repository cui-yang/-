@echo off
set "gjh=@2txt�ؼ�������.txt"
md "%~dp0txt\">nul 2>nul

mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo �뽫��Ҫ��ȡ��txt�ļ�����txt�ļ����У�
echo ------------------------------------------------------------
echo Ȼ���txt�ļ���������һ���ı���
echo ------------------------------------------------------------
echo ����Ҫ��ȡ���ַ������ڵ�����, 
echo ------------------------------------------------------------
echo ���Ƶ�"%gjh%"�ļ��б���, ���������������кš�
echo ------------------------------------------------------------
echo ��ע�⣺ֻ����ȡ�滻���ؼ��� = "�ַ���"���������ͣ�����
echo ------------------------------------------------------------
echo ������Ҫ��ȡ���кţ������ÿո�������������Զ������ӣ�
echo ������ȡ��5��14��17��18��19��20��������5 14 17,20�س���
echo ������ֱ�Ӱ��س�����"%gjh%"�ļ���ȡ������
echo �Ƽ���"%gjh%"�ļ���ʽ��ȡ�ı�������
echo ------------------------------------------------------------
set /p "sr="
if "%sr%"=="" (goto GJC) else (goto ZDH)

:ZDH
echo %sr%>"%~dp0tool\tmp.txt"
cd "%~dp0tool"
sed32 -i "s/ /\n/g" tmp.txt
echo ------------------------------------------------------------
echo ������ȡָ��������...
for /f "usebackq delims=" %%h in ("%~dp0tool\tmp.txt") do (
cd "%~dp0txt"
for %%i in (*.txt) do (
cd "%~dp0tool"
sed32 -n %%hp "%~dp0txt\%%i">>tmp2.txt
))>nul
findstr /r [\^"] "%~dp0tool\tmp2.txt" >"%~dp0tool\tmp.txt"
sed32 -i "s/\= \".*$//" "tmp.txt"
(for /f "tokens=* usebackq" %%l in ("tmp.txt") do echo %%l)>"tmp2.txt"
gawk "!x[$0]++" tmp2.txt > tmp.txt

if exist "%~dp0tool\txtָ���йؼ���.txt" (
echo ------------------------------------------------------------
echo ��⵽��ȡָ���е���ʷ��¼��
echo �����Ҫɾ����ʷ��¼���´������밴y���س�����
echo ��Ҫ����ǰ�к�׷�ӵ���ʷ��¼�У�����ֱ�Ӱ��س�����
set /p "xw="
if "%xw%"=="y" (goto SCJL) else (
if "%xw%"=="Y" (goto SCJL) else (
goto BSC))) else (goto BSC)

:SCJL
del "%~dp0tool\txtָ���йؼ���.txt">nul 2>nul

:BSC
findstr /V /c:"ECHO " "tmp.txt">>"txtָ���йؼ���.txt"
gawk "!x[$0]++" "txtָ���йؼ���.txt" > "%~dp0tmp0.txt"
del "%~dp0tool\tmp.txt">nul 2>nul
del "%~dp0tool\tmp2.txt">nul 2>nul
goto TQ


:GJC
(for /f "tokens=* usebackq" %%t in ("%gjh%") do echo %%t)>"%~dp0tmp.txt"
findstr /V /c:"ECHO " "%~dp0tmp.txt">"%~dp0tmp0.txt"
del "%~dp0tmp.txt">nul 2>nul

:TQ
md "%~dp0������ʱ���ļ���\">nul 2>nul
del "%~dp0������ʱ���ļ���\*.txt">nul 2>nul
for /f "usebackq delims==" %%k in ("%~dp0tmp0.txt") do (
del "%~dp0tool\tmp.txt">nul 2>nul
echo ------------------------------------------------------------
echo ������ȡ%%k���ı�����...
cd "%~dp0txt"
for %%j in (*.txt) do (
findstr /c:"%%k" %%j >> "%~dp0tool\tmp.txt"
findstr /s /c:"%%k" %%j >> "%~dp0������ʱ���ļ���\%%k_log.txt"
)>nul
findstr /r [\^"] "%~dp0tool\tmp.txt" >"%~dp0tool\tmp1.txt"
findstr /V "� """"" "%~dp0tool\tmp1.txt">"%~dp0tool\tmp.txt"
cd "%~dp0tool"
sed32 -i "s/.* \= \"//; s/\"$//" "tmp.txt"
gawk "!x[$0]++" tmp.txt > "tmp1.txt"
concmd /o:utf8 /f:s tmp1.txt "%~dp0%%kԭ��ȡ�ļ�.txt">nul
del "tmp.txt">nul 2>nul
del "tmp1.txt">nul 2>nul
copy /y "%~dp0%%kԭ��ȡ�ļ�.txt" "%~dp0%%k���޸��ļ�.txt">nul 2>nul
del "tmp.txt">nul 2>nul
)
del "%~dp0tmp0.txt">nul 2>nul
del "ECHO ���ڹر�״̬*.txt">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo ���ڡ����޸��ļ����н����޸Ĳ�����
echo ��ԭ��ȡ�ļ����롰���޸��ļ�����ÿ�д���һһ��Ӧ��ϵ��
echo ���Ҫɾ�������޸��ļ����е�ĳһ�У�
echo ��ԭ��ȡ�ļ����е���һ��ҲҪɾ����
echo ���⣬�벻Ҫ�޸��ļ���������
echo ֻ������������ȷ���滻��ȥ������
echo ����Ҫ�ġ�ԭ��ȡ�ļ����롰���޸��ļ�������ɾ����
echo ------------------------------------------------------------
echo ��������˳�...
pause>nul
exit
