# PowerShell script to add or remove a js file from a SharePoint site using PnP PowerShell

    #Add Snapin
    Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

    #TargetSite is where you want to deploy the js file
    $TargetSite = "https://contoso.com/teams/test1"

    #HostFile is the location where you save/store the js file
    $HostFile = "https://contoso.com/teams/test/Style%20Library/testjsfile.js" 

    #establish a connection
    Connect-PnPOnline -Url $TargetSite

    #To add a js file to a site
    Add-PnPJavaScriptLink -Name testjsfile -Url $HostFile -Scope Site
    #Add-PnPJavaScriptLink -Name testjsfile -Url https://contoso.com/teams/test/Style%20Library/testjsfile.js -Scope Site

    #To remove a js file from a site
    #Remove-PnPJavaScriptLink -Name SecondaryNavBar -Scope Site
