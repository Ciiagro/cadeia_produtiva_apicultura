@echo off
rem Apicultura: recarrega a historia desde 2024-06 (demora) e recalcula tudo.
cd /d "%~dp0"
python scripts\atualizar_tudo.py --desde 2024-06-01
pause
