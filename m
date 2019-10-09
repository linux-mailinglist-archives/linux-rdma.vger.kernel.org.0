Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23DD13B5
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfJIQKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44098 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfJIQKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so4142286qth.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJEg3kRU8fOi2QfaHQ3YiAy6OHmBCS5J4mto1R77tvc=;
        b=aMrCS/B+reyXBv7nn5zIEpiYlTRUyYx7ABrWLJ2AM8NuaYp1bjwQN+WDue/1hnPidQ
         eqn2DOv2NNjglW02axLOvst5GFSIkhOpr5Q+cBFrOY1gncqBjYHAVy54KfugxV/Ee9dQ
         Ma5IDITvvNf0gk/DzvQ6klJMs3gizoRfzvA2W/+MH6NityCwizJ8kAPu9dVBpko4CyPB
         nZUiqFjQ+PhHNY3Hm5jbHkxLHqQFn8tv6oCWZZwp7X30CrBOlUKKvgGtzzhpWS/u8l+3
         ntFjspleWAv9WL6srfgDDIqmfLhLoyIRiLXVuStcWRMZ8iXO51GcDHIonNaZ3t2WyeCu
         tovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJEg3kRU8fOi2QfaHQ3YiAy6OHmBCS5J4mto1R77tvc=;
        b=uKAwq+RkBvBzb8NPQynD3jeid7TiuU/+JMRFBsV6ewUYrk6R05Alnvq4EgplzT3+FD
         cqJZbSt2RzI+mOl4zIxF5vSH0l7e28Ji8/u6qEUjSR++sNlZmzFbYg/Za/4vmEWw8tzt
         a/+5vpRjH9pkDknMvQwMgpkJJK0aIQS5p+JaBCcSJXWaKSB0OkaIQs7IbhzKtQ9KrJRY
         pbdnSrcFErV3Wg/6I8nVABKtu8s7J7TYFUkdQJXYwUppLgJUxQWYKUO+RNvDsKizly83
         Jcb7MAx1YDffiIk/1PoEZsWgjJVB1WheC7OOOWt1FWoacLyeqHE+Owhym/esz2OuFrba
         S11A==
X-Gm-Message-State: APjAAAWLm5SdVFlO2F9BIm7bTtYboP3cO0Laq0RB02qr6nzDfHQ4v1Mx
        pXptHNn9BPvAXvsPUBBqRuR6TFlZBYI=
X-Google-Smtp-Source: APXvYqz+SGVLiB/1XSzDgVmhVnDjoSg9asrI1w3UInEzxwP0q8aKZhEsCDOD1itSGD9aem2CBizfsw==
X-Received: by 2002:ac8:28a3:: with SMTP id i32mr4540283qti.42.1570637409404;
        Wed, 09 Oct 2019 09:10:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w11sm1336153qtj.10.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qm-Ur; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 06/15] RDMA/mlx5: Lift implicit_mr_alloc() into the two routines that call it
Date:   Wed,  9 Oct 2019 13:09:26 -0300
Message-Id: <20191009160934.3143-7-jgg@ziepe.ca>
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

This makes the routines easier to understand, particularly with respect
the locking requirements of the entire sequence. The implicit_mr_alloc()
had a lot of ifs specializing it to each of the callers, and only a very
small amount of code was actually shared.

Following patches will cause the flow in the two functions to diverge
further.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 151 +++++++++++++++----------------
 1 file changed, 74 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index a56c627e25ae58..9b912d2f786192 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -416,96 +416,66 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 			    wq_num, err);
 }
 
-static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
-					    struct ib_umem_odp *umem_odp,
-					    bool ksm, int access_flags)
+static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
+						unsigned long idx)
 {
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
+	struct mlx5_ib_mr *ret;
 	int err;
 
-	mr = mlx5_mr_cache_alloc(dev, ksm ? MLX5_IMR_KSM_CACHE_ENTRY :
-					    MLX5_IMR_MTT_CACHE_ENTRY);
+	odp = ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),
+				      idx * MLX5_IMR_MTT_SIZE,
+				      MLX5_IMR_MTT_SIZE);
+	if (IS_ERR(odp))
+		return ERR_CAST(odp);
 
+	ret = mr = mlx5_mr_cache_alloc(imr->dev, MLX5_IMR_MTT_CACHE_ENTRY);
 	if (IS_ERR(mr))
-		return mr;
+		goto out_umem;
 
