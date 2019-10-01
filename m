Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616C5C3940
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfJAPik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46806 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfJAPij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so22117555qtq.13
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRwvhHAb6cW4dr0SmjhZbNWKzHjgG12t0Qxkx60jldw=;
        b=FGP4OZaRY3iuuNJ4438Ei+B7Mq/xt38bLk1Y7MVhNEHPL2oR63sM5EQqd6itoQI0jU
         SjtFLXLJqAuiq2kGZtWeMhKorf6pVk4xXgif1TjaeRUMCNE/od7VZ3v2wd+v7Fg2GxSr
         4QzrYvQsVMDDYKg/zMctBV/tlpu2erB1cle3wiL/Z/9HRD+jZOs4PPLTJ8p5j1Jn8Nb2
         KWyW4VSBVf4MEO8dEkLCKS7n+oqN/k3UErKjg7iFUsQKD75/d6g8iqq5lHUhJ0rJxL1b
         R+Rsu840ZrjTWkomndpBmIOUzlNJSTCB6rOCWMXHuxXmiRdxkn3t9xorrQnfQXDIpt5j
         YezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRwvhHAb6cW4dr0SmjhZbNWKzHjgG12t0Qxkx60jldw=;
        b=c4UB+n1jXmksVdiwKgEBJ3qZPCxwz4sYth31g+hiexY7s3xrCiC5ZdaVnyC0Bw3lGh
         yHn3s3XVO1Nf1uc0YlYQEbnrXH8NNnBR567ym4z4kWPZQth8n3lTAFjh7+lNqRhy1pXY
         7OhTQMG7+Rzx+7n0oH8d6Tmpz7M/kq6949sxT7ITHBqI0JVsuhfnapusLIslbH6px5L/
         Jebs5KgVAgmTNE8v+hKnqz7Ivxwhxb+wuT2Iig4x/Na1+kdUIRrZPfJglnvWd52Bsaay
         //gtK/p++VsyvjWDCwyGuCHqT2zcNQUcwh7uJ/tqKkOHI4Dx3vGKEDUWKaSPpY7wdPmC
         QqIg==
X-Gm-Message-State: APjAAAWUEXqWWidls19/TcFVbVX28+ua1yoOADen9tKlMVaR7E6qfrxT
        nEgTP6Ra3yqamKftokPU7fqXrFoUt2o=
X-Google-Smtp-Source: APXvYqzyFGhbLzik3l5S7ApX+U2D8E5f6lIFQSEvTWpFUh7tXREQMAl71o4kbtddrm26Tir10PKcSw==
X-Received: by 2002:ac8:4148:: with SMTP id e8mr31175582qtm.227.1569944318144;
        Tue, 01 Oct 2019 08:38:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 20sm7942480qkn.4.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006Ev-5b; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 5/6] RDMA/mlx5: Put live in the correct place for ODP MRs
Date:   Tue,  1 Oct 2019 12:38:20 -0300
Message-Id: <20191001153821.23621-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

live is used to signal to the pagefault thread that the MR is initialized
and ready for use. It should be after the umem is assigned and all other
setup is completed. This prevents races (at least) of the form:

    CPU0                                     CPU1
mlx5_ib_alloc_implicit_mr()
 implicit_mr_alloc()
  live = 1
 imr->umem = umem
                                    num_pending_prefetch_inc()
                                      if (live)
				        atomic_inc(num_pending_prefetch)
 atomic_set(num_pending_prefetch,0) // Overwrites other thread's store

Further, live is being used with SRCU as the 'update' in an
acquire/release fashion, so it can not be read and written raw.

Move all live = 1's to after MR initialization is completed and use
smp_store_release/smp_load_acquire() for manipulating it.

Add a missing live = 0 when an implicit MR child is deleted, before
queuing work to do synchronize_srcu().

The barriers in update_odp_mr() were some broken attempt to create a
acquire/release, but were not even applied consistently and missed the
point, delete it as well.

Fixes: 6aec21f6a832 ("IB/mlx5: Page faults handling infrastructure")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 36 ++++------------------------
 drivers/infiniband/hw/mlx5/odp.c     | 14 ++++++-----
 3 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2ceaef3ea3fb92..15e42825cc976e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -606,7 +606,7 @@ struct mlx5_ib_mr {
 	struct mlx5_ib_dev     *dev;
 	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
 	struct mlx5_core_sig_ctx    *sig;
-	int			live;
+	unsigned int		live;
 	void			*descs_alloc;
 	int			access_flags; /* Needed for rereg MR */
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 0ee8fa01177fc9..3a27bddfcf31f5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -84,32 +84,6 @@ static bool use_umr_mtt_update(struct mlx5_ib_mr *mr, u64 start, u64 length)
 		length + (start & (MLX5_ADAPTER_PAGE_SIZE - 1));
 }
 
