@echo off
cd /d "%~dp0"
set /p V=ID da visita: 
python scripts\consultar_visita.py %V%
pause
