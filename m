Return-Path: <linux-rdma+bounces-1417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713687A83B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 14:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B88285494
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC3941238;
	Wed, 13 Mar 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OMFEXHi7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90B405E6;
	Wed, 13 Mar 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336312; cv=none; b=UaSsypiOtABkyWkWzRgUy+zd8fCdagWhX9AbRLeXP3lptQ0l79cv+lgFB1EUycM5WeK0+cbkkiQTce5H+8AbEiY/tFbBVNN1E4vIgNTPCP54H4n++mz4OccHE/jHsclxElQDP1iU2PE5RhYgKwMruDtgHt2fNvRWvZA+iuweFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336312; c=relaxed/simple;
	bh=Wsm06+hVilYDR2b88UBqEerQHfWTAoKVS/uaDTEtEUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FFwUTiUJ3PrziUyL1+ev7JFAdf19XcwZaRh+Chv6focaZOa+qxkYvwZYMSGZ1frA85kV17pr7UYZnPATXgr4ny0VM3BQZMXU2wfr/aZIL8kaahkhkRLqB2W4TlE1+u0bouSU1iGZO15T2m2KBTGW1HoXyFsiMXyICZzUjoae2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OMFEXHi7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B56B20B74C2;
	Wed, 13 Mar 2024 06:25:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B56B20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710336304;
	bh=ybcua5Z9rRYqfulo278YzyDu7KTV6jehhHR7akWGX1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMFEXHi7oaHierYwKZS7lXdlB/FxeTR+OXc3iqUNULrzoUpoBGAw++AF9F47QzQJa
	 cxHrvaZ9iqsHtMQ/ZEKpIg6CIuP1iWNMZ8pvQjNoFlYWQDqkncBvvHiybNfsSvRD4Y
	 cTBgQ0LUM74ZZDgRMeHQca/2L3ZRveQT9AiOea5k=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce helpers to create and destroy mana queues
Date: Wed, 13 Mar 2024 06:24:56 -0700
Message-Id: <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
A queue always consists of umem, gdma_region, and id.
A queue can be used for a WQ or a CQ.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 40 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 71e33feee..0ec940b97 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -237,6 +237,46 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
 }
 
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+			 struct mana_ib_queue *queue)
+{
+	struct ib_umem *umem;
+	int err;
+
+	queue->umem = NULL;
+	queue->id = INVALID_QUEUE_ID;
+	queue->gdma_region = GDMA_INVALID_DMA_REGION;
+
+	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %d\n", err);
+		return err;
+	}
+
+	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
+		goto free_umem;
+	}
+	queue->umem = umem;
+
+	ibdev_dbg(&mdev->ib_dev,
+		  "create_dma_region ret %d gdma_region 0x%llx\n",
+		  err, queue->gdma_region);
+
+	return 0;
+free_umem:
+	ib_umem_release(umem);
+	return err;
+}
+
+void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue)
+{
+	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);
+	ib_umem_release(queue->umem);
+}
+
 static int
 mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 			    struct gdma_context *gc,
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index f83390eeb..859fd3bfc 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -45,6 +45,12 @@ struct mana_ib_adapter_caps {
 	u32 max_inline_data_size;
 };
 
+struct mana_ib_queue {
+	struct ib_umem *umem;
+	u64 gdma_region;
+	u64 id;
+};
+
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
@@ -169,6 +175,10 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
 
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+			 struct mana_ib_queue *queue);
+void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
+
 struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
-- 
2.43.0


