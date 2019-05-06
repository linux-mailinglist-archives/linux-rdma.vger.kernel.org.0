Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D121314F1B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEFPHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50122 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727561AbfEFPHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7ede019922;
        Mon, 6 May 2019 18:07:41 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 08/11] pyverbs/tests: Add control-path unittests for QP class
Date:   Mon,  6 May 2019 18:07:35 +0300
Message-Id: <20190506150738.19477-9-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Unittests include creation of supported QP types (RC, UD, UC, Raw
Packet) using both ibv_create_qp and ibv_create_qp_ex.
These unitests also verify that if a QP is created with a QPAttr
object, it will be returned to the user in INIT state (for connected
QPs) or RTS (UD, Raw Packet).

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt |   1 +
 pyverbs/tests/qp.py    | 255 +++++++++++++++++++++++++++++++++++++++++
 pyverbs/tests/utils.py | 128 ++++++++++++++++++++-
 3 files changed, 382 insertions(+), 2 deletions(-)
 create mode 100644 pyverbs/tests/qp.py

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 3b3838ddb8b5..328263fcc739 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -28,6 +28,7 @@ rdma_python_module(pyverbs/tests
   tests/device.py
   tests/mr.py
   tests/pd.py
+  tests/qp.py
   tests/utils.py
   )
 
