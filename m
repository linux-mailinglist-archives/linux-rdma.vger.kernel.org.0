Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC947BD20
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhLUJqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 04:46:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhLUJqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 04:46:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD95614A6;
        Tue, 21 Dec 2021 09:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7238C36AE7;
        Tue, 21 Dec 2021 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640080008;
        bh=Wh9wE+QlpCT8QpEL615uGgQqm4dvgzx3uVEsymgair4=;
        h=From:To:Cc:Subject:Date:From;
        b=C2cx8H1LCwuHvvOpqm1svQD5bG3Muq8TD0/ETooxGXWY0MpYpCp+n4Wk0NXUC2YwU
         wbfyg3oc+x7LxJJQekjEJQ6AQUT4IMVM+5aOlIV8NoRuFECsLepZGxP1vo4e0/FrUE
         wIJ0BfePjVsMamE4D51dYpH0ro/iwQcHfctQFpm09VbbMdNzLgMu7omZzRqDKwFRdH
         xX8+Vb2ztJOVyKSwVAGhzHuHnegHFPkcD69sgOVe+1ph3Q3JkvM1nU6h48JSFoHg/9
         7LH2/MW6QjcduNvENhxHHgyDpJHeElj2mJNuOf/OtidgRpwAHGsXqmpwhJjETz3yj0
         Bb/HYrnj+b1cw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Date:   Tue, 21 Dec 2021 11:46:41 +0200
Message-Id: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

The cited commit moved umem into the union, hence
umem could be accessed only for user MRs. Add udata check
before access umem in the dereg flow.

Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
 drivers/infiniband/hw/mlx5/odp.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4a7a56ed740b..29d439cebd22 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1296,7 +1296,7 @@ int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
-void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr);
+void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				    u64 length, u64 virt_addr, int access_flags,
 				    struct ib_pd *pd, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 63e2129f1142..dc833071949f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1977,7 +1977,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			return rc;
 	}
 
-	if (mr->umem) {
+	if (udata && mr->umem) {
 		bool is_odp = is_odp_mr(mr);
 
 		if (!is_odp)
@@ -1985,7 +1985,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 				   &dev->mdev->priv.reg_pages);
 		ib_umem_release(mr->umem);
 		if (is_odp)
-			mlx5_ib_free_odp_mr(mr);
+			mlx5_ib_free_odp_mr(mr, udata);
 	}
 
 	if (mr->cache_ent) {
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 91eb615b89ee..3928576b6696 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -530,7 +530,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	return ERR_PTR(err);
 }
 
-void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
+void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mtt;
 	unsigned long idx;
@@ -541,7 +541,7 @@ void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
 	 */
 	xa_for_each(&mr->implicit_children, idx, mtt) {
 		xa_erase(&mr->implicit_children, idx);
-		mlx5_ib_dereg_mr(&mtt->ibmr, NULL);
+		mlx5_ib_dereg_mr(&mtt->ibmr, udata);
 	}
 }
 
-- 
2.33.1

