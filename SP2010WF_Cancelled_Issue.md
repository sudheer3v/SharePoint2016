# SharePoint 2010 Workflow Error
### Error: SharePoint 2010 Workflow Automatically returns Canceled

> - Today, I want to talk about an issue that I faced recently. This is about one of my SharePoint 2010 workflow that I published in SharePoint 2016 environment started failing all of a sudden. 
> - The workflow is set to trigger when an item is added or updated.
> - The first and second actions of the workflow are to send an email to the requestor and manager of the item to notify that the workflow started.
> - The third step is to change the status column of that item to Pending Manager Approval.
> - Once this step is completed. The workflow impersanation steps will trigger.
> - Each Status column value has a set of impersanation steps to change the permissions on the item.
> - Because this is in production I did not edit the workflow.  

