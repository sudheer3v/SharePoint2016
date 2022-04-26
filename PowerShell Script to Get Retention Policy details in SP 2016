Add-PSSnapin Microsoft.SharePoint.PowerShell

#Date Stamp
$Date = get-date -f yyyy-MM-dd_hh-mm-ss

#Location for the output file#
$Output="c:\temp\RetentionPolicyDetails"+$Date+".csv";

# Creating a collection to store
$SiteDetailsCollection = @()
#WebApplication
$WebApp = Get-SPWebApplication "Enter your web application name"

#Loops through every site collection and gets the required details.
ForEach($site in $WebApp.Sites)
{
    $SPSite = Get-SPSite -Identity $site.Url
    $SiteCollPolicy = $null
    $SiteCollPolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.PolicyCatalog]($SPSite)
    $SiteCollPolicy.PolicyList
    foreach($web in $SPSite.AllWebs)
    {
        foreach($list in $web.Lists)
        {
            
            $listpolicy = $null
            $listpolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.ListPolicySettings]($list)
            if($listpolicy.ListHasPolicy -eq $true)
            {

                $SiteDetails = New-Object PSObject
    	          $SiteDetails | Add-Member Noteproperty -Name SiteURL $site.Url
                $SiteDetails | Add-Member Noteproperty -Name SC_PolicyName $SiteCollPolicy.PolicyList.Name
                $SiteDetails | Add-Member Noteproperty -Name SC_PolicyID $SiteCollPolicy.PolicyList.Id
                $SiteDetails | Add-Member Noteproperty -Name SC_PolicyModifiedBy $SiteCollPolicy.PolicyList.ModifiedBy
                $SiteDetails | Add-Member Noteproperty -Name SC_PolicyMOdifiedDate $SiteCollPolicy.PolicyList.ModifiedDate            
                $SiteDetails | Add-Member Noteproperty -Name SubsiteURL $web.Url            
                $SiteDetails | Add-Member noteproperty -Name ListName $list.Title
                $SiteDetails | Add-Member Noteproperty -Name ListPolicy $listpolicy.ListHasPolicy
            
                $SiteDetailsCollection += $SiteDetails            
                $SiteDetailsCollection | Export-Csv -notype -path $Output
            } 

        }
    }
}
