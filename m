Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D4AD54C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfIIJHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48370 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389601AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp1028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 03/12] pyverbs: Remove TM enums
Date:   Mon,  9 Sep 2019 12:07:03 +0300
Message-Id: <20190909090712.11029-4-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090712.11029-1-noaos@mellanox.com>
References: <20190909090712.11029-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

Currently tag matching feature is not supported.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/cq.pyx               |  1 -
 pyverbs/libibverbs_enums.pxd | 25 -------------------------
 tests/test_cq.py             |  2 --
 3 files changed, 28 deletions(-)
 mode change 100644 => 100755 pyverbs/libibverbs_enums.pxd

diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index 3ac5f704766b..32eee0a0f1fd 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -579,6 +579,5 @@ def create_wc_flags_to_str(flags):
                  e.IBV_WC_EX_WITH_COMPLETION_TIMESTAMP: 'IBV_WC_EX_WITH_COMPLETION_TIMESTAMP',
                  e.IBV_WC_EX_WITH_CVLAN: 'IBV_WC_EX_WITH_CVLAN',
                  e.IBV_WC_EX_WITH_FLOW_TAG: 'IBV_WC_EX_WITH_FLOW_TAG',
-                 e.IBV_WC_EX_WITH_TM_INFO: 'IBV_WC_EX_WITH_TM_INFO',
                  e.IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK: 'IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK'}
     return flags_to_str(flags, cqe_flags)
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
old mode 100644
new mode 100755
index c347ef31dd2b..1d437240a883
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -202,7 +202,6 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_WC_EX_WITH_COMPLETION_TIMESTAMP             = 1 << 7
         IBV_WC_EX_WITH_CVLAN                            = 1 << 8
         IBV_WC_EX_WITH_FLOW_TAG                         = 1 << 9
-        IBV_WC_EX_WITH_TM_INFO                          = 1 << 10
         IBV_WC_EX_WITH_COMPLETION_TIMESTAMP_WALLCLOCK   = 1 << 11
 
     cpdef enum ibv_wc_flags:
@@ -210,12 +209,6 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_WC_WITH_IMM         = 1 << 1
         IBV_WC_IP_CSUM_OK       = 1 << 2
         IBV_WC_WITH_INV         = 1 << 3
-        IBV_WC_TM_SYNC_REQ      = 1 << 4
-        IBV_WC_TM_MATCH         = 1 << 5
-        IBV_WC_TM_DATA_VALID    = 1 << 6
-
-    cpdef enum ibv_tm_cap_flags:
-        IBV_TM_CAP_RC       = 1 << 0,
 
     cpdef enum ibv_srq_attr_mask:
         IBV_SRQ_MAX_WR      = 1 << 0,
@@ -224,14 +217,12 @@ cdef extern from '<infiniband/verbs.h>':
     cpdef enum ibv_srq_type:
         IBV_SRQT_BASIC
         IBV_SRQT_XRC
-        IBV_SRQT_TM
 
     cpdef enum ibv_srq_init_attr_mask:
         IBV_SRQ_INIT_ATTR_TYPE      = 1 << 0
         IBV_SRQ_INIT_ATTR_PD        = 1 << 1
         IBV_SRQ_INIT_ATTR_XRCD      = 1 << 2
         IBV_SRQ_INIT_ATTR_CQ        = 1 << 3
-        IBV_SRQ_INIT_ATTR_TM        = 1 << 4
 
     cpdef enum ibv_mig_state:
         IBV_MIG_MIGRATED
@@ -313,15 +304,6 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_RX_HASH_SRC_PORT_UDP    = 1 << 6
         IBV_RX_HASH_DST_PORT_UDP    = 1 << 7
 
-    cpdef enum ibv_ops_wr_opcode:
-        IBV_WR_TAG_ADD
-        IBV_WR_TAG_DEL
-        IBV_WR_TAG_SYNC
-
-    cpdef enum ibv_ops_flags:
-        IBV_OPS_SIGNALED            = 1 << 0
-        IBV_OPS_TM_SYNC             = 1 << 1
-
     cpdef enum ibv_flow_flags:
         IBV_FLOW_ATTR_FLAGS_ALLOW_LOOP_BACK = 1 << 0
         IBV_FLOW_ATTR_FLAGS_DONT_TRAP       = 1 << 1
@@ -415,12 +397,5 @@ cdef extern from '<infiniband/verbs.h>':
     cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
 
 
-cdef extern from "<infiniband/tm_types.h>":
-    cpdef enum ibv_tmh_op:
-        IBV_TMH_NO_TAG        = 0
-        IBV_TMH_RNDV          = 1
-        IBV_TMH_FIN           = 2
-        IBV_TMH_EAGER         = 3
-
 _IBV_DEVICE_RAW_SCATTER_FCS = IBV_DEVICE_RAW_SCATTER_FCS
 _IBV_DEVICE_PCI_WRITE_END_PADDING = IBV_DEVICE_PCI_WRITE_END_PADDING
diff --git a/tests/test_cq.py b/tests/test_cq.py
index 7848f39c9c63..ad6bfde7b216 100644
--- a/tests/test_cq.py
+++ b/tests/test_cq.py
@@ -168,8 +168,6 @@ def get_attrs_ex(attr, attr_ex):
     wc_flags = list(e.ibv_create_cq_wc_flags)
     # Flow tag is not always supported, doesn't have a capability bit to check
     wc_flags.remove(e.IBV_WC_EX_WITH_FLOW_TAG)
-    if attr_ex.tm_caps.max_ops == 0:
-        wc_flags.remove(e.IBV_WC_EX_WITH_TM_INFO)
     if attr_ex.raw_packet_caps & e.IBV_RAW_PACKET_CAP_CVLAN_STRIPPING == 0:
         wc_flags.remove(e.IBV_WC_EX_WITH_CVLAN)
     sample = u.sample(wc_flags)
-- 
2.21.0

