# Rails 101

## Table of Contents
- [Instroduction](#introduction)
- [Getting to know Rails with Active Record](#getting-to-know-rails---active-record)
- [Associations](#associations)

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

__Finding a User by Parameter__
```ruby
> user.create name: 'Lancelot', email: 'lancelot@camelot.com', password: 'lancelot_secret'
> user = User.find_by name: 'Lancelot'
> user.name
=> "Lancelot"
```
* __User.find_by__: This command finds the first user in the database with the specified attribute (name: 'Lancelot')

__Finding Users by Parameter__
```ruby
> users = User.where name: 'Arthur'
> users[0].name
=> "Arthur"
```
* __User.where__: This command retrieves all users from the database with the specified attribute (name: 'Arthur')
  * __ActiveRelation__: The `where` method returns and `ActiveRelation` object, which is a lazy-loaded collection of records that can be further queried or manipulated. 

__Chaining Active Record Commands__ 
```ruby
> User.order(created_at: :desc)
> User.where(name: 'Arthur').order(created_at: :desc)
  User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."name" = ? /* loading for pp */ ORDER BY "users"."created_at" DESC LIMIT ?  [["name", "Arthur"], ["LIMIT", 11]]
```
* __User.where(name: 'Arthur').order(created_at: :desc)__: This command chains two ActiveRecord methods:

  1. __User.where(name: 'Arthur')__: Filters the users to only those with the name 'Arthur'.
  2. __order(created_at: :desc)__: Orders the filtered users by the created_at attribute in descending order.
    * __ActiveRelation__: Each method in the chain returns an ActiveRelation object, enabling the chaining of multiple query methods.
    * __SQL Query__: The generated SQL query is SELECT "users".* FROM "users" WHERE "users"."name" = 'Arthur' ORDER BY "users"."created_at" DESC.
    * __Return Value__: The method returns an array of User objects with the name 'Arthur', ordered by their creation date, with the most recently created users first.

## Associations
An association is a connection between two Active Record models. It makes common operations simpler and easier. 

```
$ ruby g model Room name description:text
```

```ruby
class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
```

The __`belongs_to`__ Association
```
$ ruby g model Message user:belongs_to room:belongs_to content:text
```

This command will generate a migration for creating messages table. 
```ruby
class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :room, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

```

also, a Message model is generated with belongs_to keyword.
```ruby
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
```

```
$ rails db:migrate
```

```ruby
$ rails c
> Message.column_names
=> ["id", "user_id", "room_id", "content", "created_at", "updated_at"]
```

```ruby
> user = User.find_by name: "Arthur"
> room = Room.create(name: "Campfire", description: "A safe place to share ideas")
> message = Message.create(user: user, room: room, content: "Hello World!")
> message.room_id
=> 1
> message.user
#<User:0x000000012a4371c0
 id: 3,
 name: "Arthur",
 email: "[FILTERED]",
 password: "[FILTERED]",
 created_at: "2024-09-23 02:27:44.739964000 +0000",
 updated_at: "2024-09-23 02:27:44.739964000 +0000">
```

The __`has_many`__ association


```ruby
class User < ApplicationRecord
  has_many :messages
end
```

```ruby
class Room < ApplicationRecord
  has_many :messages
end
```

* Association: The `has_many :messages` line establishes a one-to-many relationshiop between `Room` and `Message`. This means that a single user / single room can have multiple messages associated with it. 

```ruby
> user.messages
[#<Message:0x000000012a430280
  id: 1,
  user_id: 3,
  room_id: 1,
  content: "Hello World!",
  created_at: "2024-09-23 07:10:34.438750000 +0000",
  updated_at: "2024-09-23 07:10:34.438750000 +0000">]
```

__The `has_many :through` Association__

__Models Setup__

__User Model__
```ruby
class User < ApplicationRecord
  has_many :messages
  has_many :rooms, through: :messages
end
```

```ruby
$ rails c
> user = User.find_by name: 'Arthur'
> user.rooms
  Room Load (0.2ms)  SELECT "rooms".* FROM "rooms" INNER JOIN "messages" ON "rooms"."id" = "messages"."room_id" WHERE "messages"."user_id" = ? /* loading for pp */ LIMIT ?  [["user_id", 3], ["LIMIT", 11]]
=> 
[#<Room:0x000000012b5bc7d8
  id: 1,
  name: "Campfire",
  description: "A safe place to share ideas",
  created_at: "2024-09-23 07:02:16.883845000 +0000",
  updated_at: "2024-09-23 07:02:16.883845000 +0000">]
```

`user.rooms`, this command retrieves all rooms associated with the user 'Arthur'.

__Association with a Custom Word__

```ruby
class User < ApplicationRecord
  has_many :messages
  has_many :in_rooms, through: :messages, source: :room
end
```

* The `has_many :in_rooms` line creates a custom association name `in_rooms` instead of the default `rooms`.
* `through: :messages`: This specifies that the association should go through the `messages` table. Essentially, it means that to find the rooms a user is in, you should look at the messages they have sent.
* `source: :room`: This specifies the source of the association. In this case, it tells ActiveRecord that the `in_rooms` association should use the `room` association from the `Message` model


```
$ rails c
> user = User.find_by name: 'Arthur'
> user.in_rooms
=> 
[#<Room:0x000000011e13c148
  id: 1,
  name: "Campfire",
  description: "A safe place to share ideas",
  created_at: "2024-09-23 07:02:16.883845000 +0000",
  updated_at: "2024-09-23 07:02:16.883845000 +0000">]
```

__Why Use Custom Association Names and source?__
* Clarity: Custom association names can make your code more readable and expressive. For example, in_rooms clearly indicates that these are the rooms the user is participating in.
* Avoiding Conflicts: If you already have an association named rooms for a different purpose, using a custom name like in_rooms helps avoid conflicts.
* Flexibility: The source option allows you to specify the actual association to use, providing more flexibility in how you define relationships between models.