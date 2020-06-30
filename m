Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0920F1C9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgF3Jj3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 05:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3Jj3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EBA20775;
        Tue, 30 Jun 2020 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509968;
        bh=vGQmVYKq/UpMM1EkfsBMWc77fa/92a5bpg8/eQcrKt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuJW9WU9k2DkyxewzbHrmQZFfIIWlJU/MlNedYqHJoTfGPOWrKqqkL0wE69tuCm+j
         XuTSlSF/Z3xDaie+wsU6knOnuqVlitlM/iTP71Zvm2ft1xUjck0z2bfrhTY7rW5p2q
         Q4hGf6Wvhi5v8cooopSDvxYrdKiQtXKKpP5j+INE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 3/7] IB/uverbs: Expose UAPI to query ucontext
Date:   Tue, 30 Jun 2020 12:39:12 +0300
Message-Id: <20200630093916.332097-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630093916.332097-1-leon@kernel.org>
References: <20200630093916.332097-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Expose UAPI to query ucontext, this will let user space application that
didn't allocate the ucontext but has access to by owning the matching
command FD to retrieve the ucontext information.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c              |  1 +
 .../infiniband/core/uverbs_std_types_device.c | 41 ++++++++++++++++++-
 include/rdma/ib_verbs.h                       |  4 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  6 +++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1335ed1f1e4a..1da1b0731f25 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2669,6 +2669,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, query_port);
 	SET_DEVICE_OP(dev_ops, query_qp);
 	SET_DEVICE_OP(dev_ops, query_srq);
+	SET_DEVICE_OP(dev_ops, query_ucontext);
 	SET_DEVICE_OP(dev_ops, rdma_netdev_get_params);
 	SET_DEVICE_OP(dev_ops, read_counters);
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index ae4a59d6f9b1..8e58605a17be 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -229,6 +229,37 @@ static int UVERBS_HANDLER(UVERBS_METHOD_GET_CONTEXT)(
 	return 0;
 }

+static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_CONTEXT)(
+	struct uverbs_attr_bundle *attrs)
+{
+	u64 core_support = IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS;
+	struct ib_ucontext *ucontext;
+	struct ib_device *ib_dev;
+	u32 num_comp;
+	int ret;
+
+	ucontext = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(ucontext);
+	ib_dev = ucontext->device;
+
+	if (!ib_dev->ops.query_ucontext)
+		return -EOPNOTSUPP;
+
+	num_comp = attrs->ufile->device->num_comp_vectors;
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_CONTEXT_NUM_COMP_VECTORS,
+			     &num_comp, sizeof(num_comp));
+	if (IS_UVERBS_COPY_ERR(ret))
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_CONTEXT_CORE_SUPPORT,
+			     &core_support, sizeof(core_support));
+	if (IS_UVERBS_COPY_ERR(ret))
+		return ret;
+
+	return ucontext->device->ops.query_ucontext(ucontext, attrs);
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_GET_CONTEXT,
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
@@ -237,6 +268,13 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(u64), UA_OPTIONAL),
 	UVERBS_ATTR_UHW());

+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QUERY_CONTEXT,
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_CONTEXT_NUM_COMP_VECTORS,
+			    UVERBS_ATTR_TYPE(u32), UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_CONTEXT_CORE_SUPPORT,
+			    UVERBS_ATTR_TYPE(u64), UA_OPTIONAL));
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_INFO_HANDLES,
 	/* Also includes any device specific object ids */
@@ -260,7 +298,8 @@ DECLARE_UVERBS_GLOBAL_METHODS(UVERBS_OBJECT_DEVICE,
 			      &UVERBS_METHOD(UVERBS_METHOD_GET_CONTEXT),
 			      &UVERBS_METHOD(UVERBS_METHOD_INVOKE_WRITE),
 			      &UVERBS_METHOD(UVERBS_METHOD_INFO_HANDLES),
-			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_PORT));
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_PORT),
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_CONTEXT));

 const struct uapi_definition uverbs_def_obj_device[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DEVICE),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 70f1c130d916..83de514ad485 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2646,6 +2646,10 @@ struct ib_device_ops {
 	 */
 	int (*fill_stat_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);

+	/* query driver for its ucontext properties */
+	int (*query_ucontext)(struct ib_ucontext *context,
+			      struct uverbs_attr_bundle *attrs);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 4961d5e858eb..83b6e71ea216 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
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
--
2.26.2

