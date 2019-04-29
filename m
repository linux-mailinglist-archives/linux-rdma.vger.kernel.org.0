Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A866FE6F8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfD2PzR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 11:55:17 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47439 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728515AbfD2PzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 11:55:17 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Apr 2019 18:55:15 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3TFtF7m025539;
        Mon, 29 Apr 2019 18:55:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 1/4] pyverbs: Add missing enums
Date:   Mon, 29 Apr 2019 18:55:10 +0300
Message-Id: <20190429155513.30543-2-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429155513.30543-1-noaos@mellanox.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some needed enums were missing:
- ibv_device_cap_flags
- ODP related enums
- Transport and node type enums
- Raw packet caps

Change-Id: I82c822f394725f29040755ce82d80b6dd5767bed
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/libibverbs_enums.pxd | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index e429cd35cc47..b76914208074 100644
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -3,6 +3,22 @@
 
 cdef extern from '<infiniband/verbs.h>':
 
+    cpdef enum ibv_transport_type:
+        IBV_TRANSPORT_UNKNOWN   = -1
+        IBV_TRANSPORT_IB        = 0
+        IBV_TRANSPORT_IWARP     = 1
+        IBV_TRANSPORT_USNIC     = 2
+        IBV_TRANSPORT_USNIC_UDP = 3
+
+    cpdef enum ibv_node_type:
+        IBV_NODE_UNKNOWN    = -1
+        IBV_NODE_CA         = 1
+        IBV_NODE_SWITCH     = 2
+        IBV_NODE_ROUTER     = 3
+        IBV_NODE_RNIC       = 4
+        IBV_NODE_USNIC      = 5
+        IBV_NODE_USNIC_UDP  = 6
+
     cpdef enum:
         IBV_LINK_LAYER_UNSPECIFIED
         IBV_LINK_LAYER_INFINIBAND
@@ -348,6 +364,50 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_CREATE_CQ_ATTR_SINGLE_THREADED = 1 << 0
         IBV_CREATE_CQ_ATTR_IGNORE_OVERRUN  = 1 << 1
 
+    cpdef enum ibv_odp_general_caps:
+        IBV_ODP_SUPPORT             = 1
+        IBV_ODP_SUPPORT_IMPLICIT    = 1 << 1
+
+    cpdef enum ibv_odp_transport_cap_bits:
+        IBV_ODP_SUPPORT_SEND        = 1 << 0
+        IBV_ODP_SUPPORT_RECV        = 1 << 1
+        IBV_ODP_SUPPORT_WRITE       = 1 << 2
+        IBV_ODP_SUPPORT_READ        = 1 << 3
+        IBV_ODP_SUPPORT_ATOMIC      = 1 << 4
+        IBV_ODP_SUPPORT_SRQ_RECV    = 1 << 5
+
+    cpdef enum ibv_device_cap_flags:
+        IBV_DEVICE_RESIZE_MAX_WR            = 1 <<  0
+        IBV_DEVICE_BAD_PKEY_CNTR            = 1 <<  1
+        IBV_DEVICE_BAD_QKEY_CNTR            = 1 <<  2
+        IBV_DEVICE_RAW_MULTI                = 1 <<  3
+        IBV_DEVICE_AUTO_PATH_MIG            = 1 <<  4
+        IBV_DEVICE_CHANGE_PHY_PORT          = 1 <<  5
+        IBV_DEVICE_UD_AV_PORT_ENFORCE       = 1 <<  6
+        IBV_DEVICE_CURR_QP_STATE_MOD        = 1 <<  7
+        IBV_DEVICE_SHUTDOWN_PORT            = 1 <<  8
+        IBV_DEVICE_INIT_TYPE                = 1 <<  9
+        IBV_DEVICE_PORT_ACTIVE_EVENT        = 1 << 10
+        IBV_DEVICE_SYS_IMAGE_GUID           = 1 << 11
+        IBV_DEVICE_RC_RNR_NAK_GEN           = 1 << 12
+        IBV_DEVICE_SRQ_RESIZE               = 1 << 13
+        IBV_DEVICE_N_NOTIFY_CQ              = 1 << 14
+        IBV_DEVICE_MEM_WINDOW               = 1 << 17
+        IBV_DEVICE_UD_IP_CSUM               = 1 << 18
+        IBV_DEVICE_XRC                      = 1 << 20
+        IBV_DEVICE_MEM_MGT_EXTENSIONS       = 1 << 21
+        IBV_DEVICE_MEM_WINDOW_TYPE_2A       = 1 << 23
+        IBV_DEVICE_MEM_WINDOW_TYPE_2B       = 1 << 24
+        IBV_DEVICE_RC_IP_CSUM               = 1 << 25
+        IBV_DEVICE_RAW_IP_CSUM              = 1 << 26
+        IBV_DEVICE_MANAGED_FLOW_STEERING    = 1 << 29
+
+    cpdef enum ibv_raw_packet_caps:
+        IBV_RAW_PACKET_CAP_CVLAN_STRIPPING  = 1 << 0
+        IBV_RAW_PACKET_CAP_SCATTER_FCS      = 1 << 1
+        IBV_RAW_PACKET_CAP_IP_CSUM          = 1 << 2
+        IBV_RAW_PACKET_CAP_DELAY_DROP       = 1 << 3
+
 
 cdef extern from "<infiniband/tm_types.h>":
     cpdef enum ibv_tmh_op:
-- 
2.17.2

