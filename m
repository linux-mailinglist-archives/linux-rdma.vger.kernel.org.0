Return-Path: <linux-rdma+bounces-10399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC0ABB0C4
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FE01897F8F
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8A191F77;
	Sun, 18 May 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NDEfxMd2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6752746C
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747584622; cv=none; b=r8aCtggeXRCIVUxtPt9kooqIKly4FbDEX/oDc/WnP5toCeHaMY7f/nSzpcxLDPo+/mCanogZ40YFDOYDxq/EndRMgU/Potc1Bsp8GqmuzbnDWzas3dSVEj5qK6as74YMmM7FIYcN+wgRAFo7ElfVtG6JQCxbNvkgQtQLHkh45ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747584622; c=relaxed/simple;
	bh=Gxn31F+zPJr2y+Vca8hZHU7I76Kh5AOEpiTDvHcxOXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAmb/40eYtSYJLPsVw47r4zQMH9V/voVsH8H80RXnRgxnleaNZm53UNod0tqOfGRXCOLi8EA3mbo7BlK/DXaVEBtl+xmkDE/U4Vpb9zPHcpRppBvPoYW6ZnFkNZ4BgsLIPhbfLM2E0vcV+D5CrI6oJObmZo1yUVs9me/FyRo1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NDEfxMd2; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747584621; x=1779120621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ivnms+6pbvBIgPqoIQyuB2pGFyqptSi67hLpqrexuLA=;
  b=NDEfxMd2NW2e6UJg5pNN9jyMzZ+F1XC72nkrVWur79B4IH4t1LT3hgzM
   GldXbjLjQCGsGk2+/IHvwxxL4h1R1587eh2u8oZwo4t73aURFxC78/aU5
   MZbt7ta9PkKP6e4gmr9jSHjBPdj0Meud0Pt5K0EvJDkYJTjMUeOibqu+J
   5ySk61es7GPg2t0IAx3GEShyECoXMyd5nWv1vsKSS3BhVmNqEHovNa5mZ
   BbeVYbWYnBgn4C1+qjRlV8sb1CwhDKXI4eQuVQy9/9ghX0eJcl+7ft/u0
   yfkI3B9QWk7dE9H4yK4auS5E6m8Z5qhHgkO/WQNHO4wW91tPpkyy/Rd5I
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,299,1739836800"; 
   d="scan'208";a="521729441"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 16:10:14 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:10901]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.226:2525] with esmtp (Farcaster)
 id 248ce623-c8f2-4493-98c8-31f0d6019763; Sun, 18 May 2025 16:10:12 +0000 (UTC)
X-Farcaster-Flow-ID: 248ce623-c8f2-4493-98c8-31f0d6019763
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 18 May 2025 16:10:12 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Sun, 18 May 2025
 16:10:09 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Add CQ with external memory support
Date: Sun, 18 May 2025 16:09:56 +0000
Message-ID: <20250518160956.14711-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add an option to create CQ using external memory instead of allocating
in the driver. The memory can be passed from userspace by dmabuf fd and
an offset. One of the possible usages is creating CQs that reside in
accelerator memory, allowing low latency asynchronous direct polling
from the accelerator device. Add a capability bit to reflect on the
feature support.

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