diff --git a/pyverbs/tests/qp.py b/pyverbs/tests/qp.py
new file mode 100644
index 000000000000..be152d4ca5bd
--- /dev/null
+++ b/pyverbs/tests/qp.py
@@ -0,0 +1,255 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
+"""
+Test module for pyverbs' qp module.
+"""
+import random
+
+from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.qp import QPInitAttr, QPAttr, QP
+import pyverbs.tests.utils as u
+import pyverbs.enums as e
+from pyverbs.pd import PD
+from pyverbs.cq import CQ
+
+
+class QPTest(PyverbsTestCase):
+    """
+    Test various functionalities of the QP class.
+    """
+
+    def test_create_qp_no_attr_connected(self):
+        """
+        Test QP creation via ibv_create_qp without a QPAttr object proivded.
+        QP type can be either RC or UC.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    qia = get_qp_init_attr(cq, [e.IBV_QPT_RC, e.IBV_QPT_UC],
+                                           attr)
+                    with QP(pd, qia) as qp:
+                        assert qp.qp_state == e.IBV_QPS_RESET
+
+    def test_create_qp_no_attr(self):
+        """
+        Test QP creation via ibv_create_qp without a QPAttr object proivded.
+        QP type can be either Raw Packet or UD.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    for i in range(1, attr.phys_port_cnt + 1):
+                        qpts = [e.IBV_QPT_UD, e.IBV_QPT_RAW_PACKET] \
+                            if is_eth(ctx, i) else [e.IBV_QPT_UD]
+                        qia = get_qp_init_attr(cq, qpts, attr)
+                        with QP(pd, qia) as qp:
+                            assert qp.qp_state == e.IBV_QPS_RESET
+
+    def test_create_qp_with_attr_connected(self):
+        """
+        Test QP creation via ibv_create_qp without a QPAttr object proivded.
+        QP type can be either RC or UC.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    qia = get_qp_init_attr(cq, [e.IBV_QPT_RC, e.IBV_QPT_UC],
+                                           attr)
+                    with QP(pd, qia, QPAttr()) as qp:
+                        assert qp.qp_state == e.IBV_QPS_INIT
+
+    def test_create_qp_with_attr(self):
+        """
+        Test QP creation via ibv_create_qp with a QPAttr object proivded.
+        QP type can be either Raw Packet or UD.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    for i in range(1, attr.phys_port_cnt + 1):
+                        qpts = [e.IBV_QPT_UD, e.IBV_QPT_RAW_PACKET] \
+                            if is_eth(ctx, i) else [e.IBV_QPT_UD]
+                        qia = get_qp_init_attr(cq, qpts, attr)
+                        with QP(pd, qia, QPAttr()) as qp:
+                            assert qp.qp_state == e.IBV_QPS_RTS
+
+    def test_create_qp_ex_no_attr_connected(self):
+        """
+        Test QP creation via ibv_create_qp_ex without a QPAttr object proivded.
+        QP type can be either RC or UC.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    qia = get_qp_init_attr_ex(cq, pd, [e.IBV_QPT_RC,
+                                                       e.IBV_QPT_UC],
+                                              attr, attr_ex)
+                    with QP(ctx, qia) as qp:
+                        assert qp.qp_state == e.IBV_QPS_RESET
+
+    def test_create_qp_ex_no_attr(self):
+        """
+        Test QP creation via ibv_create_qp_ex without a QPAttr object proivded.
+        QP type can be either Raw Packet or UD.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    for i in range(1, attr.phys_port_cnt + 1):
+                        qpts = [e.IBV_QPT_UD, e.IBV_QPT_RAW_PACKET] \
+                            if is_eth(ctx, i) else [e.IBV_QPT_UD]
+                        qia = get_qp_init_attr_ex(cq, pd, qpts, attr,
+                                                  attr_ex)
+                        with QP(ctx, qia) as qp:
+                            assert qp.qp_state == e.IBV_QPS_RESET
+
+    def test_create_qp_ex_with_attr_connected(self):
+        """
+        Test QP creation via ibv_create_qp_ex with a QPAttr object proivded.
+        QP type can be either RC or UC.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    qia = get_qp_init_attr_ex(cq, pd, [e.IBV_QPT_RC,
+                                                       e.IBV_QPT_UC],
+                                              attr, attr_ex)
+                    with QP(ctx, qia, QPAttr()) as qp:
+                        assert qp.qp_state == e.IBV_QPS_INIT
+
+    def test_create_qp_ex_with_attr(self):
+        """
+        Test QP creation via ibv_create_qp_ex with a QPAttr object proivded.
+        QP type can be either Raw Packet or UD.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    for i in range(1, attr.phys_port_cnt + 1):
+                        qpts = [e.IBV_QPT_UD, e.IBV_QPT_RAW_PACKET] \
+                            if is_eth(ctx, i) else [e.IBV_QPT_UD]
+                        qia = get_qp_init_attr_ex(cq, pd, qpts, attr,
+                                                  attr_ex)
+                        with QP(ctx, qia, QPAttr()) as qp:
+                            assert qp.qp_state == e.IBV_QPS_RTS
+
+    def test_query_qp(self):
+        """
+        Queries a QP after creation. Verifies that its properties are as
+        expected.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    for i in range(1, attr.phys_port_cnt + 1):
+                        qpts = get_qp_types(ctx, i)
+                        is_ex = random.choice([True, False])
+                        if is_ex:
+                            qia = get_qp_init_attr_ex(cq, pd, qpts, attr,
+                                                      attr_ex)
+                        else:
+                            qia = get_qp_init_attr(cq, qpts, attr)
+                        caps = qia.cap  # Save them to verify values later
+                        qp = QP(ctx, qia) if is_ex else QP(pd, qia)
+                        attr, init_attr = qp.query(e.IBV_QP_CUR_STATE |
+                                                   e.IBV_QP_CAP)
+                        verify_qp_attrs(caps, e.IBV_QPS_RESET, init_attr,
+                                        attr)
+
+    def test_modify_qp(self):
+        """
+        Queries a QP after calling modify(). Verifies that its properties are
+        as expected.
+        """
+        for ctx, attr, attr_ex in self.devices:
+            with PD(ctx) as pd:
+                with CQ(ctx, 100, None, None, 0) as cq:
+                    is_ex = random.choice([True, False])
+                    if is_ex:
+                        qia = get_qp_init_attr_ex(cq, pd, [e.IBV_QPT_UD],
+                                                  attr, attr_ex)
+                    else:
+                        qia = get_qp_init_attr(cq, [e.IBV_QPT_UD], attr)
+                    qp = QP(ctx, qia) if is_ex \
+                        else QP(pd, qia)
+                    qa = QPAttr()
+                    qa.qkey = 0x123
+                    qp.to_init(qa)
+                    attr, iattr = qp.query(e.IBV_QP_QKEY)
+                    assert attr.qkey == qa.qkey
+                    qp.to_rtr(qa)
+                    qa.sq_psn = 0x45
+                    qp.to_rts(qa)
+                    attr, iattr = qp.query(e.IBV_QP_SQ_PSN)
+                    assert attr.sq_psn == qa.sq_psn
+                    qa.qp_state = e.IBV_QPS_RESET
+                    qp.modify(qa, e.IBV_QP_STATE)
+                    assert qp.qp_state == e.IBV_QPS_RESET
+
+
+def get_qp_types(ctx, port_num):
+    """
+    Returns a list of the commonly used QP types. Raw Packet QP will not be
+    included if link layer is not Ethernet.
+    :param ctx: The device's Context, to query the port's link layer
+    :param port_num: Port number to query
+    :return: An array of QP types that can be created on this port
+    """
+    qpts = [e.IBV_QPT_RC, e.IBV_QPT_UC, e.IBV_QPT_UD]
+    if is_eth(ctx, port_num):
+        qpts.append(e.IBV_QPT_RAW_PACKET)
+    return qpts
+
+
+def verify_qp_attrs(orig_cap, state, init_attr, attr):
+    assert state == attr.cur_qp_state
+    assert orig_cap.max_send_wr <= init_attr.cap.max_send_wr
+    assert orig_cap.max_recv_wr <= init_attr.cap.max_recv_wr
+    assert orig_cap.max_send_sge <= init_attr.cap.max_send_sge
+    assert orig_cap.max_recv_sge <= init_attr.cap.max_recv_sge
+    assert orig_cap.max_inline_data <= init_attr.cap.max_inline_data
+
+
+def get_qp_init_attr(cq, qpts, attr):
+    """
+    Creates a QPInitAttr object with a QP type of the provided <qpts> array and
+    other random values.
+    :param cq: CQ to be used as send and receive CQ
+    :param qpts: An array of possible QP types to use
+    :param attr: Device attributes for capability checks
+    :return: An initialized QPInitAttr object
+    """
+    qp_cap = u.random_qp_cap(attr)
+    qpt = random.choice(qpts)
+    sig = random.randint(0, 1)
+    return QPInitAttr(qp_type=qpt, scq=cq, rcq=cq, cap=qp_cap, sq_sig_all=sig)
+
+
+def get_qp_init_attr_ex(cq, pd, qpts, attr, attr_ex):
+    """
+    Creates a QPInitAttrEx object with a QP type of the provided <qpts> array
+    and other random values.
+    :param cq: CQ to be used as send and receive CQ
+    :param pd: A PD object to use
+    :param qpts: An array of possible QP types to use
+    :param attr: Device attributes for capability checks
+    :param attr_ex: Extended device attributes for capability checks
+    :return: An initialized QPInitAttrEx object
+    """
+    qpt = random.choice(qpts)
+    qia = u.random_qp_init_attr_ex(attr_ex, attr, qpt)
+    qia.send_cq = cq
+    qia.recv_cq = cq
+    qia.pd = pd  # Only XRCD can be created without a PD
+    return qia
+
+
+def is_eth(ctx, port_num):
+    """
+    Querires the device's context's <port_num> port for its link layer.
+    :param ctx: The Context to query
+    :param port_num: Which Context's port to query
+    :return: True if the port's link layer is Ethernet, else False
+    """
+    return ctx.query_port(port_num).link_layer == e.IBV_LINK_LAYER_ETHERNET
diff --git a/pyverbs/tests/utils.py b/pyverbs/tests/utils.py
index c4a28b70a2da..c84865a10a40 100644
--- a/pyverbs/tests/utils.py
+++ b/pyverbs/tests/utils.py
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
-# Copyright (c) 2019, Mellanox Technologies. All rights reserved.  See COPYING file
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.  See COPYING file
 """
 Provide some useful helper function for pyverbs' tests.
 """
@@ -7,10 +7,10 @@ from itertools import combinations as com
 from string import ascii_lowercase as al
 import random
 
+from pyverbs.qp import QPCap, QPInitAttrEx
 import pyverbs.device as d
 import pyverbs.enums as e
 
-
 MAX_MR_SIZE = 4194304
 # Some HWs limit DM address and length alignment to 4 for read and write
 # operations. Use a minimal length and alignment that respect that.
@@ -20,6 +20,8 @@ MIN_DM_SIZE = 4
 DM_ALIGNMENT = 4
 MIN_DM_LOG_ALIGN = 0
 MAX_DM_LOG_ALIGN = 6
+# Raw Packet QP supports TSO header, which creates a larger send WQE.
+MAX_RAW_PACKET_SEND_WR = 2500
 
 
 def get_mr_length():
@@ -97,3 +99,125 @@ def sample(coll):
     :return: A subset of <collection>
     """
     return random.sample(coll, int((len(coll) + 1) * random.random()))
