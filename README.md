<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email, project_title, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->


![Adopt Dont Shop](https://github.com/elyhess/adopt_dont_shop/blob/main/banner.png)

<!-- TABLE OF CONTENTS -->

<summary><h2 style="display: inline-block">Table of Contents</h2></summary>
<ol>
  <li><a href="#about-the-project">About The Project</a>
  <li><a href="#project-board">Project Board</a></li>
  <li><a href="#database-schema">Database Schema</a></li>
  <li><a href="#built-with">Built With</a>
  <li><a href="#setup-instructions">Setup Instructions</a></li>
  <li><a href="#contact">Contact</a></li>
  <li><a href="#acknowledgements">Acknowledgements</a></li>
</ol>

<!-- ABOUT THE PROJECT -->
## About The Project

[Adopt Don't Shop](https://fathomless-inlet-21274.herokuapp.com/) is a module 2 solo project for Turing School of Software & Design's Back-End Engineering (BEE) program. Users are able to apply to adopt pets - admins can either approve or reject applications. In addition admins also see adoption statistics for shelters, pets, and applications in the system. User stories tracked using [Github projects](https://github.com/elyhess/adopt_dont_shop/projects/2).

### Skills Developed by Project
* Built out CRUD functionality for a many to many relationship
* Used ActiveRecord to write queries that join multiple tables of data together
* Used MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Validation of models & sad path handling
* Use of flash messages to give feedback to the user
* Use of partials in views
* Use of `within` blocks in tests
* Deployment of application to [Heroku](https://fathomless-inlet-21274.herokuapp.com/)

<!-- PROJECT BOARD -->
## Project Board
Check out [project board](https://github.com/elyhess/adopt_dont_shop/projects/2) for a complete list of features / user stories used to develop this application.

<!-- DATABBASE SCHEMA -->
## Database Schema
<p align="center">
  <img src="https://github.com/elyhess/adopt_dont_shop/blob/main/schema.png" />
</p>

<!-- BUILT WITH -->
## Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [Postgresql](https://www.postgresql.org/)


<!-- SETUP INSTRUCTIONS -->
## Setup Instructions
To get a local copy up and running follow these simple steps.

1. Clone the repo
   ```
   git clone https://github.com/elyhess/adopt_dont_shop
   ```
2. Install dependencies
   ```
   bundle install
   ```
3. DB creation/migration
   ```
   rails db:{create,migrate,seed}
   ```
3. Run tests and view test coverage
   ```
   bundle exec rspec
   open coverage/index.html
   ```
4. Run server and navigate to http://localhost:3000/
   ```
   rails s
   ```

<!-- CONTACT -->
## Contact

Ely Hess - Ely.hess@Me.com


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [README template](https://github.com/othneildrew/Best-README-Template)
* [Turing School of Software & Desion Project Repo](https://github.com/turingschool-examples/adopt_dont_shop)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/github_username


