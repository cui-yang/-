@echo off
title Xml文本替换
mode con cols=60 lines=20 & color 1F
md "%~dp0项目文件\">nul 2>nul
echo ------------------------------------------------------------
echo 请输入需要替换文本的项目名！！！
:XMMM
set /p "xmm="
:YLJC
if exist "%~dp0项目文件\%xmm%_xml样例.txt" (goto JCXML1) else (goto JCCL)
:JCXML1
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0项目文件\%xmm%_xml样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
if exist "%~dp0%xmm%_*xml文本.txt" (goto JCXML2) else (goto JCJSON1)
:JCXML2
if exist "%~dp0项目文件\%xmm%_*xml文本备份.txt" (goto JCXML3) else (goto JCXML5)
:JCXML3
if exist "%~dp0项目文件\%xmm%_*xml搜索源.txt" (goto JCXML4) else (goto JCXML5)
:JCXML4
(dir /a /b "%~dp0项目文件\%xmm%_xml预处理" | findstr /R "." >nul && (goto KSTHXML) || (goto JCXML5))>nul 2>nul
:JCXML5
(dir /a /b "%~dp0项目文件\%xmm%_xml备份" | findstr /R "." >nul && (goto XMLCJ) || (goto JCCL))>nul 2>nul
:JCCL
echo 该项目文件缺失，或名称错误，请重新输入项目名称！！！
goto XMMM
:XMLCJ
echo ------------------------------------------------------------
echo 必要文件缺失！！！
echo 正在尝试重建必要文件，请耐心等待！！！
xcopy /s /y /f "%~dp0项目文件\%xmm%_xml备份" "%~dp0项目文件\%xmm%_xml预处理\">nul 2>nul
DIR "%~dp0项目文件\%xmm%_xml预处理\*" /s/b/a-d > "%~dp0项目文件\%xmm%_xmllist.txt"
CD .>"%~dp0项目文件\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_xmllist.txt") do (
	copy /b "%~dp0项目文件\tmp1.txt" + "%%h" "%~dp0项目文件\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0项目文件\tmp2.txt"
	move /y "%~dp0项目文件\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
	echo 正在提取"%%k"的文本内容...
("%~dp0tool\ssed.exe" -r -n "/\x3c%%k\x3e.*\x3c\x2f%%k\x3e/p" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x3c%%k\x3e\x3c\x2f%%k\x3e/d; /\x3c%%k\x3e\xe2\x80\x8b\x3c\x2f%%k\x3e/d" "%~dp0项目文件\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x3c%%k\x3e(.*)\x3c\x2f%%k\x3e.*/\1/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_xml文本备份.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x3c%%k\x3e)(.*)(\x3c\x2f%%k\x3e.*)/\1\2\3\|\1\3/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_xml搜索源.txt")>nul 2>nul)
GOTO KSTHXML
:KSTHXML
rd /s /Q "%~dp0项目文件\%xmm%_xml临时\">nul 2>nul
xcopy /y /s /E "%~dp0项目文件\%xmm%_xml预处理" "%~dp0项目文件\%xmm%_xml临时\">nul 2>nul
(DIR "%~dp0项目文件\%xmm%_xml临时\*" /s/b/a-d > "%~dp0项目文件\%xmm%_xmllist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
echo ------------------------------------------------------------
echo 正在批量替换%%k，请耐心等待！！！
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_xml文本.txt" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%~dp0项目文件\%xmm%_%%k_xml文本备份.txt" > "%~dp0项目文件\tmp4.txt"
"%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\tmp4.txt" > "%~dp0项目文件\tmp2.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0项目文件\tmp2.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt"
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$2\"\"a[$1]}1" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp4.txt" > "%~dp0项目文件\tmp7.txt"
"%~dp0tool\ssed.exe" -r "s/(.*\x3c%%k\x3e.*\x3c\x2f%%k\x3e.*\x7c.*\x3c%%k\x3e)(\x3c\x2f%%k\x3e.*)/\1/" "%~dp0项目文件\%xmm%_%%k_xml搜索源.txt" > "%~dp0项目文件\tmp5.txt"
"%~dp0tool\ssed.exe" -r "s/(.*\x3c%%k\x3e.*\x3c\x2f%%k\x3e.*\x7c.*\x3c%%k\x3e)(\x3c\x2f%%k\x3e.*)/\2/" "%~dp0项目文件\%xmm%_%%k_xml搜索源.txt" > "%~dp0项目文件\tmp6.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp5.txt" "%~dp0项目文件\tmp7.txt" > "%~dp0项目文件\tmp3.txt"
"%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp6.txt" > "%~dp0项目文件\%xmm%_%%k_xml搜替源.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_xmllist.txt") do (
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{a[$1]=$2\"\";next}$1 in a{$0=$2\"\"a[$1]}1" "%~dp0项目文件\%xmm%_%%k_xml搜替源.txt" "%%h" > "%~dp0项目文件\tmp8.txt"
move /y "%~dp0项目文件\tmp8.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_xmllist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0项目文件\tmp1.txt"
move /y "%~dp0项目文件\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0项目文件\%xmm%_xml临时" "%~dp0%xmm%_xml成果\">nul 2>nul
rd /s /Q "%~dp0项目文件\%xmm%_xml临时\">nul 2>nul
del "%~dp0项目文件\tmp*.txt"
del "%~dp0项目文件\%xmm%_*list.txt"
del "%~dp0项目文件\%xmm%_*搜替源.txt"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0项目文件"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo 替换完成！按任意键退出！
echo ------------------------------------------------------------
pause>nul
Start "" "%~dp0%xmm%_xml成果\"
exit
