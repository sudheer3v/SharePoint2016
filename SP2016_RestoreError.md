# SP2016 Restore Error
## Error: You must first restore the original parent site in order to restore the site "XXXXXX".

I have recently came accross this incident in SharePoint 2016. A user deleted a subsite called "SB2" which contains some files and folders. The parent site of this "SB2" is also a sub site and its called "SB1". I found all the contents of "SB2" in the Site Collection level recyclebin and I found this "SB2" sub site in second-stage recycle bin. 

> I tried to restore the "SB2" from second-stage recycle bin but it returned an error *You must first restore the original parent site in order to restore the site "SB2".*
