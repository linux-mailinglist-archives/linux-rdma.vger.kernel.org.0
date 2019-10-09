Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145B2D13B7
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfJIQKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40861 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbfJIQKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id m61so4175883qte.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6c1aoU1BPPfl3nQ0qYG7bB9Dkxz6YfifpPegfqhpSE=;
        b=c9H5aC5Z2bziMdIow4dr3jOuPNwFGVJceiWK6nGntjumHLvgXEZK3ZUGaYjNUvJxWV
         QIQlZcyGPxIlGHAk8D8kljMk3E3wuBVtZq+XiDC40v5PPEL60FYyDMJx5oCUCMSdaiMU
         xg92xc+cRUyHsldLIHLGxc3dEmZNUa33sy3ZhScVmFz3e1h/3rIWtt4At/sGMpvvRl25
         JGF7ef1Kc9AROtAIFb/fURIFJwkozqwfue3qzsGFOwyhwdiySmq8ECdAi2/zb9ZnbkAz
         67zs4opPgu7ZCCAR/wBMDzVE+dIRwqcSWyfEJHC4MuS6xrwW/xseh8AHrCIVVbi8cGRR
         kxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6c1aoU1BPPfl3nQ0qYG7bB9Dkxz6YfifpPegfqhpSE=;
        b=REU6MYEKS/k2wS5ecYFnixDRPM2BlTCXfKt6Gbf81U4j0BN1sE9W5eht+Kie7/6ZSo
         sSVsuFtYt2lek5NvgacIdKTRbSXzyDFesUEwgeRU0koDZ1wg/WZ1u6ygkA8LWN+QiZq3
         0fb+FI1DIh7AfgudTjCrkVKc81DN2zc9Euql9w7/DfQbJcyMcFKWqsWDUNinteMldq44
         pZTi6RqOcD1JnIeLiLJay48TJqL8+rwPPSknTfqhCe7qMR5FmuGvXPqkqwjpZVAqWofe
         /l5iNPPvI8oxvT7sUFs9nmCuxgL9A3IFXfMEatywZHS4K3rdbU39L73bzyJH9MSWwgQm
         nsVw==
X-Gm-Message-State: APjAAAVefT46XpP3nWu83jEoxY/fMdvsXhwI0GrFRavF1rLrIXFgf9HN
        S6cwyUrq2mJpETuaIBuy3GC/OjniCCI=
X-Google-Smtp-Source: APXvYqxuiWTJsov4OxzYPLOlk3YxhiXgf/MWUsfyYBEpOgtnWO9CxJJURsrNMMhftz75RtuLe7MvSg==
X-Received: by 2002:ac8:72cf:: with SMTP id o15mr2331567qtp.27.1570637410188;
        Wed, 09 Oct 2019 09:10:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t199sm1128833qke.36.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rG-6H; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 11/15] RDMA/mlx5: Avoid double lookups on the pagefault path
Date:   Wed,  9 Oct 2019 13:09:31 -0300
Message-Id: <20191009160934.3143-12-jgg@ziepe.ca>
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

Now that the locking is simplified combine pagefault_implicit_mr() with
implicit_mr_get_data() so that we sweep over the idx range only once,
and do the single xlt update at the end, after the child umems are
setup.

This avoids double iteration/xa_loads plus the sketchy failure path if the
xa_load() fails.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 186 +++++++++++++------------------
 1 file changed, 80 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e8413fd1b8c73b..1897ce6a25f693 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -419,68 +419,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	return ret;
 }
 
-static struct mlx5_ib_mr *implicit_mr_get_data(struct mlx5_ib_mr *imr,
-						u64 io_virt, size_t bcnt)
-{
-	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
-	unsigned long end_idx = (io_virt + bcnt - 1) >> MLX5_IMR_MTT_SHIFT;
-	unsigned long idx = io_virt >> MLX5_IMR_MTT_SHIFT;
-	unsigned long inv_start_idx = end_idx + 1;
-	unsigned long inv_len = 0;
-	struct mlx5_ib_mr *result = NULL;
-	int ret;
-
-	lockdep_assert_held(&imr->dev->odp_srcu);
-
-	for (idx = idx; idx <= end_idx; idx++) {
-		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
-
-		if (unlikely(!mtt)) {
-			mtt = implicit_get_child_mr(imr, idx);
-			if (IS_ERR(mtt)) {
-				result = mtt;
-				goto out;
-			}
-			inv_start_idx = min(inv_start_idx, idx);
-			inv_len = idx - inv_start_idx + 1;
-		}
-
-		/* Return first odp if region not covered by single one */
-		if (likely(!result))
-			result = mtt;
-	}
-
-	/*
-	 * Any time the implicit_children are changed we must perform an
-	 * update of the xlt before exiting to ensure the HW and the
-	 * implicit_children remains synchronized.
-	 */
-out:
-	if (likely(!inv_len))
-		return result;
-
-	/*
-	 * Notice this is not strictly ordered right, the KSM is updated after
-	 * the implicit_leaves is updated, so a parallel page fault could see
-	 * a MR that is not yet visible in the KSM.  This is similar to a
-	 * parallel page fault seeing a MR that is being concurrently removed
-	 * from the KSM. Both of these improbable situations are resolved
-	 * safely by resuming the HW and then taking another page fault. The
-	 * next pagefault handler will see the new information.
-	 */
-	mutex_lock(&odp_imr->umem_mutex);
-	ret = mlx5_ib_update_xlt(imr, inv_start_idx, inv_len, 0,
-				 MLX5_IB_UPD_XLT_INDIRECT |
-					 MLX5_IB_UPD_XLT_ATOMIC);
-	mutex_unlock(&odp_imr->umem_mutex);
-	if (ret) {
-		mlx5_ib_err(to_mdev(imr->ibmr.pd->device),
-			    "Failed to update PAS\n");
-		return ERR_PTR(ret);
-	}
-	return result;
-}
-
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     struct ib_udata *udata,
 					     int access_flags)
