Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4265BD13B3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfJIQKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40855 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfJIQKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so4175725qte.7
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJdwbx9SqBfnQym9Z50MQ/5e4bZxyYXUS1R2G4Io3fE=;
        b=KUHpYHK94j8nckh+E0UgVXVqsvFEGGpUSCWNGEum1xQqrBt5W47WqXaA1AQgGl6Hfr
         pnbjE++KZcojBZt8/144A1fFF7v6CtdY0v1JZpwdTvJWUhAlBoJibVtYCsChGS2JHii5
         NC5onFPEcCugPBizRRa0Ozey8StD7PRWUnl6XmxNJ+thOe6/Epjo1mmDWSvRL8xcWH5A
         zFC9ma22/UJagxru+R58eI21rR1ATvAZSMXty4++8yUDEaXhP++N4VT33booFPDUJNqS
         LlI6Uz/GHT9mZW5mGHyvdDG000wHR4zZS5IHkGBy7JLuzk2YkpAPY7c65puz79RFCV56
         fL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJdwbx9SqBfnQym9Z50MQ/5e4bZxyYXUS1R2G4Io3fE=;
        b=ZnKOcocvPlJrwy3Xzpxd/SaiFpymdqSlnur5SA+T2bBz3/kPok7aomqeAgAvitooWF
         8yLg11Ss/NislH+3CWF1oXjXYmgmlF+MJgQWFKMPzqh4314wFj4VpAC660NRjPsjJhly
         EzXcNhroI2kwFIL7sabDYrIdZ/y8jOVwhroiAtLnXNv1mbBRB/9xXfG/k83FjhMiASJU
         aDUcPDghOmE1T+zcb0VD45GEV2kA5ydBiZ0+eqxtN+CqyvD2QuUrKZeFAM3U19hcZ8gS
         8/+O8qMMFo0g95hdndt/mTdLQ80VpH7HRpFMT5Z/zhAqQ85SC+W13IvR4VgC/zIEPeb7
         fzuQ==
X-Gm-Message-State: APjAAAV65sZtHSDmsZTiJvS6SytW+RVJHB5ZLxh2oDmNz9oKiKBNpGyo
        GZLFFWnwEZm3HV75M+BTmMS07vtrW90=
X-Google-Smtp-Source: APXvYqyke6pLTNcSeq2HrxVvLQRl17pM4c/lyXp6flDollVfDgdCdkFhrD4pP26rrTnq18L8VXr02Q==
X-Received: by 2002:a05:6214:154c:: with SMTP id t12mr4510801qvw.127.1570637408098;
        Wed, 09 Oct 2019 09:10:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x9sm1061893qkl.75.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXM-0000qg-Sr; Wed, 09 Oct 2019 13:10:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 05/15] RDMA/mlx5: Rework implicit_mr_get_data
Date:   Wed,  9 Oct 2019 13:09:25 -0300
Message-Id: <20191009160934.3143-6-jgg@ziepe.ca>
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

This function is intended to loop across each MTT chunk in the implicit
parent that intersects the range [io_virt, io_virt+bnct).  But it is has a
confusing construction, so:

- Consistently use imr and odp_imr to refer to the implicit parent
  to avoid confusion with the normal mr and odp of the child
- Directly compute the inclusive start/end indexes by shifting. This is
  clearer to understand the intent and avoids any errors from unaligned
  values of addr
- Iterate directly over the range of MTT indexes, do not make a loop
  out of goto
- Follow 'success oriented flow', with goto error unwind
- Directly calculate the range of idx's that need update_xlt
- Ensure that any leaf MR added to the interval tree always results in an
  update to the XLT

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 123 +++++++++++++++++--------------
 1 file changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3de30317891a23..a56c627e25ae58 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -479,78 +479,93 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	return ERR_PTR(err);
 }
 
-static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
-						u64 io_virt, size_t bcnt)
+static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
+						unsigned long idx)
 {
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.pd->device);
-	struct ib_umem_odp *odp, *result = NULL;
-	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
-	u64 addr = io_virt & MLX5_IMR_MTT_MASK;
-	int nentries = 0, start_idx = 0, ret;
+	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mtt;
 
-	mutex_lock(&odp_mr->umem_mutex);
-	odp = odp_lookup(addr, 1, mr);
+	odp = ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),
+				      idx * MLX5_IMR_MTT_SIZE,
+				      MLX5_IMR_MTT_SIZE);
+	if (IS_ERR(odp))
+		return ERR_CAST(odp);
 
-	mlx5_ib_dbg(dev, "io_virt:%llx bcnt:%zx addr:%llx odp:%p\n",
-		    io_virt, bcnt, addr, odp);
+	mtt = implicit_mr_alloc(imr->ibmr.pd, odp, 0, imr->access_flags);
+	if (IS_ERR(mtt)) {
+		ib_umem_odp_release(odp);
+		return mtt;
+	}
 
