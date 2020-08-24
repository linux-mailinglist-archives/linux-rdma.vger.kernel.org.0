Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591E724FB8C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHXKdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgHXKda (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:33:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC7B208E4;
        Mon, 24 Aug 2020 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265209;
        bh=HS+imsWbVbKh/+4LKWHGaCeQ+XS7hTlf3nLb0bWXfxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJtqJylN8XEkGM7tiA4ijSCnOPQhqoqEk253U9zKQQnDKlPQo+WoMvMvnXCRxYVES
         3B3bUZ4XcwZaU/9pATXOl+5PzhFkgcSka7KPz4XrWuLX56j0Fe3qFuvy64gXRxwT5p
         M5jP9qbCpvPWruvWN4IXnZEAOr90Sw7PReamcnd8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH rdma-next 09/10] RDMA: Restore ability to return error for destroy WQ
Date:   Mon, 24 Aug 2020 13:32:46 +0300
Message-Id: <20200824103247.1088464-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824103247.1088464-1-leon@kernel.org>
References: <20200824103247.1088464-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Make this interface symmetrical to other destroy paths.

Fixes: a49b1dc7ae44 ("RDMA: Convert destroy_wq to be void")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_std_types_wq.c |  2 +-
 drivers/infiniband/core/verbs.c               | 15 +++++++++------
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/qp.c               |  3 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/qp.c               |  8 ++++++--
 drivers/infiniband/hw/mlx5/qp.h               |  4 ++--
 drivers/infiniband/hw/mlx5/qpc.c              |  5 +++--
 include/rdma/ib_verbs.h                       |  4 ++--
 9 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_wq.c b/drivers/infiniband/core/uverbs_std_types_wq.c
index cad842ede077..f2e6a625724a 100644
--- a/drivers/infiniband/core/uverbs_std_types_wq.c
+++ b/drivers/infiniband/core/uverbs_std_types_wq.c
@@ -16,7 +16,7 @@ static int uverbs_free_wq(struct ib_uobject *uobject,
 		container_of(uobject, struct ib_uwq_object, uevent.uobject);
 	int ret;
 
-	ret = ib_destroy_wq(wq, &attrs->driver_udata);
+	ret = ib_destroy_wq_user(wq, &attrs->driver_udata);
 	if (ib_is_destroy_retryable(ret, why, uobject))
 		return ret;
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 0dec1c8d6744..bab99f326cce 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2399,25 +2399,28 @@ struct ib_wq *ib_create_wq(struct ib_pd *pd,
 EXPORT_SYMBOL(ib_create_wq);
 
 /**
- * ib_destroy_wq - Destroys the specified user WQ.
+ * ib_destroy_wq_user - Destroys the specified user WQ.
  * @wq: The WQ to destroy.
  * @udata: Valid user data
  */
-int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
+int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata)
 {
 	struct ib_cq *cq = wq->cq;
 	struct ib_pd *pd = wq->pd;
+	int ret;
 
 	if (atomic_read(&wq->usecnt))
 		return -EBUSY;
 
-	wq->device->ops.destroy_wq(wq, udata);
+	ret = wq->device->ops.destroy_wq(wq, udata);
+	if (ret && udata)
+		return ret;
+
 	atomic_dec(&pd->usecnt);
 	atomic_dec(&cq->usecnt);
-
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL(ib_destroy_wq);
+EXPORT_SYMBOL(ib_destroy_wq_user);
 
 /**
  * ib_modify_wq - Modifies the specified WQ.
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 32a024f765ea..8f5467c2309a 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -899,7 +899,7 @@ void mlx4_ib_sl2vl_update(struct mlx4_ib_dev *mdev, int port);
 struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
-void mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
+int mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx4_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index f9ca6e000a81..1db1e25a436b 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4327,7 +4327,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 	return err;
 }
 
-void mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
+int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibwq->device);
 	struct mlx4_ib_qp *qp = to_mqp((struct ib_qp *)ibwq);
@@ -4338,6 +4338,7 @@ void mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 	destroy_qp_common(dev, qp, MLX4_IB_RWQ_SRC, udata);
 
 	kfree(qp);
+	return 0;
 }
 
 struct ib_rwq_ind_table
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 041f9d1d696b..0a3681463a62 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1241,7 +1241,7 @@ int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata);
-void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
+int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
 struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index fea837cb2ec4..74d3f4c39dc5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5085,14 +5085,18 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	return ERR_PTR(err);
 }
 
-void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
+int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(wq->device);
 	struct mlx5_ib_rwq *rwq = to_mrwq(wq);
+	int ret;
 
-	mlx5_core_destroy_rq_tracked(dev, &rwq->core_qp);
+	ret = mlx5_core_destroy_rq_tracked(dev, &rwq->core_qp);
+	if (ret && udata)
+		return ret;
 	destroy_user_rq(dev, wq->pd, rwq, udata);
 	kfree(rwq);
+	return ret;
 }
 
 struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index ba899df44c5b..5d4e140db99c 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -26,8 +26,8 @@ int mlx5_core_dct_query(struct mlx5_ib_dev *dev, struct mlx5_core_dct *dct,
 
 int mlx5_core_set_delay_drop(struct mlx5_ib_dev *dev, u32 timeout_usec);
 
-void mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
-				  struct mlx5_core_qp *rq);
+int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
+				 struct mlx5_core_qp *rq);
 int mlx5_core_create_sq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
 				struct mlx5_core_qp *sq);
 void mlx5_core_destroy_sq_tracked(struct mlx5_ib_dev *dev,
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index 7c3968ef9cd1..c683d7000168 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -576,11 +576,12 @@ int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
 	return err;
 }
 
-void mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
-				  struct mlx5_core_qp *rq)
+int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
+				 struct mlx5_core_qp *rq)
 {
 	destroy_resource_common(dev, rq);
 	destroy_rq_tracked(dev, rq->qpn, rq->uid);
+	return 0;
 }
 
 static void destroy_sq_tracked(struct mlx5_ib_dev *dev, u32 sqn, u16 uid)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1161e18d948a..58fdaaf4f67b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2486,7 +2486,7 @@ struct ib_device_ops {
 	struct ib_wq *(*create_wq)(struct ib_pd *pd,
 				   struct ib_wq_init_attr *init_attr,
 				   struct ib_udata *udata);
-	void (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
+	int (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
 	int (*modify_wq)(struct ib_wq *wq, struct ib_wq_attr *attr,
 			 u32 wq_attr_mask, struct ib_udata *udata);
 	struct ib_rwq_ind_table *(*create_rwq_ind_table)(
@@ -4322,7 +4322,7 @@ struct net_device *ib_device_netdev(struct ib_device *dev, u8 port);
 
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
-int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
+int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
 int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *attr,
 		 u32 wq_attr_mask);
 int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
-- 
2.26.2

