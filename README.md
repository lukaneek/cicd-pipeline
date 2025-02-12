# cicd-pipeline

1. create new repository in github with a read me

2. update and check in read me file in github.

3. go to c:/code and then type git clone github https link. This will create a new folder with the repository name. cd into that repository name.  Make sure docker desktop is running

4. https://medium.com/@muhammadnaqeeb/dockerizing-a-node-js-and-express-js-app-9cb31cf9139e (Link for setting up project and docker hub)

5. git add . || git commit -m "message" || git push || to pull the latest code use git pull

next steps are with this video https://www.youtube.com/watch?v=BDGTIM8fTUc

6. create ci.yml file 

7. add secrets to github

8. add a repository into dockerhub this is where all the images will be kept for the github repository code.  Name the dockhub reposiotry the same as the github repository .  

9. update the read me file and check in the code.  Github should run the ci yml and build and push the image to dockerhub.  

10. login to aws and create an ec2 instance.  Name the ec2 instance same as the guthub repository.  

11. when creating the instane create a new key pair for access to this ec2 instance.  Name the key pair same as github repository.  Use default setting and click create key pair button.  

12. when creating the ec2 instance, allow all traffic options when creating fire wall security group.  and click launch instance button.  This should start the ec2 instance.

12. the private key has been generated and downloaded in the dowloads folder.  Copy the private key and move it to c:/privateKeys directory.  

13. right click on the pem file, click properties, security, advanced, disable inferitince, delete all permissions.  Click add button, click select princible, then in the text area add lukaneek@gmail.com and give full access.  

13. cd into the privateKeys directory, enter (ssh -i "cicd-pipeline.pem" ubuntu@ec2-3-16-70-222.us-east-2.compute.amazonaws.com) in command line to login.  we have now logged into our ec2 instance

14. to update the lastest and greatest on the ec2 instance type in sudo su, then sudo apt update, sudo apt-get upgrade -y.  This will update the ec2 instance. 

15. next you create a runner in github.  these commands will be copied over to our ec2 instance.  go to github, settings, action, runners, click on the create self-hosted runner button.  chose linix as the runner image.  Copy and paste each command in download section and paste into ec2 instance.  

16. when you get to configure, to get the first command to work you have to first execute export RUNNER_ALLOW_RUNASROOT="1" command on the ec2 instance.  then copy the first configure command and add RUNNER_ALLOW_RUNASROOT="1" to the start of it.  then run it.  finally you can execute the run.sh command.  

17. create cd.yml

18. install docker on ec2 instance.  first step type in  cd ~ to get to base directory.  follow steps 1, 2 and 3 on this page https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository






