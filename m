Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F972689C6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINLNL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgINLLr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:11:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D061D21973;
        Mon, 14 Sep 2020 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600081906;
        bh=ykW/fEHPP+LN76MrgB4/6lGra+vywqiBBw5xgU47FIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ex8YkAdzwKtD0RZ7KATuvWOgfCaaxz2Z2pBtJgokoEQ1xGWbwfj6NY5Dm4wzOWCiA
         7TREYXvRQ0/eddPzo/XkGyB+GCJxTOUdowjRPu3OvG9HNouybNLCvhFl3sRWEj/w9q
         RUCL32RrKXjEJfFBkSMu7KQ6ftvHMijQiagDMIeA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/4] RDMA/uverbs: Expose the new GID query API to user space
Date:   Mon, 14 Sep 2020 14:11:29 +0300
Message-Id: <20200914111129.343651-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914111129.343651-1-leon@kernel.org>
References: <20200914111129.343651-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Expose the query GID table and entry API to user space by adding
two new methods and method handlers to the device object.

This API provides a faster way to query a GID table using single call and
will be used in libibverbs to improve current approach that requires
multiple calls to open, close and read multiple sysfs files for a single
GID table entry.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../infiniband/core/uverbs_std_types_device.c | 182 +++++++++++++++++-
 include/rdma/ib_verbs.h                       |   6 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |   6 +
 4 files changed, 206 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 7b03446b6936..b0aa00d8586e 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -3,11 +3,13 @@
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
  */
 
+#include <linux/overflow.h>
 #include <rdma/uverbs_std_types.h>
 #include "rdma_core.h"
 #include "uverbs.h"
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/opa_addr.h>
+#include <rdma/ib_cache.h>
 
 /*
  * This ioctl method allows calling any defined write or write_ex
@@ -266,6 +268,158 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_CONTEXT)(
 	return ucontext->device->ops.query_ucontext(ucontext, attrs);
 }
 
+static int copy_gid_entries_to_user(struct uverbs_attr_bundle *attrs,
+				    struct ib_uverbs_gid_entry *entries,
+				    size_t num_entries, size_t user_entry_size)
+{
+	const struct uverbs_attr *attr;
+	void __user *user_entries;
+	size_t copy_len;
+	int ret;
+	int i;
+
+	if (user_entry_size == sizeof(*entries)) {
+		ret = uverbs_copy_to(attrs,
+				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
+				     entries, sizeof(*entries) * num_entries);
+		return ret;
+	}
+
+	copy_len = min_t(size_t, user_entry_size, sizeof(*entries));
+	attr = uverbs_attr_get(attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
+
+	user_entries = u64_to_user_ptr(attr->ptr_attr.data);
+	for (i = 0; i < num_entries; i++) {
+		if (copy_to_user(user_entries, entries, copy_len))
+			return -EFAULT;
+
+		if (user_entry_size > sizeof(*entries)) {
+			if (clear_user(user_entries + sizeof(*entries),
+				       user_entry_size - sizeof(*entries)))
+				return -EFAULT;
+		}
+
+		entries++;
+		user_entries += user_entry_size;
+	}
+
+	return uverbs_output_written(attrs,
+				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_gid_entry *entries;
+	struct ib_ucontext *ucontext;
+	struct ib_device *ib_dev;
+	size_t user_entry_size;
+	ssize_t num_entries;
+	size_t max_entries;
+	size_t num_bytes;
+	u32 flags;
+	int ret;
+
+	ret = uverbs_get_flags32(&flags, attrs,
+				 UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, 0);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_const(&user_entry_size, attrs,
+			       UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	max_entries = uverbs_attr_ptr_get_array_size(
+		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
+		user_entry_size);
+	if (max_entries <= 0)
+		return -EINVAL;
+
+	ucontext = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(ucontext);
+	ib_dev = ucontext->device;
+
+	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
+		return -EINVAL;
+
+	entries = uverbs_zalloc(attrs, num_bytes);
+	if (!entries)
+		return -ENOMEM;
+
+	num_entries = rdma_query_gid_table(ib_dev, entries, max_entries);
+	if (num_entries < 0)
+		return -EINVAL;
+
+	ret = copy_gid_entries_to_user(attrs, entries, num_entries,
+				       user_entry_size);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs,
+			     UVERBS_ATTR_QUERY_GID_TABLE_RESP_NUM_ENTRIES,
+			     &num_entries, sizeof(num_entries));
+	return ret;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	const struct ib_gid_attr *gid_attr;
+	struct ib_uverbs_gid_entry entry;
+	struct ib_ucontext *ucontext;
+	struct ib_device *ib_dev;
+	u32 gid_index;
+	u32 port_num;
+	u32 flags;
+	int ret;
+
+	ret = uverbs_get_flags32(&flags, attrs,
+				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_const(&port_num, attrs,
+			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_const(&gid_index, attrs,
+			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
+	if (ret)
+		return ret;
+
+	ucontext = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(ucontext);
+	ib_dev = ucontext->device;
+
+	if (!rdma_ib_or_roce(ib_dev, port_num))
+		return -EINVAL;
+
+	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
+	if (IS_ERR(gid_attr))
+		return PTR_ERR(gid_attr);
+
+	memcpy(&entry.gid, &gid_attr->gid, sizeof(gid_attr->gid));
+	entry.gid_index = gid_attr->index;
+	entry.port_num = gid_attr->port_num;
+	entry.gid_type = gid_attr->gid_type;
+	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
+	if (ret)
+		goto out;
+
+	ret = uverbs_copy_to_struct_or_zero(
+		attrs, UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY, &entry,
+		sizeof(entry));
+out:
+	rdma_put_gid_attr(gid_attr);
+	return ret;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_GET_CONTEXT,
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
@@ -300,12 +454,38 @@ DECLARE_UVERBS_NAMED_METHOD(
 				   reserved),
 		UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QUERY_GID_TABLE,
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE, u64,
+			     UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, u32,
+			     UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
+			    UVERBS_ATTR_MIN_SIZE(0), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_GID_TABLE_RESP_NUM_ENTRIES,
+			    UVERBS_ATTR_TYPE(u64), UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QUERY_GID_ENTRY,
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_QUERY_GID_ENTRY_PORT, u32,
+			     UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX, u32,
+			     UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, u32,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY,
+			    UVERBS_ATTR_STRUCT(struct ib_uverbs_gid_entry,
+					       netdev_ifindex),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_GLOBAL_METHODS(UVERBS_OBJECT_DEVICE,
 			      &UVERBS_METHOD(UVERBS_METHOD_GET_CONTEXT),
 			      &UVERBS_METHOD(UVERBS_METHOD_INVOKE_WRITE),
 			      &UVERBS_METHOD(UVERBS_METHOD_INFO_HANDLES),
 			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_PORT),
-			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_CONTEXT));
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_CONTEXT),
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_GID_TABLE),
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_GID_ENTRY));
 
 const struct uapi_definition uverbs_def_obj_device[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DEVICE),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 80cc0f5de5c3..1e170e09afb0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -138,9 +138,9 @@ union ib_gid {
 extern union ib_gid zgid;
 
 enum ib_gid_type {
-	IB_GID_TYPE_IB        = 0,
-	IB_GID_TYPE_ROCE      = 1,
-	IB_GID_TYPE_ROCE_UDP_ENCAP = 2,
+	IB_GID_TYPE_IB = IB_UVERBS_GID_TYPE_IB,
+	IB_GID_TYPE_ROCE = IB_UVERBS_GID_TYPE_ROCE_V1,
+	IB_GID_TYPE_ROCE_UDP_ENCAP = IB_UVERBS_GID_TYPE_ROCE_V2,
 	IB_GID_TYPE_SIZE
 };
 
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 99dcabf61a71..7968a1845355 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -70,6 +70,8 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_QUERY_PORT,
 	UVERBS_METHOD_GET_CONTEXT,
 	UVERBS_METHOD_QUERY_CONTEXT,
+	UVERBS_METHOD_QUERY_GID_TABLE,
+	UVERBS_METHOD_QUERY_GID_ENTRY,
 };
 
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -352,4 +354,18 @@ enum uverbs_attrs_async_event_create {
 	UVERBS_ATTR_ASYNC_EVENT_ALLOC_FD_HANDLE,
 };
 
+enum uverbs_attrs_query_gid_table_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE,
+	UVERBS_ATTR_QUERY_GID_TABLE_FLAGS,
+	UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
+	UVERBS_ATTR_QUERY_GID_TABLE_RESP_NUM_ENTRIES,
+};
+
+enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_GID_ENTRY_PORT,
+	UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX,
+	UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS,
+	UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY,
+};
+
 #endif
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index d5ac65ae2557..cfea82acfe57 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -250,6 +250,12 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 };
 
+enum ib_uverbs_gid_type {
+	IB_UVERBS_GID_TYPE_IB,
+	IB_UVERBS_GID_TYPE_ROCE_V1,
+	IB_UVERBS_GID_TYPE_ROCE_V2,
+};
+
 struct ib_uverbs_gid_entry {
 	__aligned_u64 gid[2];
 	__u32 gid_index;
-- 
2.26.2

