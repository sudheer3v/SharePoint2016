# PowerShell Script to create SharePoint 2016 Site Quota 

    #Snap in
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

    #50GB
    $NewQTemp = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate 
    $newQTemp.Name = "50 GB Quota" 
    $newQtemp.StorageMaximumLevel = 50GB 
    $newQtemp.StorageWarningLevel = 45GB #90%
    $newQtemp.UserCodeMaximumLevel = 300 
    $newQtemp.UserCodeWarningLevel = 300 
    $Q =[Microsoft.SharePoint.Administration.SPWebService]::ContentService 
    $Q.QuotaTemplates.Add($newQtemp) 
    $Q.Update()
