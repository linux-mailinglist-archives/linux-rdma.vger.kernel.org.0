Return-Path: <linux-rdma+bounces-21756-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xTnlAkNnIWqMFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21756-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EE63F99D
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:53:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="q/tI42s9";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21756-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21756-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54FF317CC47
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7943CEFB;
	Thu,  4 Jun 2026 11:46:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1A43CEFA
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 11:46:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573597; cv=none; b=XITRaonmBMqK9bdTsALzm9bwftyV6TT0cnI0J/nMLHBMW9n8mWUFjUd9IjlXfh+g/UxaaHv6h3fT95i8xt6haCVjf/Y7km2FUpxadrWC8gXIZR59MehW47HIXEneSRlDrt80vVasMmfU9YC05F0p7FBkRfimsdxxLtGVi1Se7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573597; c=relaxed/simple;
	bh=LuzcsTSa7CKf34v7yiw9yXghw+HfMlP6jZodVpyDfB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0C2ljapwiaNP8+9u1kormAYRQ6VFbcF1R0UbkO6Wi+AELOloOsUot9NIdryGzEjQdx03rUoNEl3dX1izN7Oa/nws5rIy3YvGLdZgtH41iFmvH80w6wzo3me9paE7Ebsdoc1r4ik8pi9iKy7j0tBL8ghNC+wTHdkbAU+crBG9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=q/tI42s9; arc=none smtp.client-ip=35.83.148.184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780573595; x=1812109595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMxlrL497abmeC5Nz57yq81Q0EW21yDI2CanMzRDso0=;
  b=q/tI42s9iz3gJwofs+Y1AmRlquTULAgjkcMzUc0qFY08kUwssQMCBfSh
   X0f7qXqlWBJUfNAoZFpufC/HiBTdG8o76k+avEdhfwPGr5LrTZWdtyvVB
   wZjT62Fuf8k9pyPmGxq64kS37HwOJMcsFjGvWPiRoehHAsDysBMVhDskN
   ozp5GwRRc+H7qsHbFwPUyTpglBU7Lv452JZJaVcONMlg5cyRC3te8lLab
   iY6dww6e6662VdbIhiWopnd/hlCcwSrPxcEUYKEwmcMLsWBxUQySTybjG
   oJs675+f+UhKse1rTtKdezBidTQ9AJ1LlaxElaVGkAOM6mqRFqcNeLHv1
   w==;
X-CSE-ConnectionGUID: sox5g0vJSP25Jw90eWEe5Q==
X-CSE-MsgGUID: 9Z9QuD1DRyWcyxRDcZrdrg==
X-IronPort-AV: E=Sophos;i="6.24,187,1774310400"; 
   d="scan'208";a="20869982"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:46:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:25839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.73:2525] with esmtp (Farcaster)
 id b0005e02-fdbd-4042-bd73-e20d857601b7; Thu, 4 Jun 2026 11:46:32 +0000 (UTC)
X-Farcaster-Flow-ID: b0005e02-fdbd-4042-bd73-e20d857601b7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 11:46:32 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 4 Jun 2026
 11:46:30 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v6 1/5] RDMA/core: Add Completion Counters support
Date: Thu, 4 Jun 2026 11:46:23 +0000
Message-ID: <20260604114627.6086-2-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604114627.6086-1-mrgolin@amazon.com>
References: <20260604114627.6086-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-21756-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 763EE63F99D

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
 .../core/uverbs_std_types_comp_cntr.c         | 173 ++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  48 ++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/rdma/ib_verbs.h                       |  40 ++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 11 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index ab7a2197bc86..47ef6b0afd29 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -38,6 +38,7 @@ ib_umad-y :=			user_mad.o
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
+				uverbs_std_types_comp_cntr.o \
 				uverbs_std_types_dmabuf.o \
 				uverbs_std_types_dmah.o \
 				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 21ada0fe9059..75ab0069eeac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2743,6 +2743,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_ah);
 	SET_DEVICE_OP(dev_ops, create_counters);
 	SET_DEVICE_OP(dev_ops, create_cq);
+	SET_DEVICE_OP(dev_ops, create_comp_cntr);
 	SET_DEVICE_OP(dev_ops, create_user_cq);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
@@ -2763,6 +2764,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, destroy_ah);
 	SET_DEVICE_OP(dev_ops, destroy_counters);
 	SET_DEVICE_OP(dev_ops, destroy_cq);
+	SET_DEVICE_OP(dev_ops, destroy_comp_cntr);
 	SET_DEVICE_OP(dev_ops, destroy_flow);
 	SET_DEVICE_OP(dev_ops, destroy_flow_action);
 	SET_DEVICE_OP(dev_ops, destroy_qp);
