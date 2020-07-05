Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB7214B1D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgGEIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33103 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726538AbgGEIUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5nB001667;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K4gq009266;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K49r009265;
        Sun, 5 Jul 2020 11:20:04 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 01/13] Update kernel headers
Date:   Sun,  5 Jul 2020 11:19:37 +0300
Message-Id: <1593937189-8744-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit e538e95bb437 ("IB/uverbs: Expose UAPI to query MR")

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h   | 15 +++++++++++++++
 kernel-headers/rdma/mlx5_user_ioctl_cmds.h | 14 ++++++++++++++
 kernel-headers/rdma/rdma_netlink.h         |  8 ++++++++
 kernel-headers/rdma/rdma_user_ioctl_cmds.h |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

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

