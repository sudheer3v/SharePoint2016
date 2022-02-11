# PowerShell Script to get List, Items and Folders count in a SharePoint Site

    #Snap in
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

    Start-Transcript -Path "C:\Reports\JobExecution$(get-date -f yyyy-MM-dd_hh-mm-ss).txt" -NoClobber
    $Date = get-date -f yyyy-MM-dd_hh-mm-ss

    $Url = "https://contoso.com/teams/testsite"
    $siteID = "1"

    function Get-DocInventory() 
    {
        [void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")       
        $site = Get-SPSite $Url

        foreach ($web in $site.AllWebs) 
        {
            foreach ($list in $web.Lists) 
            {
            $data = @{ 
                        "Site Collection" = $Url                           
                        "SubSite" = $web.Url
                        "List" = $list.Title
                        "List Type" = $list.BaseType
                        "List Count" = $list.Items.Count
                        "Folder Count" = $list.Folders.Count                         
                        }
                        New-Object PSObject -Property $data
                
            }
            $web.Dispose();
        }
        $site.Dispose()
                
    }
   
    #Get-DocInventory | Out-GridView
    Get-DocInventory | Export-Csv -NoTypeInformation -Path C:\Reports\"$SiteID-$Date.csv"
    Stop-Transcript
