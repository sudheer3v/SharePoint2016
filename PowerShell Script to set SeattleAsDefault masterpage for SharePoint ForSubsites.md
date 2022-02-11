# PowerShell Script to set Seattle Master Page as default for all sub sites in SharePoint

    #Snap in
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue  

    #Enter the Site Collection URL
    $site = "https://contoso.com/teams/testtemplate2/"
    $SPSite = Get-SPSite $site
    $SPWeb = Get-SPWeb $site

    foreach($subweb in $SPSite.AllWebs)
    {
        if(!($subweb.IsRootWeb))
        {
            $subweb.Url
            $subweb.MasterUrl
            $subweb.CustomMasterUrl
            $subweb.AlternateCssUrl
            if(!($subweb.MasterUrl -eq "/teams/testtemplate2/_catalogs/masterpage/seattle.master"))
            {
                $subweb.MasterUrl = "/teams/testtemplate2/_catalogs/masterpage/seattle.master"
                $subweb.Update()
            }
            if(!($subweb.CustomMasterUrl -eq "/teams/testtemplate2/_catalogs/masterpage/seattle.master"))
            {
                $subweb.CustomMasterUrl = "/teams/testtemplate2/_catalogs/masterpage/seattle.master"
                $subweb.Update()
            }
            $subweb.Url
            $subweb.MasterUrl
            $subweb.CustomMasterUrl
        }
    }

