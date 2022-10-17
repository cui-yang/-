@echo off
title Unity3D文本提取
md "%~dp0txt_json\">nul 2>nul
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
(dir /a /b "%~dp0txt_json\*" | findstr /R "." >nul && (goto JC2) || (goto JC5))>nul 2>nul
:JC2
if exist "%~dp0项目文件\%xmm%_txt_json_样例.txt" (goto JC3) else (goto SZ1)
:JC3
("%~dp0tool\ssed.exe" -r -e "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_txt文本.txt" (goto JC4) else (goto SZ1))
:JC4
echo ------------------------------------------------------------
echo 该项目已存在，请为项目换个名称！！！
echo 若直接按回车键，将会覆盖旧项目！！！
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ1) else (
set "xmm=%sr%"
goto JC2)
:SZ1
echo ------------------------------------------------------------
echo 请打开需要提取的任意一个文本，将所要提取的字符串的那一整行, 
echo 复制到"%xmm%_txt_json_样例.txt"文件中保存，
echo "%xmm%_txt_json_样例.txt"文件已为您打开。
echo 请注意：只能提取替换（关键词 = "字符串"）
echo 和（"关键词": "字符串"）这两种类型！！！
echo ------------------------------------------------------------

Start /w "" "%~dp0项目文件\%xmm%_txt_json_样例.txt"
for %%a in ("%~dp0项目文件\%xmm%_txt_json_样例.txt") do (
if /i "%%~za"=="0" (goto SZ1) else (goto BF))
:BF

rd /s /Q "%~dp0项目文件\%xmm%_txt_json备份\">nul 2>nul
move /y "%~dp0txt_json" "%~dp0项目文件\%xmm%_txt_json备份">nul 2>nul
md "%~dp0txt_json\">nul 2>nul 
goto TQ
:JC5
(dir /a /b "%~dp0项目文件\%xmm%_txt_json备份\*" | findstr /R "." >nul && (goto JC6) || (goto TC))>nul 2>nul
:JC6
echo ------------------------------------------------------------
echo txt_json文件夹中没有文件？？？
echo 但项目文件中存在%xmm%_txt_json的项目数据，
echo 是否使用该项目备份再次进行文本提取？
echo 直接按回车键确认提取备份数据文本！！！
set /p "sr="
if /i "%sr%"=="" (goto JC7) else (exit)
:JC7
if exist "%~dp0项目文件\%xmm%_txt_json_样例.txt" (goto JC8) else (goto SZ2)
:JC8
("%~dp0tool\ssed.exe" -r -e "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
if exist "%~dp0%xmm%_%%k_txt文本.txt" (goto JC8) else (goto SZ2))
:JC9
echo ------------------------------------------------------------
echo 该项目已存在，请为项目换个名称！！！
echo 若直接按回车键，将会覆盖旧项目！！！
echo ------------------------------------------------------------
set /p "sr="
if /i "%sr%"=="" (goto SZ2) else (
set "xmm=%sr%"
goto JC7)
:SZ2
echo ------------------------------------------------------------
echo 请打开需要提取的任意一个文本，将所要提取的字符串的那一整行, 
echo 复制到"%xmm%_txt_json_样例.txt"文件中保存，
echo "%xmm%_txt_json_样例.txt"文件已为您打开。
echo 请注意：只能提取替换（关键词 = "字符串"）
echo 和（"关键词": "字符串"）这两种类型！！！
echo ------------------------------------------------------------

Start /w "" "%~dp0项目文件\%xmm%_txt_json_样例.txt"
for %%a in ("%~dp0项目文件\%xmm%_txt_json_样例.txt") do (
if /i "%%~za"=="0" (goto SZ2) else (goto TQ))
:TQ
echo 正在提取，请耐心等待！！！
echo ------------------------------------------------------------

