Return-Path: <linux-rdma+bounces-699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0C8377AE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 00:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A281F24F19
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 23:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4214D111;
	Mon, 22 Jan 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kxWpsLhs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF04CE10;
	Mon, 22 Jan 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965792; cv=none; b=f4JKg9ag0QaIKjXje3XJdoTSKZ6AdQSch2r7JOMN2h/5R5LofGJBSyonV2sI1eQ+5zZ//BhqmtoEAps4FtdA0o3bAaqJNH2UXBWViIx233zy/dHZ857DLUNwcNFalXI3eUIbzEgnmHFAGY2B0ob/iEAEepFlZf6C8GNaCdVYAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965792; c=relaxed/simple;
	bh=L88DAoiSBHD76fYpHeFcca7Y2t8+GzrNgBX+SAW6wuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eIEzFsOkGftRlgJDqlfpSJn6pwrWunElmigQkQ6UhvORYUXzeTqml7eqHeUQqwWTNj7yHoCjt0QHfRWf+lD9fm9xcreXp+L0yOOL4wMet7clnGCza/PmF1JfQBvQ5I4WExhA4/ulm1VoIQqUj1zs8s4vyt1e316NgGtFIwdZDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kxWpsLhs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBBF520E2C32;
	Mon, 22 Jan 2024 15:23:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBBF520E2C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705965790;
	bh=ydnT8gvdi2bZa/bNOPVGXK22E60tOprDMH+lbzR3qq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxWpsLhsUJjqXLIoISQt0Clo/JrVGKqLeYJqwOKpEgq4GTjt+7F7IsIrRZzkb0hy4
	 OIa+LVNXoD5vaNl8FG67WoWvzGHOFMpxJnnhmhGEk/9jPeJ+X2Gaa9655Xdj7+afbT
	 h8PIIIdnU6xQmcOi2J7RHhh4qM4T8LUXrlpNxWoo=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 3/3] RDMA/mana_ib: introduce mana_ib_install_cq_cb helper function
Date: Mon, 22 Jan 2024 15:23:01 -0800
Message-Id: <1705965781-3235-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use a helper function to install callbacks to CQs.
This patch removes code repetition.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 21 ++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++--
 drivers/infiniband/hw/mana/qp.c      | 28 +++++-----------------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 3369e7b665f9..83d20c3f048d 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -100,10 +100,29 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	return 0;
 }
 
-void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
+static void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
 {
 	struct mana_ib_cq *cq = ctx;
 
 	if (cq->ibcq.comp_handler)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
+
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_queue *gdma_cq;
+
+	/* Create CQ table entry */
+	WARN_ON(gc->cq_table[cq->id]);
+	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (!gdma_cq)
+		return -ENOMEM;
+
+	gdma_cq->cq.context = cq;
+	gdma_cq->type = GDMA_CQ;
+	gdma_cq->cq.callback = mana_ib_cq_handler;
+	gdma_cq->id = cq->id;
+	gc->cq_table[cq->id] = gdma_cq;
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index d373639e25d4..6a03ae645c01 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -158,6 +158,8 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
 	return mc->ports[port - 1];
 }
 
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -226,6 +228,4 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
-
-void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f5427599e033..5d4c05dcd003 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -104,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
-	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
@@ -229,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		mana_ind_table[i] = wq->rx_object;
 
 		/* Create CQ table entry */
-		WARN_ON(gc->cq_table[cq->id]);
-		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-		if (!gdma_cq) {
-			ret = -ENOMEM;
+		ret = mana_ib_install_cq_cb(mdev, cq);
+		if (ret)
 			goto fail;
-		}
-		gdma_cq_allocated[i] = gdma_cq;
 
-		gdma_cq->cq.context = cq;
-		gdma_cq->type = GDMA_CQ;
-		gdma_cq->cq.callback = mana_ib_cq_handler;
-		gdma_cq->id = cq->id;
-		gc->cq_table[cq->id] = gdma_cq;
+		gdma_cq_allocated[i] = gc->cq_table[cq->id];
 	}
 	resp.num_entries = i;
 
@@ -407,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	send_cq->id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[send_cq->id]);
-	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-	if (!gdma_cq) {
-		err = -ENOMEM;
+	err = mana_ib_install_cq_cb(mdev, send_cq);
+	if (err)
 		goto err_destroy_wq_obj;
-	}
-
-	gdma_cq->cq.context = send_cq;
-	gdma_cq->type = GDMA_CQ;
-	gdma_cq->cq.callback = mana_ib_cq_handler;
-	gdma_cq->id = send_cq->id;
-	gc->cq_table[send_cq->id] = gdma_cq;
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
-- 
2.43.0


