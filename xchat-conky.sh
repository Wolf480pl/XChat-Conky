#!/bin/sh
# Copyright (c) 2013 Wolf480pl (wolf480@interia.pl)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# xchat-conky.sh
# Makes sure XChat Conky panel is running when and only when XChat is running.
# When invoked without arguments, switches itself to background.
# Options:
# -b - don't switch to background
# -k - kill all instances of this script and all conkys

if [ "$1" = "-k" ]; then
    NAME=`basename $0`
    killall $NAME conky
    exit
fi

if [ "$1" != "-b" ]; then
    $0 -b &
    exit
fi

while :
do
    XCHAT_PID=`pidof xchat`
    if [ "$(pidof xchat)" ] && ! [ "$(ps $XCHAT_PID |grep -i \<defunct\>)" ]; then
        if [ -z $CONKY_PID ] || ! [ "$(ps $CONKY_PID)" ] || [ "$(ps $CONKY_PID |grep -i \<defunct\>)" ]; then
            sleep 2
            conky -c ./conkyrc &
            CONKY_PID=$!
        fi
    else 
        if [ -n "$CONKY_PID" ]; then
            kill $CONKY_PID
            CONKY_PID=""
        fi
    fi
    sleep 1
done
