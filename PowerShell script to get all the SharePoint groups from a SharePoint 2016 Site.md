#PowerShell script to get all the SharePoint groups from a SharePoint 2016 Site

#add snapin
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

#sp web
$site = Get-SPWeb https://contoso.com/teams/test1

$Groups = $site.Groups.Name

$Groups | Out-File -FilePath "C:\Output.txt"
