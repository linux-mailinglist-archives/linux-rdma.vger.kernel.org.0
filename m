Return-Path: <linux-rdma+bounces-11812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A204BAF06D6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 01:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2647B1BC3D85
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6DB277C87;
	Tue,  1 Jul 2025 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ner7DoX+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D526AA82
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411766; cv=none; b=tXPhLMMzaAtHdIlhQtd+mQo4v11C2AQVJSuqZe47sjpWxqeAqsjq1xHMI3k6foA7sZx0obFvN03Miy2kJA+xg1xQNAhWPqdOc2fdYMK5p9YVXisjalAxDn+M2ULh9jG9SpMNXHZPnIP4q135w9I/4Fl5F93zOVXidbyW9ZsMGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411766; c=relaxed/simple;
	bh=99SIqb3jskorRoVMMqltkOtha3tY9BaodORIyNqLRAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhaho2gfjImGO3IS1F2GpwKrT+hV/cn/DZxvAVa446J6ux0pDnEFiHUzgv2QeG+Yy5X9YlXHBWBVMxVyuIYKRotom0gyrpTkVwkrHL6d4Vbv8lhR+VvvCm/9yJ59MsiGLV7tURqKh4jeWjpJI8NoHc5VApv8CbwIL0tbysrM2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ner7DoX+; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751411766; x=1782947766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBaKDGLNgokopZpXvt1R8p+yKUmqYy076Z10Zyi9BZA=;
  b=Ner7DoX+qsxn13aOeaZ0dZLtVwbVOyXyUfTd/r9WoKfpi7Q/6d1clZzx
   w/s9DQJ3UMNZrWf+eTuxrLmHPCsDCMfntUjlj5cFtktAGJmZp2e41J80D
   Zm2esVmde3MjlUmZR8Cc4SEe2Dxn09fUMSXfKd23Tv1fvvNsxduMHO085
   h7Jt9Ts4Uc9UGyeNVy98zFEuvHyBjDMhJfis/XuDKQTtActI+yi7sppQd
   Q2QW12DPS+pYTWPh31bFqPbNKVxE87PMtJkarp1FvKy0A9tDN21rgmqUv
   6GCcQVLzxKSPU22Mp8jDGCfmDHad384FhHPOAXsvK/s4x0K2IwHlSg6TF
   w==;
X-IronPort-AV: E=Sophos;i="6.16,280,1744070400"; 
   d="scan'208";a="839579161"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:15:59 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:49714]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.19.53:2525] with esmtp (Farcaster)
 id 10b868c7-5547-4584-8c49-1f30c9ec34a1; Tue, 1 Jul 2025 23:15:57 +0000 (UTC)
X-Farcaster-Flow-ID: 10b868c7-5547-4584-8c49-1f30c9ec34a1
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Jul 2025 23:15:57 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 1 Jul 2025
 23:15:54 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Add CQ with external memory support
Date: Tue, 1 Jul 2025 23:15:45 +0000
Message-ID: <20250701231545.14282-3-mrgolin@amazon.com>
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

Add an option to create CQ using external memory instead of allocating
in the driver. The memory can be passed from userspace by dmabuf fd and
an offset or a VA. One of the possible usages is creating CQs that
reside in accelerator memory, allowing low latency asynchronous direct
polling from the accelerator device. Add a capability bit to reflect on
the feature support.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c  |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 47 ++++++++++++++++++++-------
 include/uapi/rdma/efa-abi.h           |  3 +-
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 4f03c0ec819f..b066e8387df0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -366,6 +366,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_EFA,
 	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
+	.uverbs_support_cq_with_umem = 1,
 
 	.alloc_hw_port_stats = efa_alloc_hw_port_stats,
 	.alloc_hw_device_stats = efa_alloc_hw_device_stats,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..5988f89837bd 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -249,6 +249,7 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rdma_size = dev_attr->max_rdma_size;
 
 		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID;
+		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM;
 		if (EFA_DEV_CAP(dev, RDMA_READ))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
@@ -1082,8 +1083,11 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 		synchronize_irq(cq->eq->irq.irqn);
 	}
-	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
-			DMA_FROM_DEVICE);
+
+	if (ibcq->umem)
+		ib_umem_release(ibcq->umem);
+	else
+		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 	return 0;
 }
 
@@ -1133,8 +1137,10 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_com_create_cq_result result;
 	struct ib_device *ibdev = ibcq->device;
 	struct efa_dev *dev = to_edev(ibdev);
+	struct ib_umem *umem = ibcq->umem;
 	struct efa_ibv_create_cq cmd = {};
 	struct efa_cq *cq = to_ecq(ibcq);
+	struct scatterlist *umem_sgl;
 	int entries = attr->cqe;
 	bool set_src_addr;
 	int err;
@@ -1202,11 +1208,24 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
-	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
-					 DMA_FROM_DEVICE);
-	if (!cq->cpu_addr) {
-		err = -ENOMEM;
-		goto err_out;
+
+	if (umem) {
+		umem_sgl = ibcq->umem->sgt_append.sgt.sgl;
+		if (sg_dma_len(umem_sgl) < ib_umem_offset(umem) + cq->size) {
+			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
+			err = -EINVAL;
+			goto err_free_mem;
+		}
+
+		cq->cpu_addr = NULL;
+		cq->dma_addr = sg_dma_address(umem_sgl) + ib_umem_offset(umem);
+	} else {
+		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
+						 DMA_FROM_DEVICE);
+		if (!cq->cpu_addr) {
+			err = -ENOMEM;
+			goto err_out;
+		}
 	}
 
 	params.uarn = cq->ucontext->uarn;
@@ -1223,7 +1242,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	err = efa_com_create_cq(&dev->edev, &params, &result);
 	if (err)
-		goto err_free_mapped;
+		goto err_free_mem;
 
 	resp.db_off = result.db_off;
 	resp.cq_idx = result.cq_idx;
@@ -1231,7 +1250,9 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = result.actual_depth;
 	WARN_ON_ONCE(entries != result.actual_depth);
 
-	err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+	if (!umem)
+		err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+
 	if (err) {
 		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
 			  cq->cq_idx);
@@ -1269,9 +1290,11 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	efa_cq_user_mmap_entries_remove(cq);
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
-err_free_mapped:
-	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
-			DMA_FROM_DEVICE);
+err_free_mem:
+	if (umem)
+		ib_umem_release(umem);
+	else
+		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 11b94b0b035b..98b71b9979f8 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -131,6 +131,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
+	EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM = 1 << 7,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.47.1


