@echo off
set "gjh=@2txt�ؼ�������.txt"

:jiancha
tasklist|find /i "UltraReplace.exe" && goto yunxing || goto kaishi

:yunxing
mode con cols=60 lines=20 & color C0
echo ------------------------------------------------------------
echo ��رճ��������ı��滻���ߺ������������
echo ��رճ��������ı��滻���ߺ������������
echo ��رճ��������ı��滻���ߺ������������
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
if exist "%~dp0tool\txtָ���йؼ���.txt" (goto HB) else (goto TG)

:HB
(for /f "usebackq delims=" %%k in ("%~dp0tool\txtָ���йؼ���.txt") do (
echo %%k))>>"%~dp0tool\tmp.txt"

:TG
cd "%~dp0tool"
gawk "!x[$0]++" tmp.txt > tmp0.txt
del "%~dp0tool\tmp.txt">nul 2>nul
del "%~dp0tool\����Դ.txt">nul 2>nul
del "%~dp0tool\�滻Դ.txt">nul 2>nul
echo ------------------------------------------------------------
echo ��ʼ�ϲ�����...
for /f "usebackq delims=" %%l in ("%~dp0tool\tmp0.txt") do (
if exist "%~dp0%%lԭ��ȡ�ļ�.txt" (
copy /y "%~dp0%%lԭ��ȡ�ļ�.txt" "%~dp0tool\%%l����Դ.txt">nul 2>nul
copy /y "%~dp0%%l���޸��ļ�.txt" "%~dp0tool\%%l�滻Դ.txt">nul 2>nul
cd "%~dp0tool"
sed -r "s/^/%%l\= \"/; s/$/\"/; s/\!/\@@@/g" "%%l����Դ.txt" >> "����Դ.txt"
sed -r "s/^/%%l\= \"/; s/$/\"/; s/\!/\@@@/g" "%%l�滻Դ.txt" >> "�滻Դ.txt"
del "%~dp0tool\%%l����Դ.txt">nul 2>nul
del "%~dp0tool\%%l�滻Դ.txt">nul 2>nul
) else (echo ������ɾ�����ļ�))
del "%~dp0tool\tmp0.txt">nul 2>nul
concmd /i:utf8 /o:gbk /f:s "����Դ.txt" "����ԴGBK.txt">nul
concmd /i:utf8 /o:gbk /f:s "�滻Դ.txt" "�滻ԴGBK.txt">nul
del "%~dp0tool\����Դ.txt">nul 2>nul
del "%~dp0tool\�滻Դ.txt">nul 2>nul
gawk "NR==FNR{a[NR]=$0;nr=NR;}NR>FNR{print a[NR-nr]\"^|^|\", \"^|^|\" $0}" "����ԴGBK.txt" "�滻ԴGBK.txt" > "�����滻Դ.txt"
del "%~dp0tool\����ԴGBK.txt">nul 2>nul
del "%~dp0tool\�滻ԴGBK.txt">nul 2>nul

echo ------------------------------------------------------------
echo ���ݺϲ���ɣ�
echo ------------------------------------------------------------
echo �����滻���������ļ�...
echo %~dp0txt�ɹ�\ >"%~dp0tool\tmp.txt"
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
echo "		<RepacleRulesFile>%~dp0tool\MultiRules\�滻����.nrr</RepacleRulesFile>"
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
echo �����ļ�������ɣ�
echo ------------------------------------------------------------
echo txt���׼��...
echo y|del /s "%~dp0txt�ɹ�">nul 2>nul
xcopy /q /s "%~dp0txt\*" "%~dp0txt�ɹ�\">nul 2>nul
echo ------------------------------------------------------------
echo ���������滻�����ļ��������ĵȴ�...
echo �Ժ������ı��滻���ߣ�
echo �벻Ҫ�������������ð�ť������
echo ֱ�ӵ������ʼ����ť�����ĵȴ��滻��ɣ�����
del "%~dp0tool\MultiReplace\�滻����.nrr">nul 2>nul
md "%~dp0tool\MultiReplace\">nul 2>nul
md "%~dp0tool\log\">nul 2>nul
for /f "usebackq delims=" %%m in ("%~dp0tool\�����滻Դ.txt") do (echo %%m>tmp.txt
hexstr < "tmp.txt" >> "%~dp0tool\MultiReplace\�滻����.nrr"
)
del "%~dp0tool\tmp.txt">nul 2>nul
sed32 -i "s/\,//g; s/7c7c207c7c/\;/g; s/404040/21/g" "%~dp0tool\MultiReplace\�滻����.nrr"
del "%~dp0tool\�����滻Դ.txt">nul 2>nul
echo ------------------------------------------------------------
echo �滻�����ļ�������ɣ�
echo ------------------------------------------------------------
echo �벻Ҫ���������ť������ֱ�ӵ������ʼ����ť������
echo �벻Ҫ���������ť������ֱ�ӵ������ʼ����ť������
echo �벻Ҫ���������ť������ֱ�ӵ������ʼ����ť������
echo ------------------------------------------------------------
start /w "" "%~dp0tool\UltraReplace.exe"
start "" "%~dp0txt�ɹ�"
exit
