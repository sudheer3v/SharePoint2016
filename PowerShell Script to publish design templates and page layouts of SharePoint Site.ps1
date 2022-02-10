#PowerShell Script to publish design templates and page layouts of SharePoint Site

#snap in
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

#Enter the Site Collection URL
$site = "https://contoso.com/teams/testsite2/"
$SPWeb = Get-SPWeb $site
#==>Push down CSS to All subsites<==#
 
#MAKE SURE THE BELOW PATH HAVE THE SITE COLLECTION NAME
$csspath = "/teams/testsite2/Style Library/custom.css"
Get-SPSite $site | Get-SPWeb -Limit All |% { $_.AlternateCssUrl = $csspath;$_.AllProperties["_InheritAlternateCssUrl"] = $true;$_.Update() }


#==>Publish Design Templates and Page Layouts of the Design Package<==#
#NOTE: The below Script works for both design templates and page layouts#

#PAGE LAYOUTS: MENTION BOTH HTML AND ASPX FOR PAGE LAYOUTS
               #EXAMPLE: "http://yoursitecollection/_catalogs/masterpage/customPageLayout.html","http://yoursitecollection/_catalogs/masterpage/customPageLayout.aspx"
#DESIGN TEMPLATES: MENTION THE CORRECT PATH OF DESIGN TEMPLATES
               #EXAMPLE: "http://yoursitecollection/_catalogs/masterpage/Display Templates/Content Web Parts/filename.html"


$pages = "https://contoso.com/teams/testsite2/_catalogs/masterpage/Display Templates/Content Web Parts/testList.html"

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



#==>ONLY DESIGN TEMPLATES PUBLISHING<==#
#USE THIS IF THE ABOVE SCRIPT DON'T WORK#
<#
$folder = $SPWeb.GetFolder("_catalogs/masterpage/Display Templates")

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
#>
