# Rails 101

## Table of Contents
- [Instroduction](#introduction)
- [Getting to know Rails with Active Record](#getting-to-know-rails---active-record)

## Introduction

To create a new Rails application, use the following command:
```
$ rails new rails_101
```
This command initializes a new Rails project named rails_101.

## Getting to know Rails - Active Record

To generate a new model named User with attributes name, email, and password, use the following command:
```
$ rails g model User name email password
```
This command creates a migration file to define the structure of the users table in the database.

Migration File:
`db/migrate/20240923020327_create_users.rb`

The generated migration file looks like this:
```ruby
class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
```

* __Migration Class__: The `CreateUsers` class inherits from `ActiveRecord::Migration[7.2]`, indicating that it is a migration for Active Record version 7.2.
* `change` __Method__: The `change` method defines the changes to be made to the database schema.
* __Create Table__: The `create_table :users` block creates a new table named `users` with the following columns:
  * **name**: A string column to store the users's name
  * **email**: A string column to store the user's email
  * **password**: A string column to store the user's password
  * **timestamps**: Two datetime columns, `created_at` and `updated_at`, which are automatically managed by Rails.
** 

__Migration file__
This migration file, when run, will create the `users` table with the spcified columns in the database

__User Model__
The `app/models/user.rb` file defines the `User` model:

```ruby
class User < ApplicationRecord
end
```
* __User Model__: This class inherits from `ApplicationRecord`, which means it is an Active Record model. This model will be mapped to the `users` table in the database

__Running the Migration__
To apply the migration and create the `users` table in the database, run the following command:
```
$ rails db:migrate
```
This command runs the migrations, updating the database schema to match the structure defined in the migration files.

__Using the Rails console__
To interact with the `User` model in the Rails console, follow these steps:
1. Open the Rails Console:

```
$ rails c
```
This command opens the Rails console, and interactive shell for working with your Rails application.

2. Create a New User:
```ruby
> user = User.new(name: "Mac", email: "roonglit@odds.team", password: "Password")
=> #<User:0x0000000128274678 id: nil, name: "Mac", email: "[FILTERED]", password: "[FILTERED]", created_at: nil, updated_at: nil>
```
This command creates a new instance of the `User` model with the specified attributes (`name`, `email`, and `password`).


__Saving a User__
```ruby
> user.save
  TRANSACTION (0.1ms)  begin transaction
  User Create (1.5ms)  INSERT INTO "users" ("name", "email", "password", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?) RETURNING "id"  [["name", "Mac"], ["email", "[FILTERED]"], ["password", "[FILTERED]"], ["created_at", "2024-09-23 02:18:56.276341"], ["updated_at", "2024-09-23 02:18:56.276341"]]
  TRANSACTION (1.1ms)  commit transaction
=> true
```
* __user.save__: This command saves the `users` object to the database.
* __Transaction__: The process begins with a transaction to ensure data integrity.
* __SQL Query__: An `INSERT` SQL query is executed to add the new user to the `users` table.
  * __Parameters__: The values for `name`, `email`, `password`, `created_at`, and `updated_at` are inserted.
  * __Filtered__: Sensitive information like `email` and `password` is filtered out in the logs for security reasons.
  * __Commit__: The transaction is committed, finalizing the changes to the database
  * __Return Value__: The method returns `true`, indicating that the save operation was successful.

__Creating a User__
```ruby
>  User.create(name: "Arthur", email: "arthur@camelot", password: "my_secret")
=> 
#<User:0x00000001284158d8
 id: 3,
 name: "Arthur",
 email: "[FILTERED]",
 password: "[FILTERED]",
 created_at: "2024-09-23 02:27:44.739964000 +0000",
 updated_at: "2024-09-23 02:27:44.739964000 +0000">
```
* __User.create__: This command creates a new `User` object and saves it to the database in one step.
* __Return Value__: The method returns the newly created `User` object.

__Retrieving All Users__
```ruby
> users = User.all
> users[0].name
  User Load (0.3ms)  SELECT "users".* FROM "users"
=> "Mac"

> users[1].name
=> "Arthur"
```
* __User.all__: This command retrieves all records from the `users` table.
* __SQL Query__: A `SELECT` SQL query is executed to fetch all users.
* __Accessing Attributes__: You can access the attributes of the retrieved users using array indexing.
  * __users[0].name__: Returns the name of the first user, which is "Mac".
  * __users[1].name__: Returns the name of the second user, which is "Arthur".

__Finding a User by ID__
```ruby
> user = User.find(1)
> user.name
=> "Mac"
```
* __User.find(1)__: This command retrieves the user with `id` 1 from the `users` table.
* __Accessing Attributes__: You can access the attributes of the retrieved user.
  * __user.name__: Returns the name of the user with `id` 1, which is "Mac".

__Updating a User__
```ruby
> user.update name: "Lancelot"
> user
#<User:0x00000001284f4100
 id: 1,
 name: "Lancelot",
 email: "[FILTERED]",
 password: "[FILTERED]",
 created_at: "2024-09-23 02:18:56.276341000 +0000",
 updated_at: "2024-09-23 03:27:20.085799000 +0000">
=> true
```
* __user.update__: This command updates the name attribute of the user object to "Lancelot".
Parameters: The method takes a hash where the key is the attribute to be updated (name) and the value is the new value for that attribute ("Lancelot").
* __Return Value__: The method returns true, indicating that the update operation was successful.

__Deleting a User__
```ruby
> user.destroy
> User.all.size
=> 1
```
* __user.destroy__: This command deletes the `user` object from the database.
  * __SQL Query__: An `DELETE` SQL query is executed to remove the user from the `users` table.
* __User.all.size__: This command returns the number of remaining users in the database.
  * __Return Value__: The method returns `1`, indicating that there is one user left in the database after the deletion.

__Finding a Deleted User__
```ruby
> user = User.find(1)
  User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
(rails101):27:in `<main>': Couldn't find User with 'id'=1 (ActiveRecord::RecordNotFound)
```
* __User.find(1)__: This command attempts to retrieve the user with id 1 from the users table.
  * __SQL Query__: A `SELECT` SQL query is executed to find the user with `id` 1.
* __Error__: Since the user with `id` 1 has been deleted, Active Record raises an `ActiveRecord::RecordNotFound` exception.
  * __Exception Message__: The error message indicates that the user with `id` 1 could not be found.