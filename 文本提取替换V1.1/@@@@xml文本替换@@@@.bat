@echo off
title Xml�ı��滻
mode con cols=60 lines=20 & color 1F
md "%~dp0��Ŀ�ļ�\">nul 2>nul
echo ------------------------------------------------------------
echo ��������Ҫ�滻�ı�����Ŀ��������
:XMMM
set /p "xmm="
:YLJC
if exist "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" (goto JCXML1) else (goto JCCL)
:JCXML1
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0��Ŀ�ļ�\%xmm%_xml����.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp0.txt")>nul 2>nul
if exist "%~dp0%xmm%_*xml�ı�.txt" (goto JCXML2) else (goto JCJSON1)
:JCXML2
if exist "%~dp0��Ŀ�ļ�\%xmm%_*xml�ı�����.txt" (goto JCXML3) else (goto JCXML5)
:JCXML3
if exist "%~dp0��Ŀ�ļ�\%xmm%_*xml����Դ.txt" (goto JCXML4) else (goto JCXML5)
:JCXML4
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_xmlԤ����" | findstr /R "." >nul && (goto KSTHXML) || (goto JCXML5))>nul 2>nul
:JCXML5
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_xml����" | findstr /R "." >nul && (goto XMLCJ) || (goto JCCL))>nul 2>nul
:JCCL
echo ����Ŀ�ļ�ȱʧ�������ƴ���������������Ŀ���ƣ�����
goto XMMM
:XMLCJ
echo ------------------------------------------------------------
echo ��Ҫ�ļ�ȱʧ������
echo ���ڳ����ؽ���Ҫ�ļ��������ĵȴ�������
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
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x3c%%k\x3e)(.*)(\x3c\x2f%%k\x3e.*)/\1\2\3\|\1\3/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt")>nul 2>nul)
GOTO KSTHXML
:KSTHXML
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_xml��ʱ\">nul 2>nul
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_xmlԤ����" "%~dp0��Ŀ�ļ�\%xmm%_xml��ʱ\">nul 2>nul
(DIR "%~dp0��Ŀ�ļ�\%xmm%_xml��ʱ\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_xmllist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0��Ŀ�ļ�\tmp0.txt") do (
echo ------------------------------------------------------------
echo ���������滻%%k�������ĵȴ�������
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_xml�ı�.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml�ı�����.txt" > "%~dp0��Ŀ�ļ�\tmp4.txt"
"%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\tmp4.txt" > "%~dp0��Ŀ�ļ�\tmp2.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0��Ŀ�ļ�\tmp2.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt"
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$2\"\"a[$1]}1" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp4.txt" > "%~dp0��Ŀ�ļ�\tmp7.txt"
"%~dp0tool\ssed.exe" -r "s/(.*\x3c%%k\x3e.*\x3c\x2f%%k\x3e.*\x7c.*\x3c%%k\x3e)(\x3c\x2f%%k\x3e.*)/\1/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp5.txt"
"%~dp0tool\ssed.exe" -r "s/(.*\x3c%%k\x3e.*\x3c\x2f%%k\x3e.*\x7c.*\x3c%%k\x3e)(\x3c\x2f%%k\x3e.*)/\2/" "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp6.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp5.txt" "%~dp0��Ŀ�ļ�\tmp7.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp6.txt" > "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_xmllist.txt") do (
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$2\"\"a[$1]}1" "%~dp0��Ŀ�ļ�\%xmm%_%%k_xml����Դ.txt" "%%h" > "%~dp0��Ŀ�ļ�\tmp8.txt"
move /y "%~dp0��Ŀ�ļ�\tmp8.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_xmllist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt"
move /y "%~dp0��Ŀ�ļ�\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_xml��ʱ" "%~dp0%xmm%_xml�ɹ�\">nul 2>nul
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_xml��ʱ\">nul 2>nul
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
Start "" "%~dp0%xmm%_xml�ɹ�\"
exit
