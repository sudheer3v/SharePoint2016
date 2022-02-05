### Get CheckedOut Files from SharePoint2016 WebApp


Add-PSSnapin Microsoft.SharePoint.PowerShell   

#Date Stamp
$Date = get-date -f yyyy-MM-dd_hh-mm-ss    

#--->Specify the root site collection within the Web app<---#
$webappUrl="https://sharepoint.com"
$Webapp= Get-SPWebApplication $webappUrl

$SiteCounter = 0
foreach($Site in $Webapp.Sites)
{
    Write-Progress -Activity "Scanning Site: $($Site.Url)" -Status "Completed: $([math]::Round($SiteCounter/$Webapp.Sites.Count*100))%" -PercentComplete ($SiteCounter/$Webapp.Sites.Count*100)
    $Datacollection = @()
    foreach($web in $Site.AllWebs)
    {
        
        $Lists = $web.GetListsOfType([Microsoft.SharePoint.SPBaseType]::DocumentLibrary) 
        
        foreach($list in $Lists )
        {
            
            foreach($item in $list.CheckedOutFiles)
            {
            
                $data1 = New-Object -TypeName PSObject
                $data1 | Add-Member -MemberType NoteProperty -Name SiteUrl -Value $Site.Url
                $data1 | Add-Member -MemberType NoteProperty -Name SiteOwner -Value $Site.Owner.DisplayName
                $data1 | Add-Member -MemberType NoteProperty -Name WebUrl -Value $web.Url
                $data1 | Add-Member -MemberType NoteProperty -Name File -Value "$($webappUrl)/$($item.Url)"
                $data1 | Add-Member -MemberType NoteProperty -Name CheckedOutBy -Value $item.CheckedOutBy.DisplayName
                $Datacollection += $data1
            
            }       
        }
    
        $Lists = $web.GetListsOfType([Microsoft.SharePoint.SPBaseType]::DocumentLibrary) 
        foreach($list in $Lists)
        {
            foreach($item in $list.Items)
            {
                
                if($item.File.CheckedOutBy -ne $null)            
                {
                    $data2 = New-Object -TypeName PSObject
                    $data2 | Add-Member -MemberType NoteProperty -Name SiteUrl -Value $Site.Url
                    $data2 | Add-Member -MemberType NoteProperty -Name SiteOwner -Value $Site.Owner.DisplayName
                    $data2 | Add-Member -MemberType NoteProperty -Name WebUrl -Value $web.Url
                    $data2 | Add-Member -MemberType NoteProperty -Name File -Value "$($web.Url)/$($item.File.Url)"
                    $data2 | Add-Member -MemberType NoteProperty -Name CheckedOutBy -Value $item.File.CheckedOutBy.DisplayName
                    $Datacollection += $data2    
                }
            }       
        }
        
    }
    $SiteCounter++
    $Datacollection | Export-CSV C:\CheckedOutFiles_$Date.csv -Append -NoTypeInformation -Force    
}

    
