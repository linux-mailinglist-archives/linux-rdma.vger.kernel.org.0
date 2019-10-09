Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86D7D13B2
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfJIQKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44257 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbfJIQKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so2682535qkk.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtY/yrmPgUa9fklGcJ8k1pOfZgBz5mA0yfw5UPyx2x0=;
        b=nR9WwpprfjjfsXPE5XM8SJJrtDeKyR4Vjx1YiKdAX/8zrPRbF19ebdHcDCU348Eso5
         HT2n+kFEHp3iIOlmUhThgEmVam2D81gD99pOWoQfHU0h42TGbYREqjDI2kO+s0upvS5u
         W+yNXTD0ylCCVRRHHpEpwEntqT6XOdm0FgDtSB3B9CFwukYM5mALOFmKv8xDTjneDSj4
         YeL57Pyu9B0owPPB3XJoWwZ0WULQGQIS862aSV6hO9NHFcQDhRnLCWnvSpkS9nzlEoR9
         bBalkbbUlwTHuihHJkHw13dNtKycT1JrBEQbZhAkXxuw9l7AyryO1YTeknIUgATF7mgr
         BF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BtY/yrmPgUa9fklGcJ8k1pOfZgBz5mA0yfw5UPyx2x0=;
        b=TC3o4t/Vg2up6qmcyaKxsA0/8YF0bYaDcqLuu03gz3CNOQnO+oDlL8Emtj/dXMALf1
         BaXNlYztafmfMSamx1UzMvZzbs6KDwgQibjzpkiy33SxEYGPuuIt211vn0NLc7qtHTaF
         ztgGXbhcpHpshU7HHv7+HO9FavED8Qmb1fHusjGRx3sl84M7bU9fZOs27B5sBOcVCn0+
         rHJAA+OQXnULZO2k09QBrHON0pf6J+hCwZe5nAPcHzNg/r7PfnWEi9wCLQrortKUCya+
         1lWs69oOAQUIVy7QePi8aCIfJpivLNwxHcBkuvGoUyUpPZFwwepHUstk4XoQlBZd07hD
         EGNA==
X-Gm-Message-State: APjAAAU2zsKHQe2/oqcNfuEe0RsOEUm1sUaSifgECuCfeSmhKq77hbHE
        wtfGm6P+swdW9iD4/xRNaZlwV8e33fw=
X-Google-Smtp-Source: APXvYqzpNqdkDQFQfbMncf3PnqjoE9RFq2THXemYBhSrKC/MT75V68I11WDowUJlXX9UVDrUquMyhA==
X-Received: by 2002:a37:6347:: with SMTP id x68mr4287558qkb.380.1570637406785;
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g31sm1508530qte.78.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qU-Pr; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 03/15] RDMA/mlx5: Use a dedicated mkey xarray for ODP
Date:   Wed,  9 Oct 2019 13:09:23 -0300
Message-Id: <20191009160934.3143-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

There is a per device xarray storing mkeys that is used to store every
mkey in the system. However, this xarray is now only read by ODP for
certain ODP designated MRs (ODP, implicit ODP, MW, DEVX_INDIRECT).

Create an xarray only for use by ODP, that only contains ODP related
MKeys. This xarray is protected by SRCU and all erases are protected by a
synchronize.

This improves performance:

 - All MRs in the odp_mkeys xarray are ODP MRs, so some tests for is_odp()
   can be deleted. The xarray will also consume fewer nodes.

 - normal MR's are never mixed with ODP MRs in a SRCU data structure so
   performance sucking synchronize_srcu() on every MR destruction is not
   needed.

 - No smp_load_acquire(live) and xa_load() double barrier on read

