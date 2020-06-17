Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5169B1FC7D0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFQHqd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37707 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgFQHqc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:32 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:28 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kSUR017627;
        Wed, 17 Jun 2020 10:46:28 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kSr5007161;
        Wed, 17 Jun 2020 10:46:28 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kSSS007160;
        Wed, 17 Jun 2020 10:46:28 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 01/13] Update kernel headers
Date:   Wed, 17 Jun 2020 10:45:44 +0300
Message-Id: <1592379956-7043-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit fc1d90c1f17c ("IB/uverbs: Expose KABI to query MR")

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h   | 15 +++++++++++++++
 kernel-headers/rdma/mlx5-abi.h             |  9 +++++++--
 kernel-headers/rdma/mlx5_user_ioctl_cmds.h | 14 ++++++++++++++
 kernel-headers/rdma/rdma_netlink.h         |  8 ++++++++
 kernel-headers/rdma/rdma_user_cm.h         | 11 ++++++++++-
 kernel-headers/rdma/rdma_user_ioctl_cmds.h |  2 +-
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma/ib_user_ioctl_cmds.h
index 4961d5e..99dcabf 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -69,6 +69,7 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_INFO_HANDLES,
 	UVERBS_METHOD_QUERY_PORT,
 	UVERBS_METHOD_GET_CONTEXT,
+	UVERBS_METHOD_QUERY_CONTEXT,
 };
 
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -87,6 +88,11 @@ enum uverbs_attrs_get_context_attr_ids {
 	UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
 };
 
+enum uverbs_attrs_query_context_attr_ids {
+	UVERBS_ATTR_QUERY_CONTEXT_NUM_COMP_VECTORS,
+	UVERBS_ATTR_QUERY_CONTEXT_CORE_SUPPORT,
+};
+
 enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_HANDLE,
 	UVERBS_ATTR_CREATE_CQ_CQE,
@@ -242,6 +248,7 @@ enum uverbs_methods_mr {
 	UVERBS_METHOD_DM_MR_REG,
 	UVERBS_METHOD_MR_DESTROY,
 	UVERBS_METHOD_ADVISE_MR,
+	UVERBS_METHOD_QUERY_MR,
 };
 
 enum uverbs_attrs_mr_destroy_ids {
@@ -255,6 +262,14 @@ enum uverbs_attrs_advise_mr_cmd_attr_ids {
 	UVERBS_ATTR_ADVISE_MR_SGE_LIST,
 };
 
+enum uverbs_attrs_query_mr_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_MR_HANDLE,
+	UVERBS_ATTR_QUERY_MR_RESP_LKEY,
+	UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+	UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+	UVERBS_ATTR_QUERY_MR_RESP_IOVA,
+};
+
 enum uverbs_attrs_create_counters_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_COUNTERS_HANDLE,
 };