-	err = xa_reserve(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+	err = xa_reserve(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
 			 GFP_KERNEL);
-	if (err)
+	if (err) {
+		ret = ERR_PTR(err);
 		goto out_mr;
-
-	mr->ibmr.pd = pd;
-
-	mr->dev = dev;
-	mr->access_flags = access_flags;
-	mr->mmkey.iova = 0;
-	mr->umem = &umem_odp->umem;
-
-	if (ksm) {
-		err = mlx5_ib_update_xlt(mr, 0,
-					 mlx5_imr_ksm_entries,
-					 MLX5_KSM_PAGE_SHIFT,
-					 MLX5_IB_UPD_XLT_INDIRECT |
-					 MLX5_IB_UPD_XLT_ZAP |
-					 MLX5_IB_UPD_XLT_ENABLE);
-
-	} else {
-		err = mlx5_ib_update_xlt(mr, 0,
-					 MLX5_IMR_MTT_ENTRIES,
-					 PAGE_SHIFT,
-					 MLX5_IB_UPD_XLT_ZAP |
-					 MLX5_IB_UPD_XLT_ENABLE |
-					 MLX5_IB_UPD_XLT_ATOMIC);
 	}
 
-	if (err)
-		goto out_release;
-
+	mr->ibmr.pd = imr->ibmr.pd;
+	mr->access_flags = imr->access_flags;
+	mr->umem = &odp->umem;
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
+	mr->mmkey.iova = 0;
+	mr->parent = imr;
+	odp->private = mr;
+	INIT_WORK(&odp->work, mr_leaf_free_action);
+
+	err = mlx5_ib_update_xlt(mr, 0,
+				 MLX5_IMR_MTT_ENTRIES,
+				 PAGE_SHIFT,
+				 MLX5_IB_UPD_XLT_ZAP |
+				 MLX5_IB_UPD_XLT_ENABLE |
+				 MLX5_IB_UPD_XLT_ATOMIC);
+	if (err) {
+		ret = ERR_PTR(err);
+		goto out_release;
+	}
 
-	mlx5_ib_dbg(dev, "key %x dev %p mr %p\n",
-		    mr->mmkey.key, dev->mdev, mr);
+	mr->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
+	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+		 &mr->mmkey, GFP_ATOMIC);
 
+	mlx5_ib_dbg(imr->dev, "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
 out_release:
-	xa_release(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
+	xa_release(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 out_mr:
-	mlx5_ib_err(dev, "Failed to register MKEY %d\n", err);
-	mlx5_mr_cache_free(dev, mr);
-
-	return ERR_PTR(err);
-}
-
-static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
-						unsigned long idx)
-{
-	struct ib_umem_odp *odp;
-	struct mlx5_ib_mr *mtt;
-
-	odp = ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),
-				      idx * MLX5_IMR_MTT_SIZE,
-				      MLX5_IMR_MTT_SIZE);
-	if (IS_ERR(odp))
-		return ERR_CAST(odp);
-
-	mtt = implicit_mr_alloc(imr->ibmr.pd, odp, 0, imr->access_flags);
-	if (IS_ERR(mtt)) {
-		ib_umem_odp_release(odp);
-		return mtt;
-	}
-
-	odp->private = mtt;
-	mtt->umem = &odp->umem;
-	mtt->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
-	mtt->parent = imr;
-	INIT_WORK(&odp->work, mr_leaf_free_action);
-
-	xa_store(&mtt->dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key),
-		 &mtt->mmkey, GFP_ATOMIC);
-	return mtt;
+	mlx5_mr_cache_free(imr->dev, mr);
+out_umem:
+	ib_umem_odp_release(odp);
+	return ret;
 }
 
 static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *imr,
@@ -573,27 +543,54 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     struct ib_udata *udata,
 					     int access_flags)
 {
-	struct mlx5_ib_mr *imr;
+	struct mlx5_ib_dev *dev = to_mdev(pd->ibpd.device);
 	struct ib_umem_odp *umem_odp;
+	struct mlx5_ib_mr *imr;
+	int err;
 
 	umem_odp = ib_umem_odp_alloc_implicit(udata, access_flags);
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = implicit_mr_alloc(&pd->ibpd, umem_odp, 1, access_flags);
+	imr = mlx5_mr_cache_alloc(dev, MLX5_IMR_KSM_CACHE_ENTRY);
 	if (IS_ERR(imr)) {
-		ib_umem_odp_release(umem_odp);
-		return ERR_CAST(imr);
+		err = PTR_ERR(imr);
+		goto out_umem;
 	}
 
+	imr->ibmr.pd = &pd->ibpd;
+	imr->access_flags = access_flags;
+	imr->mmkey.iova = 0;
+	imr->umem = &umem_odp->umem;
+	imr->ibmr.lkey = imr->mmkey.key;
+	imr->ibmr.rkey = imr->mmkey.key;
 	imr->umem = &umem_odp->umem;
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
-	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key),
-		 &imr->mmkey, GFP_ATOMIC);
 
+	err = mlx5_ib_update_xlt(imr, 0,
+				 mlx5_imr_ksm_entries,
+				 MLX5_KSM_PAGE_SHIFT,
+				 MLX5_IB_UPD_XLT_INDIRECT |
+				 MLX5_IB_UPD_XLT_ZAP |
+				 MLX5_IB_UPD_XLT_ENABLE);
+	if (err)
+		goto out_mr;
+
+	err = xa_err(xa_store(&dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key),
+			      &imr->mmkey, GFP_KERNEL));
+	if (err)
+		goto out_mr;
+
+	mlx5_ib_dbg(dev, "key %x mr %p\n", imr->mmkey.key, imr);
 	return imr;
+out_mr:
+	mlx5_ib_err(dev, "Failed to register MKEY %d\n", err);
+	mlx5_mr_cache_free(dev, imr);
+out_umem:
+	ib_umem_odp_release(umem_odp);
+	return ERR_PTR(err);
 }
 
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
-- 
2.23.0

