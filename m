Return-Path: <linux-rdma+bounces-1128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9287866A9F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 08:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F81F234B8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7C1BF2F;
	Mon, 26 Feb 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KdwRpf8/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA21BDDB;
	Mon, 26 Feb 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932358; cv=none; b=Cn0Wy1Xp+skPAk1UZtFL3OOwR1lfEbWpVTv2289SJ5GYG5FcfOi82kRzpP6Esqe3RhF2b2iTjiVWAu6YT4UsQ7U7z8yxDUGXwBItmRAQv8OJqCZDZVjAVa2h7qmuoI+2wlcrij81wMsKFGQDP+VUiL5VLjqFtw8RiFc0Y+SDB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932358; c=relaxed/simple;
	bh=GGEnxrpo2d0MQFl25VtsNEgV879Pc6v/0uecZ8u25Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j3j+uYctfz5XUceyNOAiexqAeP3mo4TezEZ5p7BTquQAw/d6hTFrMDTFgQRaG6wqXKpjoD0ouFsCIeL1y+JH3uIbI+p6pE3lKbhEZTS+9VPLmlxkU1muFSyQN/OV8C7dnBqkOoGbryr8hVqrnw9eMM4wPHf5lSPC/di8zmNcs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KdwRpf8/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6288520B74C2;
	Sun, 25 Feb 2024 23:25:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6288520B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708932351;
	bh=oPipnw0VjqWylXbda37uGrUDQhVYcB3DiLcxY2Nb22Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdwRpf8/i6+FxVD+4CvocIypPFSkGX4qG+ft4Rv6bhpHZNwO9SzKPNz/YW141XnJQ
	 g/G51ePrljLOL43u7I6s85aboRP6tQvbpvKjstAazGtW9nB5Ro3MX8EAVwzln3cSIm
	 jA5xQahjqt113zPOPzQR2Fd7lSc+cyqhssunw+7o=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 2/2] RDMA/mana_ib: Use virtual address in dma regions for MRs
Date: Sun, 25 Feb 2024 23:25:39 -0800
Message-Id: <1708932339-27914-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Introduce mana_ib_create_dma_region() to create dma regions with iova
for MRs.

For dma regions that must have a zero dma offset (e.g., for queues),
mana_ib_create_zero_offset_dma_region() is added.
To get the zero offset, ib_umem_find_best_pgoff() is used with zero
pgoff_bitmask.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  4 +--
 drivers/infiniband/hw/mana/main.c    | 40 +++++++++++++++++++++-------
 drivers/infiniband/hw/mana/mana_ib.h |  7 +++--
 drivers/infiniband/hw/mana/mr.c      |  4 +--
 drivers/infiniband/hw/mana/qp.c      |  6 ++---
 drivers/infiniband/hw/mana/wq.c      |  4 +--
 6 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 83d20c3f0..4a71e678d 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -48,7 +48,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	err = mana_ib_gd_create_dma_region(mdev, cq->umem, &cq->gdma_region);
+	err = mana_ib_create_zero_offset_dma_region(mdev, cq->umem, &cq->gdma_region);
 	if (err) {
 		ibdev_dbg(ibdev,
 			  "Failed to create dma region for create cq, %d\n",
@@ -57,7 +57,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	ibdev_dbg(ibdev,
-		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
+		  "create_dma_region ret %d gdma_region 0x%llx\n",
 		  err, cq->gdma_region);
 
 	/*
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index dd570832d..30b874938 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -301,8 +301,8 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
 	return 0;
 }
 
-int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
-				 mana_handle_t *gdma_region)
+static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+					mana_handle_t *gdma_region, unsigned long page_sz)
 {
 	struct gdma_dma_region_add_pages_req *add_req = NULL;
 	size_t num_pages_processed = 0, num_pages_to_handle;
@@ -314,7 +314,6 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	size_t max_pgs_create_cmd;
 	struct gdma_context *gc;
 	size_t num_pages_total;
-	unsigned long page_sz;
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
@@ -323,12 +322,6 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	gc = mdev_to_gc(dev);
 	hwc = gc->hwc.driver_data;
 
-	/* Hardware requires dma region to align to chosen page size */
-	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
-	if (!page_sz) {
-		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
-		return -ENOMEM;
-	}
 	num_pages_total = ib_umem_num_dma_blocks(umem, page_sz);
 
 	max_pgs_create_cmd =
@@ -414,6 +407,35 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	return err;
 }
 
+int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+			      mana_handle_t *gdma_region, u64 virt)
+{
+	unsigned long page_sz;
+
+	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
+	if (!page_sz) {
+		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
+		return -EINVAL;
+	}
+
+	return mana_ib_gd_create_dma_region(dev, umem, gdma_region, page_sz);
+}
+
+int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+					  mana_handle_t *gdma_region)
+{
+	unsigned long page_sz;
+
+	/* Hardware requires dma region to align to chosen page size */
+	page_sz = ib_umem_find_best_pgoff(umem, PAGE_SZ_BM, 0);
+	if (!page_sz) {
+		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
+		return -ENOMEM;
+	}
+
+	return mana_ib_gd_create_dma_region(dev, umem, gdma_region, page_sz);
+}
+
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_region)
 {
 	struct gdma_context *gc = mdev_to_gc(dev);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6a03ae645..f83390eeb 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -160,8 +160,11 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
 
 int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
-int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
-				 mana_handle_t *gdma_region);
+int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+					  mana_handle_t *gdma_region);
+
+int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+			      mana_handle_t *gdma_region, u64 virt);
 
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index ee4d4f834..b70b13484 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -127,7 +127,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_free;
 	}
 
-	err = mana_ib_gd_create_dma_region(dev, mr->umem, &dma_region_handle);
+	err = mana_ib_create_dma_region(dev, mr->umem, &dma_region_handle, iova);
 	if (err) {
 		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
 			  err);
@@ -135,7 +135,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	}
 
 	ibdev_dbg(ibdev,
-		  "mana_ib_gd_create_dma_region ret %d gdma_region %llx\n", err,
+		  "create_dma_region ret %d gdma_region %llx\n", err,
 		  dma_region_handle);
 
 	mr_params.pd_handle = pd->pd_handle;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 5d4c05dcd..6e7627745 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -357,8 +357,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	}
 	qp->sq_umem = umem;
 
-	err = mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
-					   &qp->sq_gdma_region);
+	err = mana_ib_create_zero_offset_dma_region(mdev, qp->sq_umem,
+						    &qp->sq_gdma_region);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create dma region for create qp-raw, %d\n",
@@ -367,7 +367,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	}
 
 	ibdev_dbg(&mdev->ib_dev,
-		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
+		  "create_dma_region ret %d gdma_region 0x%llx\n",
 		  err, qp->sq_gdma_region);
 
 	/* Create a WQ on the same port handle used by the Ethernet */
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 372d36151..7c9c69962 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -46,7 +46,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	wq->wq_buf_size = ucmd.wq_buf_size;
 	wq->rx_object = INVALID_MANA_HANDLE;
 
-	err = mana_ib_gd_create_dma_region(mdev, wq->umem, &wq->gdma_region);
+	err = mana_ib_create_zero_offset_dma_region(mdev, wq->umem, &wq->gdma_region);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create dma region for create wq, %d\n",
@@ -55,7 +55,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	}
 
 	ibdev_dbg(&mdev->ib_dev,
-		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
+		  "create_dma_region ret %d gdma_region 0x%llx\n",
 		  err, wq->gdma_region);
 
 	/* WQ ID is returned at wq_create time, doesn't know the value yet */
-- 
2.43.0


