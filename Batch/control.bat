@echo off
set /P rcomp="Enter name or IP of a Remote PC: "
query session /server:%rcomp%
set /P rid="Enter RDP user ID: "
start mstsc /shadow:%rid% /v:%rcomp% /control /noConsentPrompt