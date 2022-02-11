# PowerShell script to alternate CSS Url of a SharePoint site

    #add snapin
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    
    #Enter the Target Site Below#
    $siteurl = "https://contoso.com/sites/Test7"
    $cssurl = "/sites/test/Style Library/custom.css"

    #Below are the details Custom CSS File location#
    $web = Get-SPWeb $siteurl
    $web.AlternateCssUrl = $cssurl 
    $web.Update()
