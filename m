Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7C921FF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHSLRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSLRi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:38 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075D92086C;
        Mon, 19 Aug 2019 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213457;
        bh=lUsjta7Efh5fZbdhlHOVWXZIQxyhiQZTzrFYfpVf+B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWqUheM7pTOEs3qIpGD4WCIViMipe6B8lBfRZoxj73oEaR+Eii68uqMznNCDumiTY
         Cpv8V2svhph721csyYxcIR0S0vPt/BP9vgOZSG8uUbpIN8JuVTF5Jd5gopLhR99JDd
         XUK87zCn7dKtTpZ0zSt27Isoo/wzE20TjTuYne0Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 07/12] RDMA/odp: Provide ib_umem_odp_release() to undo the allocs
Date:   Mon, 19 Aug 2019 14:17:05 +0300
Message-Id: <20190819111710.18440-8-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that there are allocator APIs that return the ib_umem_odp directly
it should be freed through a umem_odp free'er as well.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c     | 20 ++++----------------
 drivers/infiniband/core/umem_odp.c |  3 +++
 drivers/infiniband/hw/mlx5/mr.c    |  2 +-
 drivers/infiniband/hw/mlx5/odp.c   |  6 +++---
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index ac7376401965..312289f84987 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -326,15 +326,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 }
 EXPORT_SYMBOL(ib_umem_get);
 
-static void __ib_umem_release_tail(struct ib_umem *umem)
-{
-	mmdrop(umem->owning_mm);
-	if (umem->is_odp)
-		kfree(to_ib_umem_odp(umem));
-	else
-		kfree(umem);
-}
-
 /**
  * ib_umem_release - release memory pinned with ib_umem_get
  * @umem: umem struct to release
@@ -343,17 +334,14 @@ void ib_umem_release(struct ib_umem *umem)
 {
 	if (!umem)
 		return;
-
-	if (umem->is_odp) {
-		ib_umem_odp_release(to_ib_umem_odp(umem));
-		__ib_umem_release_tail(umem);
-		return;
-	}
+	if (umem->is_odp)
+		return ib_umem_odp_release(to_ib_umem_odp(umem));
 
 	__ib_umem_release(umem->context->device, umem, 1);
 
 	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
-	__ib_umem_release_tail(umem);
+	mmdrop(umem->owning_mm);
+	kfree(umem);
 }
 EXPORT_SYMBOL(ib_umem_release);
 
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 79995766316a..2575dd783196 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -530,7 +530,10 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		vfree(umem_odp->page_list);
 	}
 	put_per_mm(umem_odp);
+	mmdrop(umem_odp->umem.owning_mm);
+	kfree(umem_odp);
 }
+EXPORT_SYMBOL(ib_umem_odp_release);
 
 /*
  * Map for DMA and insert a single page into the on-demand paging page tables.
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c9690d3cfb5c..aa0299662c05 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1638,7 +1638,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		 * so that there will not be any invalidations in
 		 * flight, looking at the *mr struct.
 		 */
-		ib_umem_release(umem);
+		ib_umem_odp_release(umem_odp);
 		atomic_sub(npages, &dev->mdev->priv.reg_pages);
 
 		/* Avoid double-freeing the umem. */
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4371fc759c23..ad5d5f2c8509 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -206,7 +206,7 @@ static void mr_leaf_free_action(struct work_struct *work)
 	mr->parent = NULL;
 	synchronize_srcu(&mr->dev->mr_srcu);
 
-	ib_umem_release(&odp->umem);
+	ib_umem_odp_release(odp);
 	if (imr->live)
 		mlx5_ib_update_xlt(imr, idx, 1, 0,
 				   MLX5_IB_UPD_XLT_INDIRECT |
@@ -472,7 +472,7 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 					mr->access_flags);
 		if (IS_ERR(mtt)) {
 			mutex_unlock(&odp_mr->umem_mutex);
-			ib_umem_release(&odp->umem);
+			ib_umem_odp_release(odp);
 			return ERR_CAST(mtt);
 		}
 
@@ -526,7 +526,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 
 	imr = implicit_mr_alloc(&pd->ibpd, umem_odp, 1, access_flags);
 	if (IS_ERR(imr)) {
-		ib_umem_release(&umem_odp->umem);
+		ib_umem_odp_release(umem_odp);
 		return ERR_CAST(imr);
 	}
 
-- 
2.20.1

