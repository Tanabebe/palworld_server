@echo off

call env.bat

set TEXT=%1

echo {"text":%TEXT%,"channel": "%CHANNEL%", "username":%FROM%,"icon_emoji":%ICON_EMOJI%}| nkf -w | curl -k -X POST --data-urlencode payload@- %SLACK_URL%