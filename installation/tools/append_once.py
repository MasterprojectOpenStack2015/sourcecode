#!/usr/bin/python

import sys
import os


if len(sys.argv) < 3:
    print("{} file comment".format(os.path.basename(__file__)))
    print("insert the stdin between the comment in file or append it to the start of the file")
    exit(1)

file = sys.argv[1]
comment = sys.argv[2]

if os.path.isfile(file):
    with open(file) as f:
        lines = list(f)
else:
    lines = []

# we iterate once over all lines
lines = iter(lines)

comment = comment.replace('\n', '').replace('\r', '')
comment_line_start = "# begin " + comment + " #\n"
comment_line_end   = "# end " + comment + " #\n"

with open(file, "w") as f:
    line = "\n"
    # write all lines until we reach the start comment
    for line in lines:
        if line.strip() == comment_line_start.strip():
            break
        f.write(line)
    # skip all lines until we reach the end comment
    for line in lines:
        if line.strip() == comment_line_end.strip():
            break
    # write start, content, end
    # from http://stackoverflow.com/a/17658680
    if not line or line[-1] != "\n":
        f.write("\n")
    f.write(comment_line_start)
    for line in sys.stdin:
        f.write(line)
    f.write("\n")
    f.write(comment_line_end)
    # write file content until end of file
    for line in lines:
        f.write(line)
    
        
    




