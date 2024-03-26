Return-Path: <linux-rdma+bounces-1585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D588CDE2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 21:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8366E1F345CA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420213D534;
	Tue, 26 Mar 2024 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PQU9SYrm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70013D28E;
	Tue, 26 Mar 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483707; cv=none; b=bXIUYDFMF9eiIyImppA8OL/LAMovdQoYCTNXsO00LiQBK2wPZLP0uPwHEAelLYxxeOr/WlywkA5YgP5hfvhlGhqczWPUBYHLcHlcasV6ZAl5tSrw0UQSWbRBC60nRf8WTnR9xTaduKaxPY15qqnrxmShETaUELPHPhzMU6X7pcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483707; c=relaxed/simple;
	bh=Ls4fVshGniv43gxJmhjkRm+O/WtM1xgnlACsdlTOhfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PZXTAbh9ig7xB68BI+mcGreN2MLjnpWKHPPdHkiyEQokY8Jo8L5lmzVac7MVrLwEEQk97JEf8LZReLfSvQIy70fyySCXwHjLHLVk8U/oMR1eREhzhSPGK1OPAaseF8ZdAR7o844RoqCCu+G5n5JBU+G8QOQXUd6W/Wdttm9rYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PQU9SYrm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 598D52084326;
	Tue, 26 Mar 2024 13:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 598D52084326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711483698;
	bh=Rz7NUFddHhxSbuLiwy+f4HlOb8fknUrsOZrygt76PHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQU9SYrmq/PpabyXCTXemRFcgYlVr9m7NRl8NMbSWRMH34aWXm2pVZrzlBqKGXaCB
	 po7DV4DMupjAoZii5CUmFV60AA+DR+sRuHA40ZvOmqcr6e/c6domSEz+J1kk8QNkLb
	 H/EJcn2mOeSDBrsPDCyv6BlIb8y6KM6mvE678WiM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 4/4] RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
Date: Tue, 26 Mar 2024 13:08:08 -0700
Message-Id: <1711483688-24358-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use struct mana_ib_queue and its helpers for RAW QPs

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h |  8 +---
 drivers/infiniband/hw/mana/qp.c      | 56 ++++++++--------------------
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a8953ee80..ceca21cef 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -94,12 +94,8 @@ struct mana_ib_cq {
 struct mana_ib_qp {
 	struct ib_qp ibqp;
 
-	/* Work queue info */
-	struct ib_umem *sq_umem;
-	int sqe;
-	u64 sq_gdma_region;
-	u64 sq_id;
-	mana_handle_t tx_object;
+	mana_handle_t qp_handle;
+	struct mana_ib_queue raw_sq;
 
 	/* The port on the IB device, starting with 1 */
 	u32 port;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f606caa75..ef0a6dc66 100644
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
+	err = mana_ib_create_queue(mdev, ucmd.sq_buf_addr, ucmd.sq_buf_size, &qp->raw_sq);
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
+	wq_spec.gdma_region = qp->raw_sq.gdma_region;
 	wq_spec.queue_size = ucmd.sq_buf_size;
 
 	cq_spec.gdma_region = send_cq->queue.gdma_region;
@@ -382,19 +364,19 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
-				 &cq_spec, &qp->tx_object);
+				 &cq_spec, &qp->qp_handle);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create wq for create raw-qp, err %d\n",
 			  err);
-		goto err_destroy_dma_region;
+		goto err_destroy_queue;
 	}
 
 	/* The GDMA regions are now owned by the WQ object */
-	qp->sq_gdma_region = GDMA_INVALID_DMA_REGION;
+	qp->raw_sq.gdma_region = GDMA_INVALID_DMA_REGION;
 	send_cq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
 
-	qp->sq_id = wq_spec.queue_index;
+	qp->raw_sq.id = wq_spec.queue_index;
 	send_cq->queue.id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
@@ -403,10 +385,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		goto err_destroy_wq_obj;
 
 	ibdev_dbg(&mdev->ib_dev,
-		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-		  qp->tx_object, qp->sq_id, send_cq->queue.id);
+		  "ret %d qp->qp_handle 0x%llx sq id %llu cq id %llu\n", err,
+		  qp->qp_handle, qp->raw_sq.id, send_cq->queue.id);
 
-	resp.sqid = qp->sq_id;
+	resp.sqid = qp->raw_sq.id;
 	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
@@ -425,13 +407,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	gc->cq_table[send_cq->queue.id] = NULL;
 
 err_destroy_wq_obj:
-	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
+	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->qp_handle);
 
-err_destroy_dma_region:
-	mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
-
-err_release_umem:
-	ib_umem_release(umem);
+err_destroy_queue:
+	mana_ib_destroy_queue(mdev, &qp->raw_sq);
 
 err_free_vport:
 	mana_ib_uncfg_vport(mdev, pd, port);
@@ -505,12 +484,9 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	mpc = netdev_priv(ndev);
 	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
-	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
+	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->qp_handle);
 
-	if (qp->sq_umem) {
-		mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
-		ib_umem_release(qp->sq_umem);
-	}
+	mana_ib_destroy_queue(mdev, &qp->raw_sq);
 
 	mana_ib_uncfg_vport(mdev, pd, qp->port);
 
-- 
2.43.0


