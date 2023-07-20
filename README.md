# About
This docker repository is the second patch of [gatsby-fork-docker](https://github.com/Shinya-GitHub-Center/gatsby-fork-docker), to focus onto the development on your local machine

## Easy to Learn!! - How DevOps cycle actually works
This docker may help you to make your projects automated but with a SLIGHT automation - A hint of automation  
Only the #1 of the following process would be automated, LOL

1. Git clone gatsby project from your own repository (at this point, the project is supposed to be finished trimming with the help of [gatsby-fork-docker](https://github.com/Shinya-GitHub-Center/gatsby-fork-docker), ready-to-develop status)
2. Develop on your local machine
3. Git push back to your remote 'origin' repository
4. You can delete your local repository whenever you want to, as long as you store the project on your remote repository
5. You can resume your development anytime by going back to process #1

## How to Use this docker
1. Download and unzip the source of this repository, then rename the root directory's name to your favorite one
2. If the project requires an additional file(s) such as `.env` file in order to be worked correctly, please locate the additional file(s) into `./gatsby-dev/.LocalDevFiles` folder
3. Modify the file `./gatsby-dev/variables.txt`
4. Go to the directory where the docker-compose.yml exists
5. `docker compose up -d`
6. `docker exec -it <your container name> bash`
7. Execute `dev-init.sh` script file
8. Go into the created repository
9. Develop and git push manually
10. When you finish your today's development, type `exit` to go back to your host machine, then you can do either `docker compose stop` or `docker compose down`. 
    * In the former case, you can resume your yesterday's work immediately by `docker compose up -d` then `docker exec -it <your container name> bash`
    * In the latter case, upon attaching to the docker container, please re-execute `dev-init.sh` in order to re-setup the environment. Unfortunately git credentials have to be set again - you will be prompted when you do git push again
    * In either case, your repository itself is kept safe storing at your host machine (Bind-Mounting)

## How to modify variables.txt
* REPODIR : set this to the same name as the repository name of RMT_REPO_ADDR (if they don't match, script command is not forwarded inside the repository automatically...)
* RMT_REPO_ADDR : your remote repository address
* GIT_UNAME : set your git user name
* GIT_UMAIL : set your git email address

## Development commands
* Develop command : `yarn develop --host 0.0.0.0`  
(required to add host option since this is  inside docker container)
* Run formatter : `yarn format`
* Build command : `yarn build`
* Check built contents : `yarn serve --host 0.0.0.0`
* Test command : `yarn test`
* Clear the cache : `yarn clean`
* Alternative command for develop : `yarn start --host 0.0.0.0`

## Using VSCode instead of using regular terminal
* You can also use VSCode together with Remote Containers plugin for this docker
* Git History plugin will be installed automatically upon executing the script
* Git credential information will be stored into the default `~/.git-credentials` file which is located at container's home directory.

1. Open root folder of this docker project via VSCode
2. If the project requires an additional file(s) such as `.env` file in order to be worked correctly, please locate the additional file(s) into `./gatsby-dev/.LocalDevFiles` folder
3. Modify the file `./gatsby-dev/variables.txt`
4. From VSCode's terminal, `docker compose up -d`
5. Attach to the container via Remote Containers plugin
6. You are now in the home directory of the container. From VSCode menu, click 'open folder' and set the directory to `/home/node/workdir/` and click ok
7. You are now in the workdir directory. Please execute `dev-init.sh` script file :
```
bash ./dev-init.sh
```
8. From VSCode menu, click 'open folder' and set the directory to `/home/node/workdir/<repository name>/` and click ok (VSCode does not allow you to move to the created respository, so you need to move yourself manually)
9. Develop and git push manually
10. When you finish your today's development, just close the VSCode's container window, and right click the contaier name at the original workspace and select 'stop container' or 'remove container'
11. I recommend to use this docker only for one gatsby project. If you want to develop other gatsby projects at the same time, please download zip file again and start over the process for your another project

## Notices
* If you want to modify or upgrade the base image of this docker, please log in as root user and run the command as root user. In the same manner, you can also modify Dockerfile directly, such as node.js version change.
```
docker exec -it -u root <your container name> bash
```
* Upon execution of the shell script files, if the same repository name is already created as indicated at `variables.txt` / REPODIR name, the process will be slightly modified in order to prevent from overriding the existing repository.
* Git credentials are going to be stored inside the docker container. I would recommend to `docker compose down` while you are away from this development for a period of time, in order to keep security.

## For your local memo
