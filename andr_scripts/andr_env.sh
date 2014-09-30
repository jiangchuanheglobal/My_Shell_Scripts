# android auto get, build, install tool
# by jiangchuan

## major function
# 1. download sdk manager  
# 2. download or update package and tools
# 3. install ant
# 4. create new project
# 5. project management

## menu
#===================================
# install env
# uninstall env
# update env
#===================================

#! /bin/zsh

# prerequired command

COMMAND_ZSH='zsh'
COMMAND_BREW='brew'

command -v $COMMAND_ZSH >/dev/null 2>&1 || { echo >&2 "I require $COMMAND_ZSH but it's not installed.  Aborting."; exit 1; }
command -v $COMMAND_BREW >/dev/null 2>&1 || { echo >&2 "I require $COMMAND_BREW but it's not installed.  Aborting."; exit 1; }

# brew install android-sdk
ANDR_SDK='android-sdk'
ANDR_PLATFORM_TOOL='android-platform-tools'

ANDR_SDK_PATH='/usr/local/Cellar/android-sdk/*/bin'
ANDR_PLAT_PATH='/usr/local/Cellar/android-sdk/*/tools'
ANDROID_HOME='/usr/local/Cellar/android-sdk'

brew install $ANDR_SDK
brew install $ANDR_PLATFORM_TOOL

echo "add android sdk path to your environment"
echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.zshrc
echo "export PATH=\$PATH:$ANDR_SDK_PATH" >> ~/.zshrc
echo "export PATH=\$PATH:$ANDR_PLAT_PATH" >> ~/.zshrc

# download a certain package
android list sdk --all --extends
android update sdk --filter tools,platform-tools,build-tools-19.0.3

# get ant
brew install ant












