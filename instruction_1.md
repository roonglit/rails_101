# Instructions
### 1. Create a New Rails Application
Open your terminal and run the following command to create a new Rails application named `todo`:
```
$ rails new todo_app_2
$ cd todo_app_2
```
### 2. Generate the Todo Model
Generate a model named `Todo` with a `name` field
```ruby
$ rails generate model Todo name:string
$ rails db:migrate
```
### 3. Create 5 New Todos in Rails console
Open the Rails console:
```
$ rails console
```

In the Rails console, create 5 new todos:
```ruby
Todo.create(name: "Todo 1")
Todo.create(name: "Todo 2")
Todo.create(name: "Todo 3")
Todo.create(name: "Todo 4")
Todo.create(name: "Todo 5")
```
### 4. Change the Last Todo's Name
Find the last todo and change its name:
```ruby
last_todo = Todo.last
last_todo.update(name: "Updated Todo 5")
```
### 5. Delete the 3rd Todo
Find and delete the 3rd todo:
```ruby
third_todo = Todo.find_by(name: "Todo 3")
third_todo.destroy
```
### 6. Add Enum Status for Incomplete and Complete
Generate a migration to add a `status` field to the `todos` table:
```
$ rails generate migration AddStatusToTodos status:integer
$ rails db:migrate
```

Update the `Todo` model to include the enum for `status`:

```ruby
class Todo < ApplicationRecord
  enum status: { incomplete: 0, complete: 1 }
end
```
### 7. Set Default Value of the Todo Status to Incomplete
Generate a migration to set the default value of the `status` field to `incomplete`:
```
$ rails generate migration ChangeStatusDefaultOnTodos
```
Edit the generated migration file to set the default value:
```ruby
class ChangeStatusDefaultOnTodos < ActiveRecord::Migration[7.2]
  def change
    change_column_default :todos, :status, from: nil, to: 0
  end
end
```

Run the migration:
```ruby
$ rails db:migrate
```

### 8. List all Todo with only incomplete status
To list all `Todo` items with only incomplete  status, open the Rails console:
```bash
$ rails console
```
In the Rails console, run the following command:
```
incomplete_todos = Todo.incomplete
```
This will return all `Todo` items with the status set to `incomplete`.

### 9. List all Todo with only complete status
To list all `Todo` items with only complete status, open the Rails console:
```bash
$ rails console
```

In the Rails console, run the following command:
```
complete_todos = Todo.complete
```

This will return all `Todo` items with the status set to `complete`.

### Challenge!
Create a method in the `Todo` model that toggles the status of a todo item between `incomplete` and `complete`. Then, use this method in the Rails console to toggle the status of a specific todo item.
