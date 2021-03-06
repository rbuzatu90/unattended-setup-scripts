#!/usr/bin/python
import sys
from xmlrpclib import ServerProxy

if len(sys.argv) > 1:
    filename = sys.argv[1]
    with open(filename, 'rb') as f:
        text = f.read()
else:
    filename = 'stdin'
    text = sys.stdin.read()

s = ServerProxy('http://paste.openstack.org/xmlrpc/', allow_none=True);
id = s.pastes.newPaste(None, text, None, filename)

print 'http://paste.openstack.org/show/%s/' % id
