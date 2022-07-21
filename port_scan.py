#!/usr/bin/python
# -*- coding: UTF-8 -*-
# -*- support python version 2 -*-
from threading import Thread
import time
import socket
import sys

##
DEB = False  # True
RUN = True

##
_host_name = 'baidu.com'
_from_port = 20
_to_port = 81
_threads_count = 6
_soc_timeout = 1.0

##
argc = len(sys.argv)
if argc > 1:
    _host_name = sys.argv[1]
if argc > 2:
    _from_port = int(sys.argv[2])
if argc > 3:
    _to_port = int(sys.argv[3])
if argc > 4:
    _threads_count = int(sys.argv[4])
if argc > 5:
    _soc_timeout = float(sys.argv[5])


##
def sys_write(string):
    sys.stdout.write(string)
    sys.stdout.flush()


##
def deb_print(string):
    if DEB:
        print(string)


##
def tcp_scan(host, port, timeout):
    # deb_print("tcp_scan, host={0}, port={1}, timeout={2}".format(host, port, timeout))

    soc = None
    try:
        soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        soc.settimeout(timeout)
        err_no = soc.connect_ex((host, port))

        if err_no == 0:
            sys_write('[ ' + str(port) + ' ],')
        else:
            sys_write(str(port) + ',')
            pass

    except Exception, e:
        sys_write(str(port) + ',')
        deb_print("tcp_scan, Exception={0}".format(e))

    finally:
        soc.close()


##
def tcp_scan_port_range(host_name, from_port, to_port, soc_timeout):
    # deb_print(" tcp_scan_port_range, from_port={0} start. ".format(from_port))
    for index in range(from_port, to_port + 1):
        tcp_scan(host_name, index, soc_timeout)
        if not RUN:
            # deb_print(" tcp_scan_port_range, RUN={0}".format(RUN))
            break
    # deb_print(" tcp_scan_port_range, from_port={0} end. ".format(from_port))


##
def threads_scan(host_name, from_port, to_port, threads_count, soc_timeout):
    port_range = (to_port - from_port)
    each_len = port_range / threads_count
    if each_len <= 0:
        each_len = 1

    threads = []
    for index in range(threads_count):
        end_offset = -1 if index < threads_count - 1 else 1
        start = (each_len * index + from_port)
        end = start + each_len + end_offset
        # deb_print(" treads_scan, start={0}, end={1}, end_offset={2}, each_len={3}.".format(start, end, end_offset, each_len))

        try:
            t = Thread(target=tcp_scan_port_range, args=(host_name, start, end, soc_timeout))
            t.daemon = True
            t.start()
            threads.append(t)
        except Exception, e:
            deb_print(" threads_scan, Error: unable to start thread, Exception={0}".format(e))

    for t in threads:
        # deb_print("\n threads_scan, join={0}. \n".format(t))
        t.join()

    try:
        while 1:
            time.sleep(1)
    except KeyboardInterrupt:
        RUN = False
        print(" KeyboardInterrupt, RUN={0}\n".format(RUN))
        pass


##
def main():
    delta_time = time.time()

    prompt = " scaning {0}, port from {1} to {2}, in {3} threads {4} timeout." \
        .format(_host_name, _from_port, _to_port, _threads_count, _soc_timeout)
    print(prompt)

    threads_scan(_host_name, _from_port, _to_port, _threads_count, _soc_timeout)

    delta_time = time.time() - delta_time
    print(' scan over in time {0}.'.format(delta_time))


##
main()

##
# if __name__=="__main__":
# main()
