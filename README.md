# Epic Task: Create your own Ruby CLI

Create your own CLI that you are interested in. Be creative and use a site that is scrape friendly.

## Objectives

1. Build a menu that gives users the ability to pick and choose.
2. Construct Web Scraping Functionality.
3. Add user Authentication using BCrypt (login and sign up)
4. Add a logout option
5. Add a reset password option
6. Add technical documentation in the readme.md file

## Limitations

1. You cannot use any urls previously presented

## Technicals

1. cli.rb manages the display and input of text in the console
   * Provides a menu to authenticate
   * Provides a list of options once authenticated
   * Displays results of scraping
   * Allows exiting the program
2. scrape.rb manages the scraping of the data from a url
   * Accesses document with Nokogiri by opening url with OpenURI
   * Uses Ruby .css method on document to access specific elements
   * Loops through those elements and grabs the text from them
   * Finally, creates a new instance of either Game or Hunter for each item in the loop
3. game.rb and hunter.rb are classes to represent the data obtained from scraping
   * Both are initialized with empty class arrays to hold the resulting scraped items
   * Both have a class method to access the class array
4. user.rb manages authentication and the list/file of users and their encrypted passwords
   * Utilizes BCrypt to encrypt passwords for safe storage
   * Utilizes JSON to generate or parse an external File