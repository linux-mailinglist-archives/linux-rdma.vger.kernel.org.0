Return-Path: <linux-rdma+bounces-20413-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAdcCMhLAmpaqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20413-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 23:36:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20B51656B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 23:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA2C73018FBE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920594D90C4;
	Mon, 11 May 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pZte4uEk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882584D90C6
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535363; cv=none; b=OAabuZVzRso65N8EK7RzpSruqtNi4AXE646smv/wYHHyZgfnQkFp+toygAbrIfxbxJaczboC1h4i4orEP7WT4XpqZJyDKG+HMZyWrc4MsF8pyTSmv7Fh86JP3LaSFgoPH4KuNZ5qlVudNmLgsetoxYmFbih1WDCaWqzaSJKxolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535363; c=relaxed/simple;
	bh=CwqAAZZEWYtgzRvKnVLXuMCM1Hx6zbj85VtDcROz6go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dX5sJwE9Hlcp1gyH0kg3lFNQh5IbxyBYD6svESI5KaewnaB9GmrUYGGArTEVanjUDhh4dFDf50RMbN0iTCEBzNq62QBGIv8M88S/86V+SKkUC23iUfTOOVWl350hKmtQsiKDW+xtYth+51yaP6VxeIK91zWAujO0/HQMg5CtC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pZte4uEk; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778535361; x=1810071361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZrcoij/+hm0TCa2sMXBdcfNLgi8OdvMiqkOCAG7CAs=;
  b=pZte4uEkrtUIBUFcGpzt4VuD3hgFD7/ZX6Y5XWOU85Q7JLkH0rgVUYxE
   KaHxn5/aTub4BxUnXaSum7Rx187T7cc14qB9yXWtjFlWNLClsH1lkFMaL
   ilkUhFxgJWqwVkRrhCd/dijh3Rh6+a8URBbSH0HwU7kRgC46Y0uTDsRxm
   7jKZ51Y/lJiIaGfpw2IHBdrkX5Hjhh1qIqHjI+uKyyIPlMq4Xs7xHtbee
   veRVwmVheYvGb+dpYwqk+yRjnIgqQVIpB616zOebK/xUpj4zoICe6JILk
   Iw9qq5KraV2H+aDIh8suPgIsTJL6sLBgLPZLtzALSP6SAeZuqgovzdsvY
   A==;
X-CSE-ConnectionGUID: SzGUYuyfS7ypYqNqOSXdnQ==
X-CSE-MsgGUID: 498DKWg/TW2uynCT33TY2Q==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19194516"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:35:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:5498]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.221:2525] with esmtp (Farcaster)
 id 7074327f-9188-4d28-b495-ff83ea12068c; Mon, 11 May 2026 21:35:58 +0000 (UTC)
X-Farcaster-Flow-ID: 7074327f-9188-4d28-b495-ff83ea12068c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 21:35:57 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 21:35:55 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v3 2/5] RDMA/core: Add Completion Counters support
Date: Mon, 11 May 2026 21:35:42 +0000
Message-ID: <20260511213549.594-4-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511213549.594-1-mrgolin@amazon.com>
References: <20260511213549.594-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: DF20B51656B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20413-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add core infrastructure for Completion Counters, a light-weight
alternative to polling CQ for tracking operation completions.

Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
modify and read methods for both success and error counters. Add a QP
attach method on the QP object to associate a completion counter with a
queue pair.

Add ib_comp_cntr struct, ib_comp_cntr_attach_attr, device ops, and
DECLARE_RDMA_OBJ_SIZE for driver object allocation.

Only userspace Completion Counters are supported at this stage.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/Makefile              |   1 +
 drivers/infiniband/core/device.c              |   6 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/uverbs_cmd.c          |   1 +
 .../core/uverbs_std_types_comp_cntr.c         | 174 ++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  45 ++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/rdma/ib_verbs.h                       |  40 ++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 11 files changed, 326 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index dce798d8cfe6..4767339608a1 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -35,6 +35,7 @@ ib_umad-y :=			user_mad.o
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
+				uverbs_std_types_comp_cntr.o \
 				uverbs_std_types_dmabuf.o \
 				uverbs_std_types_dmah.o \
 				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b89efaaa81ec..18d809e59afa 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2734,6 +2734,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_ah);
 	SET_DEVICE_OP(dev_ops, create_counters);
 	SET_DEVICE_OP(dev_ops, create_cq);
