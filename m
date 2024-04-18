Return-Path: <linux-rdma+bounces-1978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2D8AA061
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02621F21992
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2D4171E7C;
	Thu, 18 Apr 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZD085CwF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C87171653;
	Thu, 18 Apr 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459133; cv=none; b=T4cWROiVqYRafvAM3LhQHqIz10r5/KossauZYTX7wDLuxQnR0hFx+iDU7R/U1RtWxGygvPQDZi+rfZHscnGaACWGSxF6Wa747QWPWBhtN9Y3MFeu0A+yWXaUlCZCxAyJZGXx2L8qiV3jeRwaVEVpEOee1JmFr8WjYdzrhpXFmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459133; c=relaxed/simple;
	bh=AYlUEqB21YfxQ2P7BzSsTllrC2taqWdyUY1X+23xLk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fKLBSBtLyjZY6TC9VDArBse01AEqzHw9eu6BrT2arA6Q4TyW45JMcthKnZPOnKnvte86z8gL7g7ATiHNDJOD7sHafvqdtbEI9q4wTuYAnDW183w63DfvMXKoHdG9B8wmpbdct17sGCIO8wjmJF7+yoEvKC17y9orJAU53FQIf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZD085CwF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7232820FD8E1;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7232820FD8E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=re9gWjtsan98p476rpHxm6H6zqpS2UjxW7+iOlaeMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZD085CwFL300tTyoe/3E3gJPuoboJwWh6xDJPiRNlboDpmGAnl48HXfol2ph1uwx1
	 AL64AYHDwXRvAJPajihOt4Gpeu51y81GwgjSd3yVr4D9z0OFyc6MBq9pUxfxoQZ/F5
	 ph5ydbne2ufrxannuwi1luMthld/jH4Pr/og5Kgw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove cq callbacks
Date: Thu, 18 Apr 2024 09:52:03 -0700
Message-Id: <1713459125-14914-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Intoduce the mana_ib_remove_cq_cb helper to remove cq callbacks.
The helper removes code duplicates.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 19 ++++++++++++-------
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 drivers/infiniband/hw/mana/qp.c      | 26 ++++----------------------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 0467ee8..6c3bb8c 100644
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
+	if (cq->queue.id >= gc->max_num_cqs)
+		return;
+
+	kfree(gc->cq_table[cq->queue.id]);
+	gc->cq_table[cq->queue.id] = NULL;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9c07021..6c19f4f 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -255,6 +255,7 @@ static inline void copy_in_reverse(u8 *dst, const u8 *src, u32 size)
 }
 
 int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
+void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 					  mana_handle_t *gdma_region);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index c4fb8b4..169b286 100644
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