+
+
+def random_qp_cap(attr):
+    """
+    Initializes a QPCap object with valid values based on the device's
+    attributes.
+    It doesn't check the max WR limits since they're reported for smaller WR
+    sizes.
+    :return: A QPCap object
+    """
+    # We use significantly smaller values than those in device attributes.
+    # The attributes reported by the device don't take into account possible
+    # larger WQEs that include e.g. memory window.
+    send_wr = random.randint(1, int(attr.max_qp_wr / 8))
+    recv_wr = random.randint(1, int(attr.max_qp_wr / 8))
+    send_sge = random.randint(1, int(attr.max_sge / 2))
+    recv_sge = random.randint(1, int(attr.max_sge / 2))
+    inline = random.randint(0, 16)
+    return QPCap(send_wr, recv_wr, send_sge, recv_sge, inline)
+
+
+def random_qp_create_mask(qpt, attr_ex):
+    """
+    Select a random sublist of ibv_qp_init_attr_mask. Some of the options are
+    not yet supported by pyverbs and will not be returned. TSO support is
+    checked for the device and the QP type. If it doesn't exist, TSO will not
+    be set.
+    :param qpt: Current QP type
+    :param attr_ex: Extended device attributes for capability checks
+    :return: A sublist of ibv_qp_init_attr_mask
+    """
+    has_tso = attr_ex.tso_caps.max_tso > 0 and \
+        attr_ex.tso_caps.supported_qpts & 1 << qpt
+    supp_flags = [e.IBV_QP_INIT_ATTR_CREATE_FLAGS,
+                  e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER]
+    # Either PD or XRCD flag is needed, XRCD is not supported yet
+    selected = sample(supp_flags)
+    selected.append(e.IBV_QP_INIT_ATTR_PD)
+    if e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER in selected and not has_tso:
+        selected.remove(e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER)
+    mask = 0
+    for s in selected:
+        mask += s.value
+    return mask
+
+
+def get_create_qp_flags_raw_packet(attr_ex):
+    """
+    Select random QP creation flags for Raw Packet QP. Filter out unsupported
+    flags prior to selection.
+    :param attr_ex: Device extended attributes to check capabilities
+    :return: A random combination of QP creation flags
+    """
+    has_fcs = attr_ex.device_cap_flags_ex & e._IBV_DEVICE_RAW_SCATTER_FCS
+    has_cvlan = attr_ex.raw_packet_caps & e.IBV_RAW_PACKET_CAP_CVLAN_STRIPPING
+    has_padding = attr_ex.device_cap_flags_ex & \
+        e._IBV_DEVICE_PCI_WRITE_END_PADDING
+    l = list(e.ibv_qp_create_flags)
+    l.remove(e.IBV_QP_CREATE_SOURCE_QPN)  # UD only
+    if not has_fcs:
+        l.remove(e.IBV_QP_CREATE_SCATTER_FCS)
+    if not has_cvlan:
+        l.remove(e.IBV_QP_CREATE_CVLAN_STRIPPING)
+    if not has_padding:
+        l.remove(e.IBV_QP_CREATE_PCI_WRITE_END_PADDING)
+    flags = sample(l)
+    val = 0
+    for i in flags:
+        val |= i.value
+    return val
+
+
+def random_qp_create_flags(qpt, attr_ex):
+    """
+    Select a random sublist of ibv_qp_create_flags according to the QP type.
+    :param qpt: Current QP type
+    :param attr_ex: Used for Raw Packet QP to check device capabilities
+    :return: A sublist of ibv_qp_create_flags
+    """
+    if qpt == e.IBV_QPT_RAW_PACKET:
+        return get_create_qp_flags_raw_packet(attr_ex)
+    elif qpt == e.IBV_QPT_UD:
+        # IBV_QP_CREATE_SOURCE_QPN is only supported by mlx5 driver and is not
+        # to be check in unittests.
+        return random.choice([0, 2])  # IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
+    else:
+        return 0
+
+
+def random_qp_init_attr_ex(attr_ex, attr, qpt=None):
+    """
+    Create a random-valued QPInitAttrEX object with the given QP type.
+    QP type affects QP capabilities, so allow users to set it and still get
+    valid attributes.
+    :param attr_ex: Extended device attributes for capability checks
+    :param attr: Device attributes for capability checks
+    :param qpt: Requested QP type
+    :return: A valid initialized QPInitAttrEx object
+    """
+    max_tso = 0
+    if qpt is None:
+        qpt = random.choice([e.IBV_QPT_RC, e.IBV_QPT_UC, e.IBV_QPT_UD,
+                             e.IBV_QPT_RAW_PACKET])
+    qp_cap = random_qp_cap(attr)
+    if qpt == e.IBV_QPT_RAW_PACKET and \
+       qp_cap.max_send_wr > MAX_RAW_PACKET_SEND_WR:
+        qp_cap.max_send_wr = MAX_RAW_PACKET_SEND_WR
+    sig = random.randint(0, 1)
+    mask = random_qp_create_mask(qpt, attr_ex)
+    if mask & e.IBV_QP_INIT_ATTR_CREATE_FLAGS:
+        cflags = random_qp_create_flags(qpt, attr_ex)
+    else:
+        cflags = 0
+    if mask & e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER:
+        if qpt != e.IBV_QPT_RAW_PACKET:
+            mask -= e.IBV_QP_INIT_ATTR_MAX_TSO_HEADER
+        else:
+            max_tso = \
+                random.randint(16, int(attr_ex.tso_caps.max_tso / 400))
+    qia = QPInitAttrEx(qp_type=qpt, cap=qp_cap, sq_sig_all=sig, comp_mask=mask,
+                       create_flags=cflags, max_tso_header=max_tso)
+    return qia
-- 
2.17.2

