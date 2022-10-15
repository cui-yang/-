@echo off
title Unity3D文本替换
mode con cols=60 lines=20 & color 1F
md "%~dp0项目文件\">nul 2>nul
echo ------------------------------------------------------------
echo 请输入需要替换文本的项目名！！！
:XMMM
set /p "xmm="
:YLJC
if exist "%~dp0项目文件\%xmm%_txt_json_样例.txt" (goto JCTXT1) else (goto JCCL)
:JCTXT1
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/(.*)\x20\x3d\x20\x22.*/\1/; /.*\x22.*\x22\x3a\x20\x22.*/d" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp0.txt")
("%~dp0tool\ssed.exe" -r "s/^\s+//g; s/.*\x22(.*)\x22\x3a\x20\x22.*/\1/; /.*\x20\x3d\x20\x22.*/d" "%~dp0项目文件\%xmm%_txt_json_样例.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp00.txt")
if exist "%~dp0%xmm%_*txt文本.txt" (goto JCTXT2) else (goto JCJSON1)
:JCTXT2
if exist "%~dp0项目文件\%xmm%_*txt文本备份.txt" (goto JCTXT3) else (goto JCTXT5)
:JCTXT3
if exist "%~dp0项目文件\%xmm%_*txt搜索源.txt" (goto JCTXT4) else (goto JCTXT5)
:JCTXT4
(dir /a /b "%~dp0项目文件\%xmm%_txt预处理" | findstr /R "." >nul && (goto KSTHTXT) || (goto JCTXT5))>nul 2>nul
:JCTXT5
(dir /a /b "%~dp0项目文件\%xmm%_txt_json备份" | findstr /R "." >nul && (goto TXTCJ) || (goto JCJSON1))>nul 2>nul
:JCJSON1
if exist "%~dp0%xmm%_*json文本.txt" (goto JCJSON2) else (goto JCCL)
:JCJSON2
if exist "%~dp0项目文件\%xmm%_*json文本备份.txt" (goto JCJSON3) else (goto JCJSON4)
:JCJSON3
if exist "%~dp0项目文件\%xmm%_*json搜索源.txt" (goto JCJSON8) else (goto JCJSON4)
:JCJSON4
(dir /a /b "%~dp0项目文件\%xmm%_txt_json备份" | findstr /R "." >nul && (goto JSONCJ) || (goto JCCL))>nul 2>nul
:JCCL
echo 该项目文件缺失，或名称错误，请重新输入项目名称！！！
goto XMMM
:TXTCJ
echo ------------------------------------------------------------
echo 必要文件缺失！！！
echo 正在尝试重建必要文件，请耐心等待！！！
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
("%~dp0tool\ssed.exe" -r -n "/%%k\x20\x3d\x20\x22/p" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/%%k\x20\x3d\x20\x22\x22$/d; /\x22\xe2\x80\x8b\x22$/d" "%~dp0项目文件\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x22/\x40\x40\x40/; s/.*\x40\x40\x40//; s/^(.*)\x22.*/\1/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_txt文本备份.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*%%k\x20\x3d\x20\x22)(.*)(\x22.*)/\1\2\3\|\1\3/; /\x20\x3d\x20\x22\x22\|%%k\x20\x3d\x20\x22/d; /\x20\x3d\x20\x22\xe2\x80\x8b\x22\|%%k\x20\x3d\x20\x22/d" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_txt搜索源.txt")>nul 2>nul)
GOTO KSTHTXT
:KSTHTXT
rd /s /Q "%~dp0项目文件\%xmm%_txt临时\">nul 2>nul
xcopy /y /s /E "%~dp0项目文件\%xmm%_txt预处理" "%~dp0项目文件\%xmm%_txt临时\">nul 2>nul
(DIR "%~dp0项目文件\%xmm%_txt临时\*" /s/b/a-d > "%~dp0项目文件\%xmm%_txtlist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp0.txt") do (
echo ------------------------------------------------------------
echo 正在批量替换%%k，请耐心等待！！！
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_txt文本.txt" > "%~dp0项目文件\tmp1.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\%xmm%_%%k_txt文本备份.txt" | "%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0项目文件\%xmm%_%%k_txt文本备份.txt" > "%~dp0项目文件\tmp4.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0项目文件\tmp2.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp4.txt" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*%%k\x20\x3d\x20\x22.*\x22.*\|.*%%k\x20\x3d\x20\x22)(\x22.*)/\1/" "%~dp0项目文件\%xmm%_%%k_txt搜索源.txt" > "%~dp0项目文件\tmp5.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*%%k\x20\x3d\x20\x22.*\x22.*\|.*%%k\x20\x3d\x20\x22)(\x22.*)/\2/" "%~dp0项目文件\%xmm%_%%k_txt搜索源.txt" > "%~dp0项目文件\tmp6.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp5.txt" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp6.txt" > "%~dp0项目文件\%xmm%_%%k_txt搜替源.txt")>nul 2>nul
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_txtlist.txt") do (
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0项目文件\%xmm%_%%k_txt搜替源.txt" "%%h" > "%~dp0项目文件\tmp1.txt")>nul 2>nul
move /y "%~dp0项目文件\tmp1.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_txtlist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0项目文件\tmp1.txt"
move /y "%~dp0项目文件\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0项目文件\%xmm%_txt临时" "%~dp0%xmm%_txt_json成果\">nul 2>nul
rd /s /Q "%~dp0项目文件\%xmm%_txt临时\">nul 2>nul
goto JCJSON5
:JCJSON5
if exist "%~dp0%xmm%_*json文本.txt" (goto JCJSON6) else (goto WC)
:JCJSON6
if exist "%~dp0项目文件\%xmm%_*json文本备份.txt" (goto JCJSON7) else (goto JCJSON9)
:JCJSON7
if exist "%~dp0项目文件\%xmm%_*json搜索源.txt" (goto JCJSON8) else (goto JCJSON9)
:JCJSON8
(dir /a /b "%~dp0项目文件\%xmm%_json预处理" | findstr /R "." >nul && (goto KSJSON) || (goto JSONCJ))>nul 2>nul
:JCJSON9
(dir /a /b "%~dp0项目文件\%xmm%_txt_json备份" | findstr /R "." >nul && (goto JSONCJ) || (goto WC))>nul 2>nul
:JSONCJ
echo ------------------------------------------------------------
echo 必要文件缺失！！！
echo 正在尝试重建必要文件，请耐心等待！！！
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
("%~dp0tool\ssed.exe" -r -n "/\x22%%k\x22\x3a\x20\x22/p" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "/\x22%%k\x22\x3a\x20\x22\x22$/d; /\x22%%k\x22\x3a\x20\x22\x22\x2c$/d; /\x22\xe2\x80\x8b\x22$/d; /\x22\xe2\x80\x8b\x22\x2c$/d" "%~dp0项目文件\tmp3.txt" | "%~dp0tool\mawk.exe" "!x[$0]++" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/.*\x22%%k\x22\x3a\x20\x22(.*)\x22.*/\1/" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_json文本备份.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/\x7c/@#@~@~@#@/g; s/(.*\x22%%k\x22\x3a\x20\x22)(.*)(\x22.*)/\1\2\3\x7c\1\3/; /\x22%%k\x22\x3a\x20\x22\x22\x2c\x7c\x22/d; /\x22%%k\x22\x3a\x20\x22\x22\x7c\x22/d" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\%xmm%_%%k_json搜索源.txt")>nul 2>nul)
GOTO KSJSON
:KSJSON
rd /s /Q "%~dp0项目文件\%xmm%_json临时\">nul 2>nul
xcopy /y /s /E "%~dp0项目文件\%xmm%_json预处理" "%~dp0项目文件\%xmm%_json临时\">nul 2>nul
(DIR "%~dp0项目文件\%xmm%_json临时\*" /s/b/a-d > "%~dp0项目文件\%xmm%_jsonlist.txt")>nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0项目文件\tmp00.txt") do (
echo ------------------------------------------------------------
echo 正在批量替换%%k，请耐心等待！！！
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0%xmm%_%%k_json文本.txt" > "%~dp0项目文件\tmp1.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "!x[$0]++" "%~dp0项目文件\%xmm%_%%k_json文本备份.txt" | "%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" "s/\x7c/@#@~@~@#@/g" "%~dp0项目文件\%xmm%_%%k_json文本备份.txt" > "%~dp0项目文件\tmp4.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\x7c\" $0}" "%~dp0项目文件\tmp2.txt" "%~dp0项目文件\tmp1.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2a[$1] }1" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp4.txt" > "%~dp0项目文件\tmp2.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*\x22%%k\x22\x3a\x20\x22.*)(\x22.*)/\1/" "%~dp0项目文件\%xmm%_%%k_json搜索源.txt" > "%~dp0项目文件\tmp5.txt")>nul 2>nul
("%~dp0tool\ssed.exe" -r "s/(.*\x22%%k\x22\x3a\x20\x22.*)(\x22.*)/\2/" "%~dp0项目文件\%xmm%_%%k_json搜索源.txt" > "%~dp0项目文件\tmp6.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp5.txt" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp3.txt")>nul 2>nul
("%~dp0tool\mawk.exe" "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"\" $0}" "%~dp0项目文件\tmp3.txt" "%~dp0项目文件\tmp6.txt" > "%~dp0项目文件\%xmm%_%%k_json搜替源.txt")>nul 2>nul
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_jsonlist.txt") do (
"%~dp0tool\mawk.exe" -F "|" "NR==FNR{ a[$1]=$2\"\";next}$1 in a{$0=$2 a[$1] }1" "%~dp0项目文件\%xmm%_%%k_json搜替源.txt" "%%h" > "%~dp0项目文件\tmp1.txt"
move /y "%~dp0项目文件\tmp1.txt" "%%h">nul 2>nul))
for /f "usebackq delims=" %%h in ("%~dp0项目文件\%xmm%_jsonlist.txt") do (
"%~dp0tool\ssed.exe" -r "s/@#@~@~@#@/\x7c/g" "%%h" > "%~dp0项目文件\tmp1.txt"
move /y "%~dp0项目文件\tmp1.txt" "%%h">nul 2>nul)
xcopy /y /s /E "%~dp0项目文件\%xmm%_json临时" "%~dp0%xmm%_txt_json成果\">nul 2>nul
rd /s /Q "%~dp0项目文件\%xmm%_json临时\">nul 2>nul
goto WC
:WC
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
Start "" "%~dp0%xmm%_txt_json成果\"
exit
