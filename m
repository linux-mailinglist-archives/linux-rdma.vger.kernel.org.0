Return-Path: <linux-rdma+bounces-1487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F28802DD
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DA02850EA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC08179A6;
	Tue, 19 Mar 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ScJnI+e9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E322325;
	Tue, 19 Mar 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867627; cv=none; b=VXUwt+2pNkp8TW5WXfAnk6ZgEJgFHtJfJZZ82C5NbHYvqpIfg2LlImzBxRV0SmuAD7QUCRzZKHOZwRCoOMzX0u7vy99AFsxDvgNvKABGgkqAEXPSiJdYjILf/M7h5TgHZXIZvwrHQbDThn5u2KYigVJf7JmguyVkhFx/pXad0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867627; c=relaxed/simple;
	bh=VYWbTKvwiXxX5MoDZMS5LsE+7Y09WRO1EMZa66vY0S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ByITyodrx8pQwQ7awfYdLK2F+eYp+nMqj59ET5iUJcyGBbozfBEX77N8UWiTK5Yely3C+oE0LJ1l4bYY+7ybP5RaTgbiGk0fELnMDU6H6WTHkxu80g6ZE4COYst/g5MvFCx1YZ3gQtv2mxlHGkmHPor0d1vnCK0LhbH2iZ29YUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ScJnI+e9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8479F20B74C3;
	Tue, 19 Mar 2024 10:00:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8479F20B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710867625;
	bh=ufX/U1zNv09Ri+oL2azvLywYnvh8PET/KeZx2M1KecA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScJnI+e9AxKQQNkLjqlO2M58+kbyQdF1aNVzw+qlfwsgOk5K5UY2ROXvFL0Zo69aP
	 uQfCy7jpvDfIdlwrmw6Ex5n6FM5hQiM/kn8cg3wKfE6/QCd2OQdm+HQLAoz2XVg3QB
	 rXZewXt/1Rhp2JwjLQgLPw+TiSchUZkWWtYfRdbM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 3/4] RDMA/mana_ib: Use struct mana_ib_queue for WQs
Date: Tue, 19 Mar 2024 10:00:12 -0700
Message-Id: <1710867613-4798-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use struct mana_ib_queue and its helpers for WQs

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
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


