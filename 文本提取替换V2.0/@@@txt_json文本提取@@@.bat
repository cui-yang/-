@echo off
title Unity3D�ı���ȡ
md "%~dp0txt_json\">nul 2>nul
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
(dir /a /b "%~dp0txt_json\*" | findstr /R "." >nul && (goto JC2) || (goto JC5))>nul 2>nul
:JC2
if exist "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" (goto JC3) else (goto SZ1)
:JC3
("%~dp0tool\ssed.exe" -r -e "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_txt�ı�.txt" (goto JC4) else (goto SZ1))
:JC4
echo ------------------------------------------------------------
echo ����Ŀ�Ѵ��ڣ���Ϊ��Ŀ�������ƣ�����
echo ��ֱ�Ӱ��س��������Ḳ�Ǿ���Ŀ������
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ1) else (
set "xmm=%sr%"
goto JC2)
:SZ1
echo ------------------------------------------------------------
echo �����Ҫ��ȡ������һ���ı�������Ҫ��ȡ���ַ�������һ����, 
echo ���Ƶ�"%xmm%_txt_json_����.txt"�ļ��б��棬
echo "%xmm%_txt_json_����.txt"�ļ���Ϊ���򿪡�
echo ��ע�⣺ֻ����ȡ�滻���ؼ��� = "�ַ���"��
echo �ͣ�"�ؼ���": "�ַ���"�����������ͣ�����
echo ------------------------------------------------------------

Start /w "" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt"
for %%a in ("%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt") do (
if /i "%%~za"=="0" (goto SZ1) else (goto BF))
:BF

rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_txt_json����\">nul 2>nul
move /y "%~dp0txt_json" "%~dp0��Ŀ�ļ�\%xmm%_txt_json����">nul 2>nul
md "%~dp0txt_json\">nul 2>nul 
goto TQ
:JC5
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_txt_json����\*" | findstr /R "." >nul && (goto JC6) || (goto TC))>nul 2>nul
:JC6
echo ------------------------------------------------------------
echo txt_json�ļ�����û���ļ�������
echo ����Ŀ�ļ��д���%xmm%_txt_json����Ŀ���ݣ�
echo �Ƿ�ʹ�ø���Ŀ�����ٴν����ı���ȡ��
echo ֱ�Ӱ��س���ȷ����ȡ���������ı�������
set /p "sr="
if /i "%sr%"=="" (goto JC7) else (exit)
:JC7
if exist "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" (goto JC8) else (goto SZ2)
:JC8
("%~dp0tool\ssed.exe" -r -e "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_txt�ı�.txt" (goto JC8) else (goto SZ2))
:JC9
echo ------------------------------------------------------------
echo ����Ŀ�Ѵ��ڣ���Ϊ��Ŀ�������ƣ�����
echo ��ֱ�Ӱ��س��������Ḳ�Ǿ���Ŀ������
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ2) else (
set "xmm=%sr%"
goto JC7)
:SZ2
echo ------------------------------------------------------------
echo �����Ҫ��ȡ������һ���ı�������Ҫ��ȡ���ַ�������һ����, 
echo ���Ƶ�"%xmm%_txt_json_����.txt"�ļ��б��棬
echo "%xmm%_txt_json_����.txt"�ļ���Ϊ���򿪡�
echo ��ע�⣺ֻ����ȡ�滻���ؼ��� = "�ַ���"��
echo �ͣ�"�ؼ���": "�ַ���"�����������ͣ�����
echo ------------------------------------------------------------

Start /w "" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt"
for %%a in ("%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt") do (
if /i "%%~za"=="0" (goto SZ2) else (goto TQ))
:TQ
echo ������ȡ�������ĵȴ�������
echo ------------------------------------------------------------

