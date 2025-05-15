Return-Path: <linux-rdma+bounces-10360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A9AB89E1
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB91A06862
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED21D6DBB;
	Thu, 15 May 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DRpgYJUw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954B1DED5B
	for <linux-rdma@vger.kernel.org>; Thu, 15 May 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320664; cv=none; b=V1uOFKyJiLykSW7oHi1IDWg1I9qN+NO56pLQO4iA3gwSlfsQt39UIk/ascRXuq/naqfwllb9B4iODy1cD2c0YAJJcogjDPQgJrmkT3IJf1uhuOoibCMQP2hXnvUWb/Eglp6V66WcPzwgidt6wV994PS+RBz4jMOYPZZQazUf9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320664; c=relaxed/simple;
	bh=cDa5xqtskvdT63WTVB3B624mr+wFpMWPw9PBmM6H+Gw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EkVjxWxhQaOxrM+g0x9FNi67eBqw/uAX4KLcZgH6aYQD7RGmGhEZImmEox1rmAh/du35U50+4JsEOzijQbHRxRAv9EdVJTP2K3GQ5jJFT+7GJklY935gIFc/a/H3ZETi3pvgRrUlbQVTQXAd56kY1Fsz2upiMNix/vpb2idnGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DRpgYJUw; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747320659; x=1778856659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H/0kTwjtUmjjwlwfeMGQZMu0FL+JijRSIoQ43fb+NXk=;
  b=DRpgYJUwhD5xzIrdpsa3S8g3tzndX99he8bIxtF8DHmc9GMEieEPpCdz
   ccHlIfthZC7xglDvK3z6mZzMSnn6fmS0i4G4lw6agMjWCwryjhicYCADu
   GmsfuwXz1tRvJqT4Ecvz3z/CJd7CkKs6INHW8EaWXBCccm0scN6hnrzoN
   Thjh7RQ5lDBfAHBjrC5MGFuYyMebQasj3r4l2gOrLrjag858bp9te5Ro1
   JAgrOevka+Q7/JOlhOsX+LGo28q+fDKjab1LKAm2KILibRHaduF4yW2LK
   DvVqQKmXwpaKNHCp2v3cBRLVhfIsGMMgnvmKNThDxmRSo59mICz4D6J0H
   A==;
X-IronPort-AV: E=Sophos;i="6.15,291,1739836800"; 
   d="scan'208";a="723101322"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 14:50:56 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:36284]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.49:2525] with esmtp (Farcaster)
 id 2fc5668b-3f66-47c0-90fa-66cdb691399a; Thu, 15 May 2025 14:50:55 +0000 (UTC)
X-Farcaster-Flow-ID: 2fc5668b-3f66-47c0-90fa-66cdb691399a
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 14:50:53 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 15 May 2025
 14:50:50 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Date: Thu, 15 May 2025 14:50:40 +0000
Message-ID: <20250515145040.6862-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add an option to create CQ using external memory instead of allocating
in the driver. The memory can be passed from userspace by dmabuf fd and
an offset. Add a capability bit to reflect on the feature support.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 60 ++++++++++++++++++++++-----
 include/uapi/rdma/efa-abi.h           |  8 +++-
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 838182d0409c..fd609a50cea0 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -107,6 +107,7 @@ struct efa_cq {
 	u16 cq_idx;
 	/* NULL when no interrupts requested */
 	struct efa_eq *eq;
+	struct ib_umem *umem;
 };
 
 struct efa_qp {
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..ecebc47ff249 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -249,6 +249,7 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rdma_size = dev_attr->max_rdma_size;
 
 		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID;
+		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM_DMABUF;
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
 
@@ -1133,8 +1137,10 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_com_create_cq_result result;
 	struct ib_device *ibdev = ibcq->device;
 	struct efa_dev *dev = to_edev(ibdev);
+	struct ib_umem_dmabuf *umem_dmabuf;
 	struct efa_ibv_create_cq cmd = {};
 	struct efa_cq *cq = to_ecq(ibcq);
+	struct scatterlist *umem_sgl;
 	int entries = attr->cqe;
 	bool set_src_addr;
 	int err;
@@ -1202,11 +1208,40 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
-	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
-					 DMA_FROM_DEVICE);
-	if (!cq->cpu_addr) {
-		err = -ENOMEM;
-		goto err_out;
+
+	if (cmd.flags & EFA_CREATE_CQ_WITH_EXT_MEM_DMABUF) {
+		if (cmd.ext_mem_length < cq->size) {
+			ibdev_dbg(&dev->ibdev, "External memory too small\n");
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ibdev, cmd.ext_mem_offset,
+							cq->size, cmd.ext_mem_fd,
+							IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem_dmabuf)) {
+			err = PTR_ERR(umem_dmabuf);
+			ibdev_dbg(&dev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
+			goto err_out;
+		}
+		cq->umem = &umem_dmabuf->umem;
+		umem_sgl = cq->umem->sgt_append.sgt.sgl;
+
+		if (sg_dma_len(umem_sgl) < ib_umem_offset(cq->umem) + cq->size) {
+			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
+			err = -EINVAL;
+			goto err_free_mapped;
+		}
+
+		cq->cpu_addr = NULL;
+		cq->dma_addr = sg_dma_address(umem_sgl) + ib_umem_offset(cq->umem);
+	} else {
+		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
+						 DMA_FROM_DEVICE);
+		if (!cq->cpu_addr) {
+			err = -ENOMEM;
+			goto err_out;
+		}
 	}
 
 	params.uarn = cq->ucontext->uarn;
@@ -1231,7 +1266,9 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = result.actual_depth;
 	WARN_ON_ONCE(entries != result.actual_depth);
 
-	err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+	if (!(cmd.flags & EFA_CREATE_CQ_WITH_EXT_MEM_DMABUF))
+		err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+
 	if (err) {
 		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
 			  cq->cq_idx);
@@ -1270,8 +1307,11 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
-	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
-			DMA_FROM_DEVICE);
+	if (cq->umem)
+		ib_umem_release(cq->umem);
+	else
+		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
+				DMA_FROM_DEVICE);
 
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 11b94b0b035b..f2bcef789571 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -56,6 +56,7 @@ struct efa_ibv_alloc_pd_resp {
 enum {
 	EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL = 1 << 0,
 	EFA_CREATE_CQ_WITH_SGID               = 1 << 1,
+	EFA_CREATE_CQ_WITH_EXT_MEM_DMABUF     = 1 << 2,
 };
 
 struct efa_ibv_create_cq {
@@ -64,6 +65,10 @@ struct efa_ibv_create_cq {
 	__u16 num_sub_cqs;
 	__u8 flags;
 	__u8 reserved_58[5];
+	__aligned_u64 ext_mem_offset;
+	__aligned_u64 ext_mem_length;
+	__u32 ext_mem_fd;
+	__u8 reserved_120[4];
 };
 
 enum {
@@ -131,6 +136,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
+	EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM_DMABUF = 1 << 7,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.47.1


