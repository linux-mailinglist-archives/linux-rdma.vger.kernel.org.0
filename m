Return-Path: <linux-rdma+bounces-11973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7AAFD85A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B605C189AFA2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04199242D64;
	Tue,  8 Jul 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BpFME36j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7992417EE
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006210; cv=none; b=i3FI7Lx7R/UTj23V7NOmHcOk12JJUHdqBe5B/jR3Rn4ol7ql28qPqOjWWE3Ai23rU4upFjpVOkfuzKT5/AO4/3ARD+N6uyufYBkMIVC6HQh5Is8VhJ4WOw+P0mP5kt3xLC7yyIekJOfnZFgVs7P9tyHzcgwtFXMYeqidtp583S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006210; c=relaxed/simple;
	bh=Ag7aV7KYxNXNiq2pAZRHlpij+hGK1hLD7GRgVbVZ0T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNWEc0SqsFNr0LUPRg6ze8ShZPg2ftYd+qSBnb52+r5h5HHVqpemmkw/qbt/U5wZ80ZCM0wtUaEOxGUXR93OmzgkBG88kCSSI8bwnRWgciRxl9cOql/ohYfvM0Ohov+bPE+AbqgyTwZZJZCzf3gLgsapLUIayDyDVyMMygTZ6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BpFME36j; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752006209; x=1783542209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cGQD7Ypeny3JG1aAW7CeqKzBfpBzdVug3u8ogaRD4Y=;
  b=BpFME36jD9o6yhQgCEquBjRJzvIZ78Hww68HKJLnTJqYPYri9YlqtfWS
   2nB+LneZQdz3wZg3GPGs3iKtcPRJ6wisDSkPHjRMruxiv/WKyh/W25334
   3TAXCWcgN6+YflJ5veP1NwFpgVsPogOkP4Bk0db5GCARM2A11VfnjTADr
   Jj1A2KuhWz7mtaZJCa57DoLIfCFjzhUI/Ngb7gVxPeGcpFTTd6TKKj8p0
   YbqHmzAoI8/xMV08fJhDf2i2sq2xs5WCjspYbhsbmguqsjJse99jI/xZ5
   j5Qnnaknfq03FkgAK0Bxm96UkuDCsLASP85GPAvuc6iPCaC5QXfAlTKaJ
   A==;
X-IronPort-AV: E=Sophos;i="6.16,298,1744070400"; 
   d="scan'208";a="36371868"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:23:21 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:29165]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id 078b064e-f9fb-4043-b8e0-154d6bd5ee63; Tue, 8 Jul 2025 20:23:19 +0000 (UTC)
X-Farcaster-Flow-ID: 078b064e-f9fb-4043-b8e0-154d6bd5ee63
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:23:17 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 8 Jul 2025
 20:23:15 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v2 1/3] RDMA/uverbs: Add a common way to create CQ with umem
Date: Tue, 8 Jul 2025 20:23:06 +0000
Message-ID: <20250708202308.24783-2-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708202308.24783-1-mrgolin@amazon.com>
References: <20250708202308.24783-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add ioctl command attributes and a common handling for the option to
create CQs with memory buffers passed from userspace. When required
attributes are supplied, create umem and provide it for driver's use.
The extension enables creation of CQs on top of preallocated CPU
virtual or device memory buffers, by supplying VA or dmabuf fd, in a
common way.
Drivers can support this flow by initializing a new create_cq_umem fp
field in their ops struct, with a function that can handle the new
parameter.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/uverbs_std_types_cq.c | 87 +++++++++++++++++--
 include/rdma/ib_verbs.h                       |  4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
 4 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1ca6a9b7ba1a..f301cdce1728 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2728,6 +2728,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_ah);
 	SET_DEVICE_OP(dev_ops, create_counters);
 	SET_DEVICE_OP(dev_ops, create_cq);
+	SET_DEVICE_OP(dev_ops, create_cq_umem);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 432054f0a8a4..37cd37556510 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -64,15 +64,21 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct ib_ucq_object *obj = container_of(
 		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_CQ_HANDLE),
 		typeof(*obj), uevent.uobject);
+	struct ib_uverbs_completion_event_file *ev_file = NULL;
 	struct ib_device *ib_dev = attrs->context->device;
-	int ret;
-	u64 user_handle;
+	struct ib_umem_dmabuf *umem_dmabuf;
 	struct ib_cq_init_attr attr = {};
-	struct ib_cq                   *cq;
-	struct ib_uverbs_completion_event_file    *ev_file = NULL;
 	struct ib_uobject *ev_file_uobj;
+	struct ib_umem *umem = NULL;
+	u64 buffer_length;
+	u64 buffer_offset;
+	struct ib_cq *cq;
+	u64 user_handle;
+	u64 buffer_va;
+	int buffer_fd;
+	int ret;
 
-	if (!ib_dev->ops.create_cq || !ib_dev->ops.destroy_cq)
+	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_cq_umem) || !ib_dev->ops.destroy_cq)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.comp_vector, attrs,
@@ -112,9 +118,66 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
+
+		ret = uverbs_copy_from(&buffer_va, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
+		if (ret)
+			goto err_event_file;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			goto err_event_file;
+
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
+		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+		    !ib_dev->ops.create_cq_umem) {
+			ret = -EINVAL;
+			goto err_event_file;
+		}
+
+		umem = ib_umem_get(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem)) {
+			ret = PTR_ERR(umem);
+			goto err_event_file;
+		}
+	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD)) {
+
+		ret = uverbs_get_raw_fd(&buffer_fd, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
+		if (ret)
+			goto err_event_file;
+
+		ret = uverbs_copy_from(&buffer_offset, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
+		if (ret)
+			goto err_event_file;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			goto err_event_file;
+
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
+		    !ib_dev->ops.create_cq_umem) {
+			ret = -EINVAL;
+			goto err_event_file;
+		}
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset, buffer_length,
+							buffer_fd, IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem_dmabuf)) {
+			ret = PTR_ERR(umem_dmabuf);
+			goto err_event_file;
+		}
+		umem = &umem_dmabuf->umem;
+	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH) ||
+		   !ib_dev->ops.create_cq) {
+		ret = -EINVAL;
+		goto err_event_file;
+	}
+
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
 		ret = -ENOMEM;
+		ib_umem_release(umem);
 		goto err_event_file;
 	}
 
@@ -128,7 +191,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = ib_dev->ops.create_cq(cq, &attr, attrs);
+	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
+		ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 
@@ -180,6 +244,17 @@ DECLARE_UVERBS_NAMED_METHOD(
 		       UVERBS_OBJECT_ASYNC_EVENT,
 		       UVERBS_ACCESS_READ,
 		       UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_VA,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+			   UVERBS_ATTR_TYPE(u64),
+			   UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 010594dc755b..5ad0136d43c4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2486,6 +2486,10 @@ struct ib_device_ops {
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
 	int (*create_cq)(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
 			 struct uverbs_attr_bundle *attrs);
+	int (*create_cq_umem)(struct ib_cq *cq,
+			      const struct ib_cq_init_attr *attr,
+			      struct ib_umem *umem,
+			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index ac7b162611ed..5f3e5bee51b2 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -105,6 +105,10 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_FLAGS,
 	UVERBS_ATTR_CREATE_CQ_RESP_CQE,
 	UVERBS_ATTR_CREATE_CQ_EVENT_FD,
+	UVERBS_ATTR_CREATE_CQ_BUFFER_VA,
+	UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
+	UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
+	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.47.1


