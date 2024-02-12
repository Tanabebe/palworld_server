@echo off

chcp 65001

call env.bat

call az vm start --resource-group %AZ_RESOURCE_GROUP_MANE% --name %AZ_VM_NAME%

for /f %%i in ('az vm show --resource-group  %AZ_RESOURCE_GROUP_MANE% --name %AZ_VM_NAME% --show-details --query "publicIps" --output tsv') do set PUBLIC_IP=%%i

set TEXT="PalWorldのサーバーを起動しました\nIP: `%PUBLIC_IP%`\nServer PASS: `%SERVER_PASS%`\nRDP PASS: `%RDP_PASS%`"

echo {"text":%TEXT%,"channel": "%CHANNEL%", "username":%FROM%,"icon_emoji":%ICON_EMOJI%}| nkf -w | curl -k -X POST --data-urlencode payload@- %SLACK_URL%