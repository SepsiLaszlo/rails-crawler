# Rails Crawler
This application crawls the official Rails repository throughout the GitHub API. It lists the open pull requests and shows which pull request have files that have been changed by multiple commits.
```sh
   _      _
  (<      >)
   `O,99,O`
  //-\__/-\\  
```

## Set up
The application uses `ruby 2.7.1`. You can install the correct ruby version natively or use it with RVM:
```sh
rvm use 2.7.1
```

Then install the dependencies:
```sh
bundle install
```

Set up the database:

```sh
rails db:setup
```

Now you can start the rails server:
```shell
rails server
```

Check the application on http://localhost:3000