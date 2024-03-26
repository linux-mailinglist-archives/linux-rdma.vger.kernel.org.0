Return-Path: <linux-rdma+bounces-1582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B888CDDC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 21:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC61F33016
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A213D2A5;
	Tue, 26 Mar 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M39DedJT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD673481A3;
	Tue, 26 Mar 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483706; cv=none; b=isGuW3IiS9VDnF9PchkzwERBTZ8u8QOr0JFgQzD1u0KvfL1fpybJ0n1oqnhu27wnfAwQhy4Az5tjEi3FXrExlVZ1ZtxGBxN3gjkYSM4Az/8l4msPJ1DxAlUXETlcts5Syvc647bgDW57TLVW+2zCAREMcku6pOhDOdAmoVvvbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483706; c=relaxed/simple;
	bh=1RK/yyc++lmdAIbNWO/SBwu6IqyJv1IEHzCHGOlbuGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lRU16vvPDEKl+0nfGUNT/Cj97Wj9o8jh/Nc5CivUUP0EMOShoBYouk/K9PQQz23Fk9VajtZPG7pC28Yp+arcohXlHnvP2uq2MrR50x95cb/9Dx8++lnaUaghLx2hflDhc0VdKVdaqGWXIvlEzfGpoq81gWMOKvjXnI/NWfRUlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M39DedJT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 41FC4208431D;
	Tue, 26 Mar 2024 13:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41FC4208431D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711483698;
	bh=cTbrcz68/r2f5z/FMV0mXG1ZgvDyxRWK/vJfQFxMgYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M39DedJTFhO1m1RzTNEfPg7XhUkp4EpYzU3yQ/waiELokFkKjdA2A3LOLN0jo5oPy
	 vfDzUuGWqomdnq4bHi3QZl2oKJGH5YrHftUhtBvuHh11JP2Lf2B+8Lj4Pzm4KeXHw2
	 JxjD5OfFMAZTntzjzaat5xiSeA+/vkoFkryZtGrk=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 3/4] RDMA/mana_ib: Use struct mana_ib_queue for WQs
Date: Tue, 26 Mar 2024 13:08:07 -0700
Message-Id: <1711483688-24358-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use struct mana_ib_queue and its helpers for WQs

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h |  4 +---
 drivers/infiniband/hw/mana/qp.c      | 10 ++++-----
 drivers/infiniband/hw/mana/wq.c      | 31 ++++------------------------
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6acb5c281..a8953ee80 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -59,11 +59,9 @@ struct mana_ib_dev {
 
 struct mana_ib_wq {
 	struct ib_wq ibwq;
-	struct ib_umem *umem;
+	struct mana_ib_queue queue;
 	int wqe;
 	u32 wq_buf_size;
-	u64 gdma_region;
-	u64 id;
 	mana_handle_t rx_object;
 };
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index d7485ee6a..f606caa75 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -194,7 +194,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibcq = ibwq->cq;
 		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 
-		wq_spec.gdma_region = wq->gdma_region;
+		wq_spec.gdma_region = wq->queue.gdma_region;
 		wq_spec.queue_size = wq->wq_buf_size;
 
 		cq_spec.gdma_region = cq->queue.gdma_region;
@@ -212,18 +212,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		}
 
 		/* The GDMA regions are now owned by the WQ object */
-		wq->gdma_region = GDMA_INVALID_DMA_REGION;
+		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 		cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
-		wq->id = wq_spec.queue_index;
+		wq->queue.id = wq_spec.queue_index;
 		cq->queue.id = cq_spec.queue_index;
 
 		ibdev_dbg(&mdev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
-			  ret, wq->rx_object, wq->id, cq->queue.id);
+			  ret, wq->rx_object, wq->queue.id, cq->queue.id);
 
 		resp.entries[i].cqid = cq->queue.id;
-		resp.entries[i].wqid = wq->id;
+		resp.entries[i].wqid = wq->queue.id;
 
 		mana_ind_table[i] = wq->rx_object;
 
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 7c9c69962..f959f4b92 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -13,7 +13,6 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_create_wq ucmd = {};
 	struct mana_ib_wq *wq;
-	struct ib_umem *umem;
 	int err;
 
 	if (udata->inlen < sizeof(ucmd))
@@ -32,39 +31,18 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 
 	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
 
-	umem = ib_umem_get(pd->device, ucmd.wq_buf_addr, ucmd.wq_buf_size,
-			   IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		err = PTR_ERR(umem);
+	err = mana_ib_create_queue(mdev, ucmd.wq_buf_addr, ucmd.wq_buf_size, &wq->queue);
+	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to get umem for create wq, err %d\n", err);
+			  "Failed to create queue for create wq, %d\n", err);
 		goto err_free_wq;
 	}
 
-	wq->umem = umem;
 	wq->wqe = init_attr->max_wr;
 	wq->wq_buf_size = ucmd.wq_buf_size;
 	wq->rx_object = INVALID_MANA_HANDLE;
-
-	err = mana_ib_create_zero_offset_dma_region(mdev, wq->umem, &wq->gdma_region);
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to create dma region for create wq, %d\n",
-			  err);
-		goto err_release_umem;
-	}
-
-	ibdev_dbg(&mdev->ib_dev,
-		  "create_dma_region ret %d gdma_region 0x%llx\n",
-		  err, wq->gdma_region);
-
-	/* WQ ID is returned at wq_create time, doesn't know the value yet */
-
 	return &wq->ibwq;
 
-err_release_umem:
-	ib_umem_release(umem);
-
 err_free_wq:
 	kfree(wq);
 
@@ -86,8 +64,7 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 
 	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
-	mana_ib_gd_destroy_dma_region(mdev, wq->gdma_region);
-	ib_umem_release(wq->umem);
+	mana_ib_destroy_queue(mdev, &wq->queue);
 
 	kfree(wq);
 
-- 
2.43.0


