#!/usr/bin/env python3

import telnetlib
import argparse
import os
import time
import sys

def write_string(tn, string, endchar):
    for c in string:
        tn.write(c.encode('ascii'))
        time.sleep(0.2)
    tn.write(endchar.encode('ascii'))

def main():
    pid = os.fork()

    if pid != 0:
        sys.exit(0)

    parser = argparse.ArgumentParser(description='Connect via telnet to DGS-3100 and configure to set up STP and LLDP')
    parser.add_argument('-c', '--config', dest='filename', action='store', help='Configfile for the switch', required=True)
    parser.add_argument('-s', '--switch', dest='host', action='store',help='IP address of the switch', required=True)
    parser.add_argument('-u', '--username', dest='user', action='store', help='Username', required=False, default='admin')
    parser.add_argument('-p', '--passsword', dest='password', action='store', help='Password',required=False, default='pp27tech#')

    args = parser.parse_args()

    filename = args.filename
    host = args.host
    user = args.user
    password = args.password
    
    print('Connecting to host: {}'.format(host))
    tn = telnetlib.Telnet(host)
    
    tn.read_until(b'UserName:')
    print('Connected!')

    print('Sending username: {}'.format(user))
    write_string(tn, user, '\r\n')
    
    tn.read_until(b'Password:')

    print('Sending passwoord: {}'.format(password))
    write_string(tn, password, '\r\n')

    tn.read_until(b'DGS-3100# ')
    print('Logged in! Sending commands. ')

    write_string(tn, 'create snmp system_name edge', '\r\n')
    tn.read_until(b'Success.')
    
    tn.close()
    print('Connection closed. ')

if __name__ == '__main__':
    main()
