# Power Shell Script to delete a site collection if its failed during site creation process but it still shows up in Central Admin.

    #add snapin
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

    $s = Get-SPSite -Identity https://contoso.com/sites/testsite1
    $siteid = $s.Id
    $Sitedb = $s.ContentDatabase
    $sitedb.ForceDeleteSite($siteid, $false, $false)