Due to the SRCU locking scheme care must be taken with the placement of
the xa_store(). Once it completes the MR is immediately visible to other
threads and only through a xa_erase() & synchronize_srcu() cycle could it
be destroyed.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c    |  8 +--
 drivers/infiniband/hw/mlx5/main.c    | 17 +++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  5 +-
 drivers/infiniband/hw/mlx5/mr.c      | 43 +++++++-------
 drivers/infiniband/hw/mlx5/odp.c     | 83 +++++++++++++++-------------
 5 files changed, 83 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index d609f4659afb7a..6b1fca91d7d3d1 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1265,8 +1265,8 @@ static int devx_handle_mkey_indirect(struct devx_obj *obj,
 	mkey->pd = MLX5_GET(mkc, mkc, pd);
 	devx_mr->ndescs = MLX5_GET(mkc, mkc, translations_octword_size);
 
-	return xa_err(xa_store(&dev->mdev->priv.mkey_table,
-			       mlx5_base_mkey(mkey->key), mkey, GFP_KERNEL));
+	return xa_err(xa_store(&dev->odp_mkeys, mlx5_base_mkey(mkey->key), mkey,
+			       GFP_KERNEL));
 }
 
 static int devx_handle_mkey_create(struct mlx5_ib_dev *dev,
@@ -1345,9 +1345,9 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
 		 * the mmkey, we must wait for that to stop before freeing the
 		 * mkey, as another allocation could get the same mkey #.
 		 */
-		xa_erase(&obj->ib_dev->mdev->priv.mkey_table,
+		xa_erase(&obj->ib_dev->odp_mkeys,
 			 mlx5_base_mkey(obj->devx_mr.mmkey.key));
-		synchronize_srcu(&dev->mr_srcu);
+		synchronize_srcu(&dev->odp_srcu);
 	}
 
 	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b7eea724beaab7..4692c37b057cee 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6145,10 +6145,10 @@ static struct ib_counters *mlx5_ib_create_counters(struct ib_device *device,
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
 	mlx5_ib_cleanup_multiport_master(dev);
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		srcu_barrier(&dev->mr_srcu);
-		cleanup_srcu_struct(&dev->mr_srcu);
-	}
+	WARN_ON(!xa_empty(&dev->odp_mkeys));
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+		srcu_barrier(&dev->odp_srcu);
+	cleanup_srcu_struct(&dev->odp_srcu);
 
 	WARN_ON(!xa_empty(&dev->sig_mrs));
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
@@ -6202,16 +6202,15 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->cap_mask_mutex);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
+	xa_init(&dev->odp_mkeys);
 	xa_init(&dev->sig_mrs);
 
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
 
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		err = init_srcu_struct(&dev->mr_srcu);
-		if (err)
-			goto err_mp;
-	}
+	err = init_srcu_struct(&dev->odp_srcu);
+	if (err)
+		goto err_mp;
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f4ce58354544ad..2cf91db6a36f5f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -606,7 +606,6 @@ struct mlx5_ib_mr {
 	struct mlx5_ib_dev     *dev;
 	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
 	struct mlx5_core_sig_ctx    *sig;
-	unsigned int		live;
 	void			*descs_alloc;
 	int			access_flags; /* Needed for rereg MR */
 
@@ -975,7 +974,9 @@ struct mlx5_ib_dev {
 	 * Sleepable RCU that prevents destruction of MRs while they are still
 	 * being used by a page fault handler.
 	 */
-	struct srcu_struct      mr_srcu;
+	struct srcu_struct      odp_srcu;
+	struct xarray		odp_mkeys;
+
 	u32			null_mkey;
 	struct mlx5_ib_flow_db	*flow_db;
 	/* protect resources needed as part of reset flow */
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index fd24640606c120..60b12dc530049c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -59,13 +59,9 @@ static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
 
 static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	int err = mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
+	WARN_ON(xa_load(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key)));
 
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
-		/* Wait until all page fault handlers using the mr complete. */
-		synchronize_srcu(&dev->mr_srcu);
-
-	return err;
+	return mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 }
 
 static int order2idx(struct mlx5_ib_dev *dev, int order)
@@ -218,9 +214,6 @@ static void remove_keys(struct mlx5_ib_dev *dev, int c, int num)
 		mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 	}
 
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
-		synchronize_srcu(&dev->mr_srcu);
-
 	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
 		list_del(&mr->list);
 		kfree(mr);
@@ -555,10 +548,6 @@ static void clean_keys(struct mlx5_ib_dev *dev, int c)
 		mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 	}
 
-#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
-	synchronize_srcu(&dev->mr_srcu);
-#endif
-
 	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
 		list_del(&mr->list);
 		kfree(mr);
@@ -1338,9 +1327,14 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (is_odp_mr(mr)) {
 		to_ib_umem_odp(mr->umem)->private = mr;
 		atomic_set(&mr->num_pending_prefetch, 0);
+		err = xa_err(xa_store(&dev->odp_mkeys,
+				      mlx5_base_mkey(mr->mmkey.key), &mr->mmkey,
+				      GFP_KERNEL));
+		if (err) {
+			dereg_mr(dev, mr);
+			return ERR_PTR(err);
+		}
 	}
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
-		smp_store_release(&mr->live, 1);
 
 	return &mr->ibmr;
 error:
