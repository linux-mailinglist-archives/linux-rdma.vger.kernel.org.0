Return-Path: <linux-rdma+bounces-1584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D353288CDDE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CF91F3285C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3713D2BA;
	Tue, 26 Mar 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TPGVY9sX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD75313D28F;
	Tue, 26 Mar 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483706; cv=none; b=jWw0mHPX/XGqUEhlFE/b03mqrlbzS7prv+sQXh16yi6GWaMmvftXyaXsIZJ0fryQbWZovqXkhixoh2TFSTSI4P9vULxCPG8MrWEUmOVDSOk+UM5FuUR456NfXzdGoFAon7SO4zGjgHf9dL4IEvEhejh7kl/SvnHs0Y9qVqpjmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483706; c=relaxed/simple;
	bh=O63J8rXJrKUKcByXFD/XHXP8yZiXcSUWUBvDfD7Qmd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xwbe7TcCq+o/q2O0Efp8P5H19wKC5RQKJDu7+g1oAxcEQ9cxGrwf7buh24vmA6W2V5AXMrQowBg0bAEoJ7T/DVQ5eY4xeviQD79dgBPx87LQVxgYFNMtI3Yik1uIc/1PXMXDDsgLrxFIuV3wq4V4NBDWGNJhtH2HMerUzyPAFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TPGVY9sX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29C312083ED0;
	Tue, 26 Mar 2024 13:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29C312083ED0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711483698;
	bh=eRT6IOy3b4cgi900XY5/w0UKVOyZX8xyu2zBPcc26+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPGVY9sXCOg4ND5q9LKqb5hfmfiOTYhhW0joUAvPJJrCckwhkOzG3+Tor3zBV4zGh
	 r+4uAuiRejSg81pGRSvu7T5nR7GlKgUdhKokUkf6LXYeLC1jpl1LhZlrigyOHnWaXO
	 3c41aI5AEu8A5oJizoV5mWvvgYB714Ba+YFZ2w+I=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 2/4] RDMA/mana_ib: Use struct mana_ib_queue for CQs
Date: Tue, 26 Mar 2024 13:08:06 -0700
Message-Id: <1711483688-24358-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use struct mana_ib_queue and its helpers for CQs

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 52 ++++++----------------------
 drivers/infiniband/hw/mana/mana_ib.h |  4 +--
 drivers/infiniband/hw/mana/qp.c      | 26 +++++++-------
 3 files changed, 24 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 4a71e678d..c9129218f 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -39,37 +39,13 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	cq->cqe = attr->cqe;
-	cq->umem = ib_umem_get(ibdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
-			       IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->umem)) {
-		err = PTR_ERR(cq->umem);
-		ibdev_dbg(ibdev, "Failed to get umem for create cq, err %d\n",
-			  err);
-		return err;
-	}
-
-	err = mana_ib_create_zero_offset_dma_region(mdev, cq->umem, &cq->gdma_region);
+	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE, &cq->queue);
 	if (err) {
-		ibdev_dbg(ibdev,
-			  "Failed to create dma region for create cq, %d\n",
-			  err);
-		goto err_release_umem;
+		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
+		return err;
 	}
 
-	ibdev_dbg(ibdev,
-		  "create_dma_region ret %d gdma_region 0x%llx\n",
-		  err, cq->gdma_region);
-
-	/*
-	 * The CQ ID is not known at this time. The ID is generated at create_qp
-	 */
-	cq->id = INVALID_QUEUE_ID;
-
 	return 0;
-
-err_release_umem:
-	ib_umem_release(cq->umem);
-	return err;
 }
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
@@ -78,24 +54,16 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
 	struct gdma_context *gc;
-	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(mdev);
 
-	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
-	if (err) {
-		ibdev_dbg(ibdev,
-			  "Failed to destroy dma region, %d\n", err);
-		return err;
-	}
-
-	if (cq->id != INVALID_QUEUE_ID) {
-		kfree(gc->cq_table[cq->id]);
-		gc->cq_table[cq->id] = NULL;
+	if (cq->queue.id != INVALID_QUEUE_ID) {
+		kfree(gc->cq_table[cq->queue.id]);
+		gc->cq_table[cq->queue.id] = NULL;
 	}
 
-	ib_umem_release(cq->umem);
+	mana_ib_destroy_queue(mdev, &cq->queue);
 
 	return 0;
 }
