@echo off
rem Apicultura: so recalcula o resumo (sem baixar do SisATeG). Use quando a Bovinocultura acabou de carregar os dados, ou quando mudou o SQL.
cd /d "%~dp0"
python scripts\atualizar_tudo.py --so-resumo
pause