-next_mr:
-	if (likely(odp)) {
-		if (nentries)
-			nentries++;
-	} else {
-		odp = ib_umem_odp_alloc_child(odp_mr, addr, MLX5_IMR_MTT_SIZE);
-		if (IS_ERR(odp)) {
-			mutex_unlock(&odp_mr->umem_mutex);
-			return ERR_CAST(odp);
-		}
+	odp->private = mtt;
+	mtt->umem = &odp->umem;
+	mtt->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
+	mtt->parent = imr;
+	INIT_WORK(&odp->work, mr_leaf_free_action);
 
-		mtt = implicit_mr_alloc(mr->ibmr.pd, odp, 0,
-					mr->access_flags);
-		if (IS_ERR(mtt)) {
-			mutex_unlock(&odp_mr->umem_mutex);
-			ib_umem_odp_release(odp);
-			return ERR_CAST(mtt);
-		}
+	xa_store(&mtt->dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key),
+		 &mtt->mmkey, GFP_ATOMIC);
+	return mtt;
+}
 
-		odp->private = mtt;
-		mtt->umem = &odp->umem;
-		mtt->mmkey.iova = addr;
-		mtt->parent = mr;
-		INIT_WORK(&odp->work, mr_leaf_free_action);
+static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *imr,
+						u64 io_virt, size_t bcnt)
+{
+	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
+	unsigned long end_idx = (io_virt + bcnt - 1) >> MLX5_IMR_MTT_SHIFT;
+	unsigned long idx = io_virt >> MLX5_IMR_MTT_SHIFT;
+	unsigned long inv_start_idx = end_idx + 1;
+	unsigned long inv_len = 0;
+	struct ib_umem_odp *result = NULL;
+	struct ib_umem_odp *odp;
+	int ret;
 
-		xa_store(&dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key),
-			 &mtt->mmkey, GFP_ATOMIC);
+	mutex_lock(&odp_imr->umem_mutex);
+	odp = odp_lookup(idx * MLX5_IMR_MTT_SIZE, 1, imr);
+	for (idx = idx; idx <= end_idx; idx++) {
+		if (unlikely(!odp)) {
+			struct mlx5_ib_mr *mtt;
 
-		if (!nentries)
-			start_idx = addr >> MLX5_IMR_MTT_SHIFT;
-		nentries++;
-	}
+			mtt = implicit_get_child_mr(imr, idx);
+			if (IS_ERR(mtt)) {
+				result = ERR_CAST(mtt);
+				goto out;
+			}
+			odp = to_ib_umem_odp(mtt->umem);
+			inv_start_idx = min(inv_start_idx, idx);
+			inv_len = idx - inv_start_idx + 1;
+		}
 
-	/* Return first odp if region not covered by single one */
-	if (likely(!result))
-		result = odp;
+		/* Return first odp if region not covered by single one */
+		if (likely(!result))
+			result = odp;
 
-	addr += MLX5_IMR_MTT_SIZE;
-	if (unlikely(addr < io_virt + bcnt)) {
 		odp = odp_next(odp);
-		if (odp && ib_umem_start(odp) != addr)
+		if (odp && ib_umem_start(odp) != idx * MLX5_IMR_MTT_SIZE)
 			odp = NULL;
-		goto next_mr;
 	}
 
-	if (unlikely(nentries)) {
-		ret = mlx5_ib_update_xlt(mr, start_idx, nentries, 0,
-					 MLX5_IB_UPD_XLT_INDIRECT |
+	/*
+	 * Any time the children in the interval tree are changed we must
+	 * perform an update of the xlt before exiting to ensure the HW and
+	 * the tree remains synchronized.
+	 */
+out:
+	if (likely(!inv_len))
+		goto out_unlock;
+
+	ret = mlx5_ib_update_xlt(imr, inv_start_idx, inv_len, 0,
+				 MLX5_IB_UPD_XLT_INDIRECT |
 					 MLX5_IB_UPD_XLT_ATOMIC);
-		if (ret) {
-			mlx5_ib_err(dev, "Failed to update PAS\n");
-			result = ERR_PTR(ret);
-		}
+	if (ret) {
+		mlx5_ib_err(to_mdev(imr->ibmr.pd->device),
+			    "Failed to update PAS\n");
+		result = ERR_PTR(ret);
+		goto out_unlock;
 	}
 
-	mutex_unlock(&odp_mr->umem_mutex);
+out_unlock:
+	mutex_unlock(&odp_imr->umem_mutex);
 	return result;
 }
 
-- 
2.23.0

