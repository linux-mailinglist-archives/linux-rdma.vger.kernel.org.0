Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440DA425B7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407479AbfFLM1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407161AbfFLM1r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 08:27:47 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF40A20874;
        Wed, 12 Jun 2019 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342466;
        bh=d1thBi0V/V9LAtl7uoNhG9wkJ1GxR66QuX3NmcUE1XA=;
        h=From:To:Cc:Subject:Date:From;
        b=AYb7E7MVelfpOhd5vHw9Je2yCxrTRnbJvdHEo8RF68TYSdC+USSsEkTEmcP9wHVMr
         AR2NiFFaUVzgiLKz0PAqCpHeuyUTRprgleB5g9t/MfcoXO5SYztachFa+qcLhEKBMA
         GYju5ZkYSCb/IdACl4bebGxe8MwQfm69mczA+4fk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA: Convert destroy_wq to be void
Date:   Wed, 12 Jun 2019 15:27:41 +0300
Message-Id: <20190612122741.22850-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

All callers of destroy WQ are always success and there is no need
to check their return value, so convert destroy_wq to be void.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c      | 12 +++++-------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
 drivers/infiniband/hw/mlx4/qp.c      |  4 +---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/qp.c      |  4 +---
 include/rdma/ib_verbs.h              |  2 +-
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 2fb834bb146c..d55f491be24f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2344,19 +2344,17 @@ EXPORT_SYMBOL(ib_create_wq);
  */
 int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 {
-	int err;
 	struct ib_cq *cq = wq->cq;
 	struct ib_pd *pd = wq->pd;
 
 	if (atomic_read(&wq->usecnt))
 		return -EBUSY;
 
-	err = wq->device->ops.destroy_wq(wq, udata);
-	if (!err) {
-		atomic_dec(&pd->usecnt);
-		atomic_dec(&cq->usecnt);
-	}
-	return err;
+	wq->device->ops.destroy_wq(wq, udata);
+	atomic_dec(&pd->usecnt);
+	atomic_dec(&cq->usecnt);
+
+	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_wq);
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 81b3d85e5167..eb53bb4c0c91 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -906,7 +906,7 @@ void mlx4_ib_sl2vl_update(struct mlx4_ib_dev *mdev, int port);
 struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
-int mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
+void mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx4_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 5221c0794d1d..520364defa28 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4248,7 +4248,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 	return err;
 }
 
-int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
+void mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibwq->device);
 	struct mlx4_ib_qp *qp = to_mqp((struct ib_qp *)ibwq);
@@ -4259,8 +4259,6 @@ int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 	destroy_qp_common(dev, qp, MLX4_IB_RWQ_SRC, udata);
 
 	kfree(qp);
-
-	return 0;
 }
 
 struct ib_rwq_ind_table
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b256100d1e52..0bfc14ff8aed 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1222,7 +1222,7 @@ int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
-int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
+void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
 struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index cbd63ea41347..63d8f61e50e0 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6161,7 +6161,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	return ERR_PTR(err);
 }
 
-int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
+void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(wq->device);
 	struct mlx5_ib_rwq *rwq = to_mrwq(wq);
@@ -6169,8 +6169,6 @@ int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 	mlx5_core_destroy_rq_tracked(dev->mdev, &rwq->core_qp);
 	destroy_user_rq(dev, wq->pd, rwq, udata);
 	kfree(rwq);
-
-	return 0;
 }
 
 struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 255999488693..d902ff49b56e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2428,7 +2428,7 @@ struct ib_device_ops {
 	struct ib_wq *(*create_wq)(struct ib_pd *pd,
 				   struct ib_wq_init_attr *init_attr,
 				   struct ib_udata *udata);
-	int (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
+	void (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
 	int (*modify_wq)(struct ib_wq *wq, struct ib_wq_attr *attr,
 			 u32 wq_attr_mask, struct ib_udata *udata);
 	struct ib_rwq_ind_table *(*create_rwq_ind_table)(
-- 
2.20.1

