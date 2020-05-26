Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33C1C6B9F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 10:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEFIZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 04:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgEFIZ1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 04:25:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691DA20747;
        Wed,  6 May 2020 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753526;
        bh=QB/bLqj6brUpS/LRM7Y43tKusqVEiXntafCSrg9L6LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLWnJuFP70JNH258wo7nG09WwvJQcDsE6ZrTs3XMuRDrcLl4TzkgbaWbsYpT5751b
         uzuwG45YM+WdeQQZ+nv5X3d7If6NygbKqWy1g+yACIyigCKa7i+TvJ2xP6V0V3cSPT
         puvy3e9gOjoBR6xSE+z2vWdigqpuwhI5RzMpETE8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 10/10] IB/uverbs: Introduce create/destroy QP commands over ioctl
Date:   Wed,  6 May 2020 11:24:44 +0300
Message-Id: <20200506082444.14502-11-leon@kernel.org>
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

Introduce create/destroy QP commands over the ioctl interface to let it
be extended to get an asynchronous event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/Makefile              |   3 +-
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/uverbs_std_types.c    |  40 --
 drivers/infiniband/core/uverbs_std_types_qp.c | 401 ++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  28 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |   9 +
 7 files changed, 442 insertions(+), 41 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_qp.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 96c0a4b5af18..63c1591223ac 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -38,6 +38,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_uapi.o uverbs_std_types_device.o \
 				uverbs_std_types_async_fd.o \
 				uverbs_std_types_srq.o \
-				uverbs_std_types_wq.o
+				uverbs_std_types_wq.o \
+				uverbs_std_types_qp.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 9e9f2fa04fb9..33706dad6c0f 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -159,6 +159,7 @@ extern const struct uapi_definition uverbs_def_obj_dm[];
 extern const struct uapi_definition uverbs_def_obj_flow_action[];
 extern const struct uapi_definition uverbs_def_obj_intf[];
 extern const struct uapi_definition uverbs_def_obj_mr[];
+extern const struct uapi_definition uverbs_def_obj_qp[];
 extern const struct uapi_definition uverbs_def_obj_srq[];
 extern const struct uapi_definition uverbs_def_obj_wq[];
 extern const struct uapi_definition uverbs_def_write_intf[];
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index c328d5194076..08c39cfb1bd9 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -75,40 +75,6 @@ static int uverbs_free_mw(struct ib_uobject *uobject,
 	return uverbs_dealloc_mw((struct ib_mw *)uobject->object);
 }
 
-static int uverbs_free_qp(struct ib_uobject *uobject,
-			  enum rdma_remove_reason why,
-			  struct uverbs_attr_bundle *attrs)
-{
-	struct ib_qp *qp = uobject->object;
-	struct ib_uqp_object *uqp =
-		container_of(uobject, struct ib_uqp_object, uevent.uobject);
-	int ret;
-
-	/*
-	 * If this is a user triggered destroy then do not allow destruction
-	 * until the user cleans up all the mcast bindings. Unlike in other
-	 * places we forcibly clean up the mcast attachments for !DESTROY
-	 * because the mcast attaches are not ubojects and will not be
-	 * destroyed by anything else during cleanup processing.
-	 */
-	if (why == RDMA_REMOVE_DESTROY) {
-		if (!list_empty(&uqp->mcast_list))
-			return -EBUSY;
-	} else if (qp == qp->real_qp) {
-		ib_uverbs_detach_umcast(qp, uqp);
-	}
-
-	ret = ib_destroy_qp_user(qp, &attrs->driver_udata);
-	if (ib_is_destroy_retryable(ret, why, uobject))
-		return ret;
-
-	if (uqp->uxrcd)
-		atomic_dec(&uqp->uxrcd->refcnt);
-
-	ib_uverbs_release_uevent(&uqp->uevent);
-	return ret;
-}
-
 static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
 				   enum rdma_remove_reason why,
 				   struct uverbs_attr_bundle *attrs)
@@ -210,10 +176,6 @@ DECLARE_UVERBS_NAMED_OBJECT(
 			     "[infinibandevent]",
 			     O_RDONLY));
 
