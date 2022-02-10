#PowerShell to publish design tempaltes and page layouts in SharePoint
#Snapin
Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

$site = "https://contoso.com/teams/testtemplate2/"

$SPSite = Get-SPSite $site
$PublishingSite = New-Object Microsoft.SharePoint.Publishing.PublishingSite($SPSite)

$SPWeb = Get-SPWeb $site
$PublishingWeb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($SPWeb)


$pages = "https://contoso.com/teams/testtemplate2/_catalogs/masterpage/Display Templates/Content Web Parts/testList.html"

$pages | ForEach-Object {$item = $SPWeb.GetListItem($_)

if ($item.File.CheckOutType -ne "None")
    {
        $item.File.CheckIn("checked in", "CheckIn");
    }
    if ($item.Versions[0].Level -ne "Published")
    {
        $item.File.Publish("published");
    }

}