+	SET_DEVICE_OP(dev_ops, create_comp_cntr);
 	SET_DEVICE_OP(dev_ops, create_user_cq);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
@@ -2754,6 +2755,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, destroy_ah);
 	SET_DEVICE_OP(dev_ops, destroy_counters);
 	SET_DEVICE_OP(dev_ops, destroy_cq);
+	SET_DEVICE_OP(dev_ops, destroy_comp_cntr);
 	SET_DEVICE_OP(dev_ops, destroy_flow);
 	SET_DEVICE_OP(dev_ops, destroy_flow_action);
 	SET_DEVICE_OP(dev_ops, destroy_qp);
@@ -2805,6 +2807,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, modify_hw_stat);
 	SET_DEVICE_OP(dev_ops, modify_port);
 	SET_DEVICE_OP(dev_ops, modify_qp);
+	SET_DEVICE_OP(dev_ops, qp_attach_comp_cntr);
 	SET_DEVICE_OP(dev_ops, modify_srq);
 	SET_DEVICE_OP(dev_ops, modify_wq);
 	SET_DEVICE_OP(dev_ops, peek_cq);
@@ -2828,12 +2831,14 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, query_ucontext);
 	SET_DEVICE_OP(dev_ops, rdma_netdev_get_params);
 	SET_DEVICE_OP(dev_ops, read_counters);
+	SET_DEVICE_OP(dev_ops, read_comp_cntr);
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
 	SET_DEVICE_OP(dev_ops, resize_user_cq);