@@ -647,6 +585,84 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	return ret;
 }
 
+static int pagefault_implicit_mr(struct mlx5_ib_mr *imr,
+				 struct ib_umem_odp *odp_imr, u64 user_va,
+				 size_t bcnt, u32 *bytes_mapped, u32 flags)
+{
+	unsigned long end_idx = (user_va + bcnt - 1) >> MLX5_IMR_MTT_SHIFT;
+	unsigned long upd_start_idx = end_idx + 1;
+	unsigned long upd_len = 0;
+	unsigned long npages = 0;
+	int err;
+	int ret;
+
+	if (unlikely(user_va >= mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE ||
+		     mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE - user_va < bcnt))
+		return -EFAULT;
+
+	/* Fault each child mr that intersects with our interval. */
+	while (bcnt) {
+		unsigned long idx = user_va >> MLX5_IMR_MTT_SHIFT;
+		struct ib_umem_odp *umem_odp;
+		struct mlx5_ib_mr *mtt;
+		u64 len;
+
+		mtt = xa_load(&imr->implicit_children, idx);
+		if (unlikely(!mtt)) {
+			mtt = implicit_get_child_mr(imr, idx);
+			if (IS_ERR(mtt)) {
+				ret = PTR_ERR(mtt);
+				goto out;
+			}
+			upd_start_idx = min(upd_start_idx, idx);
+			upd_len = idx - upd_start_idx + 1;
+		}
+
+		umem_odp = to_ib_umem_odp(mtt->umem);
+		len = min_t(u64, user_va + bcnt, ib_umem_end(umem_odp)) -
+		      user_va;
+
+		ret = pagefault_real_mr(mtt, umem_odp, user_va, len,
+					bytes_mapped, flags);
+		if (ret < 0)
+			goto out;
+		user_va += len;
+		bcnt -= len;
+		npages += ret;
+	}
+
+	ret = npages;
+
+	/*
+	 * Any time the implicit_children are changed we must perform an
+	 * update of the xlt before exiting to ensure the HW and the
+	 * implicit_children remains synchronized.
+	 */
+out:
+	if (likely(!upd_len))
+		return ret;
+
+	/*
+	 * Notice this is not strictly ordered right, the KSM is updated after
+	 * the implicit_children is updated, so a parallel page fault could
+	 * see a MR that is not yet visible in the KSM.  This is similar to a
+	 * parallel page fault seeing a MR that is being concurrently removed
+	 * from the KSM. Both of these improbable situations are resolved
+	 * safely by resuming the HW and then taking another page fault. The
+	 * next pagefault handler will see the new information.
+	 */
+	mutex_lock(&odp_imr->umem_mutex);
+	err = mlx5_ib_update_xlt(imr, upd_start_idx, upd_len, 0,
+				 MLX5_IB_UPD_XLT_INDIRECT |
+					 MLX5_IB_UPD_XLT_ATOMIC);
+	mutex_unlock(&odp_imr->umem_mutex);
+	if (err) {
+		mlx5_ib_err(imr->dev, "Failed to update PAS\n");
+		return err;
+	}
+	return ret;
+}
+
 /*
  * Returns:
  *  -EFAULT: The io_virt->bcnt is not within the MR, it covers pages that are
@@ -660,8 +676,6 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 			u32 *bytes_mapped, u32 flags)
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-	struct mlx5_ib_mr *mtt;
-	int npages = 0;
 
 	if (!odp->is_implicit_odp) {
 		if (unlikely(io_virt < ib_umem_start(odp) ||
@@ -670,48 +684,8 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 		return pagefault_real_mr(mr, odp, io_virt, bcnt, bytes_mapped,
 					 flags);
 	}
-
-	if (unlikely(io_virt >= mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE ||
-		     mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE - io_virt < bcnt))
-		return -EFAULT;
-
-	mtt = implicit_mr_get_data(mr, io_virt, bcnt);
-	if (IS_ERR(mtt))
-		return PTR_ERR(mtt);
-
-	/* Fault each child mr that intersects with our interval. */
-	while (bcnt) {
-		struct ib_umem_odp *umem_odp = to_ib_umem_odp(mtt->umem);
-		u64 end = min_t(u64, io_virt + bcnt, ib_umem_end(umem_odp));
-		u64 len = end - io_virt;
-		int ret;
-
-		ret = pagefault_real_mr(mtt, umem_odp, io_virt, len,
-					bytes_mapped, flags);
-		if (ret < 0)
-			return ret;
-		io_virt += len;
-		bcnt -= len;
-		npages += ret;
-
-		if (unlikely(bcnt)) {
-			mtt = xa_load(&mr->implicit_children,
-				      io_virt >> MLX5_IMR_MTT_SHIFT);
-
-			/*
-			 * implicit_mr_get_data sets up all the leaves, this
-			 * means they got invalidated before we got to them.
-			 */
-			if (!mtt) {
-				mlx5_ib_dbg(
-					mr->dev,
-					"next implicit leaf removed at 0x%llx.\n",
-					io_virt);
-				return -EAGAIN;
-			}
-		}
-	}
-	return npages;
+	return pagefault_implicit_mr(mr, odp, io_virt, bcnt, bytes_mapped,
+				     flags);
 }
 
 struct pf_frame {
-- 
2.23.0

