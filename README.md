# Rnters - Backend Code Challenge


## Creation of users


I've created a migration in order to create the users table, with the attributes "first_name:string", "last_name:string", "admin:boolean" and the timestamps, which could be useful in a real-world application ("created_at:datetime" and "updated_at:datetime").


The defined routes (resources: users) are inside the namespaces "api" and "v1"... The available routes are constructed to allow us creating, showing the all the records and showing specific records.

It was necessary to create a model referring to the users, which was created under the name "User". The model has validations, with the attributes "first_name" and "last_name" not being allowed to be blank.

It also includes attr_accessible, defining which attributes are permitted to be defined when posting the data.

In the controller, the action "create" defines a new user, based upon the "user_params", which is a function that points to the model's attr_accessible and allows that specific attributes to be defined.

Íf the user is successfully saved, it will be rendered json, with the "created" status coming as a response.

Otherwise, the response will be a bad request (for example, a user like {first_name: '', last_name: ''} is a bad request).

## Getting all the users

In order to test the creation and update after 30 seconds of all the users, I've created another endpoint, (get '/api/v1/users').


Inside the controller's action, all the users are gathered (by calling the function "get_users") and used to be rendered as JSON. The status is 200, if any records are found.


## Getting a specific user

This API also allows us to get a specific user, via the following endpoint (get '/api/v1/users/:id').

Inside the controller, the function "get_user" is called before any action occurs. It's not called individually inside "show" because, in a more extensive API (that would contain actions like updating and destroying records) it would also be used, so in this way we don't have the need to call it several times.




## Adding a moustache after 30 seconds
As it is a feature wanted to each record only one time, I felt I needed to do something after the creation of each instance. So, I've included in the model a function under the name "add_moustache" that is fired when a record is created (after_create). I've built an asynchrounous job, that waits 30 seconds after the each creation event to be performed. The job goes under the name "UpdateUserJob" and simply updates the user's last name, adding a moustache after it.


## Securing the API

I've added another class ("ApiKey") with the attribute "access_token:string" and the timestamps being the attributes added.

The objective was to build an authentication token, so I could secure the API in order to prevent access to everyone except those who have a valid token.

Inside the corresponding model, there is a private method named "generate_access_token", in which a random hexadecimal string is generated. It has a condition to stop the generation, that has the objective of avoiding repeated tokens.

Then, in the controller (commented) there is a function ("restrict_access") called before any action is taken. Inside the function, it is compared the header 'Authorization-token' with the registers in the database and then if the token doesn't exist in the DB, the sent status is 401 (unauthorized).


Another (simplistic) way of securing the API is also commented in the controller with the instruction "http_basic_authenticate_with name: 'rnters', password: 'sign€d'", which forces us to login as that user and to know that password in order to access the API functionalities.


## Notes

The templates for the user updating and destroying are also included in the controller, so if we wanted to add those actions we only would need to uncomment them.


The docker-compose file had a problem in the "worker" container, caused by the lack of a defined "working_dir".