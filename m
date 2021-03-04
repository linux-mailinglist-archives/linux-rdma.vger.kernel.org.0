Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBE32D29B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhCDMIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240104AbhCDMIp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:08:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B649164F36;
        Thu,  4 Mar 2021 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614859685;
        bh=PnZmpkQQDT6FsMWRRamimKx3OgF2rV5EcVursODtq90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0h6vwrFiThS1VbJBJeM1V25MxrKMlOVo57Boa2/WslmB3GTMoBoNiiaeZqRGHP2X
         q5ygZAhxCNa/icX8j3e90zAtDkVihDDBnwfrKm3HZBG3yRPGYQlSAlNVK5wmJl5rqq
         UKlT3EfAMbjxtoxOrVsK1Q7SBfqgstzaM208pk0o2gtyRDxc0eeXc8qwoJXRGi6vp3
         KQDQlU8psftr2WB9ivO2nBi/I3dbGNuVz/DLb9NR7msHYThC0fo6dLz2a2BS1jzb6R
         8apRLNZQtPYhyDO0iq+4ZmrBAxaJmclRiqTYyeEfaueV/j28N1dcT3Fm0o9J0/fJUx
         up6AwLiwd5+Zg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/4] RDMA/mlx5: Rename mlx5_mr_cache_invalidate() to revoke_mr()
Date:   Thu,  4 Mar 2021 14:07:45 +0200
Message-Id: <20210304120745.1090751-5-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304120745.1090751-1-leon@kernel.org>
References: <20210304120745.1090751-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that this is only used in a few places in mr.c give it a sensible
name. It has nothing to do with the cache and can be invoked on any
MR. DMA is stopped and the user cannot touch the MR any further once it
completes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6304ba54a42d..86ffc7e5ef96 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1640,14 +1640,14 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 }
 
 /**
- * mlx5_mr_cache_invalidate - Fence all DMA on the MR
+ * revoke_mr - Fence all DMA on the MR
  * @mr: The MR to fence
  *
  * Upon return the NIC will not be doing any DMA to the pages under the MR,
- * and any DMA inprogress will be completed. Failure of this function
+ * and any DMA in progress will be completed. Failure of this function
  * indicates the HW has failed catastrophically.
  */
-static int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr)
+static int revoke_mr(struct mlx5_ib_mr *mr)
 {
 	struct mlx5_umr_wr umrwr = {};
 
@@ -1741,7 +1741,7 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	 * with it. This ensure the change is atomic relative to any use of the
 	 * MR.
 	 */
-	err = mlx5_mr_cache_invalidate(mr);
+	err = revoke_mr(mr);
 	if (err)
 		return err;
 
@@ -1820,7 +1820,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * Only one active MR can refer to a umem at one time, revoke
 		 * the old MR before assigning the umem to the new one.
 		 */
-		err = mlx5_mr_cache_invalidate(mr);
+		err = revoke_mr(mr);
 		if (err)
 			return ERR_PTR(err);
 		umem = mr->umem;
@@ -1965,7 +1965,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	/* Stop DMA */
 	if (mr->cache_ent) {
-		if (mlx5_mr_cache_invalidate(mr)) {
+		if (revoke_mr(mr)) {
 			spin_lock_irq(&mr->cache_ent->lock);
 			mr->cache_ent->total_mrs--;
 			spin_unlock_irq(&mr->cache_ent->lock);
-- 
2.29.2

