#PowerShell script to delete specific sharepoint groups from a site.

#add snapin
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
$spWeb = Get-SPWeb "https://intranet.com/sites/test1"
$spGroups = $spWeb.SiteGroups
$groups = $spGroups.name

$groups = ("Approvers","Designers","Everyone","Excel Services Viewers", "Hierarchy Managers", "Home Members", "Home Owners","Home Visitors","NT AUTHORITY\authenticated users","Quick Deploy Users","Restricted Readers", "Style Resource Readers", "Translation Managers")

ForEach($group in $groups) {
   $spGroups.Remove($group)
}

$spWeb.Dispose()


