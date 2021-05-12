Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A137B79D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhELINl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:13:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2641 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhELINj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:13:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg6rM3f9xzQmH9;
        Wed, 12 May 2021 16:09:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:12:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/mlx5: Remove unused parameter udata
Date:   Wed, 12 May 2021 16:12:21 +0800
Message-ID: <1620807142-39157-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The old version of ib_umem_get() need these udata as a parameter but now
they are unnecessary.

Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/mlx5/cq.c       | 2 +-
 drivers/infiniband/hw/mlx5/doorbell.c | 3 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 4 +---
 drivers/infiniband/hw/mlx5/mr.c       | 2 +-
 drivers/infiniband/hw/mlx5/odp.c      | 1 -
 drivers/infiniband/hw/mlx5/qp.c       | 4 ++--
 drivers/infiniband/hw/mlx5/srq.c      | 2 +-
 7 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index eb92ceff..7beb3e2 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -750,7 +750,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	err = mlx5_ib_db_map_user(context, udata, ucmd.db_addr, &cq->db);
+	err = mlx5_ib_db_map_user(context, ucmd.db_addr, &cq->db);
 	if (err)
 		goto err_umem;
 
diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index 61475b5..913af75 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -43,8 +43,7 @@ struct mlx5_ib_user_db_page {
 	int			refcnt;
 };
 
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
-			struct ib_udata *udata, unsigned long virt,
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 			struct mlx5_db *db)
 {
 	struct mlx5_ib_user_db_page *page;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e9a3f34..7378cd3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1198,8 +1198,7 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 		struct mlx5_user_mmap_entry, rdma_entry);
 }
 
-int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
-			struct ib_udata *udata, unsigned long virt,
+int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 			struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
 void __mlx5_ib_cq_clean(struct mlx5_ib_cq *cq, u32 qpn, struct mlx5_ib_srq *srq);
@@ -1265,7 +1264,6 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags);
 int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
-					     struct ib_udata *udata,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
 void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4388afe..383c0c6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1510,7 +1510,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 		if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 			return ERR_PTR(-EINVAL);
 
-		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), udata, access_flags);
+		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), access_flags);
 		if (IS_ERR(mr))
 			return ERR_CAST(mr);
 		return &mr->ibmr;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 87fa0b2..0415e53 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -478,7 +478,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 }
 
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
-					     struct ib_udata *udata,
 					     int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->ibpd.device);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9282eb1..67da125 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -835,7 +835,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
-	err = mlx5_ib_db_map_user(ucontext, udata, ucmd->db_addr, &rwq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd->db_addr, &rwq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_umem;
@@ -961,7 +961,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, udata, ucmd->db_addr, &qp->db);
+	err = mlx5_ib_db_map_user(context, ucmd->db_addr, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index fab6736..191c4ee 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -84,7 +84,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 	in->umem = srq->umem;
 
-	err = mlx5_ib_db_map_user(ucontext, udata, ucmd.db_addr, &srq->db);
+	err = mlx5_ib_db_map_user(ucontext, ucmd.db_addr, &srq->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map doorbell failed\n");
 		goto err_umem;
-- 
2.7.4

