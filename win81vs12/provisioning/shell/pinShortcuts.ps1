# http://stackoverflow.com/a/21956798/4185948
$sa = new-object -c shell.application
$pn = $sa.namespace($env:windir).parsename('system32\WindowsPowerShell\v1.0\powershell.exe'); $pn.invokeverb('taskbarpin')
$pn = $sa.namespace("${env:ProgramFiles(x86)}").parsename('Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'); $pn.invokeverb('taskbarpin')
#$pn = $sa.namespace("${env:ProgramFiles(x86)}").parsename('Microsoft SQL Server\120\Tools\Binn\ManagementStudio\Ssms.exe'); $pn.invokeverb('taskbarpin')
$pn = $sa.namespace("${env:ProgramFiles(x86)}").parsename('Notepad++\notepad++.exe'); $pn.invokeverb('taskbarpin')
#$pn = $sa.namespace("${env:ProgramFiles(x86)}").parsename('ChocolateyGUI\ChocolateyGui.exe'); $pn.invokeverb('taskbarpin')
#$pn = $sa.namespace("${env:ProgramFiles}").parsename('paint.net\PaintDotNet.exe'); $pn.invokeverb('taskbarpin')