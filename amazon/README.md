# Amazon setup

## Launch an instance:

*  From <https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:sort=instanceId>, launch an EC2 instance.
*  Step 1: Select 64-bit Ubuntu server 16.04
*  Step 2: select instance type 't2.large' (2 vcpus, 8G RAM), click button 'Next: Configure Instance Details'
*  Step 3: Click 'Advanced Details' at bottom. In the text box shown, insert the following text:

    #!/bin/bash
    curl https://get.docker.com | sh
    sudo usermod -a -G docker ubuntu
    sudo service docker start

then, click 'Next: Add Storage'

* Step 4: 'Storage' set size to 25

* Step 5: 'Add tags' - skip this step.  Click button 'Next: Configure Security Group'

* Step 6: 'Configure Security Group': Click 'Add Rule', and add:

    Custom TCP Rule      TCP      8787      Anywhere    0.0.0.0/0

* You're done.  Click 'Review and Launch', followed by Launch.

It'll ask you to select or create a new key pair.  Assuming you don't already have one, select 'Create a new key pair', and then download that keypair to your local computer.  Click 'Launch Instances'.

Click 'View Instances' at the bottom right of the page.   This will bring you to the EC2 dashboard.  You should see your new instance listed in the dashboard, and the column 'IPv4 Public IP' will contain the IP address that you'll use to connect to your instance using ssh to complete the configuration.

## Configure your EC2 Instance for the Single Cell Workshop

SSH to your instance using your key pair .pem file:

    ssh -i your_ssh_key.pem ubuntu@${IPv4_Public_IP}

using the IP address from the corresponding column in the EC2 dashboard as described above.

Complete the following steps below to pull down the code and data from github, pull down the Docker container, and launch the docker container.

### simple updates to the VM

    sudo apt-get update && sudo apt-get install -y python 


### pull single cell demo code from github

    git clone https://github.com/TimothyTickle/single_cell_analysis.git

### pull docker image from docker hub

    docker pull trinityctat/cegs_demo:latest


### Launch single container for testing

    docker run --rm -p 8787:8787 -v `pwd`/single_cell_analysis/src:/home/training/src:ro --name my_rstudio_docker trinityctat/cegs_demo

    (type cntrl-c to stop it once you're done)


## Run RStudio

From within your web browser, go to the link http://${IPv4_Public_IP}:8787 using your IP address, and the ':8787' indicates that it will connect to the port that RStudio listens to on your instance.

Assuming RStudio runs within your browser, it may prompt you for user/password, in which case you can use 'training/training'.

Now you're ready to run through the workshop exercises.  Good luck!


# Modifications to support multiple users on a single EC2 instance

If you're hosting a workshop containing a number of attendees, you can set up separate RStudio instances for each fo the attendees, all running from the same EC2 machine.  Each user will require ~5 GB RAM and ~2 cores, so when you launch an EC2 instance, choose a machine that's suitably sized for your workshop. If needed, launch multiple large machines and partition them among your students.

In this setting, you'll be launching a separate Docker container for each of your students, and each will be assigned to a different port.  In the example below, we'll assume 20 students, and we'll assign ports in the range of 9000-9019.  You can do this as follows:

*  When configuring your EC2 instance, under 'Configure Security Group' include the following open ports:

    Custom TCP Rule      TCP     9000-9019       Anywhere    0.0.0.0/0

*  Perform the 'git clone' and 'docker pull' commands as described above, but do *not* run the 'docker run' command. We'll launch docker containers differently below.

*  To launch a separate docker container for each student, run the following:

    ./single_cell_analysis/amazon/init_users.py  --num_users 20 --ip_addr ${IPv4_Public_IP} --user_id_start 1 --rstudio_base_port 9000 | bash

Then assign each of your students to an RStudio URL of the format:  http://${IPv4_Public_IP}:${port_no}  where each student is given a port number ranging from 9000 to 9019

## Removing user docker containers

If you ever want to stop and remove the various user docker containers, you can run:

    ./single_cell_analysis/amazon/remove_user_dockers.sh

which will stop and remove the docker containers.

