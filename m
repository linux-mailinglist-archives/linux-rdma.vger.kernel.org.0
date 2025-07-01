Return-Path: <linux-rdma+bounces-11811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2146AF06D5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 01:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9611BC2D48
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E28027055F;
	Tue,  1 Jul 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fVs8nIZY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA009271451
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411760; cv=none; b=RM6dsTVDzCZGmxlGK0NrwVKpHPjLiNkV6jLjyS3GNT+6voetbSNWwFVoVdqQpaqs8YcN4ZEtiEAW3EQjaMfgyHZX3aDk19iZFz1URYwBaHEbANHv0xSo/u74LGT74OKwnKSrgH42/dv9seMdxkopGvMzQ7YTmQCfE8tE67rfi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411760; c=relaxed/simple;
	bh=nJij7t7bX6XWLpRq1Rhe6eFUyTDcR+1Hy3QerQfucXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl+sW6/U7gKDrLjKwDpKL8cylTk6GHSIhC7PtT8sSTyd1+zz4PUgOLTGbdKDmlOm3aVVyfcweK0A5KE0ZFtdSRHk+nfQMMjb5NbGGhTQBGQFRrt3K7a5FDAqxQZtgy4S7oVc9SSWRmnu9AFfwUTEXDcWpSyGvqfzMlVObWF7hCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fVs8nIZY; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751411759; x=1782947759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLSCd64vsJmzunSnfjPvsVPIEYg0DB8VZdNHGYn3jXQ=;
  b=fVs8nIZYwm2eYeIYoukgqwn+roA1WCiM5sT+ngB9UYZCN3vno1FDBCzV
   x6GqeE5o6uuCj0Fcg1P5cMBLA4uvWLOuYvPfiiXcUJ6sEEGQ7+e6ghfX8
   UpQYClCf5IC0ZjCiXLUfPdAkkXAbPgbBhpJhiGtvh4LrQUjKI4oG/yNT+
   M/BeIGVdiBJex7yNCYwzUfFqr1vTcdFz/59W0agja39Kbw2l9gFatumV9
   QsvY9TxTVSmM169law8tlUuCBrRaUvfDLZbXsziwrHEfTAqDmjEQ6YEBJ
   4d2hgQ+ERYjz5mnPATk3Skc2tYum4ubLZmnNr6gYSIx0n7gEdfFjerV+a
   g==;
X-IronPort-AV: E=Sophos;i="6.16,280,1744070400"; 
   d="scan'208";a="314111427"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:15:55 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:16323]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.154:2525] with esmtp (Farcaster)
 id 664a2377-21db-4292-9326-67c4adf8c6c2; Tue, 1 Jul 2025 23:15:54 +0000 (UTC)
X-Farcaster-Flow-ID: 664a2377-21db-4292-9326-67c4adf8c6c2
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Jul 2025 23:15:54 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 1 Jul 2025
 23:15:51 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next 1/2] RDMA/uverbs: Add a common way to create CQ with umem
Date: Tue, 1 Jul 2025 23:15:44 +0000
Message-ID: <20250701231545.14282-2-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701231545.14282-1-mrgolin@amazon.com>
References: <20250701231545.14282-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add ioctl command attributes and a common handling for the option to
create CQs with memory buffers passed from userspace. When required
attributes are supplied, create umem for driver use and store it in CQ
context.
The extension enables creation of CQs on top of preallocated CPU
virtual or device memory buffers, by supplying VA or dmabuf fd, in a
common way. At first stage the command fails for any driver that didn't
explicitly state its support by setting a flag in the ops struct.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/device.c              |  3 +
 drivers/infiniband/core/uverbs_std_types_cq.c | 82 ++++++++++++++++++-
 include/rdma/ib_verbs.h                       |  6 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 468ed6bd4722..8b0ce0ec15dd 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2667,6 +2667,9 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	dev_ops->uverbs_no_driver_id_binding |=
 		ops->uverbs_no_driver_id_binding;
 
+	dev_ops->uverbs_support_cq_with_umem |=
+		ops->uverbs_support_cq_with_umem;
+
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, add_sub_dev);
 	SET_DEVICE_OP(dev_ops, advise_mr);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 432054f0a8a4..a8d567d2bdf9 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -64,13 +64,19 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
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
 
 	if (!ib_dev->ops.create_cq || !ib_dev->ops.destroy_cq)
 		return -EOPNOTSUPP;
@@ -112,9 +118,65 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
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
+		    !ib_dev->ops.uverbs_support_cq_with_umem) {
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
+		    !ib_dev->ops.uverbs_support_cq_with_umem) {
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
+		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH)) {
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
 
@@ -123,6 +185,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
+	cq->umem          = umem;
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
@@ -180,6 +243,17 @@ DECLARE_UVERBS_NAMED_METHOD(
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
index 38f68d245fa6..c7b082a78381 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1625,6 +1625,7 @@ struct ib_cq {
 	};
 	struct workqueue_struct *comp_wq;
 	struct dim *dim;
+	struct ib_umem *umem;
 
 	/* updated only by trace points */
 	ktime_t timestamp;
@@ -2343,6 +2344,11 @@ struct ib_device_ops {
 	enum rdma_driver_id driver_id;
 	u32 uverbs_abi_ver;
 	unsigned int uverbs_no_driver_id_binding:1;
+	/*
+	 * Driver gets ownership over the umem and is responsible for releasing
+	 * it on CQ destroy or when it's no longer needed.
+	 */
+	unsigned int uverbs_support_cq_with_umem:1;
 
 	/*
 	 * NOTE: New drivers should not make use of device_group; instead new
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


