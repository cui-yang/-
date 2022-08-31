@echo off
set "gjh=@1json关键行样例.txt"
md "%~dp0json\">nul 2>nul

mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo 请将需要提取的json文件放入json文件夹中，
echo ------------------------------------------------------------
echo 然后打开json文件夹中任意一个文本，
echo ------------------------------------------------------------
echo 将所要提取的字符串所在的整行, 
echo ------------------------------------------------------------
echo 复制到"%gjh%"文件中保存, 或者在下面输入行号。
echo ------------------------------------------------------------
echo 请注意：只能提取替换（"关键词": "字符串"）这种类型！！！
echo ------------------------------------------------------------
echo 请输入要提取的行号，多行用空格隔开，连续行以逗号连接，
echo 例如提取第5、14、17、18、19、20，就输入5 14 17,20回车。
echo 不输入直接按回车就以"%gjh%"文件提取！！！
echo 强烈推荐以"%gjh%"文件方式提取文本！！！
echo ------------------------------------------------------------
set /p "sr="
if "%sr%"=="" (goto GJC) else (goto ZDH)

:ZDH
echo %sr%>"%~dp0tool\tmp.txt"
cd "%~dp0tool"
sed32 -i "s/ /\n/g" tmp.txt
echo ------------------------------------------------------------
echo 正在提取指定行内容...
for /f "tokens=* usebackq delims=" %%h in ("%~dp0tool\tmp.txt") do (
cd "%~dp0json"
for %%i in (*.json) do (
cd "%~dp0tool"
sed32 -n %%hp "%~dp0json\%%i">>tmp2.txt
))>nul
(for /f "tokens=* usebackq" %%l in ("tmp2.txt") do echo %%l)>"tmp.txt"
findstr /r /c:"\"\: \"" "%~dp0tool\tmp.txt" >"%~dp0tool\tmp2.txt"
sed32 -i "s/^\"//; s/\": .*$//" "tmp2.txt"
gawk "!x[$0]++" tmp2.txt > tmp.txt
if exist "%~dp0tool\json指定行关键词.txt" (
echo ------------------------------------------------------------
echo 检测到提取指定行的历史记录！
echo 如果想要删除历史记录重新创建，请按y并回车键！
echo 想要将当前行号追加到历史记录中，就请直接按回车键！
set /p "xw="
if "%xw%"=="y" (goto SCJL) else (
if "%xw%"=="Y" (goto SCJL) else (
goto BSC))) else (goto BSC)

:SCJL
del "%~dp0tool\json指定行关键词.txt">nul 2>nul

:BSC
findstr /V /c:"ECHO " "tmp.txt">>"json指定行关键词.txt"
gawk "!x[$0]++" "json指定行关键词.txt" > "%~dp0tmp0.txt"
del "%~dp0tool\tmp.txt">nul 2>nul
del "%~dp0tool\tmp2.txt">nul 2>nul
goto TQ

:GJC
(for /f "tokens=* usebackq" %%t in ("%gjh%") do echo %%t)>"%~dp0tmp.txt"
findstr /V /c:"ECHO " "%~dp0tmp.txt">"%~dp0tmp0.txt"
del "%~dp0tmp.txt">nul 2>nul
cd "%~dp0tool"

:TQ
sed32 -i "s/^\"//; s/\": \".*$//" "%~dp0tmp0.txt"
md "%~dp0有乱码时找文件用\">nul 2>nul
del "%~dp0有乱码时找文件用\*.txt">nul 2>nul
for /f "usebackq delims=" %%k in ("%~dp0tmp0.txt") do (
del "%~dp0tool\tmp.txt">nul 2>nul
echo ------------------------------------------------------------
echo 正在提取%%k的文本内容...
cd "%~dp0json"
for %%j in (*.json) do (
findstr /c:"""%%k""" %%j >> "%~dp0tool\tmp.txt"
findstr /s /c:"""%%k""" %%j >> "%~dp0有乱码时找文件用\%%k_log.txt"
)>nul
findstr /r /c:"\"\: \"" "%~dp0tool\tmp.txt" >"%~dp0tool\tmp1.txt"
findstr /V "鈥 """"" "%~dp0tool\tmp1.txt">"%~dp0tool\tmp.txt"
cd "%~dp0tool"
sed32 -i "s/.*: \"//; s/\"\,$//; s/\"$//" "tmp.txt"
gawk "!x[$0]++" tmp.txt > "tmp1.txt"
concmd /o:utf8 /f:s tmp1.txt "%~dp0%%k原提取文件.txt">nul
del "tmp.txt">nul 2>nul
del "tmp1.txt">nul 2>nul
copy /y "%~dp0%%k原提取文件.txt" "%~dp0%%k待修改文件.txt">nul 2>nul
del "tmp.txt">nul 2>nul
)
del "%~dp0tmp0.txt">nul 2>nul
del "ECHO 处于关闭状态*.txt">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo 请在“待修改文件”中进行修改操作，
echo “原提取文件”与“待修改文件”的每行存在一一对应关系，
echo 如果要删除“待修改文件”中的某一行，
echo “原提取文件”中的那一行也要删除，
echo 另外，请不要修改文件名！！！
echo 只有这样才能正确的替换回去！！！
echo 不需要的“原提取文件”与“待修改文件”可以删除。
echo ------------------------------------------------------------
echo 按任意键退出...
pause>nul
exit
