Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2212AD13B9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfJIQKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34580 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbfJIQKM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so4238895qta.1
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKBfPaP4sKng1Mx+myKf9XOKZ0nm7yqf6cQo7BikLUM=;
        b=ZSouc0ubUV6vKkzoJE/kb07sj2UYGS1YCW+bk16sshHL8aljKxgqXQ0xkaEo6IUg6p
         m8Ct4Y5luE86Nf2EQ+4/tB2JuEdrt6FHUCOWQLyUzUj3phezseo5uptgViVhV3P/9Xcb
         bLw2r5tHCwMLyrXSUrPMWmmC9GjIF+/ybINfV+w2mCDVBxondueWG9CfCIu38pmNcwai
         +CNTWj/Hi4sxRze5jyDhVi29l6qUQ+dYyS3g3iDmcUXR1n1+n5h7GroTDWgDJhiOYYl6
         y1jDlchd2ZU3yTYYQ7ItfQrM1jUS+mCqQ07k5Q40yvDF/CXZkJcMRYgCxHPTdnPzobpB
         /OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKBfPaP4sKng1Mx+myKf9XOKZ0nm7yqf6cQo7BikLUM=;
        b=KcRGi228WOqJVxT/VeX5zjSJopX9Pj5gyONx5DPm4VKNVurPx/3vJOdJDWmuQ+RV7B
         NHFEwPB4ZqmquEn48u956UVshN8GunB95prWTwsLjX6xwyXegFBO/xGKM9zW+2TAx1/4
         zD55k/U2uwDr/NMnHtL5dnrbzkjwAMd6NsrcJmB+3LYWsnMpktzMbjM/Ffek7IZE/jnk
         Iq7bU0mDfQRZ/4eiYq0p/rMnINGfFrSHhQnqJuxsf/PHmZelxGkAEh65I0jE2UMYhLPQ
         U8f0o7w4QUbWv6hIbXBI0n7WomVEJhh1V1y9NLgTzO68r1D56HmIwy9C+noCtXdlcsoY
         W18A==
X-Gm-Message-State: APjAAAUaM/X09W/N5f+W8OOL7h5Q+nESTTGhRgmropDGbsIN+YEyd+i2
        7E+D+o8GDIlGkCoKP1SZwdILf6zh7aU=
X-Google-Smtp-Source: APXvYqzRC3pnj+KPI8WMIuwT/uaZSSEY3BTSvQs5wAHlxfmXvTWGvt4WyNGsURLjx2jeOmgZOdkSaQ==
X-Received: by 2002:a05:6214:180a:: with SMTP id o10mr4430862qvw.91.1570637411181;
        Wed, 09 Oct 2019 09:10:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g3sm1025898qkb.117.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rZ-Ag; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 14/15] RDMA/mlx5: Do not race with mlx5_ib_invalidate_range during create and destroy
Date:   Wed,  9 Oct 2019 13:09:34 -0300
Message-Id: <20191009160934.3143-15-jgg@ziepe.ca>
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

For creation, as soon as the umem_odp is created the notifier can be
called, however the underlying MR may not have been setup yet. This would
cause problems if mlx5_ib_invalidate_range() runs. There is some
confusing/ulocked/racy code that might by trying to solve this, but
without locks it isn't going to work right.

Instead trivially solve the problem by short-circuiting the invalidation
if there are not yet any DMA mapped pages. By definition there is nothing
to invalidate in this case.

The create code will have the umem fully setup before anything is DMA
mapped, and npages is fully locked by the umem_mutex.

For destroy, invalidate the entire MR at the HW to stop DMA then DMA unmap
the pages before destroying the MR. This drives npages to zero and
prevents similar racing with invalidate while the MR is undergoing
destruction.

Arguably it would be better if the umem was created after the MR and
destroyed before, but that would require a big rework of the MR code.

Fixes: 6aec21f6a832 ("IB/mlx5: Page faults handling infrastructure")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 ++
 drivers/infiniband/hw/mlx5/mr.c      | 74 +++++++++------------------
 drivers/infiniband/hw/mlx5/odp.c     | 75 ++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b8c958f6262848..f61d4005c6c379 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1171,6 +1171,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     struct ib_udata *udata,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
