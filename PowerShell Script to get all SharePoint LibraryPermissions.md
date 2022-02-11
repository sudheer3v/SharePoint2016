# PowerShell Script to get all SharePoint Library Permissions

  #Snap in
  Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue 

  $url = "https://contoso.com/sites/testsite"
  $listName = "Test1";

  $SPWeb = Get-SPWeb $url;
  $SPList = $SPWeb.Lists[$listName];

  #break inheritance
  $SPItem.BreakRoleInheritance($true)
  
  #Remove all Permissions  
  for ($i = 0; $i -lt $SPItem.RoleAssignments.Count; $i++)
  {
    try
    {
      $SPItem.RoleAssignments.Remove($i)
    }
    catch
    {
    }
  }
  $SPItem.Update()


