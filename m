Return-Path: <linux-rdma+bounces-1833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80489BB58
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6891F22B3B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165C4438F;
	Mon,  8 Apr 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TczOjsxA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD95446D4;
	Mon,  8 Apr 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567662; cv=none; b=dNfaPHWquxpV7xsuO0VtRqw+uyzlABGJVXJmJtH8r+YFhpAGkSvpgAoHbYY9LRWgDsyxWEiJM0Cz+9QOIwjf+H+CH2s7I+5CXQmbOu8HvcMTimr+wbAaMrSSEJS06Hr7NGpdeWaLksSRTf+nljSs0mVNOyUOFIPA4Yg60DG3RH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567662; c=relaxed/simple;
	bh=YR0pb5Ek6I2hOGMUWo7tSi8qZRs3zK0xOKgRp6FLJTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FW/uMQq/nu9GZ+2E3spBFYYODjzJeG/ypf8d/aa5Rw6Ai1KObrDWE3LfrAZKHLMO+v0W6i+hxqLU/MYYV6gM/GH2vG+mhAPxT0yknSwXJ49wJUPKmKqO1v5JZWeuJLkSsunHKr0TLObkIpoU0ksqSi7nqRHdFsTFHJm9LanhOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TczOjsxA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C401220EA435;
	Mon,  8 Apr 2024 02:14:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C401220EA435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712567655;
	bh=TvaOedGzJmjU19tWzL5TIVuYAnZd3qA4bae8zyqpsq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TczOjsxANA0dgw9ExKM5KvL+I+/oW2TNpj/OLwtWKgHUO5zUEUq6gaAuXE49Bg1kf
	 8dewO6/QU+gMdsht760Lz+CpVf8zKAcw2CnqDkJd0c/3ZZsz1a/lRacDLS5hBhoodx
	 teqXDLzx7xwbjMJFt9MdJ94zZGJnerDwgNX4icZw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v4 3/4] RDMA/mana_ib: Use struct mana_ib_queue for WQs
Date: Mon,  8 Apr 2024 02:14:05 -0700
Message-Id: <1712567646-5247-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
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
 drivers/infiniband/hw/mana/qp.c      |  8 +++----
 drivers/infiniband/hw/mana/wq.c      | 33 ++++------------------------
 3 files changed, 9 insertions(+), 36 deletions(-)

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
index adf613b82..8eccd0e6f 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -194,7 +194,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibcq = ibwq->cq;
 		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 
-		wq_spec.gdma_region = wq->gdma_region;
+		wq_spec.gdma_region = wq->queue.gdma_region;
 		wq_spec.queue_size = wq->wq_buf_size;
 
 		cq_spec.gdma_region = cq->queue.gdma_region;
@@ -212,14 +212,14 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		}
 
 		/* The GDMA regions are now owned by the WQ object */
-		wq->gdma_region = GDMA_INVALID_DMA_REGION;
+		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 		cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
-		wq->id = wq_spec.queue_index;
+		wq->queue.id = wq_spec.queue_index;
 		cq->queue.id = cq_spec.queue_index;
 
 		resp.entries[i].cqid = cq->queue.id;
-		resp.entries[i].wqid = wq->id;
+		resp.entries[i].wqid = wq->queue.id;
 
 		mana_ind_table[i] = wq->rx_object;
 
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 7c9c69962..524261904 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -13,7 +13,6 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_create_wq ucmd = {};
 	struct mana_ib_wq *wq;
-	struct ib_umem *umem;
 	int err;
 
 	if (udata->inlen < sizeof(ucmd))
@@ -30,41 +29,18 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
-	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
-
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
 
@@ -86,8 +62,7 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 
 	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
-	mana_ib_gd_destroy_dma_region(mdev, wq->gdma_region);
-	ib_umem_release(wq->umem);
+	mana_ib_destroy_queue(mdev, &wq->queue);
 
 	kfree(wq);
 
-- 
2.43.0


