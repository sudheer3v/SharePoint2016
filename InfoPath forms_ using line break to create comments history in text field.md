Comments History or Running Comments.

To show new data or comments in a next line in a text box, without using XML file as an external data connection. This method works only in a text box field, not in Rich Text field.

1.      Here I took 3 text box fields and named them, Comment, Comment Store, Line Break Text Field.

2.      Comment field is for the User to write his comments.

3.      Comment Store is to store the comment that user inputs, its dynamic, Comment Store field changes every time Comment field is changed using a rule below.

No alt text provided for this image
 4.      Line Break Text Field displays all Previous Comments and Current Comment using CONCAT statement, in one box, with every comment in a new next line.

5.      For this to work, right click on the Line Break Text Field and select Text Box Properties, Under Display tab make sure Multi-Line is checked, this will make Text Box to Multi-line text field.

No alt text provided for this image
 

No alt text provided for this image
6.      Once this field is made multi line, write a rule to CONCAT Current comment which is stored and all the previous comments with a line break in between as below.

No alt text provided for this image
7.      CONCAT (CommentStore, ";", "",LIneBreakTextFields) this is the statement I used, and in this CONCAT statement, place your cursor in between the empty double quotes and press, CTRL + Enter. This will move the data to next line and create a line break in a text field. See the picture below.

No alt text provided for this image
concat(CommentStore, ";", "

",LineBreakTextFields)

8.      You can add this rule to any button or any field based on your form logic and publish the form.

9.      Below are how the form comments look, you type your comment in the Comment field and it gets saved in the Comment Store, usually you can hide that field from user.

10.  Once you click Submit the comment gets concatenated to the previous comments as below.

No alt text provided for this image
Thank You

Sudheer Akurathi
