Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D51C6A39
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgEFHlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:41:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 530E8206E6;
        Wed,  6 May 2020 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750878;
        bh=fUOrXF7Hg4ZlZzFMIOuRKxeEORKdDJCZ+r734Ta2XNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QguCwkrrGvTFtwkgMpRr9zHQQFuEx+ZPXx51samWI6OeTxOliuTVVXF+TceW99T4b
         6UXCmoPRg2XWOu+XFCLt/dWTAezcjPUElp+O/348CAuPWob08Qxplc1ZehxRsiZXMc
         2++SI/uqRGhG41nFoEgxRyvkkD/9sjkf1ZOwl+Ww=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/9] IB/uverbs: Introduce create/destroy SRQ commands over ioctl
Date:   Wed,  6 May 2020 10:40:46 +0300
Message-Id: <20200506074049.8347-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074049.8347-1-leon@kernel.org>
References: <20200506074049.8347-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Introduce create/destroy SRQ commands over the ioctl interface to let it
be extended to get an asynchronous event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/Makefile              |   3 +-
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/uverbs_std_types.c    |  32 ---
 .../infiniband/core/uverbs_std_types_srq.c    | 233 ++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  27 ++
 6 files changed, 264 insertions(+), 33 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_srq.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 870f0fcd54d5..d7b46a7c07fd 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -36,6 +36,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
 				uverbs_std_types_mr.o uverbs_std_types_counters.o \
 				uverbs_uapi.o uverbs_std_types_device.o \
-				uverbs_std_types_async_fd.o
+				uverbs_std_types_async_fd.o \
+				uverbs_std_types_srq.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 2b529233e159..d623f911b70b 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -159,6 +159,7 @@ extern const struct uapi_definition uverbs_def_obj_dm[];
 extern const struct uapi_definition uverbs_def_obj_flow_action[];
 extern const struct uapi_definition uverbs_def_obj_intf[];
 extern const struct uapi_definition uverbs_def_obj_mr[];
+extern const struct uapi_definition uverbs_def_obj_srq[];
 extern const struct uapi_definition uverbs_def_write_intf[];
 
 static inline const struct uverbs_api_write_method *
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 3abfc63225cb..d9b6912eafa8 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -142,31 +142,6 @@ static int uverbs_free_wq(struct ib_uobject *uobject,
 	return ret;
 }
 
-static int uverbs_free_srq(struct ib_uobject *uobject,
-			   enum rdma_remove_reason why,
-			   struct uverbs_attr_bundle *attrs)
-{
-	struct ib_srq *srq = uobject->object;
-	struct ib_uevent_object *uevent =
-		container_of(uobject, struct ib_uevent_object, uobject);
-	enum ib_srq_type  srq_type = srq->srq_type;
-	int ret;
-
-	ret = ib_destroy_srq_user(srq, &attrs->driver_udata);
-	if (ib_is_destroy_retryable(ret, why, uobject))
-		return ret;
-
-	if (srq_type == IB_SRQT_XRC) {
-		struct ib_usrq_object *us =
-			container_of(uevent, struct ib_usrq_object, uevent);
-
-		atomic_dec(&us->uxrcd->refcnt);
-	}
-
-	ib_uverbs_release_uevent(uevent);
-	return ret;
-}
-
 static int uverbs_free_xrcd(struct ib_uobject *uobject,
 			    enum rdma_remove_reason why,
 			    struct uverbs_attr_bundle *attrs)
@@ -267,11 +242,6 @@ DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_MW,
 			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_mw),
 			    &UVERBS_METHOD(UVERBS_METHOD_MW_DESTROY));
 
-DECLARE_UVERBS_NAMED_OBJECT(
-	UVERBS_OBJECT_SRQ,
-	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_usrq_object),
-				 uverbs_free_srq));
-
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_AH_DESTROY,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_AH_HANDLE,
@@ -346,8 +316,6 @@ const struct uapi_definition uverbs_def_obj_intf[] = {
 				      UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MW,
 				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_mw)),
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_SRQ,
-				      UAPI_DEF_OBJ_NEEDS_FN(destroy_srq)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_FLOW,
 				      UAPI_DEF_OBJ_NEEDS_FN(destroy_flow)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_WQ,