diff --git a/kernel-headers/rdma/mlx5-abi.h b/kernel-headers/rdma/mlx5-abi.h
index df1cc36..27905a0 100644
--- a/kernel-headers/rdma/mlx5-abi.h
+++ b/kernel-headers/rdma/mlx5-abi.h
@@ -100,6 +100,7 @@ struct mlx5_ib_alloc_ucontext_req_v2 {
 enum mlx5_ib_alloc_ucontext_resp_mask {
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
+	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
 };
 
 enum mlx5_user_cmds_supp_uhw {
@@ -322,6 +323,8 @@ struct mlx5_ib_create_qp {
 		__aligned_u64 sq_buf_addr;
 		__aligned_u64 access_key;
 	};
+	__u32  ece_options;
+	__u32  reserved;
 };
 
 /* RX Hash function flags */
@@ -371,7 +374,7 @@ enum mlx5_ib_create_qp_resp_mask {
 
 struct mlx5_ib_create_qp_resp {
 	__u32	bfreg_index;
-	__u32   reserved;
+	__u32   ece_options;
 	__u32	comp_mask;
 	__u32	tirn;
 	__u32	tisn;
@@ -420,12 +423,14 @@ struct mlx5_ib_burst_info {
 struct mlx5_ib_modify_qp {
 	__u32			   comp_mask;
 	struct mlx5_ib_burst_info  burst_info;
-	__u32			   reserved;
+	__u32			   ece_options;
 };
 
 struct mlx5_ib_modify_qp_resp {
 	__u32	response_length;
 	__u32	dctn;
+	__u32   ece_options;
+	__u32   reserved;
 };
 
 struct mlx5_ib_create_wq_resp {
diff --git a/kernel-headers/rdma/mlx5_user_ioctl_cmds.h b/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
index 8e316ef..b330e6e 100644
--- a/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/mlx5_user_ioctl_cmds.h
@@ -228,6 +228,10 @@ enum mlx5_ib_flow_matcher_methods {
 	MLX5_IB_METHOD_FLOW_MATCHER_DESTROY,
 };
 
+enum mlx5_ib_device_query_context_attrs {
+	MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX = (1U << UVERBS_ID_NS_SHIFT),
+};
+
 #define MLX5_IB_DW_MATCH_PARAM 0x80
 
 struct mlx5_ib_match_params {
@@ -286,4 +290,14 @@ enum mlx5_ib_create_flow_action_create_packet_reformat_attrs {
 	MLX5_IB_ATTR_CREATE_PACKET_REFORMAT_DATA_BUF,
 };
 
+enum mlx5_ib_query_pd_attrs {
+	MLX5_IB_ATTR_QUERY_PD_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_ATTR_QUERY_PD_RESP_PDN,
+};
+
+enum mlx5_ib_pd_methods {
+	MLX5_IB_METHOD_PD_QUERY = (1U << UVERBS_ID_NS_SHIFT),
+
+};
+
 #endif
diff --git a/kernel-headers/rdma/rdma_netlink.h b/kernel-headers/rdma/rdma_netlink.h
index 8e27778..3826143 100644
--- a/kernel-headers/rdma/rdma_netlink.h
+++ b/kernel-headers/rdma/rdma_netlink.h
@@ -287,6 +287,12 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_STAT_DEL,
 
+	RDMA_NLDEV_CMD_RES_QP_GET_RAW,
+
+	RDMA_NLDEV_CMD_RES_CQ_GET_RAW,
+
+	RDMA_NLDEV_CMD_RES_MR_GET_RAW,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -525,6 +531,8 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
 
+	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
+
 	/*
 	 * Always the end
 	 */
diff --git a/kernel-headers/rdma/rdma_user_cm.h b/kernel-headers/rdma/rdma_user_cm.h
index 1bb6e75..ed5a514 100644
--- a/kernel-headers/rdma/rdma_user_cm.h
+++ b/kernel-headers/rdma/rdma_user_cm.h
@@ -210,10 +210,16 @@ struct rdma_ucm_ud_param {
 	__u8  reserved[7];
 };
 
+struct rdma_ucm_ece {
+	__u32 vendor_id;
+	__u32 attr_mod;
+};
+
 struct rdma_ucm_connect {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_ucm_listen {
@@ -226,12 +232,14 @@ struct rdma_ucm_accept {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_ucm_reject {
 	__u32 id;
 	__u8  private_data_len;
-	__u8  reserved[3];
+	__u8  reason;
+	__u8  reserved[2];
 	__u8  private_data[RDMA_MAX_PRIVATE_DATA];
 };
 
@@ -291,6 +299,7 @@ struct rdma_ucm_event_resp {
 		struct rdma_ucm_ud_param   ud;
 	} param;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 /* Option levels */
diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
index 7b1ec80..38ab7ac 100644
--- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
@@ -36,7 +36,7 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
-/* Documentation/ioctl/ioctl-number.rst */
+/* Documentation/userspace-api/ioctl/ioctl-number.rst */
 #define RDMA_IOCTL_MAGIC	0x1b
 #define RDMA_VERBS_IOCTL \
 	_IOWR(RDMA_IOCTL_MAGIC, 1, struct ib_uverbs_ioctl_hdr)
-- 
1.8.3.1

