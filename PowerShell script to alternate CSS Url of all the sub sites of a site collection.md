# PowerShell script to alternate CSS Url of all the sub sites of a site collection.

    #add snapin
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    
    $site = "https://contoso.com/sites/testsitecoll"
    $csspath = "/sites/testsite1/Style Library/custom.css"

    Get-SPSite $site | Get-SPWeb -Limit All |% { $_.AlternateCssUrl = $csspath;$_.AllProperties["_InheritAlternateCssUrl"] = $true;$_.Update() }

