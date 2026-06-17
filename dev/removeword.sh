#!/bin/bash
if cd /home/netsight/scripts/configs/audit/
then
	sed -i '/debug cfgmgr show next dm/Id' ./*.audit
	sed -i '/svc_nac/Id' ./*.audit
	sed -i '/PyLoginName/Id' ./*.audit
	sed -i '/ show /Id' ./*.audit
	sed -i '/ sho /Id' ./*.audit
	sed -i '/ clipaging /Id' ./*.audit
	sed -i '/ exit /Id' ./*.audit
	sed -i '/dis cli p/Id' ./*.audit
	sed -i '/dis cli r/Id' ./*.audit
    sed -i '/disable cli p/Id' ./*.audit
    sed -i '/dissable cli r/Id' ./*.audit
	sed -i '/ tftp /Id' ./*.audit
	sed -i '/ ls /Id' ./*.audit
	sed -i '/ sh /Id' ./*.audit
	sed -i '/ save /Id' ./*.audit
	sed -i '/ scp2 /Id' ./*.audit
	sed -i '/disable log debug-mode/Id' ./*.audit
	sed -i '/ ping /Id' ./*.audit
	sed -i '/ traceroute /Id' ./*.audit
	sed -i '/auto-provision/Id' ./*.audit
	sed -i '/ sa /Id' ./*.audit
	sed -i '/ sav /Id' ./*.audit
	sed -i '/create process cablediag/Id' ./*.audit
	sed -i '/start process cablediag/Id' ./*.audit
	sed -i '/ top /Id' ./*.audit
fi
