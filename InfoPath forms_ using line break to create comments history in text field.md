# Using line break in a text fiels with out XML data connection to create a comment history

The main idea of this process is to create a running commentary functionality in a text box. Every time a user performs an action a text comment will be added with date and time. This comment will move all the existing comments to next line in a text box, without using XML file as an external data connection. This method works only in a text box field, not in Rich Text field.

#### Instructions

1. Here I took 3 text fields and named them, Comment, Comment Store, Line Break Text Field.
2. **Comment** field is for the User to write comments.
3. **Comment Store** is to store the comment that a user inputs, its dynamic, Comment Store field changes every time Comment field is changed using a rule below.
4. 
5. Line Break Text Field displays all Previous Comments and Current Comment using CONCAT statement, in one box, with every comment in a new next line.
6. For this to work, right click on the Line Break Text Field and select Text Box Properties, Under Display tab make sure Multi-Line is checked, this will make Text Box to Multi-line text field.
7. Once this field is made multi line, write a rule to CONCAT Current comment which is stored and all the previous comments with a line break in between as below.
8. CONCAT (CommentStore, ";", "",LIneBreakTextFields) this is the statement I used, and in this CONCAT statement, place your cursor in between the empty double quotes and press, CTRL + Enter. This will move the data to next line and create a line break in a text field. See the picture below.
9. concat(CommentStore, ";", "",LineBreakTextFields)
10. You can add this rule to any button or any field based on your form logic and publish the form.
11. Below are how the form comments look, you type your comment in the Comment field and it gets saved in the Comment Store, usually you can hide that field from user.
12. Once you click Submit the comment gets concatenated to the previous comments as below.


Thank You

Sudheer Akurathi