@@ -1582,10 +1576,10 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		/* Prevent new page faults and
 		 * prefetch requests from succeeding
 		 */
-		WRITE_ONCE(mr->live, 0);
+		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 
 		/* Wait for all running page-fault handlers to finish. */
-		synchronize_srcu(&dev->mr_srcu);
+		synchronize_srcu(&dev->odp_srcu);
 
 		/* dequeue pending prefetch requests for the mr */
 		if (atomic_read(&mr->num_pending_prefetch))
@@ -1959,9 +1953,19 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
+		err = xa_err(xa_store(&dev->odp_mkeys,
+				      mlx5_base_mkey(mw->mmkey.key), &mw->mmkey,
+				      GFP_KERNEL));
+		if (err)
+			goto free_mkey;
+	}
+
 	kfree(in);
 	return &mw->ibmw;
 
+free_mkey:
+	mlx5_core_destroy_mkey(dev->mdev, &mw->mmkey);
 free:
 	kfree(mw);
 	kfree(in);
@@ -1975,13 +1979,12 @@ int mlx5_ib_dealloc_mw(struct ib_mw *mw)
 	int err;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		xa_erase(&dev->mdev->priv.mkey_table,
-			 mlx5_base_mkey(mmw->mmkey.key));
+		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mmw->mmkey.key));
 		/*
 		 * pagefault_single_data_segment() may be accessing mmw under
 		 * SRCU if the user bound an ODP MR to this MW.
 		 */
-		synchronize_srcu(&dev->mr_srcu);
+		synchronize_srcu(&dev->odp_srcu);
 	}
 
 	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4cc5b9420d3ec4..3de30317891a23 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -199,7 +199,7 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
 	 * locking around the children list.
 	 */
 	lockdep_assert_held(&to_ib_umem_odp(mr->umem)->umem_mutex);
-	lockdep_assert_held(&mr->dev->mr_srcu);
+	lockdep_assert_held(&mr->dev->odp_srcu);
 
 	odp = odp_lookup(offset * MLX5_IMR_MTT_SIZE,
 			 nentries * MLX5_IMR_MTT_SIZE, mr);
@@ -229,16 +229,16 @@ static void mr_leaf_free_action(struct work_struct *work)
 	int srcu_key;
 
 	mr->parent = NULL;
-	synchronize_srcu(&mr->dev->mr_srcu);
+	synchronize_srcu(&mr->dev->odp_srcu);
 
-	if (smp_load_acquire(&imr->live)) {
-		srcu_key = srcu_read_lock(&mr->dev->mr_srcu);
+	if (xa_load(&mr->dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key))) {
+		srcu_key = srcu_read_lock(&mr->dev->odp_srcu);
 		mutex_lock(&odp_imr->umem_mutex);
 		mlx5_ib_update_xlt(imr, idx, 1, 0,
 				   MLX5_IB_UPD_XLT_INDIRECT |
 				   MLX5_IB_UPD_XLT_ATOMIC);
 		mutex_unlock(&odp_imr->umem_mutex);
-		srcu_read_unlock(&mr->dev->mr_srcu, srcu_key);
+		srcu_read_unlock(&mr->dev->odp_srcu, srcu_key);
 	}
 	ib_umem_odp_release(odp);
 	mlx5_mr_cache_free(mr->dev, mr);
@@ -318,7 +318,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
-		WRITE_ONCE(mr->live, 0);
+		xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 		umem_odp->dying = 1;
 		atomic_inc(&mr->parent->num_leaf_free);
 		schedule_work(&umem_odp->work);
@@ -430,6 +430,11 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	if (IS_ERR(mr))
 		return mr;
 
+	err = xa_reserve(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			 GFP_KERNEL);
+	if (err)
+		goto out_mr;
+
 	mr->ibmr.pd = pd;
 
 	mr->dev = dev;
@@ -455,7 +460,7 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	}
 
 	if (err)
-		goto fail;
+		goto out_release;
 
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
@@ -465,7 +470,9 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 
 	return mr;
 
-fail:
+out_release:
+	xa_release(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
+out_mr:
 	mlx5_ib_err(dev, "Failed to register MKEY %d\n", err);
 	mlx5_mr_cache_free(dev, mr);
 
@@ -513,7 +520,8 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 		mtt->parent = mr;
 		INIT_WORK(&odp->work, mr_leaf_free_action);
 
-		smp_store_release(&mtt->live, 1);
+		xa_store(&dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key),
+			 &mtt->mmkey, GFP_ATOMIC);
 
 		if (!nentries)
 			start_idx = addr >> MLX5_IMR_MTT_SHIFT;