("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/; /.*\x22.*\x22\x3a\x20\x22.*/d" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/.*\x22(.*)\x22\x3a\x20\x22.*/\1/; /.*\x20\x3d\x20\x22.*/d" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp00.txt")>nul 2>nul
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����\">nul 2>nul
xcopy /s /y /f "%~dp0��Ŀ�ļ�\%xmm%_txt_json����" "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����\">nul 2>nul
(for /r "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����" %%a in (*) do (echo %%a)) > "%~dp0��Ŀ�ļ�\%xmm%_alllist.txt"
"%~dp0tool\ssed.exe" -r "/.*txt$/d; /^$/d" "%~dp0��Ŀ�ļ�\%xmm%_alllist.txt" > "%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt"
for /f "usebackq delims=" %%a in ("%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt") do (del "%%a">nul 2>nul)
(for /r "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����" %%a in (*.txt) do (echo %%a)) > "%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt"
CD .>"%~dp0��Ŀ�ļ�\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt") do (
	copy /b "%~dp0��Ŀ�ļ�\tmp1.txt" + "%%h" "%~dp0��Ŀ�ļ�\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp2.txt"
	move /y "%~dp0��Ŀ�ļ�\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
	echo ������ȡ"%%k"���ı�����...
("%~dp0tool\ssed.exe" -r -n "/%%k\x20\x3d\x20\x22/p" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/%%k\x20\x3d\x20\x22\x22$/d; /\x22\xe2\x80\x8b\x22$/d" "%~dp0��Ŀ�ļ�\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
	
("%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)\x22.*/\1/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt�ı�����.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt�ı�����.txt" > "%~dp0%xmm%_%%k_txt�ı�.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*%%k\x20\x3d\x20\x22)(.*)(\x22.*)/\1\2\3\|\1\3/; /\x20\x3d\x20\x22\x22\|%%k\x20\x3d\x20\x22/d; /\x20\x3d\x20\x22\xe2\x80\x8b\x22\|%%k\x20\x3d\x20\x22/d" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt")>nul 2>nul)
GOTO JSON
:JSON
xcopy /s /y /f "%~dp0��Ŀ�ļ�\%xmm%_txt_json����" "%~dp0��Ŀ�ļ�\%xmm%_jsonԤ����\">nul 2>nul
(for /r "%~dp0��Ŀ�ļ�\%xmm%_jsonԤ����" %%a in (*) do (echo %%a)) > "%~dp0��Ŀ�ļ�\%xmm%_alllist.txt"
"%~dp0tool\ssed.exe" -r "/.*json$/d; /^$/d" "%~dp0��Ŀ�ļ�\%xmm%_alllist.txt" > "%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt"
for /f "usebackq delims=" %%a in ("%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt") do (del "%%a">nul 2>nul)
(for /r "%~dp0��Ŀ�ļ�\%xmm%_jsonԤ����" %%a in (*.json) do (echo %%a)) > "%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt"
CD .>"%~dp0��Ŀ�ļ�\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt") do (
	copy /b "%~dp0��Ŀ�ļ�\tmp1.txt" + "%%h" "%~dp0��Ŀ�ļ�\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp2.txt"
	move /y "%~dp0��Ŀ�ļ�\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp00.txt") do (
	echo ������ȡ"%%k"���ı�����...
("%~dp0tool\ssed.exe" -r -n "/\x22%%k\x22\x3a\x20\x22/p" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x22%%k\x22\x3a\x20\x22\x22$/d; /\x22%%k\x22\x3a\x20\x22\x22\x2c$/d; /\x22\xe2\x80\x8b\x22$/d; /\x22\xe2\x80\x8b\x22\x2c$/d" "%~dp0��Ŀ�ļ�\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x22%%k\x22\x3a\x20\x22(.*)\x22.*/\1/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_json�ı�����.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json�ı�����.txt" > "%~dp0%xmm%_%%k_json�ı�.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x22%%k\x22\x3a\x20\x22)(.*)(\x22.*)/\1\2\3\x7c\1\3/; /\x22%%k\x22\x3a\x20\x22\x22\x2c\x7c\x22/d; /\x22%%k\x22\x3a\x20\x22\x22\x7c\x22/d" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt")>nul 2>nul)
GOTO WC
:WC
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
