@echo off
title Ren'Py�ı��滻
mode con cols=60 lines=20 & color 1F
md "%~dp0��Ŀ�ļ�\">nul 2>nul
echo ------------------------------------------------------------
echo ��������Ҫ�滻�ı�����Ŀ��������
:JC1
set /p "xmm="
if exist "%~dp0%xmm%_rpy��ȡ�ı�.txt" (goto JC2) else (goto JC4)
:JC2
if exist "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt" (goto JC3) else (goto JC4)
:JC3
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_rpyB�ƻ�" | findstr /R "." >nul && (goto FZ1) || (goto JC5))>nul 2>nul
:FZ1
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_rpyB�ƻ�" "%~dp0%xmm%_rpy�ɹ�\">nul 2>nul
goto HB1
:FZ2
xcopy /y /s /E "%~dp0��Ŀ�ļ�\%xmm%_rpy����" "%~dp0%xmm%_rpy�ɹ�\">nul 2>nul
goto HB2
:JC4
echo ����Ŀ�ļ�ȱʧ�������ƴ���������������Ŀ���ƣ�����
goto JC1
:JC5
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_rpy����" | findstr /R "." >nul && (goto FZ2) || (goto JC4))>nul 2>nul
:HB1
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_rpy��ȡ�ı�.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0\"\x22\"}" "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\%xmm%_rpy�滻Դ.txt"
goto TH
:HB2
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0\"\x22\"}" "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt" "%~dp0%xmm%_rpy��ȡ�ı�.txt" > "%~dp0��Ŀ�ļ�\%xmm%_rpy�滻Դ.txt"
goto TH
:TH
"%~dp0tool\ssed.exe" -r -n "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$//;1p;1q" "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
set /p qz=<"%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\ssed.exe" -r -n "s/^.*\x22(.)%qz%\x22.*/\1/;1p;1q" "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
set /p fgf=<"%~dp0��Ŀ�ļ�\tmp1.txt"
DIR "%~dp0%xmm%_rpy�ɹ�\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt"
echo ------------------------------------------------------------
echo ���������滻�У������ĵȴ�������
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt") do (
	
	"%~dp0tool\ssed.exe" -r ":a;$!N;s/(.*)(#)(.*\x22.*)\n(.*)/\1\2\3/g; s/^(\x20\x20\x20\x20old\x20\x22)(.*)\n(.*)/\1\2/g;P;D" "%%h" > "%~dp0��Ŀ�ļ�\tmp1.txt"
	
	"%~dp0tool\gawk.exe" -F "%fgf%" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$0\"\x0a\"a[$1]}1" "%~dp0��Ŀ�ļ�\%xmm%_rpy�滻Դ.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" | "%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" > "%%h")
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\%xmm%_*list.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\%xmm%_*�滻Դ.txt">nul 2>nul
echo ------------------------------------------------------------
echo �滻��ɣ���������˳���
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_rpy�ɹ�\"
exit
