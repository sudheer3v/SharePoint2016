# PowerShell Script to get all ID's of Sites and sub sites in SharePoint.

    #Snap in
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

    $webapp = Get-SPWebApplication -Identity Intranet

    foreach($sitecoll in $webapp.Sites)
    {
        $site = Get-SPSite $sitecoll.Url
        $web = Get-SPWeb $sitecoll.Url
        write-host "Site: " + $site.id
        write-host "Web: " + $web.id

        $web.Dispose()
        $site.Dispose()
    }
