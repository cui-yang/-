@echo off
title Unity3DTMP真实字库查看
md "%~dp0项目文件\">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo 不是双击双开bat！不是双击双开bat！
echo 请将MonoBehaviour文件拖到该bat上！
echo 正在提取TMP中的字符，请耐心等待！
echo ------------------------------------------------------------
"%~dp0tool\ssed.exe" -r -n "/m_Unicode/p; /int\x20id/p; /\x22id\x22/p" %1 | "%~dp0tool\ssed.exe" -r "s/.*: //; s/.* \= //" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\mawk.exe" "{ printf \"%%x\n\", $1 }" "%~dp0项目文件\tmp1.txt" | "%~dp0tool\ssed.exe" -r "s/^(.)$/\\u000\1/g; s/^(..)$/\\u00\1/g; s/^(...)$/\\u0\1/g; s/^(....)$/\\u\1/g" > "%~dp0项目文件\tmp2.txt"
"%~dp0tool\ssed.exe" -nr "H;${g;s/\n//gp}" "%~dp0项目文件\tmp2.txt" > "%~dp0项目文件\tmp1.txt"
"%~dp0tool\uesc.exe" < "%~dp0项目文件\tmp1.txt" > "%~dpn1包含的字符.txt"
del "%~dp0项目文件\tmp*.txt">nul 2>nul
Start "" "%~dpn1包含的字符.txt"
exit
