Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDF4E3787
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 04:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiCVDbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 23:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiCVDbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 23:31:45 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91123403C10
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 20:30:17 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A+zWpja6NpmO2f1VpTdQISgxRtAfFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShjUHn2YdUW+GO66DNGHwfd11bt/i8BsHu5XXyoVjTQU5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfouWXfyLh7pT7I0ruNiGEL+9VJEU7Oosw+ettB2x?=
 =?us-ascii?q?Ks/sCJ1glbB+Mr+Sowb66Q69ngcFLBM3qOp4P/2tsyDjxE/krW9bATr/M6Nse2?=
 =?us-ascii?q?y0/7v2it962i9ExMGIpNUqfJUYUfAp/NX73p8/w7lGXTtGSgA79SXIL3lXu?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AVZBZC6Ajn0VVN2flHelI55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKJyC9Ffbo8fxG/c5rrCMc5wxwZJhNo7y90ey7MBbhHP1OkO4s1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKn/baknDH4VmtJuIHZIQNDSJNykZsS/l2njEL/8QhMmA7LuzhfrT?=
 =?us-ascii?q?i1NkTQRRYalm6AtjYzzraXFedU1XA4YjDpqA6o5irzqkQ34eacO2HT0rRO7Gzu?=
 =?us-ascii?q?e77q7OUFoXAQI98gmSgXeN4L7+KRKR2RATSHdu7N4ZgBD4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122862670"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Mar 2022 11:30:11 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C3BB54D17162;
        Tue, 22 Mar 2022 11:30:06 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 22 Mar 2022 11:30:04 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 22 Mar 2022 11:30:07 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 2/2] IB/uverbs: Move part of enum ib_device_cap_flags to uapi
Date:   Tue, 22 Mar 2022 11:30:02 +0800
Message-ID: <20220322033002.496195-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322033002.496195-1-yangx.jy@fujitsu.com>
References: <20220322033002.496195-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C3BB54D17162.AAA86
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1)Part of enum ib_device_cap_flags are used by ibv_query_device(3)
  or ibv_query_device_ex(3), so we define them in
  include/uapi/rdma/ib_user_verbs.h and only expose them to userspace.

2)Reformat enum ib_device_cap_flags by removing the indent before '='.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/core/uverbs_cmd.c |  6 ++-
 include/rdma/ib_verbs.h              | 76 ++++++++++++++--------------
 include/uapi/rdma/ib_user_verbs.h    | 57 +++++++++++++++++++++
 3 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6b6393176b3c..a1978a6f8e0c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -337,7 +337,8 @@ static void copy_query_dev_fields(struct ib_ucontext *ucontext,
 	resp->hw_ver		= attr->hw_ver;
 	resp->max_qp		= attr->max_qp;
 	resp->max_qp_wr		= attr->max_qp_wr;
-	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags);
+	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags &
+		IB_UVERBS_DEVICE_CAP_FLAGS_MASK);
 	resp->max_sge		= min(attr->max_send_sge, attr->max_recv_sge);
 	resp->max_sge_rd	= attr->max_sge_rd;
 	resp->max_cq		= attr->max_cq;
@@ -3618,7 +3619,8 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 
 	resp.timestamp_mask = attr.timestamp_mask;
 	resp.hca_core_clock = attr.hca_core_clock;
