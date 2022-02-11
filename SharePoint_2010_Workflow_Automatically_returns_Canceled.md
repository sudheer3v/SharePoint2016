# SharePoint 2010 Workflow Error
### Error: SharePoint 2010 Workflow Automatically returns Canceled

#### Issue Description:
> - Today, I want to talk about an issue that I faced recently in December 2021. This is about SharePoint 2010 workflow that was created and published in SharePoint 2016 environment back in May 2018. 
> - The issue is the workflow returns Canceled in the workflow status column. This happened all of a sudden.
> - This workflow is attached to a form library and it is set to trigger when an item is created or modified.
> - The functionality of the workflow is very basic, update the status column of an item/form to different stages, email different users about the updates in each stage, and change the permissions of an item/form depending on the stage of the item/form using impersanation steps.
> - The workflow doesn't log each and every step to the workflow history list so we don't know where exactly it is failing and returning canceled.
> - Because this is in production I did not edit the workflow to insert logging.

#### Troubleshooting
> - I recreated the error by submitting a new test form and it returned canceled. I went into the server and opened the ULS logs of that time frame. 
> - I used Microsoft USL Viewer(https://www.microsoft.com/en-us/download/details.aspx?id=44020) to view the uls logs because it let's me use multiple filters.
> - After searching a lot I found out that workflow is successfully completing the first three actions of the workflow. 
> - Those are (send an email to users to notify that the workflow started and change the status column of that item to Pending Manager Approval).
> - Once this step is completed the workflow will go into impersanation steps to change the permissions on the item/form according the stage it is in.
> - I didn't see any logs about this step so I assumed that it is failing at the Impersanation steps.
> - After so much of reading, I found an article that suggested me to republish the workflow so that the impersanation steps will be published again and make sure the account that is publishing the workflow has all the permissions to perform the impersanation steps.
 
#### Solution
> - I thought of giving this republishing a try, and I made sure I have full control and I republished the workflow and this fixed the issue.
> - I created another form and this time the workflow completed all the steps.
> - I later realized that, I unintentionally caused the issue. Back in May 2018 this workflow was published by one of my team member who is no longer working with us.
> - Because he is no longer with us I removed his id from the site permissions and this caused the impersanation steps to stop working.
> - Because I republished the workflow with my account and since I have all the required permissions, this time it worked successfully.

#lol

