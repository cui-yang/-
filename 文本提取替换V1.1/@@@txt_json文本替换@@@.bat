@echo off
title Unity3D�ı��滻
mode con cols=60 lines=20 & color 1F
md "%~dp0��Ŀ�ļ�\">nul 2>nul
echo ------------------------------------------------------------
echo ��������Ҫ�滻�ı�����Ŀ��������
:XMMM
set /p "xmm="
:YLJC
if exist "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" (goto JCTXT1) else (goto JCCL)
:JCTXT1
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/; /.*\x22.*\x22\x3a\x20\x22.*/d" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/.*\x22(.*)\x22\x3a\x20\x22.*/\1/; /.*\x20\x3d\x20\x22.*/d" "%~dp0��Ŀ�ļ�\%xmm%_txt_json_����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp00.txt")
if exist "%~dp0%xmm%_*txt�ı�.txt" (goto JCTXT2) else (goto JCJSON1)
:JCTXT2
if exist "%~dp0��Ŀ�ļ�\%xmm%_*txt�ı�����.txt" (goto JCTXT3) else (goto JCTXT5)
:JCTXT3
if exist "%~dp0��Ŀ�ļ�\%xmm%_*txt����Դ.txt" (goto JCTXT4) else (goto JCTXT5)
:JCTXT4
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����" | findstr /R "." >nul && (goto KSTHTXT) || (goto JCTXT5))>nul 2>nul
:JCTXT5
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_txt_json����" | findstr /R "." >nul && (goto TXTCJ) || (goto JCJSON1))>nul 2>nul
:JCJSON1
if exist "%~dp0%xmm%_*json�ı�.txt" (goto JCJSON2) else (goto JCCL)
:JCJSON2
if exist "%~dp0��Ŀ�ļ�\%xmm%_*json�ı�����.txt" (goto JCJSON3) else (goto JCJSON4)
:JCJSON3
if exist "%~dp0��Ŀ�ļ�\%xmm%_*json����Դ.txt" (goto JCJSON8) else (goto JCJSON4)
:JCJSON4
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_txt_json����" | findstr /R "." >nul && (goto JSONCJ) || (goto JCCL))>nul 2>nul
:JCCL
echo ����Ŀ�ļ�ȱʧ�������ƴ���������������Ŀ���ƣ�����
goto XMMM
:TXTCJ
echo ------------------------------------------------------------
echo ��Ҫ�ļ�ȱʧ������
echo ���ڳ����ؽ���Ҫ�ļ��������ĵȴ�������
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
("%~dp0tool\ssed.exe" -r -n "/%%k\x20\x3d\x20\x22/p" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/%%k\x20\x3d\x20\x22\x22$/d; /\x22\xe2\x80\x8b\x22$/d" "%~dp0��Ŀ�ļ�\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)\x22.*/\1/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt�ı�����.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*%%k\x20\x3d\x20\x22)(.*)(\x22.*)/\1\2\3\|\1\3/; /\x20\x3d\x20\x22\x22\|%%k\x20\x3d\x20\x22/d; /\x20\x3d\x20\x22\xe2\x80\x8b\x22\|%%k\x20\x3d\x20\x22/d" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt")>nul 2>nul)
GOTO KSTHTXT
:KSTHTXT
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_txt��ʱ\">nul 2>nul
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_txtԤ����" "%~dp0��Ŀ�ļ�\%xmm%_txt��ʱ\">nul 2>nul
(DIR "%~dp0��Ŀ�ļ�\%xmm%_txt��ʱ\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
echo ------------------------------------------------------------
echo ���������滻%%k�������ĵȴ�������
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_txt�ı�.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt�ı�����.txt" | "%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt�ı�����.txt" > "%~dp0��Ŀ�ļ�\tmp4.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0��Ŀ�ļ�\tmp2.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp4.txt" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*%%k\x20\x3d\x20\x22.*\x22.*\|.*%%k\x20\x3d\x20\x22)(\x22.*)/\1/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp5.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*%%k\x20\x3d\x20\x22.*\x22.*\|.*%%k\x20\x3d\x20\x22)(\x22.*)/\2/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp6.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp5.txt" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp6.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt")>nul 2>nul
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt") do (
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0��Ŀ�ļ�\%xmm%_%%k_txt����Դ.txt" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt")>nul 2>nul
move /y "%~dp0��Ŀ�ļ�\tmp1.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_txtlist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt"
move /y "%~dp0��Ŀ�ļ�\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_txt��ʱ" "%~dp0%xmm%_txt_json�ɹ�\">nul 2>nul
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_txt��ʱ\">nul 2>nul
goto JCJSON5
:JCJSON5
if exist "%~dp0%xmm%_*json�ı�.txt" (goto JCJSON6) else (goto WC)
:JCJSON6
if exist "%~dp0��Ŀ�ļ�\%xmm%_*json�ı�����.txt" (goto JCJSON7) else (goto JCJSON9)
:JCJSON7
if exist "%~dp0��Ŀ�ļ�\%xmm%_*json����Դ.txt" (goto JCJSON8) else (goto JCJSON9)
:JCJSON8
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_jsonԤ����" | findstr /R "." >nul && (goto KSJSON) || (goto JSONCJ))>nul 2>nul
:JCJSON9
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_txt_json����" | findstr /R "." >nul && (goto JSONCJ) || (goto WC))>nul 2>nul
:JSONCJ
echo ------------------------------------------------------------
echo ��Ҫ�ļ�ȱʧ������
echo ���ڳ����ؽ���Ҫ�ļ��������ĵȴ�������
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
("%~dp0tool\ssed.exe" -r -n "/\x22%%k\x22\x3a\x20\x22/p" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x22%%k\x22\x3a\x20\x22\x22$/d; /\x22%%k\x22\x3a\x20\x22\x22\x2c$/d; /\x22\xe2\x80\x8b\x22$/d; /\x22\xe2\x80\x8b\x22\x2c$/d" "%~dp0��Ŀ�ļ�\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x22%%k\x22\x3a\x20\x22(.*)\x22.*/\1/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_json�ı�����.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x22%%k\x22\x3a\x20\x22)(.*)(\x22.*)/\1\2\3\x7c\1\3/; /\x22%%k\x22\x3a\x20\x22\x22\x2c\x7c\x22/d; /\x22%%k\x22\x3a\x20\x22\x22\x7c\x22/d" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt")>nul 2>nul)
GOTO KSJSON
:KSJSON
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_json��ʱ\">nul 2>nul
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_jsonԤ����" "%~dp0��Ŀ�ļ�\%xmm%_json��ʱ\">nul 2>nul
(DIR "%~dp0��Ŀ�ļ�\%xmm%_json��ʱ\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp00.txt") do (
echo ------------------------------------------------------------
echo ���������滻%%k�������ĵȴ�������
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_json�ı�.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json�ı�����.txt" | "%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json�ı�����.txt" > "%~dp0��Ŀ�ļ�\tmp4.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0��Ŀ�ļ�\tmp2.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp4.txt" > "%~dp0��Ŀ�ļ�\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*\x22%%k\x22\x3a\x20\x22.*)(\x22.*)/\1/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp5.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*\x22%%k\x22\x3a\x20\x22.*)(\x22.*)/\2/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp6.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp5.txt" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp6.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt")>nul 2>nul
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt") do (
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2 a[$1] }1" "%~dp0��Ŀ�ļ�\%xmm%_%%k_json����Դ.txt" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt"
move /y "%~dp0��Ŀ�ļ�\tmp1.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_jsonlist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt"
move /y "%~dp0��Ŀ�ļ�\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_json��ʱ" "%~dp0%xmm%_txt_json�ɹ�\">nul 2>nul
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_json��ʱ\">nul 2>nul
goto WC
:WC
del "%~dp0��Ŀ�ļ�\tmp*.txt"
del "%~dp0��Ŀ�ļ�\%xmm%_*list.txt"
del "%~dp0��Ŀ�ļ�\%xmm%_*����Դ.txt"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0��Ŀ�ļ�"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo �滻��ɣ���������˳���
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_txt_json�ɹ�\"
exit