+	SET_DEVICE_OP(dev_ops, modify_comp_cntr);
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
@@ -2842,6 +2847,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_comp_cntr);
 	SET_OBJ_SIZE(dev_ops, ib_dmah);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 269b393799ab..2569550e4c6d 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -156,6 +156,7 @@ uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata);
 
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
+extern const struct uapi_definition uverbs_def_obj_comp_cntr[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
 extern const struct uapi_definition uverbs_def_obj_device[];
 extern const struct uapi_definition uverbs_def_obj_dm[];
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a768436ba468..4bc493b3b624 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3673,6 +3673,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 	resp.cq_moderation_caps.max_cq_moderation_period =
 		attr.cq_caps.max_cq_moderation_period;
 	resp.max_dm_size = attr.max_dm_size;
+	resp.max_comp_cntr = attr.max_comp_cntr;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 
 	return uverbs_response(attrs, &resp, sizeof(resp));
diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
new file mode 100644
index 000000000000..c1cf0f59d483
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include "rdma_core.h"
+#include "uverbs.h"
+
+static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_reason why,
+				 struct uverbs_attr_bundle *attrs)
+{
+	struct ib_comp_cntr *cc = uobject->object;
+	int ret;
+
+	ret = cc->device->ops.destroy_comp_cntr(cc);
+	if (ret)
+		return ret;
+
+	kfree(cc);
+	return 0;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
+							  UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
+	struct ib_device *ib_dev = attrs->context->device;
+	struct ib_comp_cntr *cc;
+	int ret;
+
+	if (!ib_dev->ops.create_comp_cntr ||
+	    !ib_dev->ops.destroy_comp_cntr ||
+	    !ib_dev->ops.qp_attach_comp_cntr)
+		return -EOPNOTSUPP;
+
+	cc = rdma_zalloc_drv_obj(ib_dev, ib_comp_cntr);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->device = ib_dev;
+	cc->uobject = uobj;
+
+	ret = ib_dev->ops.create_comp_cntr(cc, attrs);
+	if (ret)
+		goto err_free;
+
+	uobj->object = cc;
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
+			     &cc->comp_count_max_value, sizeof(cc->comp_count_max_value));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
+			     &cc->err_count_max_value, sizeof(cc->err_count_max_value));
+	return ret;
+
+err_free:
+	kfree(cc);
+	return ret;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_MODIFY)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(attrs, UVERBS_ATTR_MODIFY_COMP_CNTR_HANDLE);
+	enum ib_comp_cntr_modify_op op;
+	enum ib_comp_cntr_entry entry;
+	u64 value;
+	int ret;
+
+	if (!cc->device->ops.modify_comp_cntr)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_get_const(&entry, attrs, UVERBS_ATTR_MODIFY_COMP_CNTR_ENTRY);
+	if (ret)
+		return ret;
+
+	ret = uverbs_get_const(&op, attrs, UVERBS_ATTR_MODIFY_COMP_CNTR_OP);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&value, attrs, UVERBS_ATTR_MODIFY_COMP_CNTR_VALUE);
+	if (ret)
+		return ret;
+
+	return cc->device->ops.modify_comp_cntr(cc, entry, op, value);
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_READ)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(attrs, UVERBS_ATTR_READ_COMP_CNTR_HANDLE);
+	enum ib_comp_cntr_entry entry;
+	u64 value;
+	int ret;
+
+	if (!cc->device->ops.read_comp_cntr)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_get_const(&entry, attrs, UVERBS_ATTR_READ_COMP_CNTR_ENTRY);
+	if (ret)
+		return ret;
+
+	ret = cc->device->ops.read_comp_cntr(cc, entry, &value);
+	if (ret)
+		return ret;
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE, &value, sizeof(value));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_COMP_CNTR_CREATE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE,
+			UVERBS_OBJECT_COMP_CNTR,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY),
+	UVERBS_ATTR_UHW());
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(
+	UVERBS_METHOD_COMP_CNTR_DESTROY,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_DESTROY_COMP_CNTR_HANDLE,
+			UVERBS_OBJECT_COMP_CNTR,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_COMP_CNTR_MODIFY,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_MODIFY_COMP_CNTR_HANDLE,
+			UVERBS_OBJECT_COMP_CNTR,
+			UVERBS_ACCESS_WRITE,
+			UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_MODIFY_COMP_CNTR_ENTRY,
+			     enum ib_uverbs_comp_cntr_entry,
+			     UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_MODIFY_COMP_CNTR_OP,
+			     enum ib_uverbs_comp_cntr_modify_op,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_MODIFY_COMP_CNTR_VALUE,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_COMP_CNTR_READ,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_READ_COMP_CNTR_HANDLE,
+			UVERBS_OBJECT_COMP_CNTR,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_READ_COMP_CNTR_ENTRY,
+			     enum ib_uverbs_comp_cntr_entry,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(
+	UVERBS_OBJECT_COMP_CNTR,
+	UVERBS_TYPE_ALLOC_IDR(uverbs_free_comp_cntr),
+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_CREATE),
+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_DESTROY),
+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_MODIFY),
+	&UVERBS_METHOD(UVERBS_METHOD_COMP_CNTR_READ));
+
+const struct uapi_definition uverbs_def_obj_comp_cntr[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_COMP_CNTR,
+				      UAPI_DEF_OBJ_NEEDS_FN(destroy_comp_cntr)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..dec4c0ebb41c 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -367,11 +367,54 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_qp_resp),
 			    UA_MANDATORY));
 
+static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *qp_uobj = uverbs_attr_get_uobject(
+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE);
+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(
+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_CNTR_HANDLE);
+	struct ib_comp_cntr_attach_attr attr = {};
+	struct ib_qp *qp = qp_uobj->object;
+	int ret;
+
+	if (!cc->device->ops.qp_attach_comp_cntr)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_get_flags32(&attr.op_mask, attrs,
+				 UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND |
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV |
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ |
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ |
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE |
+				 IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE);
+	if (ret)
+		return ret;
+
+	return qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QP_ATTACH_COMP_CNTR,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE,
+			UVERBS_OBJECT_QP,
+			UVERBS_ACCESS_WRITE,
+			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_CNTR_HANDLE,
+			UVERBS_OBJECT_COMP_CNTR,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
+			     enum ib_uverbs_comp_cntr_attach_op,
+			     UA_OPTIONAL));
+
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_QP,
 	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_uqp_object), uverbs_free_qp),
 	&UVERBS_METHOD(UVERBS_METHOD_QP_CREATE),
