@echo off
title Xml文本提取
md "%~dp0xml\">nul 2>nul
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
(dir /a /b "%~dp0xml\*" | findstr /R "." >nul && (goto JC2) || (goto JC9))>nul 2>nul
:JC2
if exist "%~dp0项目文件\%xmm%_xml样例.txt" (goto JC7) else (goto JC6)
:JC3
(dir /a /b "%~dp0项目文件\%xmm%_xml备份\*" | findstr /R "." >nul && (goto JC5) || (goto TC))>nul 2>nul
:JC4
echo ------------------------------------------------------------
echo 该项目已存在，请为项目换个名称！！！
echo 若直接按回车键，将会覆盖旧项目！！！
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ) else (
set "xmm=%sr%"
goto JC1)
:JC5
echo ------------------------------------------------------------
echo xml文件夹中没有文件？？？
echo 但项目文件中存在%xmm%_xml的项目数据，
echo 是否使用该项目备份再次进行文本提取？
echo 直接按回车键提取备份数据文本！！！反之退出程序！！！
set /p "sr="
if /i "%sr%"=="" (goto SZ) else (exit)
:JC6
rd /s /Q "%~dp0项目文件\%xmm%_xml备份\">nul 2>nul
move /y "%~dp0xml" "%~dp0项目文件\%xmm%_xml备份">nul 2>nul
md "%~dp0xml\">nul 2>nul 
goto SZ
:JC7
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0项目文件\%xmm%_xml样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_xml文本.txt" (goto JC8) else (goto JC6))
:JC8
echo ------------------------------------------------------------
echo 该项目已存在，请为项目换个名称！！！
echo 若直接按回车键，将会覆盖旧项目！！！
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto JC6) else (
set "xmm=%sr%"
goto JC1)
:JC9
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0项目文件\%xmm%_xml样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_xml文本.txt" (goto JC4) else (goto JC3))
:SZ
echo ------------------------------------------------------------
echo 请打开需要提取的任意一个文本，将所要提取的字符串的那一整行, 
echo 复制到"%xmm%_xml样例.txt"文件中保存，
echo "%xmm%_xml样例.txt"文件已为您打开。
echo 注意：只能提取替换〈关键词〉字符串〈/关键词〉这种类型！！！
echo ------------------------------------------------------------
Start /w "" "%~dp0项目文件\%xmm%_xml样例.txt"
for %%a in ("%~dp0项目文件\%xmm%_xml样例.txt") do (
if /i "%%~za"=="0" (goto SZ) else (goto TQ))
:TQ
echo 正在提取，请耐心等待！！！
echo ------------------------------------------------------------
("%~dp0tool\ssed.exe" -r "s/.*\x3c(.*)\x3e.*\x3c\x2f.*\x3e.*/\1/" "%~dp0项目文件\%xmm%_xml样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
rd /s /Q "%~dp0项目文件\%xmm%_xml预处理\">nul 2>nul
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
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\%xmm%_%%k_xml文本备份.txt" > "%~dp0%xmm%_%%k_xml文本.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x3c%%k\x3e)(.*)(\x3c\x2f%%k\x3e.*)/\1\2\3\|\1\3/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_xml搜索源.txt")>nul 2>nul)
del "%~dp0项目文件\tmp*.txt">nul 2>nul
del "%~dp0项目文件\*list.txt">nul 2>nul
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0项目文件"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo 提取完成！！！按任意键退出！
echo ------------------------------------------------------------
pause>nul
exit
:TC
del "%~dp0项目文件\tmp*.txt">nul 2>nul
del "%~dp0项目文件\*list.txt">nul 2>nul
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
cd "%~dp0项目文件"
For /f "tokens=*" %%i in ('dir /a-d /b "*.*"') do (
If "%%~zi"=="0" (Del /q /f "%%i"))
echo ------------------------------------------------------------
echo 没有找到txt文件！按任意键退出！
pause>nul
exit
