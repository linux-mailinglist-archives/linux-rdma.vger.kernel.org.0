Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508E21C6B9D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEFIZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 04:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgEFIZT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 04:25:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF99720714;
        Wed,  6 May 2020 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753518;
        bh=yXMM8oey6SumbePeqri1bvprUqOIFfHhszO4J1gHZBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3Kiue1x09fJVRCqGKEaWTQSOLZSS37HahDrJUQGn1q+esqahLLxgIGAgb7l0hGLZ
         yIOwFDENaOHV+ZFi8acOjUDji3/O5q6M/yuTEBRHt24zWSMc7cRwvP3cpjYA+dpooM
         Vl0xYdE24G2i3+42Xxk4QSLJZfIHnXLlnqIoukYI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 09/10] IB/uverbs: Introduce create/destroy WQ commands over ioctl
Date:   Wed,  6 May 2020 11:24:43 +0300
Message-Id: <20200506082444.14502-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Introduce create/destroy WQ commands over the ioctl interface to let it
be extended to get an asynchronous event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/Makefile              |   3 +-
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/uverbs_std_types.c    |  23 ---
 drivers/infiniband/core/uverbs_std_types_wq.c | 194 ++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  25 +++
 6 files changed, 223 insertions(+), 24 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_wq.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d7b46a7c07fd..96c0a4b5af18 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -37,6 +37,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_mr.o uverbs_std_types_counters.o \
 				uverbs_uapi.o uverbs_std_types_device.o \
 				uverbs_std_types_async_fd.o \
-				uverbs_std_types_srq.o
+				uverbs_std_types_srq.o \
+				uverbs_std_types_wq.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index d623f911b70b..9e9f2fa04fb9 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -160,6 +160,7 @@ extern const struct uapi_definition uverbs_def_obj_flow_action[];
 extern const struct uapi_definition uverbs_def_obj_intf[];
 extern const struct uapi_definition uverbs_def_obj_mr[];
 extern const struct uapi_definition uverbs_def_obj_srq[];
+extern const struct uapi_definition uverbs_def_obj_wq[];
 extern const struct uapi_definition uverbs_def_write_intf[];
 
 static inline const struct uverbs_api_write_method *
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index d9b6912eafa8..c328d5194076 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -125,23 +125,6 @@ static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
 	return ret;
 }
 
-static int uverbs_free_wq(struct ib_uobject *uobject,
-			  enum rdma_remove_reason why,
-			  struct uverbs_attr_bundle *attrs)
-{
-	struct ib_wq *wq = uobject->object;
-	struct ib_uwq_object *uwq =
-		container_of(uobject, struct ib_uwq_object, uevent.uobject);
-	int ret;
-
-	ret = ib_destroy_wq(wq, &attrs->driver_udata);
-	if (ib_is_destroy_retryable(ret, why, uobject))
-		return ret;
-
-	ib_uverbs_release_uevent(&uwq->uevent);
-	return ret;
-}
-
 static int uverbs_free_xrcd(struct ib_uobject *uobject,
 			    enum rdma_remove_reason why,
 			    struct uverbs_attr_bundle *attrs)
@@ -266,10 +249,6 @@ DECLARE_UVERBS_NAMED_OBJECT(
 				 uverbs_free_flow),
 			    &UVERBS_METHOD(UVERBS_METHOD_FLOW_DESTROY));
 
-DECLARE_UVERBS_NAMED_OBJECT(
-	UVERBS_OBJECT_WQ,
-	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uwq_object), uverbs_free_wq));
-
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_RWQ_IND_TBL_DESTROY,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_RWQ_IND_TBL_HANDLE,
@@ -318,8 +297,6 @@ const struct uapi_definition uverbs_def_obj_intf[] = {
 				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_mw)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_FLOW,
 				      UAPI_DEF_OBJ_NEEDS_FN(destroy_flow)),
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_WQ,
-				      UAPI_DEF_OBJ_NEEDS_FN(destroy_wq)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
 		UVERBS_OBJECT_RWQ_IND_TBL,
 		UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),