@@ -567,7 +575,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
-	smp_store_release(&imr->live, 1);
+	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key),
+		 &imr->mmkey, GFP_ATOMIC);
 
 	return imr;
 }
@@ -778,13 +787,28 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	size_t offset;
 	int ndescs;
 
-	srcu_key = srcu_read_lock(&dev->mr_srcu);
+	srcu_key = srcu_read_lock(&dev->odp_srcu);
 
 	io_virt += *bytes_committed;
 	bcnt -= *bytes_committed;
 
 next_mr:
-	mmkey = xa_load(&dev->mdev->priv.mkey_table, mlx5_base_mkey(key));
+	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(key));
+	if (!mmkey) {
+		mlx5_ib_dbg(
+			dev,
+			"skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
+			key);
+		if (bytes_mapped)
+			*bytes_mapped += bcnt;
+		/*
+		 * The user could specify a SGL with multiple lkeys and only
+		 * some of them are ODP. Treat the non-ODP ones as fully
+		 * faulted.
+		 */
+		ret = 0;
+		goto srcu_unlock;
+	}
 	if (!mkey_is_eq(mmkey, key)) {
 		mlx5_ib_dbg(dev, "failed to find mkey %x\n", key);
 		ret = -EFAULT;
@@ -794,20 +818,6 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	switch (mmkey->type) {
 	case MLX5_MKEY_MR:
 		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
-		if (!smp_load_acquire(&mr->live) || !mr->ibmr.pd) {
-			mlx5_ib_dbg(dev, "got dead MR\n");
-			ret = -EFAULT;
-			goto srcu_unlock;
-		}
-
-		if (!is_odp_mr(mr)) {
-			mlx5_ib_dbg(dev, "skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
-				    key);
-			if (bytes_mapped)
-				*bytes_mapped += bcnt;
-			ret = 0;
-			goto srcu_unlock;
-		}
 
 		ret = pagefault_mr(mr, io_virt, bcnt, bytes_mapped, 0);
 		if (ret < 0)
@@ -902,7 +912,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	}
 	kfree(out);
 
-	srcu_read_unlock(&dev->mr_srcu, srcu_key);
+	srcu_read_unlock(&dev->odp_srcu, srcu_key);
 	*bytes_committed = 0;
 	return ret ? ret : npages;
 }
@@ -1623,18 +1633,15 @@ get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
 
-	lockdep_assert_held(&dev->mr_srcu);
+	lockdep_assert_held(&dev->odp_srcu);
 
-	mmkey = xa_load(&dev->mdev->priv.mkey_table, mlx5_base_mkey(lkey));
+	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(lkey));
 	if (!mmkey || mmkey->key != lkey || mmkey->type != MLX5_MKEY_MR)
 		return NULL;
 
 	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
 
-	if (!smp_load_acquire(&mr->live))
-		return NULL;
-
-	if (mr->ibmr.pd != pd || !is_odp_mr(mr))
+	if (mr->ibmr.pd != pd)
 		return NULL;
 
 	/*
@@ -1709,7 +1716,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 	int ret = 0;
 	u32 i;
 
-	srcu_key = srcu_read_lock(&dev->mr_srcu);
+	srcu_key = srcu_read_lock(&dev->odp_srcu);
 	for (i = 0; i < num_sge; ++i) {
 		struct mlx5_ib_mr *mr;
 
@@ -1725,7 +1732,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 	}
 
 out:
-	srcu_read_unlock(&dev->mr_srcu, srcu_key);
+	srcu_read_unlock(&dev->odp_srcu, srcu_key);
 	return ret;
 }
 
@@ -1749,12 +1756,12 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	if (!work)
 		return -ENOMEM;
 
-	srcu_key = srcu_read_lock(&dev->mr_srcu);
+	srcu_key = srcu_read_lock(&dev->odp_srcu);
 	if (!init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge)) {
-		srcu_read_unlock(&dev->mr_srcu, srcu_key);
+		srcu_read_unlock(&dev->odp_srcu, srcu_key);
 		return -EINVAL;
 	}
 	queue_work(system_unbound_wq, &work->work);
-	srcu_read_unlock(&dev->mr_srcu, srcu_key);
+	srcu_read_unlock(&dev->odp_srcu, srcu_key);
 	return 0;
 }
-- 
2.23.0

