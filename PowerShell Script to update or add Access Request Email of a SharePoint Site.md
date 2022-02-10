#PowerShell Script to update or add Access Request Email of a SharePoint Site

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

$SiteURL = "https://sharepoint.com/sites/testsite"
$SiteEmail = "testid@sharepoint.com"
    
    # get the collection of webs
    $SPWeb = Get-SPWeb $SiteURL
    
    # if a site inherits permissions, then the Access request mail setting also will be inherited
    if (!$SPWeb.HasUniquePerm)
    {
        Write-Host $SPWeb.Name "Inheriting from Parent site"
    }
    elseif($SPWeb.RequestAccessEnabled)
    {
        #Write-Host $SPweb.Name "Not Inheriting from Parent Site"
        $SPWeb.RequestAccessEmail = $SiteEmail
        $SPWeb.Update()
    }
 
