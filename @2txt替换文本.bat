@echo off
set "gjh=@2txt关键行样例.txt"

:jiancha
tasklist|find /i "UltraReplace.exe" && goto yunxing || goto kaishi

:yunxing
mode con cols=60 lines=20 & color C0
echo ------------------------------------------------------------
echo 请关闭超级批量文本替换工具后按任意键继续！
echo 请关闭超级批量文本替换工具后按任意键继续！
echo 请关闭超级批量文本替换工具后按任意键继续！
echo ------------------------------------------------------------
pause
goto jiancha

:kaishi
mode con cols=60 lines=20 & color 1F

IF "%PROCESSOR_ARCHITECTURE%" == "X86" (
copy /y "%~dp0tool\sed32.exe" "%~dp0tool\sed.exe">nul
) ELSE (
copy /y "%~dp0tool\sed64.exe" "%~dp0tool\sed.exe">nul
)
cd "%~dp0"
(for /f "tokens=* usebackq" %%h in ("%gjh%") do echo %%h)>"%~dp0tool\tmp.txt"
findstr /V /c:"ECHO " "%~dp0tool\tmp.txt">"%~dp0tool\tmp0.txt"
(for /f "usebackq delims==" %%i in ("%~dp0tool\tmp0.txt") do (
echo %%i))>"%~dp0tool\tmp.txt"
if exist "%~dp0tool\txt指定行关键词.txt" (goto HB) else (goto TG)

:HB
(for /f "usebackq delims=" %%k in ("%~dp0tool\txt指定行关键词.txt") do (
echo %%k))>>"%~dp0tool\tmp.txt"

:TG
cd "%~dp0tool"
gawk "!x[$0]++" tmp.txt > tmp0.txt
del "%~dp0tool\tmp.txt">nul 2>nul
del "%~dp0tool\搜索源.txt">nul 2>nul
del "%~dp0tool\替换源.txt">nul 2>nul
echo ------------------------------------------------------------
echo 开始合并数据...
for /f "usebackq delims=" %%l in ("%~dp0tool\tmp0.txt") do (
if exist "%~dp0%%l原提取文件.txt" (
copy /y "%~dp0%%l原提取文件.txt" "%~dp0tool\%%l搜索源.txt">nul 2>nul
copy /y "%~dp0%%l待修改文件.txt" "%~dp0tool\%%l替换源.txt">nul 2>nul
cd "%~dp0tool"
sed -r "s/^/%%l\= \"/; s/$/\"/; s/\!/\@@@/g" "%%l搜索源.txt" >> "搜索源.txt"
sed -r "s/^/%%l\= \"/; s/$/\"/; s/\!/\@@@/g" "%%l替换源.txt" >> "替换源.txt"
del "%~dp0tool\%%l搜索源.txt">nul 2>nul
del "%~dp0tool\%%l替换源.txt">nul 2>nul
) else (echo 跳过已删除的文件))
del "%~dp0tool\tmp0.txt">nul 2>nul
concmd /i:utf8 /o:gbk /f:s "搜索源.txt" "搜索源GBK.txt">nul
concmd /i:utf8 /o:gbk /f:s "替换源.txt" "替换源GBK.txt">nul
del "%~dp0tool\搜索源.txt">nul 2>nul
del "%~dp0tool\替换源.txt">nul 2>nul
gawk "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"^|^|\", \"^|^|\" $0}" "搜索源GBK.txt" "替换源GBK.txt" > "搜索替换源.txt"
del "%~dp0tool\搜索源GBK.txt">nul 2>nul
del "%~dp0tool\替换源GBK.txt">nul 2>nul