-DECLARE_UVERBS_NAMED_OBJECT(
-	UVERBS_OBJECT_QP,
-	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uqp_object), uverbs_free_qp));
-
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	UVERBS_METHOD_MW_DESTROY,
 	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_MW_HANDLE,
@@ -289,8 +251,6 @@ const struct uapi_definition uverbs_def_obj_intf[] = {
 				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_pd)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_COMP_CHANNEL,
 				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_pd)),
-	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_QP,
-				      UAPI_DEF_OBJ_NEEDS_FN(destroy_qp)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_AH,
 				      UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_MW,
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
new file mode 100644
index 000000000000..3bf8dcdfe7eb
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include "rdma_core.h"
+#include "uverbs.h"
+#include "core_priv.h"
+
+static int uverbs_free_qp(struct ib_uobject *uobject,
+			  enum rdma_remove_reason why,
+			  struct uverbs_attr_bundle *attrs)
+{
+	struct ib_qp *qp = uobject->object;
+	struct ib_uqp_object *uqp =
+		container_of(uobject, struct ib_uqp_object, uevent.uobject);
+	int ret;
+
+	/*
+	 * If this is a user triggered destroy then do not allow destruction
+	 * until the user cleans up all the mcast bindings. Unlike in other
+	 * places we forcibly clean up the mcast attachments for !DESTROY
+	 * because the mcast attaches are not ubojects and will not be
+	 * destroyed by anything else during cleanup processing.
+	 */
+	if (why == RDMA_REMOVE_DESTROY) {
+		if (!list_empty(&uqp->mcast_list))
+			return -EBUSY;
+	} else if (qp == qp->real_qp) {
+		ib_uverbs_detach_umcast(qp, uqp);
+	}
+
+	ret = ib_destroy_qp_user(qp, &attrs->driver_udata);
+	if (ib_is_destroy_retryable(ret, why, uobject))
+		return ret;
+
+	if (uqp->uxrcd)
+		atomic_dec(&uqp->uxrcd->refcnt);
+
+	ib_uverbs_release_uevent(&uqp->uevent);
+	return ret;
+}
+
+static int check_creation_flags(enum ib_qp_type qp_type,
+				u32 create_flags)
+{
+	create_flags &= ~IB_UVERBS_QP_CREATE_SQ_SIG_ALL;
+
+	if (!create_flags || qp_type == IB_QPT_DRIVER)
+		return 0;
+
+	if (qp_type != IB_QPT_RAW_PACKET && qp_type != IB_QPT_UD)
+		return -EINVAL;
+
+	if ((create_flags & IB_UVERBS_QP_CREATE_SCATTER_FCS ||
+	     create_flags & IB_UVERBS_QP_CREATE_CVLAN_STRIPPING) &&
+	     qp_type != IB_QPT_RAW_PACKET)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void set_caps(struct ib_qp_init_attr *attr,
+		     struct ib_uverbs_qp_cap *cap, bool req)
+{
+	if (req) {
+		attr->cap.max_send_wr = cap->max_send_wr;
+		attr->cap.max_recv_wr = cap->max_recv_wr;
+		attr->cap.max_send_sge = cap->max_send_sge;
+		attr->cap.max_recv_sge = cap->max_recv_sge;
+		attr->cap.max_inline_data = cap->max_inline_data;
+	} else {
+		cap->max_send_wr = attr->cap.max_send_wr;
+		cap->max_recv_wr = attr->cap.max_recv_wr;
+		cap->max_send_sge = attr->cap.max_send_sge;
+		cap->max_recv_sge = attr->cap.max_recv_sge;
+		cap->max_inline_data = attr->cap.max_inline_data;
+	}
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uqp_object *obj = container_of(
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_QP_HANDLE),
+		typeof(*obj), uevent.uobject);
+	struct ib_qp_init_attr attr = {};
+	struct ib_uverbs_qp_cap cap = {};
+	struct ib_rwq_ind_table *rwq_ind_tbl = NULL;
+	struct ib_qp *qp;
+	struct ib_pd *pd = NULL;
+	struct ib_srq *srq = NULL;
+	struct ib_cq *recv_cq = NULL;
+	struct ib_cq *send_cq = NULL;
+	struct ib_xrcd *xrcd = NULL;
+	struct ib_uobject *xrcd_uobj = NULL;
+	struct ib_device *device;
+	u64 user_handle;
+	int ret;
+
+	ret = uverbs_copy_from_or_zero(&cap, attrs,
+			       UVERBS_ATTR_CREATE_QP_CAP);
+	if (!ret)
+		ret = uverbs_copy_from(&user_handle, attrs,
+				       UVERBS_ATTR_CREATE_QP_USER_HANDLE);
+	if (!ret)
+		ret = uverbs_get_const(&attr.qp_type, attrs,
+				       UVERBS_ATTR_CREATE_QP_TYPE);
+	if (ret)
+		return ret;
+
+	switch (attr.qp_type) {
+	case IB_QPT_XRC_TGT:
+		if (uverbs_attr_is_valid(attrs,
+				UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE) ||
+		    uverbs_attr_is_valid(attrs,
+				UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE) ||
+		    uverbs_attr_is_valid(attrs,
+				UVERBS_ATTR_CREATE_QP_PD_HANDLE) ||
+		    uverbs_attr_is_valid(attrs,
+				UVERBS_ATTR_CREATE_QP_IND_TABLE_HANDLE))
+			return -EINVAL;
+
+		xrcd_uobj = uverbs_attr_get_uobject(attrs,
+					UVERBS_ATTR_CREATE_QP_XRCD_HANDLE);
+		if (IS_ERR(xrcd_uobj))
+			return PTR_ERR(xrcd_uobj);
+
+		xrcd = (struct ib_xrcd *)xrcd_uobj->object;
+		if (!xrcd)
+			return -EINVAL;
+		device = xrcd->device;
+		break;
+	case IB_UVERBS_QPT_RAW_PACKET:
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
+		fallthrough;
+	case IB_UVERBS_QPT_RC:
+	case IB_UVERBS_QPT_UC:
+	case IB_UVERBS_QPT_UD:
+	case IB_UVERBS_QPT_XRC_INI:
+	case IB_UVERBS_QPT_DRIVER:
+		if (uverbs_attr_is_valid(attrs,
+					 UVERBS_ATTR_CREATE_QP_XRCD_HANDLE) ||
+		   (uverbs_attr_is_valid(attrs,
+					 UVERBS_ATTR_CREATE_QP_SRQ_HANDLE) &&
+			attr.qp_type == IB_QPT_XRC_INI))
+			return -EINVAL;
+
+		pd = uverbs_attr_get_obj(attrs,
+					 UVERBS_ATTR_CREATE_QP_PD_HANDLE);
+		if (IS_ERR(pd))
+			return PTR_ERR(pd);
+
+		rwq_ind_tbl = uverbs_attr_get_obj(attrs,
+			UVERBS_ATTR_CREATE_QP_IND_TABLE_HANDLE);
+		if (!IS_ERR(rwq_ind_tbl)) {
+			if (cap.max_recv_wr || cap.max_recv_sge ||
+			    uverbs_attr_is_valid(attrs,
+				UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE) ||
+			    uverbs_attr_is_valid(attrs,
+					UVERBS_ATTR_CREATE_QP_SRQ_HANDLE))
+				return -EINVAL;
+
+			/* send_cq is optinal */
+			if (cap.max_send_wr) {
+				send_cq = uverbs_attr_get_obj(attrs,
+					UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE);
+				if (IS_ERR(send_cq))
+					return PTR_ERR(send_cq);
+			}
+			attr.rwq_ind_tbl = rwq_ind_tbl;
+		} else {
+			send_cq = uverbs_attr_get_obj(attrs,
+					UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE);
+			if (IS_ERR(send_cq))
+				return PTR_ERR(send_cq);
+
+			if (attr.qp_type != IB_QPT_XRC_INI) {
+				recv_cq = uverbs_attr_get_obj(attrs,
+					UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE);
+				if (IS_ERR(recv_cq))
+					return PTR_ERR(recv_cq);
+			}
+		}
+
+		device = pd->device;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = uverbs_get_flags32(&attr.create_flags, attrs,
+			 UVERBS_ATTR_CREATE_QP_FLAGS,
+			 IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
+			 IB_UVERBS_QP_CREATE_SCATTER_FCS |
+			 IB_UVERBS_QP_CREATE_CVLAN_STRIPPING |
+			 IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING |
+			 IB_UVERBS_QP_CREATE_SQ_SIG_ALL);
+	if (ret)
+		return ret;
+
+	ret = check_creation_flags(attr.qp_type, attr.create_flags);
+	if (ret)
+		return ret;
+
+	if (uverbs_attr_is_valid(attrs,
+			UVERBS_ATTR_CREATE_QP_SOURCE_QPN)) {
+		ret = uverbs_copy_from(&attr.source_qpn, attrs,
+				       UVERBS_ATTR_CREATE_QP_SOURCE_QPN);
+		if (ret)
+			return ret;
+		attr.create_flags |= IB_QP_CREATE_SOURCE_QPN;
+	}
+
+	srq = uverbs_attr_get_obj(attrs,
+				  UVERBS_ATTR_CREATE_QP_SRQ_HANDLE);
+	if (!IS_ERR(srq)) {
+		if ((srq->srq_type == IB_SRQT_XRC &&
+			attr.qp_type != IB_QPT_XRC_TGT) ||
+		    (srq->srq_type != IB_SRQT_XRC &&
+			attr.qp_type == IB_QPT_XRC_TGT))
+			return -EINVAL;
+		attr.srq = srq;
+	}
+
+	obj->uevent.event_file = ib_uverbs_get_async_event(attrs,
+					UVERBS_ATTR_CREATE_QP_EVENT_FD);
+	INIT_LIST_HEAD(&obj->uevent.event_list);
+	INIT_LIST_HEAD(&obj->mcast_list);
+	obj->uevent.uobject.user_handle = user_handle;
+	attr.event_handler = ib_uverbs_qp_event_handler;
+	attr.send_cq = send_cq;
+	attr.recv_cq = recv_cq;
+	attr.xrcd = xrcd;
+	if (attr.create_flags & IB_UVERBS_QP_CREATE_SQ_SIG_ALL) {
+		/* This creation bit is uverbs one, need to mask before
+		 * calling drivers. It was added to prevent an extra user attr
+		 * only for that when using ioctl.
+		 */
+		attr.create_flags &= ~IB_UVERBS_QP_CREATE_SQ_SIG_ALL;
+		attr.sq_sig_type = IB_SIGNAL_ALL_WR;
+	} else {
+		attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	}
+
+	set_caps(&attr, &cap, true);
+	mutex_init(&obj->mcast_lock);
+
+	if (attr.qp_type == IB_QPT_XRC_TGT)
+		qp = ib_create_qp(pd, &attr);
+	else
+		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata,
+				   obj);
+
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
+		goto err_put;
+	}
+
+	if (attr.qp_type != IB_QPT_XRC_TGT) {
+		atomic_inc(&pd->usecnt);
+		if (attr.send_cq)
+			atomic_inc(&attr.send_cq->usecnt);
+		if (attr.recv_cq)
+			atomic_inc(&attr.recv_cq->usecnt);
+		if (attr.srq)
+			atomic_inc(&attr.srq->usecnt);
+		if (attr.rwq_ind_tbl)
+			atomic_inc(&attr.rwq_ind_tbl->usecnt);
+	} else {
+		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
+					  uobject);
+		atomic_inc(&obj->uxrcd->refcnt);
+		/* It is done in _ib_create_qp for other QP types */
+		qp->uobject = obj;
+	}
+
+	obj->uevent.uobject.object = qp;
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_QP_HANDLE);
+
+	if (attr.qp_type != IB_QPT_XRC_TGT) {
+		ret = ib_create_qp_security(qp, device);
+		if (ret)
+			return ret;
+	}
+
+	set_caps(&attr, &cap, false);
+	ret = uverbs_copy_to_struct_or_zero(attrs,
+					UVERBS_ATTR_CREATE_QP_RESP_CAP, &cap,
+					sizeof(cap));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+			     &qp->qp_num,
+			     sizeof(qp->qp_num));
+
+	return ret;
+err_put:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
+	return ret;
+};
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_HANDLE,
+			UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_XRCD_HANDLE,
+			UVERBS_OBJECT_XRCD,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SRQ_HANDLE,
+			UVERBS_OBJECT_SRQ,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
+			UVERBS_OBJECT_CQ,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDLE,
+			UVERBS_OBJECT_CQ,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_IND_TABLE_HANDLE,
+			UVERBS_OBJECT_RWQ_IND_TBL,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_USER_HANDLE,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_CAP,
+			   UVERBS_ATTR_STRUCT(struct ib_uverbs_qp_cap,
+					      max_inline_data),
+			   UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_CREATE_QP_TYPE,
+			     enum ib_uverbs_qp_type,
+			     UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_CREATE_QP_FLAGS,
+			     enum ib_uverbs_qp_create_flags,
+			     UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SOURCE_QPN,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_FD(UVERBS_ATTR_CREATE_QP_EVENT_FD,
+		       UVERBS_OBJECT_ASYNC_EVENT,
+		       UVERBS_ACCESS_READ,
+		       UA_OPTIONAL),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_CAP,
+			    UVERBS_ATTR_STRUCT(struct ib_uverbs_qp_cap,
+					       max_inline_data),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_UHW());
+
+static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_DESTROY_QP_HANDLE);
+	struct ib_uqp_object *obj =
+		container_of(uobj, struct ib_uqp_object, uevent.uobject);
+	struct ib_uverbs_destroy_qp_resp resp = {
+		.events_reported = obj->uevent.events_reported
+	};
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_DESTROY_QP_RESP, &resp,
+			      sizeof(resp));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QP_DESTROY,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_QP_HANDLE,
+			UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_DESTROY_QP_RESP,
+			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_qp_resp),
+			    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(
+	UVERBS_OBJECT_QP,
+	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uqp_object), uverbs_free_qp),
+	&UVERBS_METHOD(UVERBS_METHOD_QP_CREATE),
+	&UVERBS_METHOD(UVERBS_METHOD_QP_DESTROY));
+
+const struct uapi_definition uverbs_def_obj_qp[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_QP,
+				      UAPI_DEF_OBJ_NEEDS_FN(destroy_qp)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 0ec8cf86ecfa..5addc8fae3f3 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -634,6 +634,7 @@ static const struct uapi_definition uverbs_core_api[] = {
 	UAPI_DEF_CHAIN(uverbs_def_obj_flow_action),
 	UAPI_DEF_CHAIN(uverbs_def_obj_intf),
 	UAPI_DEF_CHAIN(uverbs_def_obj_mr),
+	UAPI_DEF_CHAIN(uverbs_def_obj_qp),
 	UAPI_DEF_CHAIN(uverbs_def_obj_srq),
 	UAPI_DEF_CHAIN(uverbs_def_obj_wq),
 	UAPI_DEF_CHAIN(uverbs_def_write_intf),
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 381b17889d20..4961d5e858eb 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -121,6 +121,34 @@ enum uverbs_attrs_destroy_flow_action_esp {
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
 enum uverbs_attrs_create_srq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_SRQ_HANDLE,
 	UVERBS_ATTR_CREATE_SRQ_PD_HANDLE,
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index b1662dfe86a6..5debab45ebcb 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -96,6 +96,7 @@ enum ib_uverbs_qp_create_flags {
 	IB_UVERBS_QP_CREATE_SCATTER_FCS = 1 << 8,
 	IB_UVERBS_QP_CREATE_CVLAN_STRIPPING = 1 << 9,
 	IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING = 1 << 11,
+	IB_UVERBS_QP_CREATE_SQ_SIG_ALL = 1 << 12,
 };
 
 enum ib_uverbs_query_port_cap_flags {
@@ -219,6 +220,14 @@ struct ib_uverbs_query_port_resp_ex {
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
2.26.2

