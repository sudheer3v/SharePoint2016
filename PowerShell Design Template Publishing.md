#Snap in
Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

$webUrl = "https://contoso.com/teams/testtemplate2"
$web = get-spweb $webUrl
$folder = $web.GetFolder("_catalogs/masterpage/Display Templates")
$subfolders = $folder.SubFolders

foreach($sub in $subfolders)
{
    if($sub.Name -eq "Content Web Parts")
    {
        $sub.Files | ?{ $_.Item -ne $null -and $_.Item.Properties["HtmlDesignLockedFile"] -eq $null -and $_.MinorVersion -ne 0 } | %{
        Write-Host ("Publishing {0}" -f $_.Url);
        $_.Publish("design package deployment");
        }
    }
}
