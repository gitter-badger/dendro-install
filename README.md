# Contents



#	What is Dendro?

The Dendro platform is a completely open-source platform designed to help researchers describe their datasets, fully build on Linked Open Data. It is designed to capture data and metadata during the research workflow. Whenever researchers want to publish a dataset, they can export to repositories such as [CKAN](http://ckan.org/), [DSpace](http://www.dspace.org/), [Invenio](http://invenio-software.org/), or [EUDAT's B2Share](https://www.eudat.eu/services/b2share). Any repository can be added by writing small plug-ins.

It is under development at [Faculdade de Engenharia da Universidade do Porto](https://www.fe.up.pt/)'s [Infolab](http://infolab.fe.up.pt) since 2013. If you are interested in the academic foundations and innovations behind Dendro, please check out our **publications** at the [Dendro official website](http://dendro.fe.up.pt).


You are free to use Dendro to build any service for your research group or institution.

#Demo instance

**See the [DEMO PAGE](http://dendro.fe.up.pt/demo).** If it is down, please file an [issue](https://github.com/feup-infolab-rdm/dendro/issues/new).

# What is this package?

This package allows you to

 * Install and try out [Dendro](http://dendro.fe.up.pt/blog/index.php/dendro/) without having to write any code
 * We use a [virtual machine](https://en.wikipedia.org/wiki/Virtual_machine) inside your computer and not your real computer.
   * No garbage is installed on it
   * When you are done, just delete the virtual machine, and nothing will remain.

## Requirements

* All OS's
	* **2GB of free memory for the Virtual Machine**

* Mac OS X
	* 10.6.x+

* Linux (Any Debian-derived distro)
	* Ubuntu and Linux Mint
	* Tested on Debian Jessie

* Windows 7+

## Dependencies

Dendro relies on

 * OpenLink Virtuoso for the database layer
 * ElasticSearch for free text searching
 * MongoDB and its GridFS system for scalable file storage
 * NodeJS and ExpressJS for the server side
 * Twitter Boostrap

#	Installation Tutorials on YouTube

| Users            | Developers                                                                              |
|--------------------|------------------------------------------------------------------------------------------|
| Want to try Dendro? Watch the video below. It is intended to get you up and running with a fully configured Virtual Machine that you can destroy after you are done. | Interested in developing for the Dendro platform? You should follow the video for Regular Users before setting up the VM for development. |
| [![YouTube installation tutorial for Dendro](http://i.imgur.com/3r1lfot.png)](https://www.youtube.com/watch?v=YEKQ1InfmOE) | Run `./install.sh -d` on the `dendro-install/` after following the normal tutorial. |

# Step by step instructions



## For users

1. **Download and install the _latest versions_ of:**
	*	[OracleVirtualBox](https://www.virtualbox.org/)
	*	[Vagrant](https://www.vagrantup.com/downloads.html)

	*	> #####**DO NOT** use packaged versions from your Linux Distro, as they are often outdated and will not work. On Debian-based distros you can use `$ sudo gdebi <package.deb>` to install `.deb` packages.
	* 	[Git](https://git-scm.com/downloads)

2. **Check that everything is working**
	* On Windows, press Windows+R, type `powershell.exe`, press Enter
		* Paste: `vagrant -v; VBoxControl.exe -v; git --version`
	* On the Mac or in Linux, open your Terminal application
		* Paste: `vagrant -v; VBoxManage -v -v; git --version`
		* You should see the versions of the installed programs.

3. **Installing with default settings**
	* Cloning (Mac + Linux)

		Open Terminal and paste the following:

		```bash
		git clone https://github.com/feup-infolab-rdm/dendro-install.git;
		cd dendro-install;
		chmod +x ./install.sh;
		exec ./install.sh
		```
	* Cloning using Powershell (Windows)

		Press Windows+R, type `powershell.exe`, press Enter and paste the following:

		```powershell
		git config --global core.autocrlf false
		git clone https://github.com/feup-infolab-rdm/dendro-install.git
		git config --global core.autocrlf true
		cd dendro-install\windows
		.\install.bat
		```

4. (optional) **Customize the installation**
	* Edit the `constants.sh` file if you want to customize the installation
	* You may want to change the following parameters:
		* Root passwords for all services (MySQL, ElasticSearch, Virtuoso...) are specified in `constants.sh`
		* `svn_user` + `svn_user_password` --> Until we have a public GitHub repository, these are the credentials for accessing the private Subversion repository at FEUP
		* `emailing_account_gmail_user` + `emailing_account_gmail_password`  
			* Credentials of a GMail account for sending emails such as password resets
		* You will find what needs to be changed by searching for the `FIXME_____` keyword within `constants.sh`

5. **Access your new Dendro installation**
	* The default credentials for the administrator are:
		`user: admin`
		`password: admintest123`

## For developers

Developers need to make some changes to the virtual machine that is generated by the Vagrant scripts above to set up their development environment.

###Script arguments

 - `-d` : **Set up the VM for development**. Needed to make the VM open all ports of its servers to the outside world. or a server. This will allow you to work on your host machine, use the editor and debugger you want to develop for Dendro, while having all the dependencies neatly running on your VM. When you need to reset everything, simply delete the VM and start over. DO NOT RUN ON A PRODUCTION MACHINE.
 - `-r` : **Refresh the existing installation**. Only code and ontologies will be reloaded, but no dependencies will be installed. Useful when testing to not instal Virtuoso from source every time as it takes long).
 - `-c` : **Install TeamCity**. Installs TeamCity 10.0.4 into the VM or a server.
 - `-a` : **Install TeamCity Build Angent**. Needed to make the TeamCity Server run build jobs on the server. TeamCity will not work without installing a Build Agent.
 - `-t` : **Run Tests**. Updates the code and runs tests on Dendro.
 - `-j` : **Install Jenkins**. Install the Jenkins platform.
 - `-b < branch_name >` : **Install a branch of Dendro**. Installs Dendro with the branch < branch_name > into the VM or server.
 
These flags are valid for both Windows and Linux/Mac installations
 
####For the curious
If you want to know what the `./install.sh -d` command does, see the video below. Because following this video took too much of an effort every time we wanted to setup a machine for development, we have decided to automate those steps in the installation script with the `-d` flag.

[![YouTube Development setup tutorial for Dendro](http://i.imgur.com/Z7I9B98.png)](https://www.youtube.com/watch?v=baEsv-KTK8w).

# Acknowledgements

This work was supported by project NORTE-07-0124-FEDER-000059, financed by the North Portugal Regional Operational Programme (ON.2-O Novo Norte), under the National Strategic Reference Framework (NSRF), through the European Regional Development Fund (ERDF), and by national funds, through the Portuguese funding agency, Fundação para a Ciência e a Tecnologia (FCT). João Rocha da Silva was also supported by research grant SFRH/BD/77092/2011, provided by the Portuguese funding agency, Fundação para a Ciência e a Tecnologia (FCT).

This work is financed by the ERDF – European Regional Development Fund through the Operational Programme for Competitiveness and Internationalisation - COMPETE 2020 Programme and by National Funds through the Portuguese funding agency, FCT - Fundação para a Ciência e a Tecnologia within project POCI-01-0145-FEDER-016736.

<img src="https://github.com/feup-infolab-rdm/dendro-install/raw/master/logos.jpg">

# License

All source code is freely available under a standard [BSD 3-Clause license](https://opensource.org/licenses/BSD-3-Clause).

Copyright (c) 2016, João Rocha da Silva, FEUP InfoLab

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