@@ -114,7 +82,7 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	struct gdma_queue *gdma_cq;
 
 	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[cq->id]);
+	WARN_ON(gc->cq_table[cq->queue.id]);
 	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
 	if (!gdma_cq)
 		return -ENOMEM;
@@ -122,7 +90,7 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	gdma_cq->cq.context = cq;
 	gdma_cq->type = GDMA_CQ;
 	gdma_cq->cq.callback = mana_ib_cq_handler;
-	gdma_cq->id = cq->id;
-	gc->cq_table[cq->id] = gdma_cq;
+	gdma_cq->id = cq->queue.id;
+	gc->cq_table[cq->queue.id] = gdma_cq;
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 859fd3bfc..6acb5c281 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -88,10 +88,8 @@ struct mana_ib_mr {
 
 struct mana_ib_cq {
 	struct ib_cq ibcq;
-	struct ib_umem *umem;
+	struct mana_ib_queue queue;
 	int cqe;
-	u64 gdma_region;
-	u64 id;
 	u32 comp_vector;
 };
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 6e7627745..d7485ee6a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -197,7 +197,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq_spec.gdma_region = wq->gdma_region;
 		wq_spec.queue_size = wq->wq_buf_size;
 
-		cq_spec.gdma_region = cq->gdma_region;
+		cq_spec.gdma_region = cq->queue.gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
 		eq = &mpc->ac->eqs[cq->comp_vector % gc->max_num_queues];
@@ -213,16 +213,16 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->gdma_region = GDMA_INVALID_DMA_REGION;
-		cq->gdma_region = GDMA_INVALID_DMA_REGION;
+		cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
 		wq->id = wq_spec.queue_index;
-		cq->id = cq_spec.queue_index;
+		cq->queue.id = cq_spec.queue_index;
 
 		ibdev_dbg(&mdev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
-			  ret, wq->rx_object, wq->id, cq->id);
+			  ret, wq->rx_object, wq->id, cq->queue.id);
 
-		resp.entries[i].cqid = cq->id;
+		resp.entries[i].cqid = cq->queue.id;
 		resp.entries[i].wqid = wq->id;
 
 		mana_ind_table[i] = wq->rx_object;
@@ -232,7 +232,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		if (ret)
 			goto fail;
 
-		gdma_cq_allocated[i] = gc->cq_table[cq->id];
+		gdma_cq_allocated[i] = gc->cq_table[cq->queue.id];
 	}
 	resp.num_entries = i;
 
@@ -264,7 +264,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 
-		gc->cq_table[cq->id] = NULL;
+		gc->cq_table[cq->queue.id] = NULL;
 		kfree(gdma_cq_allocated[i]);
 
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
@@ -374,7 +374,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	wq_spec.gdma_region = qp->sq_gdma_region;
 	wq_spec.queue_size = ucmd.sq_buf_size;
 
-	cq_spec.gdma_region = send_cq->gdma_region;
+	cq_spec.gdma_region = send_cq->queue.gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
 	eq_vec = send_cq->comp_vector % gc->max_num_queues;
@@ -392,10 +392,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	/* The GDMA regions are now owned by the WQ object */
 	qp->sq_gdma_region = GDMA_INVALID_DMA_REGION;
-	send_cq->gdma_region = GDMA_INVALID_DMA_REGION;
+	send_cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
 	qp->sq_id = wq_spec.queue_index;
-	send_cq->id = cq_spec.queue_index;
+	send_cq->queue.id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
 	err = mana_ib_install_cq_cb(mdev, send_cq);
@@ -404,10 +404,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-		  qp->tx_object, qp->sq_id, send_cq->id);
+		  qp->tx_object, qp->sq_id, send_cq->queue.id);
 
 	resp.sqid = qp->sq_id;
-	resp.cqid = send_cq->id;
+	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
 	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
@@ -422,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 err_release_gdma_cq:
 	kfree(gdma_cq);
-	gc->cq_table[send_cq->id] = NULL;
+	gc->cq_table[send_cq->queue.id] = NULL;
 
 err_destroy_wq_obj:
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
-- 
2.43.0


