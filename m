Return-Path: <linux-rdma+bounces-11972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DBCAFD858
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664B417363D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03BE14EC73;
	Tue,  8 Jul 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cJVaRjmA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96324169E
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006210; cv=none; b=UwriOp8buPEMcvn0ciHz4FjmQIjZYtvDJg49dnbLP56CkHI9RWdknD7Evvv2M2uWLel/1WFvHq3Y9EK/iGX31lCx+YvzqTIRv9NvMozLz4+NpDDoNPOovAEgR2cl/6efuAPpBvR+nA8z8rB3TLD+sIP4BN3Pi1Z3Y4MfQ1p/Z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006210; c=relaxed/simple;
	bh=QKX2lH+0FegqMLe4qzyu431WflaGYL/fExuOI4eWays=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phf55QvPmeiQBlP52rQ7myMjgI0cvYq8YRwJISmgTp60NPoX6BV77n9qbxKFqV+iGZY+W3xmr8KfWnMtS6JiqBLtS8AIKVKiO4F9+2Xg9opR2uKef5iwUAcve1rV1FeYrS4hDZkUZ8NP9YI6jvny2JcskGRUDJ99uzyuWa0Qm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cJVaRjmA; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752006209; x=1783542209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKwwFpXcy6DbFJOhloBZ5eAGQSx9esTC+/R0rXJMMs8=;
  b=cJVaRjmAtOfKHODKAjYXHarnORX51eiu0UjqeVHHAKhBMyUUXPIdLlsb
   0oovE2miu2kHFWlDsDJdYp8nSOA14a/n5Sk+eZ0C4YXT781PMkJ6PKs7i
   lFvBbgLb+m6kteIBiIeCvsKA0dEIS5iYXE7JDOkaIWp9tV+GafgIBIld8
   XRcRHDSn5pgwGmhSdUfhnIzdRXJno+WOkNKuZnaOTVS2l6jI5R7QC7nDX
   hQsjh5OFMUEjMuCMuF0QyC8bHaa2T6t8kMBOm1S2Sgr8mlH42uWekm8oX
   /En64e0pFh68W/UH27wo1x8DHcnSAWdKVVgeAykJ47TmN1HYsn9LMlDuN
   A==;
X-IronPort-AV: E=Sophos;i="6.16,298,1744070400"; 
   d="scan'208";a="36371890"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:23:26 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:36062]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.124:2525] with esmtp (Farcaster)
 id a77123c2-a885-4bd6-845a-05f374045ed5; Tue, 8 Jul 2025 20:23:24 +0000 (UTC)
X-Farcaster-Flow-ID: a77123c2-a885-4bd6-845a-05f374045ed5
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:23:22 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 8 Jul 2025
 20:23:20 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v2 3/3] RDMA/efa: Add CQ with external memory support
Date: Tue, 8 Jul 2025 20:23:08 +0000
Message-ID: <20250708202308.24783-4-mrgolin@amazon.com>
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
 drivers/infiniband/hw/efa/efa.h       |  3 ++
 drivers/infiniband/hw/efa/efa_main.c  |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 61 +++++++++++++++++++++------
 include/uapi/rdma/efa-abi.h           |  3 +-
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 838182d0409c..3d49c1db928e 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -107,6 +107,7 @@ struct efa_cq {
 	u16 cq_idx;
 	/* NULL when no interrupts requested */
 	struct efa_eq *eq;
+	struct ib_umem *umem;
 };
 
 struct efa_qp {
@@ -162,6 +163,8 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs);
+int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 4f03c0ec819f..6c415b9adb5f 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -372,6 +372,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_cq = efa_create_cq,
+	.create_cq_umem = efa_create_cq_umem,
 	.create_qp = efa_create_qp,
 	.create_user_ah = efa_create_ah,
 	.dealloc_pd = efa_dealloc_pd,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..7fcdcd0dfc9d 100644
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
+	if (cq->umem)
+		ib_umem_release(cq->umem);
+	else
+		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 	return 0;
 }
 
@@ -1122,8 +1126,8 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 	return 0;
 }
 
-int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct uverbs_attr_bundle *attrs)
+int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
@@ -1202,11 +1206,30 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
-	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
-					 DMA_FROM_DEVICE);
-	if (!cq->cpu_addr) {
-		err = -ENOMEM;
-		goto err_out;
+
+	if (umem) {
+		if (umem->length < cq->size) {
+			ibdev_dbg(&dev->ibdev, "External memory too small\n");
+			err = -EINVAL;
+			goto err_free_mem;
+		}
+
+		if (!ib_umem_is_contiguous(umem)) {
+			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
+			err = -EINVAL;
+			goto err_free_mem;
+		}
+
+		cq->cpu_addr = NULL;
+		cq->dma_addr = ib_umem_start_dma_addr(umem);
+		cq->umem = umem;
+	} else {
+		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
+						 DMA_FROM_DEVICE);
+		if (!cq->cpu_addr) {
+			err = -ENOMEM;
+			goto err_out;
+		}
 	}
 
 	params.uarn = cq->ucontext->uarn;
@@ -1223,7 +1246,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	err = efa_com_create_cq(&dev->edev, &params, &result);
 	if (err)
-		goto err_free_mapped;
+		goto err_free_mem;
 
 	resp.db_off = result.db_off;
 	resp.cq_idx = result.cq_idx;
@@ -1231,7 +1254,9 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = result.actual_depth;
 	WARN_ON_ONCE(entries != result.actual_depth);
 
-	err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+	if (!umem)
+		err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+
 	if (err) {
 		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
 			  cq->cq_idx);
@@ -1269,15 +1294,23 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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
 	return err;
 }
 
+int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct uverbs_attr_bundle *attrs)
+{
+	return efa_create_cq_umem(ibcq, attr, NULL, attrs);
+}
+
 static int umem_to_page_list(struct efa_dev *dev,
 			     struct ib_umem *umem,
 			     u64 *page_list,
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


