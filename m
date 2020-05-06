Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA81C6D57
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEFJmH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:07 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32986 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728854AbgEFJmG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:06 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0Kq015438;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469fxiC024583;
        Wed, 6 May 2020 12:41:59 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469fx5p024582;
        Wed, 6 May 2020 12:41:59 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 1/8] Update kernel headers
Date:   Wed,  6 May 2020 12:41:02 +0300
Message-Id: <1588758069-24464-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit 86a2d80e24eb ("IB/uverbs: Introduce create/destroy QP commands over ioctl")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h  | 81 +++++++++++++++++++++++++++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h | 43 ++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma/ib_user_ioctl_cmds.h
index d4ddbe4..4961d5e 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -95,6 +95,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_COMP_VECTOR,
 	UVERBS_ATTR_CREATE_CQ_FLAGS,
 	UVERBS_ATTR_CREATE_CQ_RESP_CQE,
+	UVERBS_ATTR_CREATE_CQ_EVENT_FD,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
@@ -120,11 +121,91 @@ enum uverbs_attrs_destroy_flow_action_esp {
 	UVERBS_ATTR_DESTROY_FLOW_ACTION_HANDLE,
 };
 
+enum uverbs_attrs_create_qp_cmd_attr_ids {
+	UVERBS_ATTR_CREATE_QP_HANDLE,
+	UVERBS_ATTR_CREATE_QP_XRCD_HANDLE,
+	UVERBS_ATTR_CREATE_QP_PD_HANDLE,
+	UVERBS_ATTR_CREATE_QP_SRQ_HANDLE,
+	UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
+	UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE,
+	UVERBS_ATTR_CREATE_QP_IND_TABLE_HANDLE,
+	UVERBS_ATTR_CREATE_QP_USER_HANDLE,
+	UVERBS_ATTR_CREATE_QP_CAP,
+	UVERBS_ATTR_CREATE_QP_TYPE,
+	UVERBS_ATTR_CREATE_QP_FLAGS,
+	UVERBS_ATTR_CREATE_QP_SOURCE_QPN,
+	UVERBS_ATTR_CREATE_QP_EVENT_FD,
+	UVERBS_ATTR_CREATE_QP_RESP_CAP,
+	UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+};
+
+enum uverbs_attrs_destroy_qp_cmd_attr_ids {
+	UVERBS_ATTR_DESTROY_QP_HANDLE,
+	UVERBS_ATTR_DESTROY_QP_RESP,
+};
+
+enum uverbs_methods_qp {
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_METHOD_QP_DESTROY,
+};
+
+enum uverbs_attrs_create_srq_cmd_attr_ids {
+	UVERBS_ATTR_CREATE_SRQ_HANDLE,
+	UVERBS_ATTR_CREATE_SRQ_PD_HANDLE,
+	UVERBS_ATTR_CREATE_SRQ_XRCD_HANDLE,
+	UVERBS_ATTR_CREATE_SRQ_CQ_HANDLE,
+	UVERBS_ATTR_CREATE_SRQ_USER_HANDLE,
+	UVERBS_ATTR_CREATE_SRQ_MAX_WR,
+	UVERBS_ATTR_CREATE_SRQ_MAX_SGE,
+	UVERBS_ATTR_CREATE_SRQ_LIMIT,
+	UVERBS_ATTR_CREATE_SRQ_MAX_NUM_TAGS,
+	UVERBS_ATTR_CREATE_SRQ_TYPE,
+	UVERBS_ATTR_CREATE_SRQ_EVENT_FD,
+	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR,
+	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE,
+	UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
+};
+
+enum uverbs_attrs_destroy_srq_cmd_attr_ids {
+	UVERBS_ATTR_DESTROY_SRQ_HANDLE,
+	UVERBS_ATTR_DESTROY_SRQ_RESP,
+};
+
+enum uverbs_methods_srq {
+	UVERBS_METHOD_SRQ_CREATE,
+	UVERBS_METHOD_SRQ_DESTROY,
+};
+
 enum uverbs_methods_cq {
 	UVERBS_METHOD_CQ_CREATE,
 	UVERBS_METHOD_CQ_DESTROY,
 };
 
