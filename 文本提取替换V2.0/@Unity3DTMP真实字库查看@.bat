@echo off
title Unity3DTMP��ʵ�ֿ�鿴
md "%~dp0��Ŀ�ļ�\">nul 2>nul
mode con cols=60 lines=20 & color 1F
echo ------------------------------------------------------------
echo ����˫��˫��bat������˫��˫��bat��
echo �뽫MonoBehaviour�ļ��ϵ���bat�ϣ�
echo ������ȡTMP�е��ַ��������ĵȴ���
echo ------------------------------------------------------------
"%~dp0tool\ssed.exe" -r -n "/m_Unicode/p; /int\x20id/p; /\x22id\x22/p" %1 | "%~dp0tool\ssed.exe" -r "s/.*: //; s/.* \= //" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\mawk.exe" "{ printf \"%%x\n\", $1 }" "%~dp0��Ŀ�ļ�\tmp1.txt" | "%~dp0tool\ssed.exe" -r "s/^(.)$/\\u000\1/g; s/^(..)$/\\u00\1/g; s/^(...)$/\\u0\1/g; s/^(....)$/\\u\1/g" > "%~dp0��Ŀ�ļ�\tmp2.txt"
"%~dp0tool\ssed.exe" -nr "H;${g;s/\n//gp}" "%~dp0��Ŀ�ļ�\tmp2.txt" > "%~dp0��Ŀ�ļ�\tmp1.txt"
"%~dp0tool\uesc.exe" < "%~dp0��Ŀ�ļ�\tmp1.txt" > "%~dpn1�������ַ�.txt"
del "%~dp0��Ŀ�ļ�\tmp*.txt">nul 2>nul
Start "" "%~dpn1�������ַ�.txt"
exit
