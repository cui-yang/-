@echo off
title Ren'Py�ı���ȡ
md "%~dp0rpy\">nul 2>nul
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
if exist "%~dp0%xmm%_rpy��ȡ�ı�.txt" (
echo ------------------------------------------------------------
echo ����Ŀ�Ѵ��ڣ���Ϊ��Ŀ�������ƣ�����
echo ��ֱ�Ӱ��س��������Ḳ�Ǿ���Ŀ������
echo ------------------------------------------------------------
set /p "sr=") else (goto JC2)
if /i "%sr%"=="" (goto JC2) else (
set "xmm=%sr%"
goto JC1)
:JC2
(dir /a /b "%~dp0rpy\*" | findstr /R "." >nul && (goto JC3) || (goto JC4))>nul 2>nul
:JC3
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_rpy����\">nul 2>nul
move /y "%~dp0rpy" "%~dp0��Ŀ�ļ�\%xmm%_rpy����">nul 2>nul
md "%~dp0rpy\">nul 2>nul 
goto TQ
:JC4
(dir /a /b "%~dp0��Ŀ�ļ�\%xmm%_rpy����\*" | findstr /R "." >nul && (goto JC5) || (goto TC))>nul 2>nul
:JC5
echo ------------------------------------------------------------
echo ������rpy�ļ�����û���ļ�������
echo ����Ŀ�ļ��д���%xmm%_rpy�ı������ݣ�
echo �Ƿ�ʹ�øñ��������ٴν����ı���ȡ��
echo ֱ�Ӱ��س���ȷ����ȡ���������ı�������
set /p "sr="
if /i "%sr%"=="" (goto TQ) else (exit)
:TQ
rd /s /Q "%~dp0��Ŀ�ļ�\%xmm%_rpyB�ƻ�\">nul 2>nul
echo ------------------------------------------------------------
echo ������ȡ�������ĵȴ�������
DIR "%~dp0��Ŀ�ļ�\%xmm%_rpy����\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt"
CD .>"%~dp0��Ŀ�ļ�\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt") do (
	
	copy /b "%~dp0��Ŀ�ļ�\tmp1.txt" + "%%h" "%~dp0��Ŀ�ļ�\tmp1.txt">nul 2>nul)
"%~dp0tool\ssed.exe" -r -n "/.*old\x20\x22.*/p; /#.*\x22.*/p" "%~dp0��Ŀ�ļ�\tmp1.txt" | "%~dp0tool\gawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)(\x22)(.*)/\1/g" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0%xmm%_rpy��ȡ�ı�.txt"
"%~dp0tool\ssed.exe" -nr "H;${g;s/\n//gp}" "%~dp0%xmm%_rpy��ȡ�ı�.txt" | "%~dp0tool\gawk.exe" "{ if ($0!~/\|/) print "0"; if ($0!~/\@/) print "2"; if ($0!~/`/) print "1"; if ($0!~/\^/) print "6"; if ($0!~/\&/) print "7"; if ($0!~/\$/) print "4"; else print "9"}" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\gawk.exe" "!x[$0]++" "%~dp0��Ŀ�ļ�\tmp1.txt" | "%~dp0tool\ssed.exe" -nr "s/0/\^\|/; s/2/\\\@/; s/1/\\`/; s/6/\^\^/; s/7/\^\&/; s/4/\\\$/;1p;1q" > "%~dp0��Ŀ�ļ�\tmp3.txt"
set /p fgf=<"%~dp0��Ŀ�ļ�\tmp3.txt"
if /i "%fgf%"=="9" (goto XC) else (
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$/\x22/" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"%fgf%\" $0}" "%~dp0��Ŀ�ļ�\tmp2.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt")
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt">nul 2>nul
Start "" "%~dp0%xmm%_rpy��ȡ�ı�.txt"
echo ------------------------------------------------------------
echo ��ȡ��ɣ�������������˳���
echo ------------------------------------------------------------
pause>nul
exit
:CC
echo ------------------------------------------------------------
echo ��Ǹ�����˵����⣬
echo �����������ԣ�
echo ��������˳���
pause>nul
exit
:XC
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo �ɶ�û�к��ʵķ�����Ϊ�ָ�����
echo ����ֻ�ܲ���B�ƻ��ˡ�����
echo �����ֵ��ǣ�������������
xcopy /s /y /f "%~dp0��Ŀ�ļ�\%xmm%_rpy����" "%~dp0��Ŀ�ļ�\%xmm%_rpyB�ƻ�\">nul 2>nul
DIR "%~dp0��Ŀ�ļ�\%xmm%_rpyB�ƻ�\*" /s/b/a-d > "%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt"
CD .>"%~dp0��Ŀ�ļ�\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt") do (
	copy /b "%~dp0��Ŀ�ļ�\tmp1.txt" + "%%h" "%~dp0��Ŀ�ļ�\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0��Ŀ�ļ�\tmp2.txt"
	move /y "%~dp0��Ŀ�ļ�\tmp2.txt" "%%h")>nul 2>nul
"%~dp0tool\ssed.exe" -r -n "/.*old\x20\x22.*/p; /#.*\x22.*/p" "%~dp0��Ŀ�ļ�\tmp1.txt" | "%~dp0tool\gawk.exe" "!x[$0]++" > "%~dp0��Ŀ�ļ�\tmp2.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)(\x22)(.*)/\1/g" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0%xmm%_rpy��ȡ�ı�.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$/\x22/; s/\x7c/@#@~@~@#@/g" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp3.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"^|\" $0}" "%~dp0��Ŀ�ļ�\tmp3.txt" "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dp0��Ŀ�ļ�\%xmm%_rpy����Դ.txt"
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
del "%~dp0��Ŀ�ļ�\%xmm%_rpylist.txt">nul 2>nul
echo ------------------------------------------------------------
echo ��ȡ��ɣ�������������˳���
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_rpy��ȡ�ı�.txt"
exit
:TC
echo ------------------------------------------------------------
echo û���ҵ�rpy�ļ�����������˳���
pause>nul
exit