echo ------------------------------------------------------------
echo 数据合并完成！
echo ------------------------------------------------------------
echo 制作替换工具配置文件...
echo %~dp0txt成果\ >"%~dp0tool\tmp.txt"
hexstr < "tmp.txt" > "tmp2.txt"
sed32 -i "s/\,//g; s/20$/\;1/g" "tmp2.txt"
del "%~dp0tool\tmp.txt">nul 2>nul
for /f "usebackq delims=" %%n in ("tmp2.txt") do (
(echo "<?xml version="1.0" encoding="UTF-8" standalone="yes"?>"
echo "<str>"
echo "	<Configure1>"
echo "		<BackUp>0</BackUp>"
echo "		<Subdir>0</Subdir>"
echo "		<Case_Sensitive>1</Case_Sensitive>"
echo "		<MutilReplace>1</MutilReplace>"
echo "		<Force_ReadOnly>1</Force_ReadOnly>"
echo "		<ReplaceType>1</ReplaceType>"
echo "	</Configure1>"
echo "	<Configure2>"
echo "		<Language>Chinese_Simplified</Language>"
echo "		<SelectFileExt>*.txt;*.htm;*.json</SelectFileExt>"
echo "		<DefaultFileExt>*.txt;*.htm;*.json;*.c;*.cpp;*.h;*.hpp;*.pas;*.dpr;*.bpr;*.asp;*.php;*.cgi;*.ini;*.bat;*.inc;*.java;*.py;*.dfm;*.js;*.sql</DefaultFileExt>"
echo "		<itsSelf>0</itsSelf>"
echo "		<OutPutDir></OutPutDir>"
echo "		<Extract_File_Source_Add>1</Extract_File_Source_Add>"
echo "		<Extract_Add_Empty_Row>0</Extract_Add_Empty_Row>"
echo "		<Extract_Include_Start>1</Extract_Include_Start>"
echo "		<Extract_Include_End>1</Extract_Include_End>"
echo "	</Configure2>"
echo "	<History>"
echo "		<Target>%%n</Target>"
echo "	</History>"
echo "	<MultiReplace>"
echo "		<RepacleRulesFile>%~dp0tool\MultiRules\替换规则.nrr</RepacleRulesFile>"
echo "	</MultiReplace>"
echo "	<Other>"
echo "		<DefaultEditer>notepad.exe</DefaultEditer>"
echo "	</Other>"
echo "</str>")
)>"%~dp0tool\tmp.txt"
sed32 -i "s/^\"//; s/\"$//" "%~dp0tool\tmp.txt"
concmd /i:gbk /o:utf8 /f:s "tmp.txt" "UltraReplace.xml">nul
del "%~dp0tool\tmp2.txt">nul 2>nul
echo ------------------------------------------------------------
echo 配置文件制作完成！
echo ------------------------------------------------------------
echo txt输出准备...
echo y|del /s "%~dp0txt成果">nul 2>nul
xcopy /q /s "%~dp0txt\*" "%~dp0txt成果\">nul 2>nul
echo ------------------------------------------------------------
echo 正在制作替换规则文件，请耐心等待...
echo 稍后将启动文本替换工具，
echo 请不要随意点击其他设置按钮！！！
echo 直接点击“开始”按钮，耐心等待替换完成！！！
del "%~dp0tool\MultiReplace\替换规则.nrr">nul 2>nul
md "%~dp0tool\MultiReplace\">nul 2>nul
md "%~dp0tool\log\">nul 2>nul
for /f "usebackq delims=" %%m in ("%~dp0tool\搜索替换源.txt") do (echo %%m>tmp.txt
hexstr < "tmp.txt" >> "%~dp0tool\MultiReplace\替换规则.nrr"
)
del "%~dp0tool\tmp.txt">nul 2>nul
sed32 -i "s/\,//g; s/7c7c207c7c/\;/g; s/404040/21/g" "%~dp0tool\MultiReplace\替换规则.nrr"
del "%~dp0tool\搜索替换源.txt">nul 2>nul
echo ------------------------------------------------------------
echo 替换规则文件制作完成！
echo ------------------------------------------------------------
echo 请不要点击其他按钮！！！直接点击“开始”按钮！！！
echo 请不要点击其他按钮！！！直接点击“开始”按钮！！！
echo 请不要点击其他按钮！！！直接点击“开始”按钮！！！
echo ------------------------------------------------------------
start /w "" "%~dp0tool\UltraReplace.exe"
start "" "%~dp0txt成果"
exit
