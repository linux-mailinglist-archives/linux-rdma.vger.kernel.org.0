Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E701214F13
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfEFPHu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:50 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50135 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727533AbfEFPHt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:49 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edg019922;
        Mon, 6 May 2019 18:07:41 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 10/11] pyverbs/examples: Add base classes for pyverbs applications
Date:   Mon,  6 May 2019 18:07:37 +0300
Message-Id: <20190506150738.19477-11-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add TCPData class, used to transfter connection details over TCP
(GID, LID, QPN and PSN).

Add Common and PingPong classes:
Common provides common arguments (device, iterations etc.), a data
exchange function and a statistics print function (iters/seconds).
PingPong class inherits and extends Common. It is meant for
pingpong-like applications and provides a wrap around CQ polling,
data validation and some basic resources initialization as well.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 buildlib/pyverbs_functions.cmake |   2 +-
 pyverbs/CMakeLists.txt           |   5 +
 pyverbs/examples/__init__.py     |   0
 pyverbs/examples/common.py       | 331 +++++++++++++++++++++++++++++++
 pyverbs/utils.py                 |  19 ++
 5 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 pyverbs/examples/__init__.py
 create mode 100644 pyverbs/examples/common.py

diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.cmake
index 1966cf3ba1a3..6b272440a3d5 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2018, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2018 Mellanox Technologies, Inc. All rights reserved.  See COPYING file
 
 function(rdma_cython_module PY_MODULE)
   foreach(PYX_FILE ${ARGN})
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 328263fcc739..79d87ec39a20 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -32,6 +32,11 @@ rdma_python_module(pyverbs/tests
   tests/utils.py
   )
 
+rdma_python_module(pyverbs/examples
+  examples/common.py
+  examples/ib_devices.py
+  )
+
 rdma_internal_binary(
   run_tests.py
   )