+void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr);
 int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			  u64 length, u64 virt_addr, int access_flags,
 			  struct ib_pd *pd, struct ib_udata *udata);
@@ -1232,6 +1233,8 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry);
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
+int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr);
+
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1e91f61efa8a3e..199f7959aaa510 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -50,7 +50,6 @@ enum {
 static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
-static int unreg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
 {
@@ -495,7 +494,7 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	c = order2idx(dev, mr->order);
 	WARN_ON(c < 0 || c >= MAX_MR_CACHE_ENTRIES);
 
-	if (unreg_umr(dev, mr)) {
+	if (mlx5_mr_cache_invalidate(mr)) {
 		mr->allocated_from_cache = false;
 		destroy_mkey(dev, mr);
 		ent = &cache->ent[c];
@@ -1333,22 +1332,29 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(err);
 }
 
-static int unreg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+/**
+ * mlx5_mr_cache_invalidate - Fence all DMA on the MR
+ * @mr: The MR to fence
+ *
+ * Upon return the NIC will not be doing any DMA to the pages under the MR,
+ * and any DMA inprogress will be completed. Failure of this function
+ * indicates the HW has failed catastrophically.
+ */
+int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr)
 {
-	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_umr_wr umrwr = {};
 
-	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+	if (mr->dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
 		return 0;
 
 	umrwr.wr.send_flags = MLX5_IB_SEND_UMR_DISABLE_MR |
 			      MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
 	umrwr.wr.opcode = MLX5_IB_WR_UMR;
-	umrwr.pd = dev->umrc.pd;
+	umrwr.pd = mr->dev->umrc.pd;
 	umrwr.mkey = mr->mmkey.key;
 	umrwr.ignore_free_state = 1;
 
-	return mlx5_ib_post_send_wait(dev, &umrwr);
+	return mlx5_ib_post_send_wait(mr->dev, &umrwr);
 }
 
 static int rereg_umr(struct ib_pd *pd, struct mlx5_ib_mr *mr,
@@ -1432,7 +1438,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * UMR can't be used - MKey needs to be replaced.
 		 */
 		if (mr->allocated_from_cache)
-			err = unreg_umr(dev, mr);
+			err = mlx5_mr_cache_invalidate(mr);
 		else
 			err = destroy_mkey(dev, mr);
 		if (err)
@@ -1561,52 +1567,20 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	int npages = mr->npages;
 	struct ib_umem *umem = mr->umem;
 
-	if (is_odp_mr(mr)) {
-		struct ib_umem_odp *umem_odp = to_ib_umem_odp(umem);
-
-		/* Prevent new page faults and
-		 * prefetch requests from succeeding
-		 */
-		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
-
-		/* Wait for all running page-fault handlers to finish. */
-		synchronize_srcu(&dev->odp_srcu);
-
-		/* dequeue pending prefetch requests for the mr */
-		if (atomic_read(&mr->num_deferred_work)) {
-			flush_workqueue(system_unbound_wq);
-			WARN_ON(atomic_read(&mr->num_deferred_work));
-		}
-
-		/* Destroy all page mappings */
-		mlx5_ib_invalidate_range(umem_odp, ib_umem_start(umem_odp),
-					 ib_umem_end(umem_odp));
-
-		/*
-		 * We kill the umem before the MR for ODP,
-		 * so that there will not be any invalidations in
-		 * flight, looking at the *mr struct.
-		 */
-		ib_umem_odp_release(umem_odp);
-		atomic_sub(npages, &dev->mdev->priv.reg_pages);
-
-		/* Avoid double-freeing the umem. */
-		umem = NULL;
-	}
+	/* Stop all DMA */
+	if (is_odp_mr(mr))
+		mlx5_ib_fence_odp_mr(mr);
+	else
+		clean_mr(dev, mr);
 
-	clean_mr(dev, mr);
+	if (mr->allocated_from_cache)
+		mlx5_mr_cache_free(dev, mr);
+	else
+		kfree(mr);
 
-	/*
-	 * We should unregister the DMA address from the HCA before
-	 * remove the DMA mapping.
-	 */
-	mlx5_mr_cache_free(dev, mr);
 	ib_umem_release(umem);
-	if (umem)
-		atomic_sub(npages, &dev->mdev->priv.reg_pages);
+	atomic_sub(npages, &dev->mdev->priv.reg_pages);
 
-	if (!mr->allocated_from_cache)
-		kfree(mr);
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 66523313c3e46c..fd2306aff78ad7 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -144,6 +144,32 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	}
 }
 
+static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
+{
+	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+
+	/* Ensure mlx5_ib_invalidate_range() will not touch the MR any more */
+	mutex_lock(&odp->umem_mutex);
+	if (odp->npages) {
+		/*
+		 * If not cached then the caller had to do clean_mrs first to
+		 * fence the mkey.
+		 */
+		if (mr->allocated_from_cache) {
+			mlx5_mr_cache_invalidate(mr);
+		} else {
+			/* clean_mr() */
+			mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
+			WARN_ON(mr->descs);
+		}
+		ib_umem_odp_unmap_dma_pages(odp, ib_umem_start(odp),
+					    ib_umem_end(odp));
+		WARN_ON(odp->npages);
+	}
+	odp->private = NULL;
+	mutex_unlock(&odp->umem_mutex);
+}
+
 /*
  * This must be called after the mr has been removed from implicit_children
  * and the SRCU synchronized.  NOTE: The MR does not necessarily have to be
@@ -171,6 +197,8 @@ static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)
 		srcu_read_unlock(&mr->dev->odp_srcu, srcu_key);
 	}
 
+	dma_fence_odp_mr(mr);
+
 	mr->parent = NULL;
 	mlx5_mr_cache_free(mr->dev, mr);
 	ib_umem_odp_release(odp);
@@ -228,16 +256,15 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	int in_block = 0;
 	u64 addr;
 
-	if (!umem_odp) {
-		pr_err("invalidation called on NULL umem or non-ODP umem\n");
-		return;
-	}
-
+	mutex_lock(&umem_odp->umem_mutex);
+	/*
+	 * If npages is zero then umem_odp->private may not be setup yet. This
+	 * does not complete until after the first page is mapped for DMA.
+	 */
+	if (!umem_odp->npages)
+		goto out;
 	mr = umem_odp->private;
 
-	if (!mr || !mr->ibmr.pd)
-		return;
-
 	start = max_t(u64, ib_umem_start(umem_odp), start);
 	end = min_t(u64, ib_umem_end(umem_odp), end);
 
@@ -247,7 +274,6 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	 * overwrite the same MTTs.  Concurent invalidations might race us,
 	 * but they will write 0s as well, so no difference in the end result.
 	 */
-	mutex_lock(&umem_odp->umem_mutex);
 	for (addr = start; addr < end; addr += BIT(umem_odp->page_shift)) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 		/*
@@ -289,6 +315,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	if (unlikely(!umem_odp->npages && mr->parent))
 		destroy_unused_implicit_child_mr(mr);
+out:
 	mutex_unlock(&umem_odp->umem_mutex);
 }
 
@@ -536,6 +563,13 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 		WARN_ON(atomic_read(&imr->num_deferred_work));
 	}
 
+	/*
+	 * Fence the imr before we destroy the children. This allows us to
+	 * skip updating the XLT of the imr during destroy of the child mkey
+	 * the imr points to.
+	 */
+	mlx5_mr_cache_invalidate(imr);
+
 	list_for_each_entry_safe (mtt, tmp, &destroy_list, odp_destroy.elm)
 		free_implicit_child_mr(mtt, false);
 
@@ -543,6 +577,29 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	ib_umem_odp_release(odp_imr);
 }
 
+/**
+ * mlx5_ib_fence_odp_mr - Stop all access to the ODP MR
+ * @mr: to fence
+ *
+ * On return no parallel threads will be touching this MR and no DMA will be
+ * active.
+ */
+void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
+{
+	/* Prevent new page faults and prefetch requests from succeeding */
+	xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
+
+	/* Wait for all running page-fault handlers to finish. */
+	synchronize_srcu(&mr->dev->odp_srcu);
+
+	if (atomic_read(&mr->num_deferred_work)) {
+		flush_workqueue(system_unbound_wq);
+		WARN_ON(atomic_read(&mr->num_deferred_work));
+	}
+
+	dma_fence_odp_mr(mr);
+}
+
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
-- 
2.23.0

