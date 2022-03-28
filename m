Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559EC4E9BAC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiC1Ptq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiC1Prf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 11:47:35 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBBA74C7B3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 08:45:37 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AzM6SKavDz3nhLrIYrViN6llO9efnVGlcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mjdKCz+OP6yDamr2Kd9zOdvj8BwOuZTXzYNgGwM9/H9gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1cvJq/W?=
 =?us-ascii?q?UErL4XCheYcTwJFVSp5OMWq/ZeeeyPn6pHPkRGun3zEhq8G4FsNFYkV/eBfAmx?=
 =?us-ascii?q?U8/EcbjcXYXirhe256LSlS+Vtj4IoK8yDFIcevGxwiCvVCP8OX5/OWePJ6MVe0?=
 =?us-ascii?q?TN2gdpBdcsyzeJxhSFHNUyGOkMQfAxMTs9WoQthvVGnGxUwlb5fjfNfD7Dv8TF?=
 =?us-ascii?q?M?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AoUvwU6wCzMcO9bDaAEhfKrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+U8ssR4b+exoVJPtfZqYz+8R3WBzB8bEYOCFgh?=
 =?us-ascii?q?rKEGgK1+KLqFeMJ8S9zJ846U4KSclD4bPLYmSS9fyKgjVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123035464"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Mar 2022 23:45:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9BCCE4D169FF;
        Mon, 28 Mar 2022 23:45:34 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 28 Mar 2022 23:45:37 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 28 Mar 2022 23:45:15 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <leon@kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 2/2] IB/uverbs: Move part of enum ib_device_cap_flags to uapi
Date:   Mon, 28 Mar 2022 23:45:11 +0800
Message-ID: <20220328154511.305319-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328154511.305319-1-yangx.jy@fujitsu.com>
References: <20220328154511.305319-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9BCCE4D169FF.AD5F3
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

1) Part of enum ib_device_cap_flags are used by ibv_query_device(3)
   or ibv_query_device_ex(3), so we define them in
   include/uapi/rdma/ib_user_verbs.h and only expose them to userspace.

2) Reformat enum ib_device_cap_flags by removing the indent before '='.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/core/uverbs_cmd.c |   6 +-
 include/rdma/ib_verbs.h              | 104 +++++++++++++++++----------
 include/uapi/rdma/ib_user_verbs.h    |  31 ++++++++
 3 files changed, 101 insertions(+), 40 deletions(-)

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
index e3ed65920558..710517d57f84 100644
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
@@ -266,32 +266,60 @@ enum ib_device_cap_flags {
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
-};
+	IB_DEVICE_PCI_WRITE_END_PADDING =
+		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	IB_DEVICE_ALLOW_USER_UNREG = 1ULL << 37,
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
 
 enum ib_atomic_cap {
 	IB_ATOMIC_NONE,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index ff549695f1ba..06a4897c4958 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1298,6 +1298,37 @@ struct ib_uverbs_ex_modify_cq {
 
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
 enum ib_uverbs_raw_packet_caps {
 	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING = 1 << 0,
 	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS = 1 << 1,
-- 
2.34.1