diff --git a/pyverbs/examples/__init__.py b/pyverbs/examples/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/pyverbs/examples/common.py b/pyverbs/examples/common.py
new file mode 100644
index 000000000000..f912ec85af70
--- /dev/null
+++ b/pyverbs/examples/common.py
@@ -0,0 +1,331 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+
+from _socket import SO_REUSEADDR, SOL_SOCKET
+from time import sleep
+import argparse
+import random
+import socket
+
+from pyverbs.pyverbs_error import PyverbsError, PyverbsUserError, \
+    PyverbsRDMAError
+from pyverbs.utils import wc_status_to_str
+from pyverbs.device import Context
+from pyverbs.pd import PD
+import pyverbs.enums as e
+
+MAX_ATTEMPTS = 5
+DATA_LENGTH = 1024
+
+
+class TCPData:
+    """
+    A wrapper class around the common data exchanged by ping-pong applications:
+    GID, LID, PSN and remote QPN. This class also provides a remote_data field
+    that can hold user-defined data.
+    """
+
+    def __init__(self, data=None):
+        self.extra_data = None
+        if data is None:
+            self.gid = None
+            self.lid = 0
+            self.qpn = 0
+            self.psn = random.getrandbits(24)
+        else:
+            remote_data = data.decode().split(',')
+            self.gid = remote_data[0]
+            self.lid = int(remote_data[1].strip())
+            self.qpn = int(remote_data[2].strip())
+            self.psn = int(remote_data[3].strip())
+            if len(remote_data) > 4:
+                self.extra_data = remote_data[4].strip()
+
+    def __str__(self):
+        ext = ''
+        if self.extra_data is not None:
+            ext = ', {ext}'.format(ext=self.extra_data)
+        return '{gid}, {lid}, {qpn}, {psn}{extra}'. \
+            format(gid=self.gid, lid=self.lid, qpn=self.qpn, psn=self.psn,
+                   extra=ext)
+
+
+class Common:
+    """
+    Base class for pyverbs-based applications. It provides basic args and
+    support for data exchange using TCPData
+    """
+
+    def __init__(self, logger=None):
+        """
+        Initializes a Common object.
+        :param logger: A logger object to use for prints
+        """
+        self.logger = logger
+        self.parser = argparse.ArgumentParser(
+            description='Parser for common examples options',
+            conflict_handler='resolve',
+            formatter_class=argparse.ArgumentDefaultsHelpFormatter)
+        self.parser.add_argument('-x', dest='server_name')
+        self.parser.add_argument('-d', '--device', default='mlx5_0',
+                                 help='IB device to use')
+        self.parser.add_argument('-i', '--ib-port', dest='ib_port', type=int,
+                                 default=1, help='Use <ib-port> of IB device')
+        self.parser.add_argument('-p', '--port', dest='tcp_port', type=int,
+                                 default=18515,
+                                 help='TCP port to exchange data over')
+        self.parser.add_argument('-s', '--size', dest='msg_size', type=int,
+                                 default=1024,
+                                 help='Size of message to exchange')
+        self.parser.add_argument('-r', '--rx-depth', dest='rx_depth', type=int,
+                                 default=1000)
+        self.parser.add_argument('-n', '--iters', dest='iters', type=int,
+                                 default=1000, help='Number of iterations')
+        self.tcp_data = TCPData()
+        self.remote_data = None
+        self.args = None
+
+    @property
+    def rlid(self):
+        return self.remote_data.lid
+
+    @property
+    def rgid(self):
+        return self.remote_data.gid
+
+    @property
+    def rqpn(self):
+        return self.remote_data.qpn
+
+    @property
+    def rpsn(self):
+        return self.remote_data.psn
+
+    def base_print(self, data):
+        """
+        Print the user-provided data into either the logger, if exists, or
+        to the shell. If logger exists, it is expected to have an 'info()'
+        method, similarly to the logger provided by Python's logging module.
+        :param data: Data to print
+        :return: None
+        """
+        if self.logger:
+            self.logger.info(data)
+        else:
+            print(data)
+
+    def print_stats(self, start, end):
+        """
+        Print execution statistics similarly to rdma-core's ping-pong examples.
+        Calling function should provide the start and end time as measured by
+        the application. Number of iterations is taken from the test's
+        arguments.
+        :param start: A datetime object representing the execution start time
+        :param end: A datetime object representing the execution end time
+        :return: None
+        """
+        time = end - start
+        total_us = time.seconds * 1000000 + time.microseconds
+        self.base_print('{iters} iters in {sec} seconds = {avg} usec/iter'.
+                        format(iters=self.args.iters, sec=total_us / 1000000,
+                               avg=total_us / self.args.iters))
+
+    def exchange_data(self, sync=False):
+        """
+        Sync or exchange data between two sides. Server side opens a socket
+        and listens while client side attempts to connect MAX_ATTEMPTS times
+        before failing.
+        :param sync: If True, only sync between the two sides, else perform
+                     data transfer as well.
+        :return: None
+        """
+
+        s = socket.socket()
+        s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
+        if self.args.server_name is None:
+            s.bind(('', self.args.tcp_port))
+            s.listen(5)
+            c, addr = s.accept()
+            if not sync:
+                remote_data = c.recv(DATA_LENGTH)
+                c.send(self.tcp_data.__str__().encode())
+                self.remote_data = TCPData(remote_data)
+        else:
+            attempts = 0
+            connected = False
+            while not connected:
+                try:
+                    s.connect((self.args.server_name, self.args.tcp_port))
+                    connected = True
+                except socket.error:
+                    attempts += 1
+                    if attempts > MAX_ATTEMPTS:
+                        raise PyverbsError(
+                            'Number of tries to connect socket exceeded')
+                    sleep(1)
+            if not sync:
+                s.send(self.tcp_data.__str__().encode())
+                remote_data = s.recv(DATA_LENGTH)
+                self.remote_data = TCPData(remote_data)
+        s.shutdown(socket.SHUT_RDWR)
+        s.close()
+
+
+class PingPong(Common):
+    """
+    Base class for pyverbs-based ping-pong applications. It provides a resource
+    initialization method (including querying port and GID if needed), data
+    validation, a wrapper around poll CQ and a basic check of the WC.
+    """
+
+    def __init__(self, logger=None):
+        """
+        Initializes a PingPong object.
+        :param logger: A logger object to use for prints
+        """
+        super(PingPong, self).__init__(logger)
+        self.context = None
+        self.recv_sg = None
+        self.add_grh = 0
+        self.args = None
+        self.pd = None
+        self.mr = None
+        self.num_cq_events = 0
+        self.parser.description = 'Parser for ping-pong common options'
+        self.parser.add_argument('-g', '--gid-index', dest='gid_index',
+                                 type=int, default=-1,
+                                 help='Source GID index')
+        self.parser.add_argument('-l', '--sl', dest='sl', type=int, default=0,
+                                 metavar='[0-15]', help='Service level value')
+        self.parser.add_argument('-v', '--data-validation',
+                                 action='store_true', dest='validate_data')
+
+    def query_port_attr(self):
+        """
+        Query port attributes for LID and whether or not GRH is required. GRH
+        is required in RoCE (as per spec) and in an environment which uses
+        GID-based addressing (such as IB SR-IOV).
+        This method provides early fail in case GRH is requires but GID index
+        was not provided by the user. An exception is raised in such case.
+        After calling this method, self.add_grh and self.tcp_data.lid will be
+        properly set.
+        :return: None
+        """
+        port_attr = self.context.query_port(self.args.ib_port)
+        grh_bit_set = port_attr.flags & e.IBV_QPF_GRH_REQUIRED
+
+        if grh_bit_set:
+            if self.args.gid_index == -1:
+                raise PyverbsUserError(
+                    'GRH is required but GID index was not provided')
+            self.add_grh = 1
+        self.tcp_data.lid = port_attr.lid
+
+    def set_gid(self):
+        self.tcp_data.gid =\
+            self.context.query_gid(self.args.ib_port,
+                                   self.args.gid_index).__str__()
+
+    def init_resources(self):
+        """
+        Create Context and use it to query port attributes and GID.
+        Port attributes are used to:
+        1. Check if GRH is required for this specific device.
+        2. Acquire LID.
+        GID and LID will later be exchanged in order to create a connection.
+        PD is also initialized in this method instead of in each inheriting
+        class.
+        :return: None
+        """
+        self.context = Context(name=self.args.device)
+        self.query_port_attr()
+        if self.add_grh:
+            self.set_gid()
+        self.pd = PD(self.context)
+
+    def execute(self):
+        """
+        A wrapper method to start execution properly: First initialize the
+        resources, then run.
+        :return: None
+        """
+        self.init_resources()
+        self.run()
+
+    def print_connection_details(self, is_local):
+        """
+        Print the local and remote connection details: GID, LID, QPN and PSN.
+        :param is_local: If True, print prefix will be 'Local data', else
+                         'Remote data'
+        :return: None
+        """
+        ext = ''
+        if self.tcp_data.extra_data is not None and is_local:
+            ext = 'Extra data: {e}'.format(e=self.tcp_data.extra_data)
+        if not is_local and self.remote_data.extra_data is not None:
+            ext = 'Extra data: {e}'.format(e=self.remote_data.extra_data)
+        if is_local:
+            self.base_print(
+                'Local data : GID: {gid} LID: {lid} QPN: {qpn} PSN: {psn} {ex}'.
+                format(gid=self.tcp_data.gid, lid=self.tcp_data.lid,
+                       qpn=self.tcp_data.qpn, psn=self.tcp_data.psn, ex=ext))
+        else:
+            self.base_print(
+                'Remote data: GID: {gid} LID: {lid} QPN: {qpn} PSN: {psn} {ex}'.
+                format(gid=self.rgid, lid=self.rlid, qpn=self.rqpn,
+                       psn=self.rpsn, ex=ext))
+
+    @staticmethod
+    def check_wc(wc):
+        """
+        Verify that the given work completion's status is success, else an
+        exception is raised.
+        :param wc: A WC object to check
+        :return: None
+        """
+        if wc.status != e.IBV_WC_SUCCESS:
+            raise PyverbsRDMAError('Completion status is {status}'.format(
+                status=wc_status_to_str(wc.status)))
+
+    def poll_cq(self, count):
+        """
+        Poll <count> completions from the CQ.
+        Note: This function calls the blocking poll() method of the CQ until
+        until <count> completions were received. Alternatively, gets a single
+        CQ event when events are used.
+        :param count: How many completions to poll
+        :return: An array of work completions of length <count>, None when
+                 events are used
+        """
+        if self.args.use_events:
+            if count > 1:
+                raise PyverbsUserError('Can\'t poll more than 1 CQE when using events')
+            self.cc.get_cq_event(self.cq)
+            self.num_cq_events += 1
+            self.cq.req_notify()
+        while count > 0:
+            nc, wcs = self.cq.poll(count)
+            for wc in wcs:
+                self.check_wc(wc)
+            count -= nc
+        return wcs
+
+    def validate(self, received_str):
+        """
+        Validate the received buffer against the expected result.
+        The application should set client's send buffer to 'c's and the
+        server's send buffer to 's's.
+        If the expected buffer is different than the actual, an exception will
+        be raised.
+        :param received_str: The received buffer to check
+        :return: None
+        """
+        expected_str = self.args.msg_size * ('c' if self.is_server else 's')
+        received_str = received_str.decode()
+        if received_str[0:self.args.msg_size] == \
+           expected_str[0:self.args.msg_size]:
+            return
+        else:
+            raise PyverbsError(
+                'Data validation failure: expected {exp}, received {rcv}'.
+                format(exp=expected_str, rcv=received_str))
diff --git a/pyverbs/utils.py b/pyverbs/utils.py
index a59d6275fefc..0126801eb02f 100644
--- a/pyverbs/utils.py
+++ b/pyverbs/utils.py
@@ -79,3 +79,22 @@ def mig_state_to_str(mig):
         return mig_states[mig]
     except KeyError:
         return 'Unknown ({m})'.format(m=mig)
+
+
+def wc_status_to_str(status):
+    try:
+        return \
+            {0: 'Success', 1: 'Local length error',
+             2: 'local QP operation error', 3: 'Local EEC operation error',
+             4: 'Local protection error', 5: 'WR flush error',
+             6: 'Memory window bind error', 7: 'Bad response error',
+             8: 'Local access error', 9: 'Remote invalidate request error',
+             10: 'Remote access error', 11: 'Remote operation error',
+             12: 'Retry exceeded', 13: 'RNR retry exceeded',
+             14: 'Local RDD violation error',
+             15: 'Remote invalidate RD request error',
+             16: 'Remote aort error', 17: 'Invalidate EECN error',
+             18: 'Invalidate EEC state error', 19: 'Fatal error',
+             20: 'Response timeout error', 21: 'General error'}[status]
+    except KeyError:
+        return 'Unknown WC status ({s})'.format(s=status)
-- 
2.17.2

