# SP2016 Restore Error
### Error: You must first restore the original parent site in order to restore the site "SB2".

I have recently came accross this incident in SharePoint 2016. A user raised an incident saying he is missing some files. 
I went into recycle bin and found out that the user deleted the whole subsite called "SB2". I also found the files of that subsite "SB2". 
The parent site of this "SB2" is also a sub site and it's called "SB1". I found all the contents of "SB2" in the Site Collection level recycle bin but I found this "SB2" sub site in second-stage recycle bin.
I tried to restore the "SB2" from second-stage recycle bin, but it returned an error *You must first restore the original parent site in order to restore the site "SB2".*
I started troubleshooting from the top level site, I went into site contents of each site and observed the subsites and found out that "SB1" subsite url was changed from SB1 to "S".
That is the reason the restore operation is failing to identify the parent site of "SB2".
I changed the URL of parent site from 'S' to 'SB1' and tried to restore the 'SB2' sub site and it successfully restored.
