# metazploit_install
- This repo contains the files for installing metasploit in Ubuntu 14 and above.
- The metasploit mainly need java, ruby, nmap. 

Input : jdkx.x.x.tar.gz

Installation :

$ git clone https://github.com/sreeshk692/metazploit_install/

$ chmod +x metazploit_install.sh oracle_jdk_install.sh

$ ./metazploit_install.sh jdkx.x.x.tar.gz

- During installation, password will be asked, after that you have to configure 'postgressql' using commands mentioned in "postgres_db_config.txt" file
- Use the commands in that file.

- --After installation--

$ source ~/.bashrc

- After this all intallation will be completed.

$ msfconsole