diff --git a/drivers/infiniband/core/uverbs_std_types_wq.c b/drivers/infiniband/core/uverbs_std_types_wq.c
new file mode 100644
index 000000000000..781ba534ed43
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_wq.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include "rdma_core.h"
+#include "uverbs.h"
+
+static int uverbs_free_wq(struct ib_uobject *uobject,
+			  enum rdma_remove_reason why,
+			  struct uverbs_attr_bundle *attrs)
+{
+	struct ib_wq *wq = uobject->object;
+	struct ib_uwq_object *uwq =
+		container_of(uobject, struct ib_uwq_object, uevent.uobject);
+	int ret;
+
+	ret = ib_destroy_wq(wq, &attrs->driver_udata);
+	if (ib_is_destroy_retryable(ret, why, uobject))
+		return ret;
+
+	ib_uverbs_release_uevent(&uwq->uevent);
+	return ret;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_WQ_CREATE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uwq_object *obj = container_of(
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_WQ_HANDLE),
+		typeof(*obj), uevent.uobject);
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_WQ_PD_HANDLE);
+	struct ib_cq *cq =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_WQ_CQ_HANDLE);
+	struct ib_wq_init_attr wq_init_attr = {};
+	struct ib_wq *wq;
+	u64 user_handle;
+	int ret;
+
+	ret = uverbs_get_flags32(&wq_init_attr.create_flags, attrs,
+				 UVERBS_ATTR_CREATE_WQ_FLAGS,
+				 IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING |
+				 IB_UVERBS_WQ_FLAGS_SCATTER_FCS |
+				 IB_UVERBS_WQ_FLAGS_DELAY_DROP |
+				 IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING);
+	if (!ret)
+		ret = uverbs_copy_from(&wq_init_attr.max_sge, attrs,
+			       UVERBS_ATTR_CREATE_WQ_MAX_SGE);
+	if (!ret)
+		ret = uverbs_copy_from(&wq_init_attr.max_wr, attrs,
+				       UVERBS_ATTR_CREATE_WQ_MAX_WR);
+	if (!ret)
+		ret = uverbs_copy_from(&user_handle, attrs,
+				       UVERBS_ATTR_CREATE_WQ_USER_HANDLE);
+	if (!ret)
+		ret = uverbs_get_const(&wq_init_attr.wq_type, attrs,
+				       UVERBS_ATTR_CREATE_WQ_TYPE);
+	if (ret)
+		return ret;
+
+	if (wq_init_attr.wq_type != IB_WQT_RQ)
+		return -EINVAL;
+
+	obj->uevent.event_file = ib_uverbs_get_async_event(attrs,
+					UVERBS_ATTR_CREATE_WQ_EVENT_FD);
+	obj->uevent.uobject.user_handle = user_handle;
+	INIT_LIST_HEAD(&obj->uevent.event_list);
+	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
+	wq_init_attr.wq_context = attrs->ufile;
+	wq_init_attr.cq = cq;
+
+	wq = pd->device->ops.create_wq(pd, &wq_init_attr, &attrs->driver_udata);
+	if (IS_ERR(wq)) {
+		ret = PTR_ERR(wq);
+		goto err;
+	}
+
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_WQ_HANDLE);
+	obj->uevent.uobject.object = wq;
+	wq->wq_type = wq_init_attr.wq_type;
+	wq->cq = cq;
+	wq->pd = pd;
+	wq->device = pd->device;
+	wq->wq_context = wq_init_attr.wq_context;
+	atomic_set(&wq->usecnt, 0);
+	atomic_inc(&pd->usecnt);
+	atomic_inc(&cq->usecnt);
+	wq->uobject = obj;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_WQ_RESP_MAX_WR,
+			     &wq_init_attr.max_wr,
+			     sizeof(wq_init_attr.max_wr));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_WQ_RESP_MAX_SGE,
+			     &wq_init_attr.max_sge,
+			     sizeof(wq_init_attr.max_sge));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_WQ_RESP_WQ_NUM,
+			     &wq->wq_num,
+			     sizeof(wq->wq_num));
+	return ret;
+
+err:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
+	return ret;
+};
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_WQ_CREATE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_WQ_HANDLE,
+			UVERBS_OBJECT_WQ,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_WQ_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_CREATE_WQ_TYPE,
+			     enum ib_wq_type,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_WQ_USER_HANDLE,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_WQ_MAX_WR,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_WQ_MAX_SGE,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_CREATE_WQ_FLAGS,
+			     enum ib_uverbs_wq_flags,
+			     UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_WQ_CQ_HANDLE,
+			UVERBS_OBJECT_CQ,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_FD(UVERBS_ATTR_CREATE_WQ_EVENT_FD,
+		       UVERBS_OBJECT_ASYNC_EVENT,
+		       UVERBS_ACCESS_READ,
+		       UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_WQ_RESP_MAX_WR,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_WQ_RESP_MAX_SGE,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_WQ_RESP_WQ_NUM,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_UHW());
+
+static int UVERBS_HANDLER(UVERBS_METHOD_WQ_DESTROY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_DESTROY_WQ_HANDLE);
+	struct ib_uwq_object *obj =
+		container_of(uobj, struct ib_uwq_object, uevent.uobject);
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_DESTROY_WQ_RESP,
+			      &obj->uevent.events_reported,
+			      sizeof(obj->uevent.events_reported));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_WQ_DESTROY,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_WQ_HANDLE,
+			UVERBS_OBJECT_WQ,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_DESTROY_WQ_RESP,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY));
+
+
+DECLARE_UVERBS_NAMED_OBJECT(
+	UVERBS_OBJECT_WQ,
+	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uwq_object), uverbs_free_wq),
+	&UVERBS_METHOD(UVERBS_METHOD_WQ_CREATE),
+	&UVERBS_METHOD(UVERBS_METHOD_WQ_DESTROY)
+);
+
+const struct uapi_definition uverbs_def_obj_wq[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_WQ,
+				      UAPI_DEF_OBJ_NEEDS_FN(destroy_wq)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 3f5627954fe7..0ec8cf86ecfa 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -635,6 +635,7 @@ static const struct uapi_definition uverbs_core_api[] = {
 	UAPI_DEF_CHAIN(uverbs_def_obj_intf),
 	UAPI_DEF_CHAIN(uverbs_def_obj_mr),
 	UAPI_DEF_CHAIN(uverbs_def_obj_srq),
+	UAPI_DEF_CHAIN(uverbs_def_obj_wq),
 	UAPI_DEF_CHAIN(uverbs_def_write_intf),
 	{},
 };
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index c07af46ff04c..381b17889d20 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -153,6 +153,31 @@ enum uverbs_methods_cq {
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
-- 
2.26.2

