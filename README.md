# Lumastic
Last revision on 7/6/18 by Drew Lytle
## Who We Are
### Our Mission
Lumastic has two organizational missions:
1. Create a positive and sustainable evolution in education for all.
2. Enable teammates to fulfill their dreams.

Every decision we make is based on what will help us complete those two missions *simultaneously*.  Both are essential to the well-being of the company and its members.  Neither one is worth completing without the other.

## Project Description
Lumastic is an online learning tool where teachers can flip their classrooms, track student learning and participation, and sell additional learning resources to other teachers or students.

[View the AdobeXD Prototype (Password: Lumastic1234)](https://xd.adobe.com/view/8b14feb3-d85f-42f4-55ce-ff877f2043a5-fd25/)
[View the Business Plan](https://docs.google.com/document/d/1oTVtZjsgA98P2BRpPWLxomp3ZmPDBMP_lfGZM-U13dU/edit?usp=sharing)

## Codebase Information
Lumastic is built on the Ruby on Rails framework with the following versions:
* Ruby 2.5.1
* Rails 5.2.0

The dependencies and configuration of the application are all handled through a *docker container*.  Therefore, *Docker and Docker Compose* must be installed on your computer for the application to run.  The `Dockerfile` is in the root of the project and should remain unchanged for a majority of development.

## How To Start Developing
### Installing Ruby on Rails
*Mitigating confusion*:  Ruby and Rails are two different pieces of software.  Ruby is a language and Rails is a framework for that language.  Hence the name, Ruby on Rails.

There are a lot of resources for installing `ruby` and `rails`.  I'll list the ones I found helpful here, but this should be a simple google.
#### Ruby
[Mac OS X](https://gorails.com/setup/osx/10.13-high-sierra)
[Linux](https://tecadmin.net/install-ruby-on-rails-on-ubuntu/)

### Installing Docker and Docker Compose
#### Windows
Just don't.  Use a virtual installation of Linux.
#### Mac OS X
If you're on a Mac, you can *simple download Docker CE* (Community Edition) and go through your *normal application setup* process as outlined in the documentation.  Docker for Mac *already comes with Compose options*.  So, once it installs, you're all set!

[Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
#### Linux/Ubuntu
As with all things, the setup process for Docker and Compose on Linux is a little more convoluted.

The following instructions were taken from the [Docker Docs](https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository) page on 7/14/18.  If something doesn't work, refer to that guide for more up-to-date information.

Run the following commands:
1. Update the `apt` package index:
```
$ sudo apt-get update
```
2. Install packages to allow `apt` to use a repository over HTTPS:
```
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```
3. Add Docker’s official GPG key:
```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Verify that you now have the key with the fingerprint `9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88`, by searching for the last 8 characters of the fingerprint
```
$ sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```
4. Use the following command to set up the *stable* repository.
```
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```
5. Update the `apt` package index.
```
$ sudo apt-get update
```
6. Install Docker CE
```
$ sudo apt-get install docker-ce
```
7. Download the latest version of Docker Compose:
```
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```
8. Apply executable permissions to the binary:
```
sudo chmod +x /usr/local/bin/docker-compose
```
You should now, hopefully, have Docker and Docker Compose running on your machine.  Again, if anything is screwy, just head over to the updated documentation from [Docker Docs](https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository).
### Getting up and Running
#### Cloning the repository
Clone the repository and checkout the `develop` branch using the following commands (or your preferred git client)
```
git clone https://github.com/aml3ed/lumastic.git
cd lumastic
git fetch
git checkout develop
```
##### NOTE: Running Commands
Since the application is being run in a virtual environment, **one can not simply run rails commands in the project folder**.  Before any command, we must specify which container the command should run inside.

For example, to migrate the database, we would run the command:
```
docker-compose run web rails db:migrate
```
This tells `docker-compose` to `run` the `web` container and perform the `rails db:migrate` action inside of it.  Without doing this, changes made to the project might not be reflected in the docker container or the code-base.  So, better safe than sorry.
#### Creating the local database
Now that you have all of the project files, you need to create the database for rails to connect to.  You can do this by running the following commands:
```
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```
If you want to seed the database using the `seeds.rb` file, run the following:
```
docker-compose run web rails db:seed
```
#### Devise Secret Key
Navigate to the `/lumastic/` directory and run the following command:
```
docker-compose up
```
This will initiate the virtual environment and also start the rails server.  However, **there will probably be an error with the devise configuration**.  Devise is used for user authentication and requires a `secret key` for encryption.  This key is not kept in our repository and is therefore not setup upon cloning it.  So, add the line it recommends to create the key in `config/initializers/devise.rb`.
#### Run it, baby!
Once all of that is setup, re-run:
```
docker-compose up
```
You should now be able to view the application by navigating to `localhost:3000/` in your browser.
### Rebuilding the Container
If any changes are made to the `Gemfile` or the `Dockerfile`, the project must be rebuilt.  The command to rebuild the containers is:
```
docker-compose build
```

NOTE: If adding gems, this command should be performed AFTER running:
```
docker-compose run web bundle install
```
### Teammate Tools
#### Github
When developing with a team, the Github repository for the project can get a little insane.  To combat this, please keep the following guidelines in mind:
1. **Never** develop directly on the `master` branch (the master branch should house a fully working version of the application at all times)
2. When starting new work, make a new branch with the following naming convention:  `'firstname'_'feature'_'sprintNumber'`
3. Comment at the top of anything you add / change with a brief paragraph that answers:
  * What is the change / addition?
  * What does it do?
  * What additional work needs to be done?
4. After making the first push to a new branch, create a pull request on GitHub with the following:
  * Reviewers - either aml3ed or dclark43
  * Assignees - yourself
  * Labels - *Work in progress* if the branch is incomplete and *In review* if the branch is ready to merge

*With these guidelines in mind, merges will be much quicker and it will be easier to onboard new developers.*
#### Slack
Slack will be the primary means of online communication between the team.  Slack is an intelligent group-chatting application that offers great features for team and project organization.

*Workspaces* (like Lumastic) have a variety of *Channels*.  Each channel is basically a group chat but for a more specific purpose.  Teammates can create channels for specific features, actions, or just to talk to each other.  It's pretty intuitive once you get going.

Here are some example channels for Lumastic:
* *Standup* - This channel is for sprint standup meetings in which teammates update others on the progress of their tasks by answering: 1. *What I've done*  2. *What I'm working on now*  3. *What I need help with*
* *PlsHelp* - This channel is for asking questions and getting assistance from teammates.
NOTE: Once you have fixed your issue, edit your original post with a "WE GOOD:" to let others know.

[Download Slack](https://slack.com/downloads/) and [Join the Workspace](https://join.slack.com/t/lumastic/shared_invite/enQtMzkzOTkzNjYzOTcxLWVkNTRlN2Y5YTgyM2ZjNTAwY2U2YjcxMTRhNjVlZmJjNTY1MGFhNTJlZGJjZmZiOWI3MjI3ZTRmODQ5ZWVkOTU)