diff --git a/drivers/infiniband/core/uverbs_std_types_srq.c b/drivers/infiniband/core/uverbs_std_types_srq.c
new file mode 100644
index 000000000000..d74601c47d95
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_srq.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include "rdma_core.h"
+#include "uverbs.h"
+
+static int uverbs_free_srq(struct ib_uobject *uobject,
+		    enum rdma_remove_reason why,
+		    struct uverbs_attr_bundle *attrs)
+{
+	struct ib_srq *srq = uobject->object;
+	struct ib_uevent_object *uevent =
+		container_of(uobject, struct ib_uevent_object, uobject);
+	enum ib_srq_type srq_type = srq->srq_type;
+	int ret;
+
+	ret = ib_destroy_srq_user(srq, &attrs->driver_udata);
+	if (ib_is_destroy_retryable(ret, why, uobject))
+		return ret;
+
+	if (srq_type == IB_SRQT_XRC) {
+		struct ib_usrq_object *us =
+			container_of(uevent, struct ib_usrq_object, uevent);
+
+		atomic_dec(&us->uxrcd->refcnt);
+	}
+
+	ib_uverbs_release_uevent(uevent);
+	return ret;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_SRQ_CREATE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_usrq_object *obj = container_of(
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_SRQ_HANDLE),
+		typeof(*obj), uevent.uobject);
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_SRQ_PD_HANDLE);
+	struct ib_srq_init_attr attr = {};
+	struct ib_uobject *uninitialized_var(xrcd_uobj);
+	struct ib_srq *srq;
+	u64 user_handle;
+	int ret;
+
+	ret = uverbs_copy_from(&attr.attr.max_sge, attrs,
+			       UVERBS_ATTR_CREATE_SRQ_MAX_SGE);
+	if (!ret)
+		ret = uverbs_copy_from(&attr.attr.max_wr, attrs,
+				       UVERBS_ATTR_CREATE_SRQ_MAX_WR);
+	if (!ret)
+		ret = uverbs_copy_from(&attr.attr.srq_limit, attrs,
+				       UVERBS_ATTR_CREATE_SRQ_LIMIT);
+	if (!ret)
+		ret = uverbs_copy_from(&user_handle, attrs,
+				       UVERBS_ATTR_CREATE_SRQ_USER_HANDLE);
+	if (!ret)
+		ret = uverbs_get_const(&attr.srq_type, attrs,
+				       UVERBS_ATTR_CREATE_SRQ_TYPE);
+	if (ret)
+		return ret;
+
+	if (ib_srq_has_cq(attr.srq_type)) {
+		attr.ext.cq = uverbs_attr_get_obj(attrs,
+					UVERBS_ATTR_CREATE_SRQ_CQ_HANDLE);
+		if (IS_ERR(attr.ext.cq))
+			return PTR_ERR(attr.ext.cq);
+	}
+
+	switch (attr.srq_type) {
+	case IB_UVERBS_SRQT_XRC:
+		xrcd_uobj = uverbs_attr_get_uobject(attrs,
+					UVERBS_ATTR_CREATE_SRQ_XRCD_HANDLE);
+		if (IS_ERR(xrcd_uobj))
+			return PTR_ERR(xrcd_uobj);
+
+		attr.ext.xrc.xrcd = (struct ib_xrcd *)xrcd_uobj->object;
+		if (!attr.ext.xrc.xrcd)
+			return -EINVAL;
+		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
+					  uobject);
+		atomic_inc(&obj->uxrcd->refcnt);
+		break;
+	case IB_UVERBS_SRQT_TM:
+		ret = uverbs_copy_from(&attr.ext.tag_matching.max_num_tags,
+				       attrs,
+				       UVERBS_ATTR_CREATE_SRQ_MAX_NUM_TAGS);
+		if (ret)
+			return ret;
+		break;
+	case IB_UVERBS_SRQT_BASIC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	obj->uevent.event_file = ib_uverbs_get_async_event(attrs,
+					UVERBS_ATTR_CREATE_SRQ_EVENT_FD);
+	INIT_LIST_HEAD(&obj->uevent.event_list);
+	attr.event_handler = ib_uverbs_srq_event_handler;
+	obj->uevent.uobject.user_handle = user_handle;
+
+	srq = ib_create_srq_user(pd, &attr, obj, &attrs->driver_udata);
+	if (IS_ERR(srq)) {
+		ret = PTR_ERR(srq);
+		goto err;
+	}
+
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_SRQ_HANDLE);
+	obj->uevent.uobject.object = srq;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR,
+			     &attr.attr.max_wr,
+			     sizeof(attr.attr.max_wr));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE,
+			     &attr.attr.max_sge,
+			     sizeof(attr.attr.max_sge));
+	if (ret)
+		return ret;
+
+	if (attr.srq_type == IB_SRQT_XRC) {
+		ret = uverbs_copy_to(attrs,
+				     UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
+				     &srq->ext.xrc.srq_num,
+				     sizeof(srq->ext.xrc.srq_num));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+err:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
+	if (attr.srq_type == IB_SRQT_XRC)
+		atomic_dec(&obj->uxrcd->refcnt);
+	return ret;
+};
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_SRQ_CREATE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_SRQ_HANDLE,
+			UVERBS_OBJECT_SRQ,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_SRQ_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_CREATE_SRQ_TYPE,
+			     enum ib_uverbs_srq_type,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_SRQ_USER_HANDLE,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_SRQ_MAX_WR,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_SRQ_MAX_SGE,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_SRQ_LIMIT,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_SRQ_XRCD_HANDLE,
+			UVERBS_OBJECT_XRCD,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_SRQ_CQ_HANDLE,
+			UVERBS_OBJECT_CQ,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_SRQ_MAX_NUM_TAGS,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_FD(UVERBS_ATTR_CREATE_SRQ_EVENT_FD,
+		       UVERBS_OBJECT_ASYNC_EVENT,
+		       UVERBS_ACCESS_READ,
+		       UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_UHW());
+
+static int UVERBS_HANDLER(UVERBS_METHOD_SRQ_DESTROY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_DESTROY_SRQ_HANDLE);
+	struct ib_usrq_object *obj =
+		container_of(uobj, struct ib_usrq_object, uevent.uobject);
+	struct ib_uverbs_destroy_srq_resp resp = {
+		.events_reported = obj->uevent.events_reported
+	};
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_DESTROY_SRQ_RESP, &resp,
+			      sizeof(resp));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_SRQ_DESTROY,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_SRQ_HANDLE,
+			UVERBS_OBJECT_SRQ,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_DESTROY_SRQ_RESP,
+			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_srq_resp),
+			    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(
+	UVERBS_OBJECT_SRQ,
+	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_usrq_object),
+				 uverbs_free_srq),
+	&UVERBS_METHOD(UVERBS_METHOD_SRQ_CREATE),
+	&UVERBS_METHOD(UVERBS_METHOD_SRQ_DESTROY)
+);
+
+const struct uapi_definition uverbs_def_obj_srq[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_SRQ,
+				      UAPI_DEF_OBJ_NEEDS_FN(destroy_srq)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 3f121ac31e0a..3f5627954fe7 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -634,6 +634,7 @@ static const struct uapi_definition uverbs_core_api[] = {
 	UAPI_DEF_CHAIN(uverbs_def_obj_flow_action),
 	UAPI_DEF_CHAIN(uverbs_def_obj_intf),
 	UAPI_DEF_CHAIN(uverbs_def_obj_mr),
+	UAPI_DEF_CHAIN(uverbs_def_obj_srq),
 	UAPI_DEF_CHAIN(uverbs_def_write_intf),
 	{},
 };
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 286fdc1929e0..c07af46ff04c 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -121,6 +121,33 @@ enum uverbs_attrs_destroy_flow_action_esp {
 	UVERBS_ATTR_DESTROY_FLOW_ACTION_HANDLE,
 };
 
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
-- 
2.26.2