@@ -2814,6 +2816,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, modify_hw_stat);
 	SET_DEVICE_OP(dev_ops, modify_port);
 	SET_DEVICE_OP(dev_ops, modify_qp);
+	SET_DEVICE_OP(dev_ops, qp_attach_comp_cntr);
 	SET_DEVICE_OP(dev_ops, modify_srq);
 	SET_DEVICE_OP(dev_ops, modify_wq);
 	SET_DEVICE_OP(dev_ops, peek_cq);
@@ -2837,12 +2840,14 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
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
@@ -2851,6 +2856,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_comp_cntr);
 	SET_OBJ_SIZE(dev_ops, ib_dmah);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index b626d3d24d08..64ef97165fd9 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -152,6 +152,7 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
+extern const struct uapi_definition uverbs_def_obj_comp_cntr[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
 extern const struct uapi_definition uverbs_def_obj_device[];
 extern const struct uapi_definition uverbs_def_obj_dm[];
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 10bd7cafd976..e7cd91d522e7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3603,6 +3603,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 	resp.cq_moderation_caps.max_cq_moderation_period =
 		attr.cq_caps.max_cq_moderation_period;
 	resp.max_dm_size = attr.max_dm_size;
+	resp.max_comp_cntr = attr.max_comp_cntr;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 
 	return uverbs_response(attrs, &resp, sizeof(resp));
diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
new file mode 100644
index 000000000000..91ad54b270cf
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -0,0 +1,173 @@
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
+			    UA_MANDATORY));
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
index e44974abc6b5..9962155f905a 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -373,11 +373,57 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_qp_resp),
 			    UA_MANDATORY));
 
+static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *qp_uobj = uverbs_attr_get_uobject(
+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_HANDLE);
+	struct ib_comp_cntr *cc = uverbs_attr_get_obj(
+		attrs, UVERBS_ATTR_QP_ATTACH_COMP_CNTR_CNTR_HANDLE);
+	struct ib_qp_attach_comp_cntr_attr attr = {};
+	struct ib_qp *qp = qp_uobj->object;
+	int ret;
+
+	if (!cc->device->ops.qp_attach_comp_cntr)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_get_flags32(&attr.op_mask, attrs,
+				 UVERBS_ATTR_QP_ATTACH_COMP_CNTR_OP_MASK,
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_SEND |
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RECV |
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_READ |
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_READ |
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE |
+				 IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_WRITE);
+	if (ret)
+		return ret;
+
+	if (!attr.op_mask)
+		return -EINVAL;
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
+			     enum ib_uverbs_qp_attach_comp_cntr_op,
+			     UA_MANDATORY));
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
index 4e2e556c8119..d150099b99d2 100644
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
index 0daa5089d539..4d3441bf7328 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -454,6 +454,7 @@ struct ib_device_attr {
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
+enum ib_qp_attach_comp_cntr_op {
+	IB_QP_ATTACH_COMP_CNTR_OP_SEND = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_SEND,
+	IB_QP_ATTACH_COMP_CNTR_OP_RECV = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RECV,
+	IB_QP_ATTACH_COMP_CNTR_OP_RDMA_READ = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_READ,
+	IB_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_READ = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_READ,
+	IB_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE,
+	IB_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_WRITE = IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_WRITE,
+};
+
+struct ib_qp_attach_comp_cntr_attr {
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
+				   struct ib_qp_attach_comp_cntr_attr *attr);
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
index 839835bd4b23..1fd537ebb69e 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -57,6 +57,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_ASYNC_EVENT,
 	UVERBS_OBJECT_DMAH,
 	UVERBS_OBJECT_DMABUF,
+	UVERBS_OBJECT_COMP_CNTR,
 };
 
 enum {
@@ -169,9 +170,16 @@ enum uverbs_attrs_destroy_qp_cmd_attr_ids {
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
@@ -438,4 +446,34 @@ enum uverbs_attrs_query_gid_entry_cmd_attr_ids {
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
index 51030c27d479..21f86cc7bb1f 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -300,4 +300,23 @@ struct ib_uverbs_buffer_desc {
 	__aligned_u64 length;
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
+enum ib_uverbs_qp_attach_comp_cntr_op {
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_SEND = 1 << 0,
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RECV = 1 << 1,
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_READ = 1 << 2,
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_READ = 1 << 3,
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE = 1 << 4,
+	IB_UVERBS_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_WRITE = 1 << 5,
+};
+
 #endif
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index d2aeadb6d2f9..d212bb470a4a 100644
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