-static void update_odp_mr(struct mlx5_ib_mr *mr)
-{
-	if (is_odp_mr(mr)) {
-		/*
-		 * This barrier prevents the compiler from moving the
-		 * setting of umem->odp_data->private to point to our
-		 * MR, before reg_umr finished, to ensure that the MR
-		 * initialization have finished before starting to
-		 * handle invalidations.
-		 */
-		smp_wmb();
-		to_ib_umem_odp(mr->umem)->private = mr;
-		/*
-		 * Make sure we will see the new
-		 * umem->odp_data->private value in the invalidation
-		 * routines, before we can get page faults on the
-		 * MR. Page faults can happen once we put the MR in
-		 * the tree, below this line. Without the barrier,
-		 * there can be a fault handling and an invalidation
-		 * before umem->odp_data->private == mr is visible to
-		 * the invalidation handler.
-		 */
-		smp_wmb();
-	}
-}
-
 static void reg_mr_callback(int status, struct mlx5_async_work *context)
 {
 	struct mlx5_ib_mr *mr =
@@ -1346,8 +1320,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->umem = umem;
 	set_mr_fields(dev, mr, npages, length, access_flags);
 
-	update_odp_mr(mr);
-
 	if (use_umr) {
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
 
@@ -1363,10 +1335,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		mr->live = 1;
+	if (is_odp_mr(mr)) {
+		to_ib_umem_odp(mr->umem)->private = mr;
 		atomic_set(&mr->num_pending_prefetch, 0);
 	}
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+		smp_store_release(&mr->live, 1);
 
 	return &mr->ibmr;
 error:
@@ -1607,7 +1581,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		/* Prevent new page faults and
 		 * prefetch requests from succeeding
 		 */
-		mr->live = 0;
+		WRITE_ONCE(mr->live, 0);
 
 		/* Wait for all running page-fault handlers to finish. */
 		synchronize_srcu(&dev->mr_srcu);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1930d78c3091cb..3f9478d1937668 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -231,7 +231,7 @@ static void mr_leaf_free_action(struct work_struct *work)
 	mr->parent = NULL;
 	synchronize_srcu(&mr->dev->mr_srcu);
 
-	if (imr->live) {
+	if (smp_load_acquire(&imr->live)) {
 		srcu_key = srcu_read_lock(&mr->dev->mr_srcu);
 		mutex_lock(&odp_imr->umem_mutex);
 		mlx5_ib_update_xlt(imr, idx, 1, 0,
@@ -318,6 +318,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
+		WRITE_ONCE(mr->live, 0);
 		umem_odp->dying = 1;
 		atomic_inc(&mr->parent->num_leaf_free);
 		schedule_work(&umem_odp->work);
@@ -459,8 +460,6 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
 
-	mr->live = 1;
-
 	mlx5_ib_dbg(dev, "key %x dev %p mr %p\n",
 		    mr->mmkey.key, dev->mdev, mr);
 
@@ -514,6 +513,8 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 		mtt->parent = mr;
 		INIT_WORK(&odp->work, mr_leaf_free_action);
 
+		smp_store_release(&mtt->live, 1);
+
 		if (!nentries)
 			start_idx = addr >> MLX5_IMR_MTT_SHIFT;
 		nentries++;
@@ -566,6 +567,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
+	smp_store_release(&imr->live, 1);
 
 	return imr;
 }
@@ -807,7 +809,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	switch (mmkey->type) {
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
-		if (!mr->live || !mr->ibmr.pd) {
+		if (!smp_load_acquire(&mr->live) || !mr->ibmr.pd) {
 			mlx5_ib_dbg(dev, "got dead MR\n");
 			ret = -EFAULT;
 			goto srcu_unlock;
@@ -1675,12 +1677,12 @@ static bool num_pending_prefetch_inc(struct ib_pd *pd,
 
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-		if (mr->ibmr.pd != pd) {
+		if (!smp_load_acquire(&mr->live)) {
 			ret = false;
 			break;
 		}
 
-		if (!mr->live) {
+		if (mr->ibmr.pd != pd) {
 			ret = false;
 			break;
 		}
-- 
2.23.0

