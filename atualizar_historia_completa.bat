@echo off
rem Apicultura: recarrega a historia desde 2023-01 (demora) e recalcula tudo.
cd /d "%~dp0"
python scripts\atualizar_tudo.py --desde 2023-01-01
pause
