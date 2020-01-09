Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712CC135AEF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgAIOFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 09:05:24 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33796 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727738AbgAIOFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 09:05:23 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Jan 2020 16:05:15 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FhS016592;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 009E5FVl001325;
        Thu, 9 Jan 2020 16:05:15 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 009E5FBh001324;
        Thu, 9 Jan 2020 16:05:15 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com, yishaih@mellanox.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-core 1/7] Update kernel headers
Date:   Thu,  9 Jan 2020 16:04:30 +0200
Message-Id: <1578578676-752-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

to commit 336883935151 ("RDMA/mlx5: Set relaxed ordering when requested")

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 kernel-headers/rdma/ib_user_ioctl_cmds.h  | 15 +++++++++++++++
 kernel-headers/rdma/ib_user_ioctl_verbs.h | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/kernel-headers/rdma/ib_user_ioctl_cmds.h b/kernel-headers/rdma/ib_user_ioctl_cmds.h
index 64f0e3a..d4ddbe4 100644
--- a/kernel-headers/rdma/ib_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/ib_user_ioctl_cmds.h
@@ -56,6 +56,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_FLOW_ACTION,
 	UVERBS_OBJECT_DM,
 	UVERBS_OBJECT_COUNTERS,
+	UVERBS_OBJECT_ASYNC_EVENT,
 };
 
 enum {
@@ -67,6 +68,7 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_INVOKE_WRITE,
 	UVERBS_METHOD_INFO_HANDLES,
 	UVERBS_METHOD_QUERY_PORT,
+	UVERBS_METHOD_GET_CONTEXT,
 };
 
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -80,6 +82,11 @@ enum uverbs_attrs_query_port_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_PORT_RESP,
 };
 
+enum uverbs_attrs_get_context_attr_ids {
+	UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
+	UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
+};
+
 enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_HANDLE,
 	UVERBS_ATTR_CREATE_CQ_CQE,
@@ -241,4 +248,12 @@ enum uverbs_attrs_flow_destroy_ids {
 	UVERBS_ATTR_DESTROY_FLOW_HANDLE,
 };
 
+enum uverbs_method_async_event {
+	UVERBS_METHOD_ASYNC_EVENT_ALLOC,
+};
+
+enum uverbs_attrs_async_event_create {
+	UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE,
+};
+
 #endif
diff --git a/kernel-headers/rdma/ib_user_ioctl_verbs.h b/kernel-headers/rdma/ib_user_ioctl_verbs.h
index 9019b2d..a640bb8 100644
--- a/kernel-headers/rdma/ib_user_ioctl_verbs.h
+++ b/kernel-headers/rdma/ib_user_ioctl_verbs.h
@@ -41,6 +41,13 @@
 #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
 #endif
 
+#define IB_UVERBS_ACCESS_OPTIONAL_FIRST (1 << 20)
+#define IB_UVERBS_ACCESS_OPTIONAL_LAST (1 << 29)
+
+enum ib_uverbs_core_support {
+	IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS = 1 << 0,
+};
+
 enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_LOCAL_WRITE = 1 << 0,
 	IB_UVERBS_ACCESS_REMOTE_WRITE = 1 << 1,
@@ -50,6 +57,11 @@ enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_ZERO_BASED = 1 << 5,
 	IB_UVERBS_ACCESS_ON_DEMAND = 1 << 6,
 	IB_UVERBS_ACCESS_HUGETLB = 1 << 7,
+
+	IB_UVERBS_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
+	IB_UVERBS_ACCESS_OPTIONAL_RANGE =
+		((IB_UVERBS_ACCESS_OPTIONAL_LAST << 1) - 1) &
+		~(IB_UVERBS_ACCESS_OPTIONAL_FIRST - 1)
 };
 
 enum ib_uverbs_query_port_cap_flags {
-- 
1.8.3.1

