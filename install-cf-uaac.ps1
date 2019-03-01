
<#PSScriptInfo

.VERSION 0.1

.GUID 50c63250-0c33-484e-a482-b76569b2f52c

.AUTHOR Kbott@pivotal.io

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.DESCRIPTION 
 Install Ruby Environment and cf-uaac for Cloudfoundry 

#> 
Param()
$request = Invoke-WebRequest https://rubyinstaller.org/downloads/
$Download_Links = $request.Links | where class -match downloadlink 
$Devkits = $Download_Links | where {$_.innerHTML -Match [Regex]::Escape("Ruby+Devkit 2.5")}
$Downloadlink = ($Devkits | where href -Match x64 | Select-Object -First 1).href
$downloadfile = "$HOME/Downloads/$(Split-Path -Leaf $Downloadlink)"
Invoke-WebRequest -UseBasicParsing -Uri $Downloadlink -OutFile $downloadfile
Start-Process $DownloadFile -ArgumentList '/SILENT /Dir="C:\Ruby25" /Components="ruby,msys2" /Group="Ruby 2.5.3-1-x64 with MSYS2" SetupType=custom'
Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList '/k','gem uninstall eventmachine', 'gem install eventmachine --platform ruby', '/s', "`"$targetDir`""
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
gem uninstall eventmachine --force
gem install eventmachine --platform ruby
gem install cf-uaac

