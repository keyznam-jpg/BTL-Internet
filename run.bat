
@echo off
title WEB QLKS 2025
pip install -r requirements.txt
taskkill /f /im python.exe >nul 2>&1
start "" http://127.0.0.1:5000
python app.py
pause