-	resp.device_cap_flags_ex = attr.device_cap_flags;
+	resp.device_cap_flags_ex = attr.device_cap_flags &
+		IB_UVERBS_DEVICE_CAP_FLAGS_MASK;
 	resp.rss_caps.supported_qpts = attr.rss_caps.supported_qpts;
 	resp.rss_caps.max_rwq_indirection_tables =
 		attr.rss_caps.max_rwq_indirection_tables;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e3ed65920558..c486a379df47 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -220,21 +220,21 @@ enum rdma_link_layer {
 };
 
 enum ib_device_cap_flags {
-	IB_DEVICE_RESIZE_MAX_WR			= (1 << 0),
-	IB_DEVICE_BAD_PKEY_CNTR			= (1 << 1),
-	IB_DEVICE_BAD_QKEY_CNTR			= (1 << 2),
-	IB_DEVICE_RAW_MULTI			= (1 << 3),
-	IB_DEVICE_AUTO_PATH_MIG			= (1 << 4),
-	IB_DEVICE_CHANGE_PHY_PORT		= (1 << 5),
-	IB_DEVICE_UD_AV_PORT_ENFORCE		= (1 << 6),
-	IB_DEVICE_CURR_QP_STATE_MOD		= (1 << 7),
-	IB_DEVICE_SHUTDOWN_PORT			= (1 << 8),
-	/* Not in use, former INIT_TYPE		= (1 << 9),*/
-	IB_DEVICE_PORT_ACTIVE_EVENT		= (1 << 10),
-	IB_DEVICE_SYS_IMAGE_GUID		= (1 << 11),
-	IB_DEVICE_RC_RNR_NAK_GEN		= (1 << 12),
-	IB_DEVICE_SRQ_RESIZE			= (1 << 13),
-	IB_DEVICE_N_NOTIFY_CQ			= (1 << 14),
+	IB_DEVICE_RESIZE_MAX_WR = IB_UVERBS_DEVICE_RESIZE_MAX_WR,
+	IB_DEVICE_BAD_PKEY_CNTR = IB_UVERBS_DEVICE_BAD_PKEY_CNTR,
+	IB_DEVICE_BAD_QKEY_CNTR = IB_UVERBS_DEVICE_BAD_QKEY_CNTR,
+	IB_DEVICE_RAW_MULTI = IB_UVERBS_DEVICE_RAW_MULTI,
+	IB_DEVICE_AUTO_PATH_MIG = IB_UVERBS_DEVICE_AUTO_PATH_MIG,
+	IB_DEVICE_CHANGE_PHY_PORT = IB_UVERBS_DEVICE_CHANGE_PHY_PORT,
+	IB_DEVICE_UD_AV_PORT_ENFORCE = IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE,
+	IB_DEVICE_CURR_QP_STATE_MOD = IB_UVERBS_DEVICE_CURR_QP_STATE_MOD,
+	IB_DEVICE_SHUTDOWN_PORT = IB_UVERBS_DEVICE_SHUTDOWN_PORT,
+	/* IB_DEVICE_INIT_TYPE = IB_UVERBS_DEVICE_INIT_TYPE, (not in use) */
+	IB_DEVICE_PORT_ACTIVE_EVENT = IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT,
+	IB_DEVICE_SYS_IMAGE_GUID = IB_UVERBS_DEVICE_SYS_IMAGE_GUID,
+	IB_DEVICE_RC_RNR_NAK_GEN = IB_UVERBS_DEVICE_RC_RNR_NAK_GEN,
+	IB_DEVICE_SRQ_RESIZE = IB_UVERBS_DEVICE_SRQ_RESIZE,
+	IB_DEVICE_N_NOTIFY_CQ = IB_UVERBS_DEVICE_N_NOTIFY_CQ,
 
 	/*
 	 * This device supports a per-device lkey or stag that can be
@@ -243,9 +243,9 @@ enum ib_device_cap_flags {
 	 * instead of use the local_dma_lkey flag in the ib_pd structure,
 	 * which will always contain a usable lkey.
 	 */
-	IB_DEVICE_LOCAL_DMA_LKEY		= (1 << 15),
-	/* Reserved, old SEND_W_INV		= (1 << 16),*/
-	IB_DEVICE_MEM_WINDOW			= (1 << 17),
+	IB_DEVICE_LOCAL_DMA_LKEY = 1 << 15,
+	/* Reserved, old SEND_W_INV = 1 << 16,*/
+	IB_DEVICE_MEM_WINDOW = IB_UVERBS_DEVICE_MEM_WINDOW,
 	/*
 	 * Devices should set IB_DEVICE_UD_IP_SUM if they support
 	 * insertion of UDP and TCP checksum on outgoing UD IPoIB
@@ -253,9 +253,9 @@ enum ib_device_cap_flags {
 	 * incoming messages.  Setting this flag implies that the
 	 * IPoIB driver may set NETIF_F_IP_CSUM for datagram mode.
 	 */
-	IB_DEVICE_UD_IP_CSUM			= (1 << 18),
-	IB_DEVICE_UD_TSO			= (1 << 19),
-	IB_DEVICE_XRC				= (1 << 20),
+	IB_DEVICE_UD_IP_CSUM = IB_UVERBS_DEVICE_UD_IP_CSUM,
+	IB_DEVICE_UD_TSO = 1 << 19,
+	IB_DEVICE_XRC = IB_UVERBS_DEVICE_XRC,
 
 	/*
 	 * This device supports the IB "base memory management extension",
@@ -266,31 +266,33 @@ enum ib_device_cap_flags {
 	 * IB_WR_RDMA_READ_WITH_INV verb for RDMA READs that invalidate the
 	 * stag.
 	 */
-	IB_DEVICE_MEM_MGT_EXTENSIONS		= (1 << 21),
-	IB_DEVICE_BLOCK_MULTICAST_LOOPBACK	= (1 << 22),
-	IB_DEVICE_MEM_WINDOW_TYPE_2A		= (1 << 23),
-	IB_DEVICE_MEM_WINDOW_TYPE_2B		= (1 << 24),
-	IB_DEVICE_RC_IP_CSUM			= (1 << 25),
+	IB_DEVICE_MEM_MGT_EXTENSIONS = IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS,
+	IB_DEVICE_BLOCK_MULTICAST_LOOPBACK = 1 << 22,
+	IB_DEVICE_MEM_WINDOW_TYPE_2A = IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A,
+	IB_DEVICE_MEM_WINDOW_TYPE_2B = IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B,
+	IB_DEVICE_RC_IP_CSUM = IB_UVERBS_DEVICE_RC_IP_CSUM,
 	/* Deprecated. Please use IB_RAW_PACKET_CAP_IP_CSUM. */
-	IB_DEVICE_RAW_IP_CSUM			= (1 << 26),
+	IB_DEVICE_RAW_IP_CSUM = IB_UVERBS_DEVICE_RAW_IP_CSUM,
 	/*
 	 * Devices should set IB_DEVICE_CROSS_CHANNEL if they
 	 * support execution of WQEs that involve synchronization
 	 * of I/O operations with single completion queue managed
 	 * by hardware.
 	 */
-	IB_DEVICE_CROSS_CHANNEL			= (1 << 27),
-	IB_DEVICE_MANAGED_FLOW_STEERING		= (1 << 29),
-	IB_DEVICE_INTEGRITY_HANDOVER		= (1 << 30),
-	IB_DEVICE_ON_DEMAND_PAGING		= (1ULL << 31),
-	IB_DEVICE_SG_GAPS_REG			= (1ULL << 32),
-	IB_DEVICE_VIRTUAL_FUNCTION		= (1ULL << 33),
+	IB_DEVICE_CROSS_CHANNEL = 1 << 27,
+	IB_DEVICE_MANAGED_FLOW_STEERING =
+		IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING,
+	IB_DEVICE_INTEGRITY_HANDOVER = 1 << 30,
+	IB_DEVICE_ON_DEMAND_PAGING = 1ULL << 31,
+	IB_DEVICE_SG_GAPS_REG = 1ULL << 32,
+	IB_DEVICE_VIRTUAL_FUNCTION = 1ULL << 33,
 	/* Deprecated. Please use IB_RAW_PACKET_CAP_SCATTER_FCS. */
-	IB_DEVICE_RAW_SCATTER_FCS		= (1ULL << 34),
-	IB_DEVICE_RDMA_NETDEV_OPA		= (1ULL << 35),
+	IB_DEVICE_RAW_SCATTER_FCS = IB_UVERBS_DEVICE_RAW_SCATTER_FCS,
+	IB_DEVICE_RDMA_NETDEV_OPA = 1ULL << 35,
 	/* The device supports padding incoming writes to cacheline. */
-	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
-	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
+	IB_DEVICE_PCI_WRITE_END_PADDING =
+		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	IB_DEVICE_ALLOW_USER_UNREG = 1ULL << 37,
 };
 
 enum ib_atomic_cap {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index ff549695f1ba..7f374cc1a9df 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1298,6 +1298,63 @@ struct ib_uverbs_ex_modify_cq {
 
 #define IB_DEVICE_NAME_MAX 64
 
+enum ib_uverbs_device_cap_flags {
+	IB_UVERBS_DEVICE_RESIZE_MAX_WR = 1 << 0,
+	IB_UVERBS_DEVICE_BAD_PKEY_CNTR = 1 << 1,
+	IB_UVERBS_DEVICE_BAD_QKEY_CNTR = 1 << 2,
+	IB_UVERBS_DEVICE_RAW_MULTI = 1 << 3,
+	IB_UVERBS_DEVICE_AUTO_PATH_MIG = 1 << 4,
+	IB_UVERBS_DEVICE_CHANGE_PHY_PORT = 1 << 5,
+	IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE = 1 << 6,
+	IB_UVERBS_DEVICE_CURR_QP_STATE_MOD = 1 << 7,
+	IB_UVERBS_DEVICE_SHUTDOWN_PORT = 1 << 8,
+	/* IB_UVERBS_DEVICE_INIT_TYPE = 1 << 9, (not in use) */
+	IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT = 1 << 10,
+	IB_UVERBS_DEVICE_SYS_IMAGE_GUID = 1 << 11,
+	IB_UVERBS_DEVICE_RC_RNR_NAK_GEN = 1 << 12,
+	IB_UVERBS_DEVICE_SRQ_RESIZE = 1 << 13,
+	IB_UVERBS_DEVICE_N_NOTIFY_CQ = 1 << 14,
+	IB_UVERBS_DEVICE_MEM_WINDOW = 1 << 17,
+	IB_UVERBS_DEVICE_UD_IP_CSUM = 1 << 18,
+	IB_UVERBS_DEVICE_XRC = 1 << 20,
+	IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS = 1 << 21,
+	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A = 1 << 23,
+	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B = 1 << 24,
+	IB_UVERBS_DEVICE_RC_IP_CSUM = 1 << 25,
+	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_IP_CSUM. */
+	IB_UVERBS_DEVICE_RAW_IP_CSUM = 1 << 26,
+	IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
+	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
+	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
+	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
+};
+
+#define IB_UVERBS_DEVICE_CAP_FLAGS_MASK	(IB_UVERBS_DEVICE_RESIZE_MAX_WR | \
+		IB_UVERBS_DEVICE_BAD_PKEY_CNTR | \
+		IB_UVERBS_DEVICE_BAD_QKEY_CNTR | \
+		IB_UVERBS_DEVICE_RAW_MULTI | \
+		IB_UVERBS_DEVICE_AUTO_PATH_MIG | \
+		IB_UVERBS_DEVICE_CHANGE_PHY_PORT | \
+		IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE | \
+		IB_UVERBS_DEVICE_CURR_QP_STATE_MOD | \
+		IB_UVERBS_DEVICE_SHUTDOWN_PORT | \
+		IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT | \
+		IB_UVERBS_DEVICE_SYS_IMAGE_GUID | \
+		IB_UVERBS_DEVICE_RC_RNR_NAK_GEN | \
+		IB_UVERBS_DEVICE_SRQ_RESIZE | \
+		IB_UVERBS_DEVICE_N_NOTIFY_CQ | \
+		IB_UVERBS_DEVICE_MEM_WINDOW | \
+		IB_UVERBS_DEVICE_UD_IP_CSUM | \
+		IB_UVERBS_DEVICE_XRC | \
+		IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS | \
+		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A | \
+		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B | \
+		IB_UVERBS_DEVICE_RC_IP_CSUM | \
+		IB_UVERBS_DEVICE_RAW_IP_CSUM | \
+		IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING | \
+		IB_UVERBS_DEVICE_RAW_SCATTER_FCS | \
+		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING)
+
 enum ib_uverbs_raw_packet_caps {
 	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING = 1 << 0,
 	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS = 1 << 1,
-- 
2.23.0



