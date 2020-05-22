slmgr.vbs -upk
timeout 10 > NUL
slmgr.vbs -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
timeout 10 > NUL
slmgr.vbs -skms 192.168.20.30
timeout 10 > NUL
slmgr.vbs -ato
timeout 10 > NUL
slmgr.vbs -dlv
pause