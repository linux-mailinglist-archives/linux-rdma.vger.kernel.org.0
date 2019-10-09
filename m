Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A33D13B8
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJIQKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37698 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfJIQKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id l51so3920443qtc.4
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P46xjS9CLZDjZszRRlu1hhDzB49h4jVi+OHW0f74bg8=;
        b=fgq1dJNZEtsC8Pw0pXWMlOFrlUjjUJRCzOrxX1/bgMMZVHH1c3cFGhpqBQu1gsQeYN
         aZsyxF+Igk3GMa6lQi3LMQNHS5/oSO5PYhnb6SxbbqoLiiZtdyuM7PfxnKADsEu2QIT3
         b3g3b9raGwkl0W4VHcPEKPRIMjp9mXZezzeH1q00H/OF/HqcCvfLjQvcrt+XZMZ1qYI1
         utIozIWj5mSbeW8WG/HgtLcP9M4TzZ1ZiIsCop5V/Kbmdvjn6Iuf8YrqllQb2IitqFRY
         XuytPKCcUW50imV8xBT2ZmOzpxx5LB9lWweYVpzCGek1c+4zFLN7DrgU8oqDwnIPRcke
         SpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P46xjS9CLZDjZszRRlu1hhDzB49h4jVi+OHW0f74bg8=;
        b=qVshRzr74TDlmKJ1d4lYqP+kR5nbXFvxVDMjiZ2M8OC1ILpyIJaRdsIOPIgdHkGI4s
         g5NxiPRDyccNe2aqVT3kd7h1B5d3QiTKwbw6wCCUQIMpPgK3lFPlfh8eGJphGxsx+1tY
         L6AP2gaDFQNnVkgkhqTSb9JTL9pTIt7aHivRQn4b2TgQb5xxolcFqynUqQNwlzEZQfJk
         d7dT63JbUNGGZh8t0qucazDaQgKpEjDOOv9X2cL7Jdg87mGVTUwpbASlm5Ohm7TZjy2H
         RIdGoiLQcE6sXVWX43bWz9V4baWrRPAY7jF8Ii4ps5kYkefsd0fxmqjq/gK/SgYhBGDz
         adYw==
X-Gm-Message-State: APjAAAVhulXgW06K6Z5XBQTiNwGccT4VqYB9HTdvinUf6dmyiXQj8Gxf
        NDuc5+y9rszYXrofpsmO9xv3VvpdeVo=
X-Google-Smtp-Source: APXvYqyeKTxLe8BccjwRhW/l3g23fbWBlmyanNpv3F3E/YpfGKwsTfyyY3Cfd3uH9AKpSkYSzkMf3A==
X-Received: by 2002:ac8:534a:: with SMTP id d10mr4587533qto.349.1570637410814;
        Wed, 09 Oct 2019 09:10:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v12sm1465869qtb.5.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rA-4O; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 10/15] RDMA/mlx5: Reduce locking in implicit_mr_get_data()
Date:   Wed,  9 Oct 2019 13:09:30 -0300
Message-Id: <20191009160934.3143-11-jgg@ziepe.ca>
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

Now that the child MRs are stored in an xarray we can rely on the SRCU
lock to protect the xa_load and use xa_cmpxchg on the slow allocation path
to resolve races with concurrent page fault.

This reduces the scope of the critical section of umem_mutex for implicit
MRs to only cover mlx5_ib_update_xlt, and avoids taking a lock at all if
the child MR is already in the xarray. This makes it consistent with the
normal ODP MR critical section for umem_lock, and the locking approach
used for destroying an unusued implicit child MR.

The MLX5_IB_UPD_XLT_ATOMIC is no longer needed in implicit_get_child_mr()
since it is no longer called with any locks.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 38 ++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d70cf02343a79f..e8413fd1b8c73b 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -381,8 +381,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 				 MLX5_IMR_MTT_ENTRIES,
 				 PAGE_SHIFT,
 				 MLX5_IB_UPD_XLT_ZAP |
-				 MLX5_IB_UPD_XLT_ENABLE |
-				 MLX5_IB_UPD_XLT_ATOMIC);
+				 MLX5_IB_UPD_XLT_ENABLE);
 	if (err) {
 		ret = ERR_PTR(err);
 		goto out_release;
@@ -392,9 +391,16 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	 * Once the store to either xarray completes any error unwind has to
 	 * use synchronize_srcu(). Avoid this with xa_reserve()
 	 */
-	err = xa_err(xa_store(&imr->implicit_children, idx, mr, GFP_KERNEL));
-	if (err) {
-		ret = ERR_PTR(err);
+	ret = xa_cmpxchg(&imr->implicit_children, idx, NULL, mr, GFP_KERNEL);
+	if (unlikely(ret)) {
+		if (xa_is_err(ret)) {
+			ret = ERR_PTR(xa_err(ret));
+			goto out_release;
+		}
+		/*
+		 * Another thread beat us to creating the child mr, use
+		 * theirs.
+		 */
 		goto out_release;
 	}
 
@@ -424,7 +430,8 @@ static struct mlx5_ib_mr *implicit_mr_get_data(struct mlx5_ib_mr *imr,
 	struct mlx5_ib_mr *result = NULL;
 	int ret;
 
-	mutex_lock(&odp_imr->umem_mutex);
+	lockdep_assert_held(&imr->dev->odp_srcu);
+
 	for (idx = idx; idx <= end_idx; idx++) {
 		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
 
@@ -450,20 +457,27 @@ static struct mlx5_ib_mr *implicit_mr_get_data(struct mlx5_ib_mr *imr,
 	 */
 out:
 	if (likely(!inv_len))
-		goto out_unlock;
+		return result;
 
+	/*
+	 * Notice this is not strictly ordered right, the KSM is updated after
+	 * the implicit_leaves is updated, so a parallel page fault could see
+	 * a MR that is not yet visible in the KSM.  This is similar to a
+	 * parallel page fault seeing a MR that is being concurrently removed
+	 * from the KSM. Both of these improbable situations are resolved
+	 * safely by resuming the HW and then taking another page fault. The
+	 * next pagefault handler will see the new information.
+	 */
+	mutex_lock(&odp_imr->umem_mutex);
 	ret = mlx5_ib_update_xlt(imr, inv_start_idx, inv_len, 0,
 				 MLX5_IB_UPD_XLT_INDIRECT |
 					 MLX5_IB_UPD_XLT_ATOMIC);
+	mutex_unlock(&odp_imr->umem_mutex);
 	if (ret) {
 		mlx5_ib_err(to_mdev(imr->ibmr.pd->device),
 			    "Failed to update PAS\n");
-		result = ERR_PTR(ret);
-		goto out_unlock;
+		return ERR_PTR(ret);
 	}
-
-out_unlock:
-	mutex_unlock(&odp_imr->umem_mutex);
 	return result;
 }
 
-- 
2.23.0

