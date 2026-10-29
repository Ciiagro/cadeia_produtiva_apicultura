@echo off
rem ATUALIZACAO RAPIDA da Apicultura: so o mes atual e o anterior (uso do dia a dia).
cd /d "%~dp0"
echo Dica: se a Bovinocultura acabou de ser atualizada, use atualizar_so_resumo.bat (a carga e a mesma).
python scripts\atualizar_tudo.py --rapido
pause