("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/; /.*\x22.*\x22\x3a\x20\x22.*/d" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/.*\x22(.*)\x22\x3a\x20\x22.*/\1/; /.*\x20\x3d\x20\x22.*/d" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp00.txt")>nul 2>nul
rd /s /Q "%~dp0项目文件\%xmm%_txt预处理\">nul 2>nul
xcopy /s /y /f "%~dp0项目文件\%xmm%_txt_json备份" "%~dp0项目文件\%xmm%_txt预处理\">nul 2>nul
(for /r "%~dp0项目文件\%xmm%_txt预处理" %%a in (*) do (echo %%a)) > "%~dp0项目文件\%xmm%_alllist.txt"
"%~dp0tool\ssed.exe" -r "/.*txt$/d; /^$/d" "%~dp0项目文件\%xmm%_alllist.txt" > "%~dp0项目文件\%xmm%_jsonlist.txt"
for /f "usebackq delims=" %%a in ("%~dp0项目文件\%xmm%_jsonlist.txt") do (del "%%a">nul 2>nul)
(for /r "%~dp0项目文件\%xmm%_txt预处理" %%a in (*.txt) do (echo %%a)) > "%~dp0项目文件\%xmm%_txtlist.txt"
CD .>"%~dp0项目文件\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_txtlist.txt") do (
	copy /b "%~dp0项目文件\tmp1.txt" + "%%h" "%~dp0项目文件\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0项目文件\tmp2.txt"
	move /y "%~dp0项目文件\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
	echo 正在提取"%%k"的文本内容...
("%~dp0tool\ssed.exe" -r -n "/%%k\x20\x3d\x20\x22/p" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/%%k\x20\x3d\x20\x22\x22$/d; /\x22\xe2\x80\x8b\x22$/d" "%~dp0项目文件\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
	
("%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)\x22.*/\1/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_txt文本备份.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\%xmm%_%%k_txt文本备份.txt" > "%~dp0%xmm%_%%k_txt文本.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*%%k\x20\x3d\x20\x22)(.*)(\x22.*)/\1\2\3\|\1\3/; /\x20\x3d\x20\x22\x22\|%%k\x20\x3d\x20\x22/d; /\x20\x3d\x20\x22\xe2\x80\x8b\x22\|%%k\x20\x3d\x20\x22/d" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_txt搜索源.txt")>nul 2>nul)
GOTO JSON
:JSON
xcopy /s /y /f "%~dp0项目文件\%xmm%_txt_json备份" "%~dp0项目文件\%xmm%_json预处理\">nul 2>nul
(for /r "%~dp0项目文件\%xmm%_json预处理" %%a in (*) do (echo %%a)) > "%~dp0项目文件\%xmm%_alllist.txt"
"%~dp0tool\ssed.exe" -r "/.*json$/d; /^$/d" "%~dp0项目文件\%xmm%_alllist.txt" > "%~dp0项目文件\%xmm%_txtlist.txt"
for /f "usebackq delims=" %%a in ("%~dp0项目文件\%xmm%_txtlist.txt") do (del "%%a">nul 2>nul)
(for /r "%~dp0项目文件\%xmm%_json预处理" %%a in (*.json) do (echo %%a)) > "%~dp0项目文件\%xmm%_jsonlist.txt"
CD .>"%~dp0项目文件\tmp1.txt"
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_jsonlist.txt") do (
	copy /b "%~dp0项目文件\tmp1.txt" + "%%h" "%~dp0项目文件\tmp1.txt"
	"%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g" "%%h" > "%~dp0项目文件\tmp2.txt"
	move /y "%~dp0项目文件\tmp2.txt" "%%h")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp00.txt") do (
	echo 正在提取"%%k"的文本内容...
("%~dp0tool\ssed.exe" -r -n "/\x22%%k\x22\x3a\x20\x22/p" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x22%%k\x22\x3a\x20\x22\x22$/d; /\x22%%k\x22\x3a\x20\x22\x22\x2c$/d; /\x22\xe2\x80\x8b\x22$/d; /\x22\xe2\x80\x8b\x22\x2c$/d" "%~dp0项目文件\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x22%%k\x22\x3a\x20\x22(.*)\x22.*/\1/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_json文本备份.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\%xmm%_%%k_json文本备份.txt" > "%~dp0%xmm%_%%k_json文本.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x22%%k\x22\x3a\x20\x22)(.*)(\x22.*)/\1\2\3\x7c\1\3/; /\x22%%k\x22\x3a\x20\x22\x22\x2c\x7c\x22/d; /\x22%%k\x22\x3a\x20\x22\x22\x7c\x22/d" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_json搜索源.txt")>nul 2>nul)
GOTO WC
:WC
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
