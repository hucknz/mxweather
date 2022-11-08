# Cumulus MX Weather Station app

## Overview
Cumulus MX is a cross platform version of Cumulus software that runs on Microsoft Windows, all varieties of UNIX and Linux (including the Raspberry Pi Operating System), and Mac OS X. Learn more here: https://www.cumuluswiki.org/a/Main_Page

## Usage
1. Ensure Docker is installed and configured on the host machine (I recommend using DockSTARTer if you want an easy way to get started with Docker)
2. Clone the docker-compose.yml and .env files to your local machine
3. Modify the .env file to suit your environment
4. Important: If you're not using USB passthrough make sure to remove the "devices" section from the docker-compose.yml file (see Known Issues)
5. Run `docker compose up` to start the container

## First Run
1. On the first run of CumulusMX the Installation wizard will need to be run. This can be started by navigating to the following `http://{serveraddress}:8998/wizard.html`
2. Once the wizard is completed, you will be prompted to restart CumulusNX. Restart the container using the command `docker restart MXWeather`
3. The restart will prompt the `Cumulus.ini` file to be written. At shutdown of the service, the Cumulus.ini file will be copied to the `./config` folder. When the container is restarted, the Cumulus.ini file will be copied back to the `/opt/CumulusMX` directory from the `/opt/CumulusMX/config` folder.

Note: config changes won't be committed to the INI file outside the container unless the container receives a SIGTERM. The config file is persistent inside the container until the container is rebuilt or updated.

## Known Issues:
* If using the USB build and `/dev/hidraw0` device is not present the container will fail to start.

# Container builds
The upstream repo for Cumulus MX is checked daily for new releases. When a new release is identified the build process should automatically trigger and commit a new build to https://hub.docker.com/r/hucknz/cumulusmx

# Thanks

All credit goes to [@optoisolated](https://github.com/optoisolated/MXWeather) for their work in containerising Cumulus MX and providing helpful documentation. 
