#!/usr/bin/awk -f
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


# irc-prettifier.awk
# Prettifies XChat scrollback from standard input.
# Use -v variable=value argument to set the variables, eg: -v limit=80 notime=yes
# Variables: limit - line length limit (-1 for no limit), sep - nick/message separator, notime - `yes' or `true' to hide timestamps

BEGIN{
	# Line length limit
	if (limit == "") limit = 110
	# Nick/message separator
	if (sep == "") sep = "│ "
}

{
	# Get rid of 0x08 and 0x0F characters
	gsub(/[\x08\x0F]/, "");
	# Get rid of colorcodes
	gsub(/\x03[0-9]*/,"");
	# Match timestamps
	match($0, /T ([0-9]*)(([^\t]*\t)?)/, a);
	# Replace tabs with nick/message separators
	gsub(/\t/,sep);
	# Parse timestamps
	if (notime !~ /(yes)|(true)/) time = strftime("%H:%M:%S", substr($0, a[1, "start"], a[1, "length"]));
	# Join the line together
	line = time sprintf("%15s", substr($0, a[2, "start"], a[2, "length"])) substr($0, a[2, "start"] + a[2, "length"]);
	# Print trimmed line if limit is set
	if (limit >= 0) print substr(line, 0, limit)
	# Or print not-trimmed line if the limit is not set
	else print line;
}
