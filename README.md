XChat-Conky
===========

A Conky panel displaying last 10 messages from XChat scrollback of specific chat channel and topic of the channel (received from XChat via DBus).

This project is licensed under MIT license. Please see LICENSE.txt for details.

Requirements
------------
* Conky
* XChat
* DBus
* basic commandline programs: sh, awk, tail

Usage
-------
**How to run:**

Run ````xchat-conky.sh```` to make the panel appear when, and only when XChat is running

or ````conky -c conkyrc &```` to start the panel manually.

**How to turn off:**

If you runned ````xchat-conky.sh````, run ````xchat-conky.sh -k```` to turn off.

If you started the conky manualy, use ````killall conky````.
