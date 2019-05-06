Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6B14F12
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfEFPHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50140 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727586AbfEFPHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edh019922;
        Mon, 6 May 2019 18:07:41 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 11/11] pyverbs/examples: RC pingpong
Date:   Mon,  6 May 2019 18:07:38 +0300
Message-Id: <20190506150738.19477-12-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds the RC pingpong example, similar to the one in
libibverbs.
Its current options are as follows:
$ python3 rc_pingpong.py -h
usage: rc_pingpong.py [-h] [-x SERVER_NAME] [-d DEVICE] [-i IB_PORT]
                      [-p TCP_PORT] [-s MSG_SIZE] [-r RX_DEPTH] [-n ITERS]
		      [-g GID_INDEX] [-l [0-15]] [-v] [-m PATH_MTU] [-j] [-o]
		      [-e]

Parser for RC pingpong options

optional arguments:
  -h, --help            show this help message and exit
  -x SERVER_NAME
  -d DEVICE, --device DEVICE
			IB device to use (default: mlx5_0)
  -i IB_PORT, --ib-port IB_PORT
			Use <ib-port> of IB device (default: 1)
  -p TCP_PORT, --port TCP_PORT
			TCP port to exchange data over (default: 18515)
  -s MSG_SIZE, --size MSG_SIZE
			Size of message to exchange (default: 1024)
  -r RX_DEPTH, --rx-depth RX_DEPTH
  -n ITERS, --iters ITERS
			Number of iterations (default: 1000)
  -g GID_INDEX, --gid-index GID_INDEX
			Source GID index
  -l [0-15], --sl [0-15]
			Service level value (default: 0)
  -v, --data-validation
  -m PATH_MTU, --mtu PATH_MTU
  -j, --dm              Use device memory (default: False)
  -o, --odp             use on demand paging (default: False)
  -e, --use-events      Use CQ events instead of poll (default: False)

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt          |   1 +
 pyverbs/examples/rc_pingpong.py | 208 ++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 pyverbs/examples/rc_pingpong.py

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 79d87ec39a20..26da71e554e2 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -35,6 +35,7 @@ rdma_python_module(pyverbs/tests
 rdma_python_module(pyverbs/examples
   examples/common.py
   examples/ib_devices.py
+  examples/rc_pingpong.py
   )
 
 rdma_internal_binary(
diff --git a/pyverbs/examples/rc_pingpong.py b/pyverbs/examples/rc_pingpong.py
new file mode 100644
index 000000000000..cce72e5ee405
--- /dev/null
+++ b/pyverbs/examples/rc_pingpong.py
@@ -0,0 +1,208 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+import datetime
+import sys
+
+from pyverbs.qp import QPCap, QPInitAttr, QPAttr, QP
+from pyverbs.pyverbs_error import PyverbsUserError
+from pyverbs.addr import AHAttr, GlobalRoute, GID
+from pyverbs.examples.common import PingPong
+from pyverbs.device import AllocDmAttr, DM
+from pyverbs.wr import SGE, RecvWR, SendWR
+from pyverbs.cq import CQ, CompChannel
+from pyverbs.mr import MR, DMMR
+import pyverbs.enums as e
+
+
+class RCPingPong(PingPong):
+    def __init__(self, logger, args):
+        super(RCPingPong, self).__init__(logger)
+        self.args = None
+        self.parse(args)
+        self.qp = None
+        self.cq = None
+        self.dm = None
+        self.cc = None
+        self.recv_sge = None
+        self.is_server = False
+        self.num_cq_events = 0
+
+    def parse(self, args):
+        self.parser.add_argument('-m', '--mtu', dest='path_mtu', default=1024,
+                                 type=int)
+        self.parser.add_argument('-j', '--dm', action='store_true',
+                                 dest='use_dm', help='Use device memory')
+        self.parser.add_argument('-o', '--odp', action='store_true',
+                                 dest='odp', help='use on demand paging')
+        self.parser.add_argument('-e', '--use-events', action='store_true',
+                                 help='Use CQ events instead of poll')
+        self.parser.description = 'Parser for RC pingpong options'
+        self.args = self.parser.parse_args(args)
+
+    def sanity(self):
+        """
+        Perform basic sanity checks on the input and check if requested
+        features are supported by the device.
+        :return: None
+        """
+        attr_ex = self.context.query_device_ex(None)
+        if self.args.use_dm and self.args.odp:
+            raise PyverbsUserError('Device memory region can\'t be on demand')
+        if self.args.odp:
+            rc_mask = e.IBV_ODP_SUPPORT_SEND | e.IBV_ODP_SUPPORT_RECV
+            if attr_ex.odp_caps.general_caps & e.IBV_ODP_SUPPORT == 0:
+                raise PyverbsUserError('The device isn\'t ODP capable')
+            if attr_ex.odp_caps.rc_odp_caps & rc_mask != rc_mask:
+                raise PyverbsUserError('RC send/recv with ODP are not supported')
+        if self.args.use_dm:
+            if attr_ex.max_dm_size == 0:
+                raise PyverbsUserError('Device doesn\'t support DM allocation')
+            if attr_ex.max_dm_size < self.args.msg_size:
+                raise PyverbsUserError('Device max DM allocation: {s}, requested: {r}'.
+                                       format(s=attr_ex.max_dm_size,
+                                              r=self.args.msg_size))
+
+    def mtu_to_enum(self):
+        """
+        Converts the user-provided (or default) MTU (in bytes) to the matching
+        enum values.
+        :return: The enum entry that matches the given MTU
+        """
+        mtus = {256: e.IBV_MTU_256, 512: e.IBV_MTU_512, 1024: e.IBV_MTU_1024,
+                2048: e.IBV_MTU_2048, 4096: e.IBV_MTU_4096}
+        try:
+            return mtus[self.args.path_mtu]
+        except KeyError:
+            raise PyverbsUserError('Invalid MTU {m}'.
+                                   format(m=self.args.path_mtu))
+
+    def rc_qp_attr(self, attr):
+        """
+        Set the QP attributes' values to arbitrary values (based on the values
+        used in ibv_rc_pingpong).
+        :param attr: QPAttr object to modify
+        :return: None
+        """
+        attr.dest_qp_num = self.rqpn
+        attr.path_mtu = self.mtu_to_enum()
+        attr.max_dest_rd_atomic = 1
+        attr.min_rnr_timer = 12
+        attr.rq_psn = self.rpsn
+        attr.sq_psn = self.tcp_data.psn
+        attr.timeout = 14
+        attr.retry_cnt = 7
+        attr.rnr_retry = 7
+        attr.max_rd_atomic = 1
+
+    def post_recv(self, num_wqes):
+        """
+        Call the QP's post_recv() method <num_wqes> times.
+        Since this is an example, the same WR is used for each post_recv().
+        :param num_wqes: Number of WQEs to post
+        """
+        self.recv_sge = SGE(self.mr.buf if self.dm is None else 0,
+                            self.args.msg_size, self.mr.lkey)
+        wr_id = 1 if self.is_server else 2
+        recv_wr = RecvWR(wr_id=wr_id, sg=[self.recv_sge], num_sge=1)
+        for i in range(num_wqes):
+            self.qp.post_recv(recv_wr, None)
+
+    def validate(self):
+        received_str = self.recv_sge.read(self.args.msg_size, 0) \
+            if self.dm is None else self.dm.copy_from_dm(0, self.args.msg_size)
+        super(RCPingPong, self).validate(received_str)
+
+    def post_send(self):
+        """
+        Post a single send WR on the QP. The content is either 's' for server
+        side or 'c' for client side.
+        :return: None
+        """
+        length = self.args.msg_size
+        send_sge = SGE(self.mr.buf if self.dm is None else 0,
+                       length, self.mr.lkey)
+        if self.args.validate_data:
+            msg = length * ('s' if self.is_server else 'c')
+            if self.dm is not None:
+                self.dm.copy_to_dm(0, msg.encode(), length)
+            else:
+                self.mr.write(msg, length)
+        send_wr = SendWR(wr_id=1 if self.is_server else 2, num_sge=1,
+                         sg=[send_sge])
+        self.qp.post_send(send_wr, None)
+
+    def run(self):
+        self.is_server = True if self.args.server_name is None else False
+        self.sanity()
+        # Handle device memory
+        if self.args.use_dm:
+            dm_attr = AllocDmAttr(self.args.msg_size)
+            self.dm = DM(self.context, dm_attr)
+        # Other RDMA resources: CQ, MR, QP
+        if self.args.use_events:
+            self.cc = CompChannel(self.context)
+        else:
+            self.cc = None
+        self.cq = CQ(self.context, self.args.rx_depth + 1, None, self.cc, 0)
+        if self.args.use_events:
+            self.cq.req_notify()
+
+        access_flags = e.IBV_ACCESS_LOCAL_WRITE
+        if self.dm is None:
+            if self.args.odp:
+                access_flags |= e.IBV_ACCESS_ON_DEMAND
+            self.mr = MR(self.pd, self.args.msg_size, access_flags)
+        else:
+            access_flags |= e.IBV_ACCESS_ZERO_BASED
+            self.mr = DMMR(self.pd, self.args.msg_size, access_flags,
+                           dm=self.dm, offset=0)
+        qp_caps = QPCap(max_recv_wr=self.args.rx_depth)
+        qp_init_attr = QPInitAttr(qp_type=e.IBV_QPT_RC, scq=self.cq,
+                                  rcq=self.cq, cap=qp_caps)
+        qp_attr = QPAttr(port_num=self.args.ib_port)
+        self.qp = QP(self.pd, qp_init_attr, qp_attr)
+        # TCP data exchange
+        self.tcp_data.qpn = self.qp.qp_num
+        self.print_connection_details(is_local=True)
+        self.exchange_data()
+        self.print_connection_details(is_local=False)
+        # 2RTS
+        self.rc_qp_attr(qp_attr)
+        gid_idx = self.args.gid_index if self.add_grh else 0
+        if self.add_grh:
+            gr = GlobalRoute(dgid=GID(self.rgid), sgid_index=gid_idx)
+        else:
+            gr = None
+        ah_attr = AHAttr(port_num=self.args.ib_port, is_global=self.add_grh,
+                         gr=gr, dlid=self.rlid, sl=self.args.sl)
+        qp_attr.ah_attr = ah_attr
+        self.qp.to_rts(qp_attr)
+        self.post_recv(self.args.rx_depth)
+        self.exchange_data(sync=True)
+        start = datetime.datetime.now()
+        for i in range(self.args.iters):
+            if self.is_server:
+                self.poll_cq(1)
+                if self.args.validate_data:
+                    self.validate()
+                self.post_send()
+                self.poll_cq(1)
+                self.post_recv(1)
+            else:
+                self.post_send()
+                self.poll_cq(1)
+                self.poll_cq(1)
+                self.post_recv(1)
+                if self.args.validate_data:
+                    self.validate()
+
+        if self.args.use_events:
+            self.cq.ack_events(self.num_cq_events)
+        end = datetime.datetime.now()
+        self.print_stats(start, end)
+
+
+if __name__ == '__main__':
+    player = RCPingPong(None, sys.argv[1:])
+    player.execute()
-- 
2.17.2

