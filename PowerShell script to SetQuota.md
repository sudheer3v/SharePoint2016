#Snap in
Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$url = "https://contoso.com/sites/testsite"  
$Quota = "20 GB Quota" 
$quotaTemplate = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates |  Where-Object {$_.Name -eq $Quota}  

Set-SPSite -Identity $url -QuotaTemplate $quotaTemplate  

#Verify the applied quota
$Site = Get-SPSite -Identity $url 
$Site.StorageQuota
