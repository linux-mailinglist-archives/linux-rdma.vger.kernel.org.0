Return-Path: <linux-rdma+bounces-2101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3A8B380F
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204981C22749
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73C147C6B;
	Fri, 26 Apr 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="adTg/DOW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA0146D62;
	Fri, 26 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137167; cv=none; b=FlXvm3qUtLgCfMpmLSVlnwu21FWa0lfuKpT5UB9nTRnrTNLVCOVDOOWF2TLLCnTH9ZVAhzcAss8stGQmoun1c/tP+Hyx1ekdgkHJnteO9TVK3brJhrRhQ0Vml3J7+i2tLNWFT18bqON+T0r1jEWX4c+AJyqzGachYwJvquAYBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137167; c=relaxed/simple;
	bh=AbVyBbv8hoN9cGSNf2K0NleJvEmeRiwc6JqObMe0nuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D2e7Ahhf3A7Q1KXZLAJBQaTiGNGVETCEcPZBCgoKT+OmszMa5eNOw3LvOcsyMxSLZU06wAv8u7mcus42uZ+lIVD3/k68U+Oy1Yqfmn8xdV5n4mCs7Sht40TD5qb/tUWtHO63HTx/x/g+ijXQQxDbAcc/yDRMUw4LCjQjLJQlhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=adTg/DOW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20B99210EF28;
	Fri, 26 Apr 2024 06:12:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20B99210EF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714137166;
	bh=pQic5QgUwNhMTp2g55PyxrZma9wDByHV+2LR4eUCugQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adTg/DOWCwOJ/6dPvpZyHbkboHgq6qZJP0/earzmMOsiQjhrHyGgyIfZU2Nq8w2C/
	 eOp8+5uBcQGgUAOop0X3X+CYfBwUoFBguLq/lbsrO6DWdzV4HGJyG59XyD6WrwImz2
	 1TbeHqEQTuQ7SnGijOUJbocP2bmlYcYL5mAoVXt4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 3/5] RDMA/mana_ib: introduce a helper to remove cq callbacks
Date: Fri, 26 Apr 2024 06:12:38 -0700
Message-Id: <1714137160-5222-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Intoduce the mana_ib_remove_cq_cb helper to remove cq callbacks.
The helper removes code duplicates.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 19 ++++++++++++-------
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 drivers/infiniband/hw/mana/qp.c      | 26 ++++----------------------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index dc931b9..298e8f1 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -48,16 +48,10 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
-	struct gdma_context *gc;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev_to_gc(mdev);
-
-	if (cq->queue.id != INVALID_QUEUE_ID) {
-		kfree(gc->cq_table[cq->queue.id]);
-		gc->cq_table[cq->queue.id] = NULL;
-	}
 
+	mana_ib_remove_cq_cb(mdev, cq);
 	mana_ib_destroy_queue(mdev, &cq->queue);
 
 	return 0;
@@ -89,3 +83,14 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	gc->cq_table[cq->queue.id] = gdma_cq;
 	return 0;
 }
+
+void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+
+	if (cq->queue.id >= gc->max_num_cqs || cq->queue.id == INVALID_QUEUE_ID)
+		return;
+
+	kfree(gc->cq_table[cq->queue.id]);
+	gc->cq_table[cq->queue.id] = NULL;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9162f29..68c3b4f 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -255,6 +255,7 @@ static inline void copy_in_reverse(u8 *dst, const u8 *src, u32 size)
 }
 
 int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
+void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 					  mana_handle_t *gdma_region);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 280e85a..ba13c5a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -95,11 +95,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
-	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
-	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
 	unsigned int ind_tbl_size;
@@ -173,13 +171,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
-	gdma_cq_allocated = kcalloc(ind_tbl_size, sizeof(*gdma_cq_allocated),
-				    GFP_KERNEL);
-	if (!gdma_cq_allocated) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	qp->port = port;
 
 	for (i = 0; i < ind_tbl_size; i++) {
@@ -229,8 +220,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ret = mana_ib_install_cq_cb(mdev, cq);
 		if (ret)
 			goto fail;
-
-		gdma_cq_allocated[i] = gc->cq_table[cq->queue.id];
 	}
 	resp.num_entries = i;
 
@@ -250,7 +239,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
-	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return 0;
@@ -262,13 +250,10 @@ fail:
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 
-		gc->cq_table[cq->queue.id] = NULL;
-		kfree(gdma_cq_allocated[i]);
-
+		mana_ib_remove_cq_cb(mdev, cq);
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
-	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return ret;
@@ -287,10 +272,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_ib_ucontext *mana_ucontext =
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
-	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_ib_create_qp_resp resp = {};
 	struct mana_ib_create_qp ucmd = {};
-	struct gdma_queue *gdma_cq = NULL;
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
@@ -395,14 +378,13 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed copy udata for create qp-raw, %d\n",
 			  err);
-		goto err_release_gdma_cq;
+		goto err_remove_cq_cb;
 	}
 
 	return 0;
 
-err_release_gdma_cq:
-	kfree(gdma_cq);
-	gc->cq_table[send_cq->queue.id] = NULL;
+err_remove_cq_cb:
+	mana_ib_remove_cq_cb(mdev, send_cq);
 
 err_destroy_wq_obj:
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->qp_handle);
-- 
2.43.0


