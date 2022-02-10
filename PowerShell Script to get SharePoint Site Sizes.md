#PowerShell Script to get SharePoint Site Sizes.

#Snap in
Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

$Date = get-date -f yyyy-MM-dd_hh-mm-ss
$SizeLog = "C:\temp\SPSiteSize-$Date.csv"

function Get-SCSize() 
{
    #Specify the Web app#
    $WebApp = Get-SPWebApplication -Identity Intranet
    $Sites = Get-SPSite -WebApplication $WebApp -Limit All
       
    try
    {        
        foreach($Site in $Sites)
        
        {
            Write-Progress -Activity "Collecting SC Size Details. Please wait..." -status "Processing Web: $($Site.URL)" 
            $SizeInKB = $Site.Usage.Storage

            $SizeInGB = $SizeInKB/1024/1024/1024

            $SizeInGB = [math]::Round($SizeInGB,2)

            $Quota = $Site.StorageQuota
            $QuotaInGB = $Quota/1024/1024/1024 
            
            $data = @{
                          
                       "Site Title" = $Site.RootWeb.Title
                       "Site URL" = $Site.URL
                       "DataBaseName" = $Site.ContentDatabase.Name
                       "SizeInGB" = $SizeInGB
                       "Assigned Site Quota" = $QuotaInGB
                      }
                      New-Object PSObject -Property $data
         }

        #}
                       
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message  #Stores the Error Message.
        Write-Host "Error Occured :" $ErrorMessage

    }
    $site.Dispose()
            
}
     
#Get-DocInventory | Out-GridView
Get-SCSize | Export-Csv -NoTypeInformation -Path $SizeLog
Write-Host  `n `t "     Report Generated Succesfully and  Exported Here!!! $SizeLog" -ForegroundColor Green