+enum uverbs_attrs_create_wq_cmd_attr_ids {
+	UVERBS_ATTR_CREATE_WQ_HANDLE,
+	UVERBS_ATTR_CREATE_WQ_PD_HANDLE,
+	UVERBS_ATTR_CREATE_WQ_CQ_HANDLE,
+	UVERBS_ATTR_CREATE_WQ_USER_HANDLE,
+	UVERBS_ATTR_CREATE_WQ_TYPE,
+	UVERBS_ATTR_CREATE_WQ_EVENT_FD,
+	UVERBS_ATTR_CREATE_WQ_MAX_WR,
+	UVERBS_ATTR_CREATE_WQ_MAX_SGE,
+	UVERBS_ATTR_CREATE_WQ_FLAGS,
+	UVERBS_ATTR_CREATE_WQ_RESP_MAX_WR,
+	UVERBS_ATTR_CREATE_WQ_RESP_MAX_SGE,
+	UVERBS_ATTR_CREATE_WQ_RESP_WQ_NUM,
+};
+
+enum uverbs_attrs_destroy_wq_cmd_attr_ids {
+	UVERBS_ATTR_DESTROY_WQ_HANDLE,
+	UVERBS_ATTR_DESTROY_WQ_RESP,
+};
+
+enum uverbs_methods_wq {
+	UVERBS_METHOD_WQ_CREATE,
+	UVERBS_METHOD_WQ_DESTROY,
+};
+
 enum uverbs_methods_actions_flow_action_ops {
 	UVERBS_METHOD_FLOW_ACTION_ESP_CREATE,
 	UVERBS_METHOD_FLOW_ACTION_DESTROY,
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index a640bb8..5debab4 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -64,6 +64,41 @@ enum ib_uverbs_access_flags {
 		~(IB_UVERBS_ACCESS_OPTIONAL_FIRST - 1)
 };
 
+enum ib_uverbs_srq_type {
+	IB_UVERBS_SRQT_BASIC,
+	IB_UVERBS_SRQT_XRC,
+	IB_UVERBS_SRQT_TM,
+};
+
+enum ib_uverbs_wq_type {
+	IB_UVERBS_WQT_RQ,
+};
+
+enum ib_uverbs_wq_flags {
+	IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING = 1 << 0,
+	IB_UVERBS_WQ_FLAGS_SCATTER_FCS = 1 << 1,
+	IB_UVERBS_WQ_FLAGS_DELAY_DROP = 1 << 2,
+	IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING = 1 << 3,
+};
+
+enum ib_uverbs_qp_type {
+	IB_UVERBS_QPT_RC = 2,
+	IB_UVERBS_QPT_UC,
+	IB_UVERBS_QPT_UD,
+	IB_UVERBS_QPT_RAW_PACKET = 8,
+	IB_UVERBS_QPT_XRC_INI,
+	IB_UVERBS_QPT_XRC_TGT,
+	IB_UVERBS_QPT_DRIVER = 0xFF,
+};
+
+enum ib_uverbs_qp_create_flags {
+	IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK = 1 << 1,
+	IB_UVERBS_QP_CREATE_SCATTER_FCS = 1 << 8,
+	IB_UVERBS_QP_CREATE_CVLAN_STRIPPING = 1 << 9,
+	IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING = 1 << 11,
+	IB_UVERBS_QP_CREATE_SQ_SIG_ALL = 1 << 12,
+};
+
 enum ib_uverbs_query_port_cap_flags {
 	IB_UVERBS_PCF_SM = 1 << 1,
 	IB_UVERBS_PCF_NOTICE_SUP = 1 << 2,
@@ -185,6 +220,14 @@ struct ib_uverbs_query_port_resp_ex {
 	__u8  reserved[6];
 };
 
+struct ib_uverbs_qp_cap {
+	__u32 max_send_wr;
+	__u32 max_recv_wr;
+	__u32 max_send_sge;
+	__u32 max_recv_sge;
+	__u32 max_inline_data;
+};
+
 enum rdma_driver_id {
 	RDMA_DRIVER_UNKNOWN,
 	RDMA_DRIVER_MLX5,
-- 
1.8.3.1

