@echo off

chcp 65001

call env.bat

for /f %%i in ('az vm show --resource-group %AZ_RESOURCE_GROUP_MANE% --name %AZ_VM_NAME% --show-details --query "publicIps" --output tsv') do set PUBLIC_IP=%%i

call az vm deallocate --resource-group %AZ_RESOURCE_GROUP_MANE% --name %AZ_VM_NAME%

set TEXT="PalWorldのサーバーを停止しました\nIP: `%PUBLIC_IP%`"

echo {"text":%TEXT%,"channel": "%CHANNEL%","username":%FROM%,"icon_emoji":%ICON_EMOJI%}| nkf -w | curl -k -X POST --data-urlencode payload@- %SLACK_URL%