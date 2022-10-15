@echo off
title Ren'Py文本替换
mode con cols=60 lines=20 & color 1F
md "%~dp0项目文件\">nul 2>nul
echo ------------------------------------------------------------
echo 请输入需要替换文本的项目名！！！
:JC1
set /p "xmm="
if exist "%~dp0%xmm%_rpy提取文本.txt" (goto JC2) else (goto JC4)
:JC2
if exist "%~dp0项目文件\%xmm%_rpy搜索源.txt" (goto JC3) else (goto JC4)
:JC3
(dir /a /b "%~dp0项目文件\%xmm%_rpyB计划" | findstr /R "." >nul && (goto FZ1) || (goto JC5))>nul 2>nul
:FZ1
xcopy /y /s /E "%~dp0项目文件\%xmm%_rpyB计划" "%~dp0%xmm%_rpy成果\">nul 2>nul
goto HB1
:FZ2
xcopy /y /s /E "%~dp0项目文件\%xmm%_rpy备份" "%~dp0%xmm%_rpy成果\">nul 2>nul
goto HB2
:JC4
echo 该项目文件缺失，或名称错误，请重新输入项目名称！！！
goto JC1
:JC5
(dir /a /b "%~dp0项目文件\%xmm%_rpy备份" | findstr /R "." >nul && (goto FZ2) || (goto JC4))>nul 2>nul
:HB1
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_rpy提取文本.txt" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0\"\x22\"}" "%~dp0项目文件\%xmm%_rpy搜索源.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\%xmm%_rpy替换源.txt"
goto TH
:HB2
"%~dp0tool\gawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0\"\x22\"}" "%~dp0项目文件\%xmm%_rpy搜索源.txt" "%~dp0%xmm%_rpy提取文本.txt" > "%~dp0项目文件\%xmm%_rpy替换源.txt"
goto TH
:TH
"%~dp0tool\ssed.exe" -r -n "s/\x22/\x40\x40\x40/; s/#\x20//; s/old/new/g; s/\x40\x40\x40.*$//;1p;1q" "%~dp0项目文件\%xmm%_rpy搜索源.txt" > "%~dp0项目文件\tmp1.txt"
set /p qz=<"%~dp0项目文件\tmp1.txt"
"%~dp0tool\ssed.exe" -r -n "s/^.*\x22(.)%qz%\x22.*/\1/;1p;1q" "%~dp0项目文件\%xmm%_rpy搜索源.txt" > "%~dp0项目文件\tmp1.txt"
set /p fgf=<"%~dp0项目文件\tmp1.txt"
DIR "%~dp0%xmm%_rpy成果\*" /s/b/a-d > "%~dp0项目文件\%xmm%_rpylist.txt"
echo ------------------------------------------------------------
echo 正在批量替换中，请耐心等待！！！
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_rpylist.txt") do (
	
	"%~dp0tool\ssed.exe" -r ":a;$!N;s/(.*)(#)(.*\x22.*)\n(.*)/\1\2\3/g; s/^(\x20\x20\x20\x20old\x20\x22)(.*)\n(.*)/\1\2/g;P;D" "%%h" > "%~dp0项目文件\tmp1.txt"
	
	"%~dp0tool\gawk.exe" -F "%fgf%" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$0\"\x0a\"a[$1]}1" "%~dp0项目文件\%xmm%_rpy替换源.txt" "%~dp0项目文件\tmp1.txt" | "%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" > "%%h")
del "%~dp0项目文件\tmp*.txt">nul 2>nul
del "%~dp0项目文件\%xmm%_*list.txt">nul 2>nul
del "%~dp0项目文件\%xmm%_*替换源.txt">nul 2>nul
echo ------------------------------------------------------------
echo 替换完成！按任意键退出！
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_rpy成果\"
exit
