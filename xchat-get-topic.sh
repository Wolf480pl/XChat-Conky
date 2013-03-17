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


# xchat-get-topic.sh
# Reads the channel topic from XChat via DBus and prints it to standard output
# Syntax: xchat-get-topic.sh <network> <channel> <length limit>

# Find the context connected with specified network and channel
context=`dbus-send --dest=org.xchat.service --print-reply --type=method_call /org/xchat/Remote org.xchat.plugin.FindContext string:"$1" string:"$2" | tail -n1 | awk '{print $2}'`
# Set the context to the context found in previous line
dbus-send --dest=org.xchat.service --type=method_call /org/xchat/Remote org.xchat.plugin.SetContext uint32:$context
# Get the channel topic
dbus-send --dest=org.xchat.service --print-reply --type=method_call /org/xchat/Remote org.xchat.plugin.GetInfo string:"topic" | awk -v limit=$3 '{if ($0~/string/) {$1=""; match($0, /\"(.*)\"/, a); printf substr(substr($0, a[1, "start"], a[1, "length"]),0,limit)}}'
