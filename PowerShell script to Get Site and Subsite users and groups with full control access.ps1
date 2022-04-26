<#
    Created By: Sudheer Akurathi
    Created: Apr 18th 2022
    Description: This script scans the SharePoint Web App for Owners (Users and Groups with Full Contro Permissions level).
#>

Add-PSSnapin Microsoft.SharePoint.PowerShell   

#Date Stamp
$Date = get-date -f yyyy-MM-dd_hh-mm-ss

$Output="c:\temp\Get_Site_Subsite_Owners_ClaimsListData"+$Date+".csv";

$Datacollection = @()    

$Webapp= Get-SPWebApplication "enter your web app name"

foreach($Site in $Webapp.Sites)
{    
    foreach($Subsite in $Site.AllWebs)    
    {
        if($Subsite.HasUniqueRoleAssignments -eq $true)
        {
                
            $roleAssignments = $Subsite.RoleAssignments

            foreach($role in $roleAssignments)
            {
                
                if($role.RoleDefinitionBindings.Name -eq "Full Control")
                {                    
                    
                    If($role.Member.IsDomainGroup)
                    {                       
                       $Type="Domain Group"
                    }
                               
                    Elseif($role.Member.GetType() -eq [Microsoft.SharePoint.SPGroup])
                    {                         
                         $Type="SharePoint Group"
                    }
                    
                    else
                    {                           
                           $Type="User"
                    }                    

                    $Users = $null

                    foreach($member in $role.Member.Users)
                    {
                        
                        $Users += $member.DisplayName + ";"

                    }
                    
                    $permlevels = $null
                    
                    foreach($permlevel in $role.RoleDefinitionBindings.Name)
                    {                        
                        $permlevels += $permlevel + ";"
                    }

                    $data1 = New-Object -TypeName PSObject
                    $data1 | Add-Member -MemberType NoteProperty -Name SiteId -Value $Site.ID
                    $data1 | Add-Member -MemberType NoteProperty -Name SiteUrl -Value $Site.Url
                    $data1 | Add-Member -MemberType NoteProperty -Name SubsiteId -Value $Subsite.ID
                    $data1 | Add-Member -MemberType NoteProperty -Name SubsiteTitle -Value $Subsite.Title
                    $data1 | Add-Member -MemberType NoteProperty -Name SubsiteUrl -Value $Subsite.Url
                    $data1 | Add-Member -MemberType NoteProperty -Name IsSiteCollection -Value $Subsite.IsRootWeb
                    $data1 | Add-Member -MemberType NoteProperty -Name OwnerName -Value $role.Member.Name
                    $data1 | Add-Member -MemberType NoteProperty -Name PermissionType -Value $Type
                    $data1 | Add-Member -MemberType NoteProperty -Name PermissionLevel -Value $permlevels
                    $data1 | Add-Member -MemberType NoteProperty -Name UsersInGroups -Value $Users
                                        
                    $Datacollection += $data1
                }
            }
        }               
    }   
}
$Datacollection | Export-CSV -notype -path $Output  
#$Datacollection | Out-GridView
