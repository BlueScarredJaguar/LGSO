#!/bin/bash

version=1.1

SRC_DIR="$HOME/.local/share/games"
NEW_DIR=""
OLD_DIR=""
COUNTER=0
OUTPUT=0
BACKUP=0

# Checks for update.
curl -s https://raw.githubusercontent.com/Tux1c/Tux1c.github.io/master/projfiles/lgso/version.txt | while read line; do
   if [[ $(echo "$version < $line"|bc) -eq 1 ]]; then
      echo "You LGSO version is outdated!"
      echo "You are using LGSO $version while the most recent version is $line"
      echo "It is important for you to keep that script up to date!"
      echo "Please visit https://github.com/Tux1c/LGSO and update to the latest version!"
   fi
done

# Checks if too many arguments were sent.
if [[ $# -gt 5 ]]; then
   echo "Too many arguments."
   exit -1
fi

# Reads arguments.
for i in $*; do
   if [ $i == -s ] || [ $i == -silent ]; then
      OUTPUT=-1
   elif [ $i == -v ] || [ $i == -verbose ]; then
      OUTPUT=1
   elif [ $i == -b ] || [ $i == -backup ]; then
      BACKUP=1
   elif [ $i == -d ] || [ $i == -dir ]; then
      echo dir
   elif [[ $i == *-* ]]; then
      echo "Unknown parameter $i, aborting."
      exit -1
   fi
done

# Checks if SRC_DIR exists, if not, creates it.
if [ ! -d "$SRC_DIR" ]; then
   mkdir $SRC_DIR
fi

if [[ $OUTPUT -ne -1 ]]; then
   echo "LGSO is now organizing your savefiles..."
fi

# Reads line by line from the online database.
curl -s https://raw.githubusercontent.com/Tux1c/Tux1c.github.io/master/projfiles/lgso/lgsolist.txt | while read line; do

   # Increases counter - needed to determine if the vars are ready to work with.
   let COUNTER=COUNTER+1

   # Checks if line is a name of a game.
   if [[ $line == *#* ]]; then
      NEW_DIR=$SRC_DIR/${line:2}
      if [[ $OUTPUT -eq 1 ]]; then
         echo "Destination path: $NEW_DIR"
      fi
   # Else, it will assume the line is a location of the game save.
   else
     OLD_DIR=$HOME$line
     if [[ $OUTPUT -eq 1 ]]; then
        echo "Source path: $OLD_DIR"
     fi
   fi

   # Runs check if: variables are ready to work with && LGSO wasn't applied to specific directory. Then creates a new dir (if needed), moves the files and creates a new symlink.
   if [ $((COUNTER%2)) -eq 0 ]; then
      if [ -d "$OLD_DIR" ] && [ ! -L "$OLD_DIR" ]; then
         if [ ! -d "$NEW_DIR" ]; then
            if [[ $OUTPUT -eq 1 ]]; then
               echo "Creating $NEW_DIR"
            fi
            mkdir $NEW_DIR
         fi
         if [[ $OUTPUT -eq 1 ]]; then
            echo "Moving $OLD_DIR to $NEW_DIR"
         fi
         cp -r $OLD_DIR/. $NEW_DIR
         if [[ $OUTPUT -eq 1 ]]; then
            echo "Creating symlink in $OLD_DIR to $NEW_DIR"
         fi
         rm -rf $OLD_DIR
         ln -s $NEW_DIR $OLD_DIR
      fi
   fi
done

if [[ $OUTPUT -ne -1 ]]; then
   echo "LGSO has moved $((COUNTER/2)) games".
fi

if [[ $BACKUP -eq 1 ]]; then
   if [[ $OUTPUT -ne -1 ]]; then
      echo "Backing up"
   fi
fi
