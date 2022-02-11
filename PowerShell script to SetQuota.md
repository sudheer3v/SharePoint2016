# PowerShell Script to Set a Site Quota to a Specific Site in SharePoint.

> Note: To create a Site Quota using PowerShell Please refer this [script](https://github.com/sudheer3v/SharePoint2016/blob/Dev/PowerShell%20Script%20to%20create%20Site%20Quota%20Script.md)

    #Snap in
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

    $url = "https://contoso.com/sites/testsite"  
    $Quota = "20 GB Quota" 
    $quotaTemplate = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates |  Where-Object {$_.Name -eq $Quota}  

    Set-SPSite -Identity $url -QuotaTemplate $quotaTemplate  

    #Verify the applied quota
    $Site = Get-SPSite -Identity $url 
    $Site.StorageQuota


