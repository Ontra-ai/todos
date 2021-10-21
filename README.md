# Test Automation Engineer Challenge

## The Application Under test

Hiya!   Our developers have been hard at work building a cutting edge, state of the art Todo web application.   It really is the Todo application to end all todo applications and we can't wait to release it into the world.   However, we have a problem.   Our developers, while exceptionally talented, are also exceptionally lazy and declined to include any automated tests in their deliverable and now all of those jokers are on vacation!   Can you believe that?  I don't know who approved that, but the fact is, we can't, in good conscience, put our amazing application into the world without having an automated test suite.   That just won't do.   Maybe you can help us?

## The Challenge

In terms of application architecture, what we have is a typical MVC/CRUD Rails 6 app that serves a JSON API to a React front-end.   We'd like to develop a test suite that covers our back-end components, specifically **models and controllers** as well as the **end-to-end user flows**.   For the purpose of this exercise, we can skip writing React unit tests because ain't nobody got time for that.   

The RSpec and Capybara testing frameworks have been preconfigured inside of the project, however you are welcome to install and use alternative testing frameworks.   For example, MiniTest instead of RSpec, or Cypress or Selenium instead of Capybara.  But whatever you do, don't use Cucumber 🤮.  In the default setup, the directory structure for adding tests is in place and all that's left for you to do **fork this repo** is add tests.  

## Stories
The product team has put together a set of stories that describe various workflows in the application.  The developers, to the best of their knowledge, have dutifully implemented these workflows, or at least that's what the manual QA engineers tell us.   But because manual testing can be error prone, it's possible they missed something.   The only way we can know for sure is by building an automated test suite to verify this is the case.   

One last thing.  We're not 100% sure if the stories below cover all the workflows in the app.   Be on the lookout for workflows that aren't captured below, and write tests accordingly.   Please report back should you discover anything we missed.

### Home page
```
As a user
When I go to the home page
I am presented with a welcome message and a link to the log in page
```

### Log in page
```
As a user
When I go to the log in page
Then I am prompted to login
```

```
As a user
Given I am on the log in page
And I enter in a valid e-mail and password and click the log in button
Then I am redirected to the "My Todo Items" page
```

```
As a user
Given I am on the log in page
And I enter an invalid email address or password and click the log in button
I see an error alert that indicates I have entered an invalid email or password
```


```
As a user
Given I am on the log in page
And I click the "Sign up" link
Then I should be redirected to the Sign up page
```

## Sign up page

```
As a user
Given I am on the Sign Up page
Then I am prompted to enter in a valid e-mail address, password, and password confirmation
```

```
As a user
Given I am on the Sign Up page
And I enter in a valid e-mail address
And I enter a valid password
And I enter a matching confirmation password
And I click the sign up button
Then I am redirected to the "My Todo Items" page
And I see an info alert that welcomes the user
```

```
As a user
Given I am on the Sign Up page
And I enter in an e-mail that already exists in the system
And I enter a valid password
And I enter a matching confirmation password
And I click the sign up button
Then I am still on the sign up page
And I see an error message indicating the e-mail has been taken
```

```
As a user
Given I am on the Sign Up page
And I enter in a valid e-mail address
And I enter a valid password
And I enter a different confirmation password
And I click the sign up button
Then I am still on the sign up page
And I see an error message
```

## My Todo Items page
```
As a newly created, authenticated user
Given I am on the My Todo Items page
Then my todo item list should be empty
```

```
As a user
Given I am on the My Todo Items page
Then I am prompted to enter a todo item
```

```
As a user
Given I am on the My Todo Items page
And I enter text into the todo form
And I click the "Add To Do Item" button
Then I see that todo item added to the my todo item list
And its status is incomplete
And the todo item text is editable
And the todo item may be completed by clicking the check box.
And the todo item may be deleted by clicking the delete button
```


```
As a user
Given I am on the My Todo Items page
When I enter whitespace into the todo form
And I click the "Add To Do Item" button
Then I see an error alert that reads something to the effect of "Title can't be blank"
```

```
As a user
Given I am on the My Todo Items page
When I enter nothing into the todo form
And I click the "Add To Do Item" button
Then I see an error alert that reads something to the effect of "Title can't be blank"
```

```
As a user
Given I am on the My Todo Items page
And I have previously entered a todo item
When I change my todo item's text
Then the text should automatically be saved
And should be persisted across page refreshes
```

```
As a user
Given I am on the My Todo Items page
And I have previously entered a todo item
When I check the complete check box next to my to do item
Then its status should reflect as completed
```

```
As a user
Given I am on the My Todo Items page
And I have previously entered a todo item
When I click the delete button
Then it should be deleted
And it should be removed from the list
```

```
As a user
Given I am on the My Todo Items page
And I have previously entered multiple todo items
And have marked some of them as complete
When I click the "Hide Completed Items" button
Then the completed items should be hidden from view
And When I click the "Show Completed Items" button
Then the completed items should re-appear
```


## Application Environment Setup

### Running Native

As previously mentioned, this is a vanilla Rails/React app with a SQLite database.  As such, the required system dependencies are fairly minimal and easy to install on MacOS or Linux.  In a nutshell, those dependencies amount to:

- Ruby 2.6.8
- NodeJS 14.x
- Sqlite3
- ...and all of their dependencies.

If you already have these installed on your system, you should be good to go.  Once you've cloned this repo, the following commands will get you up and running:

Install gem dependencies
```sh
bundle install
```

Install node modules
```
yarn install --frozen-lockfile
```

Initialize the database
```
bundle exec rails db:prepare db:seed
```

Launch the web app
```
bundle exec rails s -b 0.0.0.0
```
Verify the app is up and running at http://localhost:3000


Run tests
```
bundle exec rspec
```

### Using Docker Compose
If you'd prefer not to muddy your system up with a bunch of dependencies, we have provided a Docker Compose environment that conveniently has the necessary dependencies pre-installed into a container for you.  All you need to install is Docker.   To use this environment, run the following commands from the project root:

Initialize the database
```sh
docker-compose run todos bundle exec rails db:prepare db:seed
```

Launch the web app  
```sh
docker-compose up -d
```
Verify the app is up and running at [http://localhost:3000](http://localhost:3000)

Run tests
```sh
docker-compose run todos bundle exec rspec
```