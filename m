Return-Path: <linux-rdma+bounces-1485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276E8802DA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F541C224A0
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFE134CB;
	Tue, 19 Mar 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OuasJ1/0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7672231F;
	Tue, 19 Mar 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867627; cv=none; b=o1RkvSv0eEDQIyySXkaEkH4A+DWXmfNDyUzTRV5sa1j+sulUlUq6res3F0HC7Zfcds7qwWH5hoiJr41nUJj8hQx4q+CZuyr4jbLqXqMRPha3ZG5Uxw5GDU8uiiyeFkBnQgcxx+urME38FPL/SAkwmFjOxQwnxrTHA7ovQkhGhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867627; c=relaxed/simple;
	bh=FmzbsTQVkoVAsFEMC+38ieoxv9Kn1qv2d3kI7COHFIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fGn+UB8i6Lom7nwgSTcYbQsvvCPiZe1oABK+I2JGU236sIEvG1AnFzSg2YFx98GAfvz7EjA4OvVXFV2ruG0X5Wa5PDv/2GO1YbJl5eQc6hqBvlMMlKxOsF0k8wOSbDT2dT/CFaYO7xoQbQX473BYE72munV9OIYDdaT97scTKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OuasJ1/0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5472C20B74C1;
	Tue, 19 Mar 2024 10:00:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5472C20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710867625;
	bh=aA2NSqe6Xdgu3VeZvewL+kJBF3nLK/wPPYLng5FrHZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuasJ1/0LQqoBcofZ8uNxAn6zwVFGO/04p4rsyv0FaKYBo+5WyQyxbZtYr1zr0zLO
	 7DiI4gEAjjbhXITLBw+3OKvo7puV0N301TWiiUK/4G3sVx3XkiERMVc27qtjV1oLxh
	 m3xSQ6YShbF/5tx+tF3Uhl605p49t5lQzoG7N9hQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/4] RDMA/mana_ib: Introduce helpers to create and destroy mana queues
Date: Tue, 19 Mar 2024 10:00:10 -0700
Message-Id: <1710867613-4798-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
A queue always consists of umem, gdma_region, and id.
A queue can become a WQ or a CQ.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 71e33feee..4524c6b80 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -237,6 +237,49 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
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
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
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


