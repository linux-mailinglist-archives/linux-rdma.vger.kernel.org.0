Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50791D76
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfHSG6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:37 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53163 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNL004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 09/14] tests: Add traffic helper methods
Date:   Mon, 19 Aug 2019 09:58:22 +0300
Message-Id: <20190819065827.26921-10-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

This patch adds common methods needed for data path such as creation
of send/recv work requests, post_send/recv wrappers etc.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/utils.py | 151 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/tests/utils.py b/tests/utils.py
index 20a7e8d38e54..881ce4d03634 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -8,6 +8,9 @@ from string import ascii_lowercase as al
 import unittest
 import random
 
+from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
+from pyverbs.addr import AHAttr, AH, GlobalRoute
+from pyverbs.wr import SGE, SendWR, RecvWR
 from pyverbs.qp import QPCap, QPInitAttrEx
 import pyverbs.device as d
 import pyverbs.enums as e
@@ -23,6 +26,7 @@ MIN_DM_LOG_ALIGN = 0
 MAX_DM_LOG_ALIGN = 6
 # Raw Packet QP supports TSO header, which creates a larger send WQE.
 MAX_RAW_PACKET_SEND_WR = 2500
+GRH_SIZE = 40
 
 
 def get_mr_length():
@@ -242,9 +246,154 @@ def wc_status_to_str(status):
     except KeyError:
         return 'Unknown WC status ({s})'.format(s=status)
 
+# Traffic helpers
+
+def get_send_wr(agr_obj, is_server):
+    """
+    Creates a single SGE Send WR for agr_obj's QP type. The content of the
+    message is either 's' for server side or 'c' for client side.
+    :param agr_obj: Aggregation object which contains all resources necessary
+    :param is_server: Indicates whether this is server or client side
+    :return: send wr
+    """
+    qp_type = agr_obj.qp.qp_type
+    mr = agr_obj.mr
+    if qp_type == e.IBV_QPT_UD:
+        send_sge = SGE(mr.buf + GRH_SIZE, agr_obj.msg_size, mr.lkey)
+    else:
+        send_sge = SGE(mr.buf, agr_obj.msg_size, mr.lkey)
+    msg = agr_obj.msg_size * ('s' if is_server else 'c')
+    mr.write(msg, agr_obj.msg_size)
+    return SendWR(num_sge=1, sg=[send_sge])
+
+
+def get_recv_wr(agr_obj):
+    """
+    Creates a single SGE Recv WR for agr_obj's QP type.
+    :param agr_obj: Aggregation object which contains all resources necessary
+    :return: recv wr
+    """
+    qp_type = agr_obj.qp.qp_type
+    mr = agr_obj.mr
+    if qp_type == e.IBV_QPT_UD:
+        recv_sge = SGE(mr.buf, agr_obj.msg_size + GRH_SIZE, mr.lkey)
+    else:
+        recv_sge = SGE(mr.buf, agr_obj.msg_size, mr.lkey)
+    return RecvWR(sg=[recv_sge], num_sge=1)
+
+
+def post_send(agr_obj, send_wr, gid_index, port):
+    """
+    Post a single send WR to the QP. Post_send's second parameter (send bad wr)
+    is ignored for simplicity. For UD traffic an address vector is added as
+    well.
+    :param agr_obj: aggregation object which contains all resources necessary
+    :param send_wr: Send work request to post send
+    :param gid_index: Local gid index
+    :param port: IB port number
+    :return: None
+    """
+    qp_type = agr_obj.qp.qp_type
+    if qp_type == e.IBV_QPT_UD:
+        gr = GlobalRoute(dgid=agr_obj.ctx.query_gid(port, gid_index),
+                         sgid_index=gid_index)
+        ah_attr = AHAttr(port_num=port, is_global=1, gr=gr,
+                         dlid=agr_obj.port_attr.lid)
+        ah = AH(agr_obj.pd, attr=ah_attr)
+        send_wr.set_wr_ud(ah, agr_obj.rqpn, agr_obj.UD_QKEY)
+    agr_obj.qp.post_send(send_wr, None)
+
+
+def post_recv(qp, recv_wr, num_wqes=1):
+    """
+    Call the QP's post_recv() method <num_wqes> times. Post_recv's second
+    parameter (recv bad wr) is ignored for simplicity.
+    :param qp: QP which posts receive work request
+    :param recv_wr: Receive work request to post
+    :param num_wqes: Number of WQEs to post
+    :return: None
+    """
+    for _ in range(num_wqes):
+        qp.post_recv(recv_wr, None)
 
-# Decorators
 
+def poll_cq(cq, count=1):
+    """
+    Poll <count> completions from the CQ.
+    Note: This function calls the blocking poll() method of the CQ
+    until <count> completions were received. Alternatively, gets a
+    single CQ event when events are used.
+    :param cq: CQ to poll from
+    :param count: How many completions to poll
+    :return: An array of work completions of length <count>, None
+             when events are used
+    """
+    wcs = None
+    while count > 0:
+        nc, wcs = cq.poll(count)
+        for wc in wcs:
+            if wc.status != e.IBV_WC_SUCCESS:
+                raise PyverbsRDMAError('Completion status is {s}'.
+                                       format(s=wc_status_to_str(wc.status)))
+        count -= nc
+    return wcs
+
+
+def validate(received_str, is_server, msg_size):
+    """
+    Validates the received buffer against the expected result.
+    The application should set client's send buffer to 'c's and the
+    server's send buffer to 's's.
+    If the expected buffer is different than the actual, an exception will
+    be raised.
+    :param received_str: The received buffer to check
+    :param is_server: Indicates whether this is the server (receiver) or
+                      client side
+    :param msg_size: the message size of the received packet
+    :return: None
+    """
+    expected_str = msg_size * ('c' if is_server else 's')
+    received_str = received_str.decode()
+    if received_str[0:msg_size] == \
+            expected_str[0:msg_size]:
+        return
+    else:
+        raise PyverbsError(
+            'Data validation failure: expected {exp}, received {rcv}'.
+                format(exp=expected_str, rcv=received_str))
+
+
+def traffic(client, server, iters, gid_idx, port):
+    """
+    Runs basic traffic between two sides
+    :param client: client side, clients base class is BaseTraffic
+    :param server: server side, servers base class is BaseTraffic
+    :param iters: number of traffic iterations
+    :param gid_idx: local gid index
+    :param port: IB port
+    :return:
+    """
+    s_recv_wr = get_recv_wr(server)
+    c_recv_wr = get_recv_wr(client)
+    post_recv(client.qp, c_recv_wr, client.num_msgs)
+    post_recv(server.qp, s_recv_wr, server.num_msgs)
+    for _ in range(iters):
+        c_send_wr = get_send_wr(client, False)
+        post_send(client, c_send_wr, gid_idx, port)
+        poll_cq(client.cq)
+        poll_cq(server.cq)
+        post_recv(client.qp, c_recv_wr)
+        msg_received = server.mr.read(server.msg_size, 0)
+        validate(msg_received, True, server.msg_size)
+        s_send_wr = get_send_wr(server, True)
+        post_send(server, s_send_wr, gid_idx, port)
+        poll_cq(server.cq)
+        poll_cq(client.cq)
+        post_recv(server.qp, s_recv_wr)
+        msg_received = client.mr.read(client.msg_size, 0)
+        validate(msg_received, False, client.msg_size)
+
+# Decorators
 def requires_odp(qp_type):
     def outer(func):
         def inner(instance):
-- 
2.21.0

