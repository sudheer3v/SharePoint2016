### PowerShell script to Get CheckedOut Files from SharePoint2016 WebApp in CSV file format.

As part of our SharePoint 2016 to SharePoint Online Migration process, our first task was to collect all the data from SP 2016 for analysing. We used [SharePoint Migration Assessment tool] (https://docs.microsoft.com/en-us/sharepointmigration/overview-of-the-sharepoint-migration-assessment-tool) to collect data for the entire farm. This SMAT tool contains Checked Out Files report too but because our SP 2016 farm was so big the tool always gets stuck while running the Cheked Out Files report. SO we had no option but to go with PowerShell script. 

This PowerShell script will give you a list of checked out files in your entire SharePoint 2016 Web Application in a CSV file format. 

One of the main reasons of getting this checked out files report is, most of the migration tools cannot migrate checked out files, so this report helps users to see which files are checked out in their site and gives then an opportunity to decide and check in those files back so that they get migrated to the target environment. 

This report will have details like SiteUrl, SiteOwner, WebUrl, File, CheckedOutBy. You also need farm admin level access to get all the files.

    #PowerShell SharePoint Snapin
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

    
