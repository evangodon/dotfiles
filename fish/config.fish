set -Ua fish_user_paths $HOME/.cargo/bin
set -Ua fish_user_paths /usr/local/go/bin

# Java
set JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -Ua fish_user_paths $JAVA_HOME/bin

set ANDROID_HOME $HOME/Android/Sdk
set -Ua fish_user_paths $ANDROID_HOME/emulator 
set -Ua fish_user_paths $ANDROID_HOME/tools 
set -Ua fish_user_paths $ANDROID_HOME/tools/bin 
set -Ua fish_user_paths $ANDROID_HOME/platform-tools 

set fish_greeting ""

bind \co ranger-cd

starship init fish | source





