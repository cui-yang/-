@echo off
title Xml�ı���ȡ
md "%~dp0xml\">nul 2>nul
md "%~dp0��Ŀ�ļ�\">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo ǰ�ԣ�
echo �����ļ������ܺ���[]֮���������ţ�����
echo �������⣬��ȡ�����ɵ��ļ�����Ҫ�޸ģ�����
echo ������ȡ�����ɵ��ı��ļ��ڵ�ǰĿ¼������
echo ------------------------------------------------------------
echo ��Ϊ��Ŀ����������
set /p "xmm="
:JC1
(dir /a /b "%~dp0xml\*" | findstr /R "." >nul && (goto JC2) || (goto JC9))>nul 2>nul
:JC2
if exist "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" (goto JC7) else (goto JC6)
:JC3
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_xml����\*" | findstr /R "." >nul && (goto JC5) || (goto TC))>nul 2>nul
:JC4
echo ------------------------------------------------------------
echo ����Ŀ�Ѵ��ڣ���Ϊ��Ŀ�������ƣ�����
echo ��ֱ�Ӱ��س��������Ḳ�Ǿ���Ŀ������
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ) else (
set "xmm=%sr%"
goto JC1)
:JC5
echo ------------------------------------------------------------
echo xml�ļ�����û���ļ�������
echo ����Ŀ�ļ��д���%xmm%_xml����Ŀ���ݣ�
echo �Ƿ�ʹ�ø���Ŀ�����ٴν����ı���ȡ��
echo ֱ�Ӱ��س�����ȡ���������ı���������֮�˳����򣡣���
set /p "sr="
if /i "%sr%"=="" (goto SZ) else (exit)
:JC6
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_xml����\">nul 2>nul
move /y "%~dp0xml" "%~dp0��Ŀ�ļ�\%xmm%_xml����">nul 2>nul
md "%~dp0xml\">nul 2>nul 
goto SZ
:JC7
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_xml�ı�.txt" (goto JC8) else (goto JC6))
:JC8
echo ------------------------------------------------------------
echo ����Ŀ�Ѵ��ڣ���Ϊ��Ŀ�������ƣ�����
echo ��ֱ�Ӱ��س��������Ḳ�Ǿ���Ŀ������
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto JC6) else (
set "xmm=%sr%"
goto JC1)
:JC9
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_xml�ı�.txt" (goto JC4) else (goto JC3))
:SZ
echo ------------------------------------------------------------
echo �����Ҫ��ȡ������һ���ı�������Ҫ��ȡ���ַ�������һ����, 
echo ���Ƶ�"%xmm%_xml����.txt"�ļ��б��棬
echo "%xmm%_xml����.txt"�ļ���Ϊ���򿪡�
echo ע�⣺ֻ����ȡ�滻���ؼ��ʡ��ַ�����/�ؼ��ʡ��������ͣ�����
echo ------------------------------------------------------------
Start /w "" "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt"
for %%a in ("%~dp0��Ŀ�ļ�\%xmm%_xml����.txt") do (
if /i "%%~za"=="0" (goto SZ) else (goto TQ))
:TQ
echo ������ȡ�������ĵȴ�������
echo ------------------------------------------------------------
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_xmlԤ����\">nul 2>nul
xcopy /s /y /f "%~dp0��Ŀ�ļ�\%xmm%_xml����" "%~dp0��Ŀ�ļ�\%xmm%_xmlԤ����\">nul 2>nul
DIR "%~dp0��Ŀ�ļ�\%xmm%_xmlԤ����\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_xmllist.txt"
CD .>"%~dp0��Ŀ�ļ�\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_xmllist.txt") do (
	copy /b "%~dp0��Ŀ�ļ�\tmp1.txt" + "%%h" "%~dp0��Ŀ�ļ�\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp2.txt"
	move /y "%~dp0��Ŀ�ļ�\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
	echo ������ȡ"%%k"���ı�����...
("%~dp0tool\ssed.exe" -r -n "/\x3c%%k\x3e.*\x3c\x2f%%k\x3e/p" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x3c%%k\x3e\x3c\x2f%%k\x3e/d; /\x3c%%k\x3e\xe2\x80\x8b\x3c\x2f%%k\x3e/d" "%~dp0��Ŀ�ļ�\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x3c%%k\x3e(.*)\x3c\x2f%%k\x3e.*/\1/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml�ı�����.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml�ı�����.txt" > "%~dp0%xmm%_%%k_xml�ı�.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x3c%%k\x3e)(.*)(\x3c\x2f%%k\x3e.*)/\1\2\3\|\1\3/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt")>nul 2>nul)
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\*list.txt">nul 2>nul
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0��Ŀ�ļ�"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo ��ȡ��ɣ�������������˳���
echo ------------------------------------------------------------
pause>nul
exit
:TC
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\*list.txt">nul 2>nul
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0��Ŀ�ļ�"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo û���ҵ�txt�ļ�����������˳���
pause>nul
exit
