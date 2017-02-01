#!/usr/bin/env python
# encoding: utf-8

from __future__ import (absolute_import, division,
                        print_function, unicode_literals)
import os, sys, re
import logging
import argparse
import subprocess

logging.basicConfig(stream=sys.stderr, level=logging.INFO)
logger = logging.getLogger(__name__)



def main():

    parser = argparse.ArgumentParser(description="instantiate user spaces", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    
    parser.add_argument("--num_users", type=int, default="", required=True, help="number of users")
    parser.add_argument("--ip_addr", type=str, required=True, help="IP address for server")
    parser.add_argument("--user_id_start", type=int, required=True, help="index to start user IDs (ex. 1)")
    
    parser.add_argument("--rstudio_base_port", type=int, default=10001, help="base port for rstudio")

    args = parser.parse_args()

    
    rstudio_user_port = args.rstudio_base_port

    users_basedir = os.path.abspath("user_spaces")
    if not os.path.isdir(users_basedir):
        os.makedirs(users_basedir)

    #print("sudo chown -R training user_spaces")
    #print("sudo chgrp -R training user_spaces")

    user_id_start = args.user_id_start
    
    for i in range(user_id_start, user_id_start + args.num_users):
        
        # create user directory
        user = "user_{:02d}".format(i)
        user_dir = os.path.sep.join([users_basedir, user])
        if not os.path.isdir(user_dir):
            os.makedirs(user_dir)
            
        cmd = str("docker run " +
                  " -v /home/ubuntu/single_cell_analysis/src:/home/training/src:ro " +
                  " -p {}:8787 ".format(rstudio_user_port) +
                  " --name rstudio_{} -d trinityctat/cegs_demo".format(user))

        print(cmd)

        print()

        rstudio_user_port += 1
    
    sys.exit(0)
 
####################
 
if __name__ == "__main__":
    main()
