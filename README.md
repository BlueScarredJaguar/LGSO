LGSO
====

### What is LGSO?

With the new arrival of Steam games to the GNU/Linux platform, came the unorganized Windows-ish file-structures of the games, which got scattered all around your hard drive without you having a clue what is actually going on.
The GNU/Linux community is not familiar with this behaviour.  
Although as users we can't do much about it, I have decided to write a simple Bash script to try and organize the game saves to a new folder - a standard I wish to set (if/when this script gets popular, GNU/Linux game developers will follow this standard and use **SRC_DIR/games** as their default game save files location).  
  
So essentially, LGSO takes all of your game saves and stores them in **SRC_DIR/games** under their names, and creates a symlink instead of the original game directories, which point to the new directory that was created in **SRC_DIR/games**.

##### What is SRC_DIR?
SRC_DIR is a variable that either follows your $XDG_DATA_HOME, or, incase that you didn't set your $XDG_DATA_HOME variable, it will use $HOME/.local/share instead. 

##### Why $HOME/.local/share/games?
As **$HOME/.local/share** is a system-wide directory that appears on **every** GNU/Linux distribution, I have decided to use the said directory. Although, if for some reason you are **not** satisfied with the said location, you can easily edit the script and replace the location as it is set in the **SRC_DIR** variable.

### How to install
####Recommended way:  
Head to [https://github.com/Tux1c/LGSO/releases](https://github.com/Tux1c/LGSO/releases) and download and unpack the latest release.  
  
####Alternative way (will download the latest version automatically, but there is no guarantee that this version is stable):
> git clone https://github.com/Tux1c/LGSO.git  
chmod +x lgso.sh  
./lgso.sh

If you want to make LGSO a command, simply run
> sudo mv lgso.sh /usr/bin/lgso

Refer to the wiki for extra flags you can use with LGSO.

### How to contribute?
If you have ideas regarding the improvement the code, please post a pull request.  
If you have a game save location to suggest, please use the "SAVE" tag and use the following structure:  
Name of the game:  
Platform (Steam, GOG, etc.):  
Full save location: (i.e. $HOME/game)  
For everything else, use the correct tag.
