# SP2016 Restore Error
### Error: You must first restore the original parent site in order to restore the site "SB2".

> - I recently came accross this incident in SharePoint 2016 where user claims he is missing some files. 
> - After some digging, I found those files in recycle bin. The user deleted the whole subsite called "SB2". 
> - I tried to restore the "SB2" from second-stage recycle bin (which is where I found this subsite), but it returned an error *You must first restore the original parent site in order to restore the site "SB2".*
> - ![Error Screenshot](https://github.com/sudheer3v/SharePoint2016/blob/56142c93b4b7ab37eb93fdbb18cb6f01a1e82776/src/images/RestoreError.png)
> - I observed the URL of the sub site in the recycle bin and found out the parent site which is also a sub site and it's called "SB1". 
> - I found out the "SB1" sub site in site contents of the site collection. I went into that sub site and the URL caught my eye because it is not the same as the URL that I saw in recycle bin. It was changed from SB1 to "S".
> - That is the reason the restore operation failed. It is failing to identify the parent site of "SB2".
> - I changed the URL of parent site from 'S' to 'SB1' and tried to restore the 'SB2' sub site and it successfully restored.
> - Then I restored all the files too.
