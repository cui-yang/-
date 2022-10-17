@echo off
title Ren'Py文本提取
md "%~dp0rpy\">nul 2>nul
md "%~dp0项目文件\">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo 前言：
echo 　　文件名不能含有[]之类的特殊符号！！！
echo 　　另外，提取后生成的文件名不要修改！！！
echo 　　提取后生成的文本文件在当前目录！！！
echo ------------------------------------------------------------
echo 请为项目命名！！！
set /p "xmm="
:JC1
if exist "%~dp0%xmm%_rpy提取文本.txt" (
echo ------------------------------------------------------------
echo 该项目已存在，请为项目换个名称！！！
echo 若直接按回车键，将会覆盖旧项目！！！
echo ------------------------------------------------------------
set /p "sr=") else (goto JC2)
if /i "%sr%"=="" (goto JC2) else (
set "xmm=%sr%"
goto JC1)
:JC2
(dir /a /b "%~dp0rpy\*" | findstr /R "." >nul && (goto JC3) || (goto JC4))>nul 2>nul
:JC3
rd /s /Q "%~dp0项目文件\%xmm%_rpy备份\">nul 2>nul
move /y "%~dp0rpy" "%~dp0项目文件\%xmm%_rpy备份">nul 2>nul
md "%~dp0rpy\">nul 2>nul 
goto TQ
:JC4
(dir /a /b "%~dp0项目文件\%xmm%_rpy备份\*" | findstr /R "." >nul && (goto JC5) || (goto TC))>nul 2>nul
:JC5
echo ------------------------------------------------------------
echo ？？？rpy文件夹中没有文件？？？
echo 但项目文件中存在%xmm%_rpy的备份数据，
echo 是否使用该备份数据再次进行文本提取？
echo 直接按回车键确认提取备份数据文本！！！
set /p "sr="
if /i "%sr%"=="" (goto TQ) else (exit)
:TQ
rd /s /Q "%~dp0项目文件\%xmm%_rpyB计划\">nul 2>nul
echo ------------------------------------------------------------
echo 正在提取，请耐心等待！！！
DIR "%~dp0项目文件\%xmm%_rpy备份\*" /s/b/a-d > "%~dp0项目文件\%xmm%_rpylist.txt"
CD .>"%~dp0项目文件\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_rpylist.txt") do (
	
	copy /b "%~dp0项目文件\tmp1.txt" + "%%h" "%~dp0项目文件\tmp1.txt">nul 2>nul)
"%~dp0tool\ssed.exe" -r -n "/.*old\x20\x22.*/p; /#.*\x22.*/p" "%~dp0项目文件\tmp1.txt" | "%~dp0tool\gawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)(\x22)(.*)/\1/g" "%~dp0项目文件\tmp2.txt" > "%~dp0%xmm%_rpy提取文本.txt"
"%~dp0tool\ssed.exe" -nr "H;${g;s/\n//gp}" "%~dp0%xmm%_rpy提取文本.txt" | "%~dp0tool\gawk.exe" "{ if ($0!~/\|/) print "0"; if ($0!~/\@/) print "2"; if ($0!~/`/) print "1"; if ($0!~/\^/) print "6"; if ($0!~/\&/) print "7"; if ($0!~/\$/) print "4"; else print "9"}" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\gawk.exe" "!x[$0]++" "%~dp0项目文件\tmp1.txt" | "%~dp0tool\ssed.exe" -nr "s/0/\^\|/; s/2/\\\@/; s/1/\\`/; s/6/\^\^/; s/7/\^\&/; s/4/\\\$/;1p;1q" > "%~dp0项目文件\tmp3.txt"
set /p fgf=<"%~dp0项目文件\tmp3.txt"
if /i "%fgf%"=="9" (goto XC) else (
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$/\x22/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"%fgf%\" $0}" "%~dp0项目文件\tmp2.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\%xmm%_rpy搜索源.txt")
del "%~dp0项目文件\tmp*.txt">nul 2>nul
del "%~dp0项目文件\%xmm%_rpylist.txt">nul 2>nul
Start "" "%~dp0%xmm%_rpy提取文本.txt"
echo ------------------------------------------------------------
echo 提取完成！！！按任意键退出！
echo ------------------------------------------------------------
pause>nul
exit
:CC
echo ------------------------------------------------------------
echo 抱歉，出了点问题，
echo 请检查代码后重试！
echo 按任意键退出！
pause>nul
exit
:XC
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo 可恶，没有合适的符号作为分隔符，
echo 看来只能采用B计划了。。。
echo 干了兄弟们！奥利给！！！
xcopy /s /y /f "%~dp0项目文件\%xmm%_rpy备份" "%~dp0项目文件\%xmm%_rpyB计划\">nul 2>nul
DIR "%~dp0项目文件\%xmm%_rpyB计划\*" /s/b/a-d > "%~dp0项目文件\%xmm%_rpylist.txt"
CD .>"%~dp0项目文件\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_rpylist.txt") do (
	copy /b "%~dp0项目文件\tmp1.txt" + "%%h" "%~dp0项目文件\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0项目文件\tmp2.txt"
	move /y "%~dp0项目文件\tmp2.txt" "%%h")>nul 2>nul
"%~dp0tool\ssed.exe" -r -n "/.*old\x20\x22.*/p; /#.*\x22.*/p" "%~dp0项目文件\tmp1.txt" | "%~dp0tool\gawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)(\x22)(.*)/\1/g" "%~dp0项目文件\tmp2.txt" > "%~dp0%xmm%_rpy提取文本.txt"
"%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$/\x22/; s/\x7c/@#@~@~@#@/g" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp3.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"^|\" $0}" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\%xmm%_rpy搜索源.txt"
del "%~dp0项目文件\tmp*.txt">nul 2>nul
del "%~dp0项目文件\%xmm%_rpylist.txt">nul 2>nul
echo ------------------------------------------------------------
echo 提取完成！！！按任意键退出！
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_rpy提取文本.txt"
exit
:TC
echo ------------------------------------------------------------
echo 没有找到rpy文件！按任意键退出！
pause>nul
exit