-	&UVERBS_METHOD(UVERBS_METHOD_QP_DESTROY));
+	&UVERBS_METHOD(UVERBS_METHOD_QP_DESTROY),
+	&UVERBS_METHOD(UVERBS_METHOD_QP_ATTACH_COMP_CNTR));
 
 const struct uapi_definition uverbs_def_obj_qp[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_QP,
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 31b248295854..a3f42a50a14f 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -628,6 +628,7 @@ void uverbs_destroy_api(struct uverbs_api *uapi)
 static const struct uapi_definition uverbs_core_api[] = {
 	UAPI_DEF_CHAIN(uverbs_def_obj_async_fd),
 	UAPI_DEF_CHAIN(uverbs_def_obj_counters),
+	UAPI_DEF_CHAIN(uverbs_def_obj_comp_cntr),
 	UAPI_DEF_CHAIN(uverbs_def_obj_cq),
 	UAPI_DEF_CHAIN(uverbs_def_obj_device),
 	UAPI_DEF_CHAIN(uverbs_def_obj_dm),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..f36a6d48790a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -453,6 +453,7 @@ struct ib_device_attr {
 	u64			max_dm_size;
 	/* Max entries for sgl for optimized performance per READ */
 	u32			max_sgl_rd;
+	u32			max_comp_cntr;
 };
 
 enum ib_mtu {
@@ -1746,6 +1747,36 @@ struct ib_cq {
 	struct rdma_restrack_entry res;
 };
 
+struct ib_comp_cntr {
+	struct ib_device *device;
+	struct ib_uobject *uobject;
+	u64 comp_count_max_value;
+	u64 err_count_max_value;
+};
+
+enum ib_comp_cntr_entry {
+	IB_COMP_CNTR_ENTRY_COMP = IB_UVERBS_COMP_CNTR_ENTRY_COMP,
+	IB_COMP_CNTR_ENTRY_ERR = IB_UVERBS_COMP_CNTR_ENTRY_ERR,
+};
+
+enum ib_comp_cntr_modify_op {
+	IB_COMP_CNTR_MODIFY_OP_SET = IB_UVERBS_COMP_CNTR_MODIFY_OP_SET,
+	IB_COMP_CNTR_MODIFY_OP_INC = IB_UVERBS_COMP_CNTR_MODIFY_OP_INC,
+};
+
+enum ib_comp_cntr_attach_op {
+	IB_COMP_CNTR_ATTACH_OP_SEND = IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND,
+	IB_COMP_CNTR_ATTACH_OP_RECV = IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV,
+	IB_COMP_CNTR_ATTACH_OP_RDMA_READ = IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ,
+	IB_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ = IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ,
+	IB_COMP_CNTR_ATTACH_OP_RDMA_WRITE = IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE,
+	IB_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE = IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE,
+};
+
+struct ib_comp_cntr_attach_attr {
+	u32 op_mask;
+};
+
 struct ib_srq {
 	struct ib_device       *device;
 	struct ib_pd	       *pd;
@@ -2624,6 +2655,8 @@ struct ib_device_ops {
 			 struct ib_udata *udata);
 	int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			 int qp_attr_mask, struct ib_udata *udata);
+	int (*qp_attach_comp_cntr)(struct ib_qp *qp, struct ib_comp_cntr *cc,
+				   struct ib_comp_cntr_attach_attr *attr);
 	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
@@ -2645,6 +2678,12 @@ struct ib_device_ops {
 	 * post_destroy_cq - Free all kernel resources
 	 */
 	void (*post_destroy_cq)(struct ib_cq *cq);
+	int (*create_comp_cntr)(struct ib_comp_cntr *cc,
+				struct uverbs_attr_bundle *attrs);
+	int (*destroy_comp_cntr)(struct ib_comp_cntr *cc);
+	int (*modify_comp_cntr)(struct ib_comp_cntr *cc, enum ib_comp_cntr_entry entry,
+				enum ib_comp_cntr_modify_op op, u64 value);
+	int (*read_comp_cntr)(struct ib_comp_cntr *cc, enum ib_comp_cntr_entry entry, u64 *value);
 	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
@@ -2878,6 +2917,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
+	DECLARE_RDMA_OBJ_SIZE(ib_comp_cntr);
 	DECLARE_RDMA_OBJ_SIZE(ib_dmah);
 	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 72041c1b0ea5..352d808c315d 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -57,6 +57,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_ASYNC_EVENT,
 	UVERBS_OBJECT_DMAH,
 	UVERBS_OBJECT_DMABUF,
+	UVERBS_OBJECT_COMP_CNTR,
 };
 
 enum {
@@ -165,9 +166,16 @@ enum uverbs_attrs_destroy_qp_cmd_attr_ids {
 	UVERBS_ATTR_DESTROY_QP_RESP,
 };
 
+enum uverbs_attrs_qp_attach_comp_cntr_cmd_attr_ids {
+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE,
+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_CNTR_HANDLE,
+	UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
+};
+
 enum uverbs_methods_qp {
 	UVERBS_METHOD_QP_CREATE,
 	UVERBS_METHOD_QP_DESTROY,
+	UVERBS_METHOD_QP_ATTACH_COMP_CNTR,
 };
 
 enum uverbs_attrs_create_srq_cmd_attr_ids {
@@ -434,4 +442,34 @@ enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_GID_ENTRY_RESP_ENTRY,
 };
 
+enum uverbs_methods_comp_cntr {
+	UVERBS_METHOD_COMP_CNTR_CREATE,
+	UVERBS_METHOD_COMP_CNTR_DESTROY,
+	UVERBS_METHOD_COMP_CNTR_MODIFY,
+	UVERBS_METHOD_COMP_CNTR_READ,
+};
+
+enum uverbs_attrs_create_comp_cntr_cmd_attr_ids {
+	UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE,
+	UVERBS_ATTR_CREATE_COMP_CNTR_RESP_COUNT_MAX_VALUE,
+	UVERBS_ATTR_CREATE_COMP_CNTR_RESP_ERR_COUNT_MAX_VALUE,
+};
+
+enum uverbs_attrs_destroy_comp_cntr_cmd_attr_ids {
+	UVERBS_ATTR_DESTROY_COMP_CNTR_HANDLE,
+};
+
+enum uverbs_attrs_modify_comp_cntr_cmd_attr_ids {
+	UVERBS_ATTR_MODIFY_COMP_CNTR_HANDLE,
+	UVERBS_ATTR_MODIFY_COMP_CNTR_ENTRY,
+	UVERBS_ATTR_MODIFY_COMP_CNTR_OP,
+	UVERBS_ATTR_MODIFY_COMP_CNTR_VALUE,
+};
+
+enum uverbs_attrs_read_comp_cntr_cmd_attr_ids {
+	UVERBS_ATTR_READ_COMP_CNTR_HANDLE,
+	UVERBS_ATTR_READ_COMP_CNTR_ENTRY,
+	UVERBS_ATTR_READ_COMP_CNTR_RESP_VALUE,
+};
+
 #endif
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 90c5cd8e7753..70b53d5daa0c 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -273,4 +273,23 @@ struct ib_uverbs_gid_entry {
 	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
 };
 
+enum ib_uverbs_comp_cntr_entry {
+	IB_UVERBS_COMP_CNTR_ENTRY_COMP,
+	IB_UVERBS_COMP_CNTR_ENTRY_ERR,
+};
+
+enum ib_uverbs_comp_cntr_modify_op {
+	IB_UVERBS_COMP_CNTR_MODIFY_OP_SET,
+	IB_UVERBS_COMP_CNTR_MODIFY_OP_INC,
+};
+
+enum ib_uverbs_comp_cntr_attach_op {
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND = 1 << 0,
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV = 1 << 1,
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ = 1 << 2,
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ = 1 << 3,
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE = 1 << 4,
+	IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE = 1 << 5,
+};
+
 #endif
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 3b7bd99813e9..45d142f4a7f8 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -299,7 +299,7 @@ struct ib_uverbs_ex_query_device_resp {
 	struct ib_uverbs_cq_moderation_caps cq_moderation_caps;
 	__aligned_u64 max_dm_size;
 	__u32 xrc_odp_caps;
-	__u32 reserved;
+	__u32 max_comp_cntr;
 };
 
 struct ib_uverbs_query_port {
-- 
2.47.3


