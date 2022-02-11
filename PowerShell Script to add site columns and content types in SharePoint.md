# PowerShell Script to add site columns and content types in SharePoint

 
Script to Create Site Columns, Site Content Types and Assign Site Columns to Content Types
First Connect to Site https://contoso.com/teams/site1
- Create all the Site Columns you need for all your lists
- Create all the Content types you need for your lists
- Assign all the site columns to site content types

    #snap in
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

#Connect to the Site Where you want to add Site Content Types
Connect-PnPOnline -Url https://contoso.com/teams/site1

#To Add Site Column to the Site
Add-PnPField -DisplayName "Size" -InternalName "Size" -Type Number -Group "My Columns" -Required 

#To Add New Content Types to Group and Parent as Item
Add-PnPContentType -Name "My Content Type" -Description "Custom Content type" -Group "My CT Group" -ParentContentType $Item

#To Add Site Column to Content Type
Add-PnPFieldToContentType -Field "Size" -ContentType "My Content Type" 
Add-PnPField -DisplayName "WebAppName" -InternalName "WebAppName" -Type Text -Group "My Columns" -Required 
Add-PnPFieldToContentType -Field "WebAppName" -ContentType "My Content Type" 
Add-PnPField -DisplayName "DB Status" -InternalName "DB Status" -Type Choice -Group "53 Columns" -Required -Choices "Full","Open"
Add-PnPFieldToContentType -Field "DB Status" -ContentType "My Content Type" 
