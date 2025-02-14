# cicd-pipeline

1. In Github (code repository), manually create a new repository in Github with a read me file.

2. In Github, manually update and check in the read me file.

3. On your file system, go to c:\code to clone the repository. Type: 'git clone {github https link}'. This will create a new folder in the c:\code directory with the repository name and the updated read me file. cd into that repository name.
  
4. Follow the following link to 1. create a Docker Hub (docker image repository) account and install Docker Desktop on your system (Both only needs to be done once) and 2. to create a simple node/express application and to check into your new repository.
   a. https://medium.com/@muhammadnaqeeb/dockerizing-a-node-js-and-express-js-app-9cb31cf9139e

5. git add . || git commit -m "message" || git push || to pull the latest code use git pull

6. Make sure Docker Desktop is running. Docker Desktop allows you to execute your Docker image, that is your code, in your local enviroment.

The following steps are with this video https://www.youtube.com/watch?v=BDGTIM8fTUc

7. Open VSCode, open the diretory where the new repository is (from the c:\\code\\{new repository}\\) type, 'code .'

8. In VSCode, in the base directory create a new folder called '.github/workflows'. Create a new file in that directory called: ci.yml

9. In this file you will 1. Login to your Docker Hub, 2. Build the Docker image and 3. Push the newly created image to your Docker Hub repository.

10. Add the secrets (Docker Hub username and password to your Docker Hub account) to Github.

11. Add a repository into your Docker Hub account. This is where all of your Docker images will be kept. Name the new Docker Hub repository the same name as the Github repository.  

12. To test the ci.yml Github action, update the read me file and check in the code. Github should run the ci.yml and build and push the Docker image to your Docker Hub account in your Docker Hub repository.  

13. Login to AWS and create an EC2 instance. An EC2 instance is virtual server in Amazon's Elastic Compute Cloud (EC2), which  is a service that allows users to rent virtual computer. Name the EC2 instance same as the Guthub repository.  

14. When creating the EC2 instance, create a new Key Pair that will give you access to this EC2 instance. Name the Key Pair the same as the Github repository. Use default settings and click the Create Key Pair button.  

15. The private key of the pair has been generated and downloaded in your Downloads folder. Copy the private key and move it to your c:\privateKeys directory. The public key remains with the EC2 instance in AWS. 

16. When continuing to create the EC2 instance, allow all traffic options when creating the firewall security group. To complete the EC2 instance, click the Launch Instance button.  This should start the EC2 instance.

17. In the c:\privatekeys directory, right click on the newly created .pem file; click properties, security, advanced and 1. Click the Disable inheritance button, 2. Delete all other permissions, 3. Click the Add button, 4. Click Select Principle, 5. In the text area add lukaneek@gmail.com and give full access. This will give your private key the proper permissions to access your EC2 instance in AWS.

18. In the same c:\privatekeys directory, enter (as an example) 'ssh -i "cicd-pipeline.pem" ubuntu@ec2-3-16-70-222.us-east-2.compute.amazonaws.com' to login into your EC2 instance.

19. Once logged into your new EC2 instance you want to update the latest libraries on the instance. This is only done one time; Type: 'sudo su', then 'sudo apt update', and finally 'sudo apt-get upgrade -y'. This will update the ec2 instance with the latest libraries that it was created with.

20. On your EC2 instance type: 'cd ~' to get to the base directory.

21. Your EC2 instance needs two different libraries installed on it. This is only done one time; 1. Github self-hosted runner application to download the GitHub action cd.yml (not yet created) and run it. 2. Docker, to run the docker image, your code, in the docker container.

22. In Github, create a self-hosted Runner. Go to Github, Settings, Action, Runners. Click the Create self-hosted Runner button. Chose Linix as the runner image (its what our EC2 instance uses). Copy and paste each command in the Download section ONLY and paste in the EC2 instance.
    a. A Github runner is a machine that executes jobs in the Github workflow. Our EC2 instance will be that machine. A self-hosted runner connects to Github to receive job assignments. The self-hosted runner uses an HTTPS long poll that opens a connection to Github for 50 seconds, and if no response is received, it then timesout and creates a new long poll. The runner app must be running on the machine to accept and run Github actions.

23. Before when you copy and past commands from the Runner Configure section, to get the first command to work you have to first execute 'export RUNNER_ALLOW_RUNASROOT="1"' command on the EC2 instance. Then copy the first Configure section command and add 'RUNNER_ALLOW_RUNASROOT="1"' to the start of the command. Run the command. Finally, you can execute the './run.sh' command to start the runner application. This will allow you see the output running when you check code into Github. Run './svc.sh' to run the runner application as a service so whenever the server restarts the runner application will restart.

24. In order to have the runner application continue to run, set up the runner service.  First, install the service with user as root by typing './svc.sh install root'.  Next run the service by typing './svc.sh start'.
Note: When logging into the EC2, If any work needs to be done on the runner application you must be a super user and to become a super user type 'sudo su'.

24. In VSCode, create the cd.yml file. When code is checked in to GitHub the ci.yml file will run and after it is complete this cd.yml file will run. The EC2 instance, acting as a self hosted runner will download the cd.yml file and 1. Pull the Docker Image from your Docker Hub account and repository, 2. Delete the Old Docker container running on the EC2 instance in the Docker you installed, 3. Run the new Docker image that was just pulled on the EC2 instance in the Docker you installed.

25. On your EC2 instance stop the action runner. Type: 'cd ~' to get to the base directory.
    
26. Install Docker on the EC2 instance. Follow steps 1, 2 and 3 in the "Install using the apt repository" section on this page https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository.

27. Start the action runner by changing directories and running the runner 'cd action-runner' and './run.sh'.

28. Checking in code in Github should trigger the CI/CD pipeline and have your latest code running on your EC2 instance.

29. On the EC2 instance, test to see if the request works. Once you get the success message that the new image has been download and running, use 'sudo docker ps' to see the docker image running. Type 'curl 0.0.0.0:8080' to see the response from your program. i.e., "hello world". 

30. Now you have to install nginx for a reverse proxy. Type 'cd ~' to get to base directory, then type 'sudo apt install nginx' to install nginx.  

31. Get the docker container id by typing 'docker ps'.

32. The following command will retrieve the private ip address of the docker container. "sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {docker container id}". 

33. The output should be your private docker container ip address. 

34. To edit the default nginx configuration file change diretory to the following: 'cd /etc/nginx/sites-available/' 

35. Copy the IP address of your docker container.  

36. Edit the default nginx configuration file: 'sudo nano default'

37. Navigate to the location section and enter the following: 'proxy_pass http://{ip address}:8080;' then save and exit file.  

38. Restart nginx to apply the changes. systemctl restart nginx 

39. Open a new tab and enter your public ipv4 url address of your EC2 instance.  The browser should now show "hello world". (DO NOT CLICK THE LINK IN AWS, COPY AND PASTE IT INTO THE NEW TAB.)

EXTRAS:
At this point you can use your browser to reach your application (running on EC2) by using Amazon's lengthy IPV4 address. No one will remember that. What should happen is that you want to connect an easliy rememberable Domain Name (ie, lukavujasin.tech) to point to your EC2 instance automatically. Follow the directions here on how to do it: https://www.freecodecamp.org/news/how-to-connect-a-domain-to-a-website-hosted-on-aws-ec2/









