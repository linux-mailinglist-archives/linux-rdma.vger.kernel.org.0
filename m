Return-Path: <linux-rdma+bounces-1420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770787A842
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB891C2174B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9146430;
	Wed, 13 Mar 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AjKvenHI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA34085A;
	Wed, 13 Mar 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336313; cv=none; b=jxvhbqGren9Sjf5SX2VaLoJ2e+2qboItPnxiIBxm7/8Tq00481PhtshlHd/kuLxsYCpt74CsoG7jw2q6eVTmaY7NlF3+yCEzzRrbYccLelbhLiEFkrISRxq9E8mzFKP6QrFqyt1tfvRQ02BgeWR3YS98HziCshb2XXb8rSMiGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336313; c=relaxed/simple;
	bh=lmK7TZg799rReSx5AVyNOVU8uiZU0TkZHckxTrY1qvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n7/5kDezplx0U2yxFAymJielUWg8Ijg6uoCmMSzupXlHx5J/HvTlnWVpqcQOIkWRkkuP9Vyu+2KcLNTiLIiW8RUNu/nvmWPr1YnA1ipfPpOjDi81hkeGsbCDeMiveAH/IWL+vXbX0BTouB7XLDtJeUwY6LPaH8VixVFfImBM7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AjKvenHI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D28A120B74C5;
	Wed, 13 Mar 2024 06:25:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D28A120B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710336304;
	bh=Wza9qHz4NQQs9Ib4cia3BrNZX6wdI6esI5+ktRofp40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjKvenHIBBGDqcSoNej8uTUbTm4PIrUqJ80YOejAF0J4f4FGoKtkJ05BK9t+KxwQ5
	 uPCqNatNkJEs46b5EPIGOQ8p7Ly0l3U3IheuaUxIqYaZ9/Hr2LotqI2iPUwSAP6TBn
	 yXqlsWyuilIXkndMbUzdhqVL96lIzK3dqrDno1oI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 4/4] RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
Date: Wed, 13 Mar 2024 06:24:59 -0700
Message-Id: <1710336299-27344-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use struct mana_ib_queue and its helpers for RAW QPs

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h | 13 +++----
 drivers/infiniband/hw/mana/qp.c      | 54 ++++++++--------------------
 2 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a8953ee80..ddb6e73e3 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -91,15 +91,16 @@ struct mana_ib_cq {
 	u32 comp_vector;
 };
 
+struct mana_ib_raw_qp {
+	/* Work queue info */
+	struct mana_ib_queue queue;
+	mana_handle_t tx_object;
+};
+
 struct mana_ib_qp {
 	struct ib_qp ibqp;
 
-	/* Work queue info */
-	struct ib_umem *sq_umem;
-	int sqe;
-	u64 sq_gdma_region;
-	u64 sq_id;
-	mana_handle_t tx_object;
+	struct mana_ib_raw_qp sq;
 
 	/* The port on the IB device, starting with 1 */
 	u32 port;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f606caa75..5818b665e 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -297,7 +297,6 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
-	struct ib_umem *umem;
 	struct mana_eq *eq;
 	int eq_vec;
 	u32 port;
@@ -346,32 +345,15 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	ibdev_dbg(&mdev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
 		  ucmd.sq_buf_addr, ucmd.port);
 
-	umem = ib_umem_get(ibpd->device, ucmd.sq_buf_addr, ucmd.sq_buf_size,
-			   IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		err = PTR_ERR(umem);
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to get umem for create qp-raw, err %d\n",
-			  err);
-		goto err_free_vport;
-	}
-	qp->sq_umem = umem;
-
-	err = mana_ib_create_zero_offset_dma_region(mdev, qp->sq_umem,
-						    &qp->sq_gdma_region);
+	err = mana_ib_create_queue(mdev, ucmd.sq_buf_addr, ucmd.sq_buf_size, &qp->sq.queue);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to create dma region for create qp-raw, %d\n",
-			  err);
-		goto err_release_umem;
+			  "Failed to create queue for create qp-raw, err %d\n", err);
+		goto err_free_vport;
 	}
 
-	ibdev_dbg(&mdev->ib_dev,
-		  "create_dma_region ret %d gdma_region 0x%llx\n",
-		  err, qp->sq_gdma_region);
-
 	/* Create a WQ on the same port handle used by the Ethernet */
-	wq_spec.gdma_region = qp->sq_gdma_region;
+	wq_spec.gdma_region = qp->sq.queue.gdma_region;
 	wq_spec.queue_size = ucmd.sq_buf_size;
 
 	cq_spec.gdma_region = send_cq->queue.gdma_region;
@@ -382,19 +364,19 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
-				 &cq_spec, &qp->tx_object);
+				 &cq_spec, &qp->sq.tx_object);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create wq for create raw-qp, err %d\n",
 			  err);
-		goto err_destroy_dma_region;
+		goto err_destroy_queue;
 	}
 
 	/* The GDMA regions are now owned by the WQ object */
-	qp->sq_gdma_region = GDMA_INVALID_DMA_REGION;
+	qp->sq.queue.gdma_region = GDMA_INVALID_DMA_REGION;
 	send_cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
-	qp->sq_id = wq_spec.queue_index;
+	qp->sq.queue.id = wq_spec.queue_index;
 	send_cq->queue.id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
@@ -404,9 +386,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-		  qp->tx_object, qp->sq_id, send_cq->queue.id);
+		  qp->sq.tx_object, qp->sq.queue.id, send_cq->queue.id);
 
-	resp.sqid = qp->sq_id;
+	resp.sqid = qp->sq.queue.id;
 	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
@@ -425,13 +407,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	gc->cq_table[send_cq->queue.id] = NULL;
 
 err_destroy_wq_obj:
-	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
+	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->sq.tx_object);
 
-err_destroy_dma_region:
-	mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
-
-err_release_umem:
-	ib_umem_release(umem);
+err_destroy_queue:
+	mana_ib_destroy_queue(mdev, &qp->sq.queue);
 
 err_free_vport:
 	mana_ib_uncfg_vport(mdev, pd, port);
@@ -505,12 +484,9 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	mpc = netdev_priv(ndev);
 	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
-	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
+	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->sq.tx_object);
 
-	if (qp->sq_umem) {
-		mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
-		ib_umem_release(qp->sq_umem);
-	}
+	mana_ib_destroy_queue(mdev, &qp->sq.queue);
 
 	mana_ib_uncfg_vport(mdev, pd, qp->port);
 
-- 
2.43.0


