Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB87125A790
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBIQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBIQd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:16:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4636C20829;
        Wed,  2 Sep 2020 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034592;
        bh=mcpx6OaB3BQNDTJIQgh5KVBuwFZgiaabm6ovD8bNquE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llcRQE+VrAhl7jjlLRCNUESUKcfHpj9fwzJ13YJPCIawaIhO6HozM+mJ/1ATMY5UK
         cD8hckWP20RQoADr1KiB5yMqfHvQRGyKNx/nSvi/8siRfaGQFVXhBbaDOvAp6sL5Sg
         DGQlBzq7If/fxnQPdCn2ttBCbAYK6DKdFFnAg6O4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA: Clean MW allocation and free flows
Date:   Wed,  2 Sep 2020 11:16:22 +0300
Message-Id: <20200902081623.746359-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081623.746359-1-leon@kernel.org>
References: <20200902081623.746359-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Move allocation and destruction of memory windows under ib_core
responsibility and clean drivers to ensure that no updates to MW
ib_core structures are done in driver layer.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c            |  1 +
 drivers/infiniband/core/uverbs_cmd.c        | 20 +++++++----
 drivers/infiniband/core/uverbs_main.c       |  7 ++--
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h      |  3 +-
 drivers/infiniband/hw/cxgb4/mem.c           | 32 ++++++-----------
 drivers/infiniband/hw/cxgb4/provider.c      |  4 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 28 +++++----------
 drivers/infiniband/hw/mlx4/main.c           |  2 ++
 drivers/infiniband/hw/mlx4/mlx4_ib.h        |  3 +-
 drivers/infiniband/hw/mlx4/mr.c             | 30 +++++-----------
 drivers/infiniband/hw/mlx5/main.c           |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h        |  3 +-
 drivers/infiniband/hw/mlx5/mr.c             | 40 ++++++++-------------
 include/rdma/ib_verbs.h                     |  4 +--
 16 files changed, 78 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0..7365ca8edcdf 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2695,6 +2695,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
 	SET_OBJ_SIZE(dev_ops, ib_ucontext);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 432e42b3c931..409913a2489b 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -880,7 +880,7 @@ static int ib_uverbs_dereg_mr(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_alloc_mw      cmd;
-	struct ib_uverbs_alloc_mw_resp resp;
+	struct ib_uverbs_alloc_mw_resp resp = {};
 	struct ib_uobject             *uobj;
 	struct ib_pd                  *pd;
 	struct ib_mw                  *mw;
@@ -906,15 +906,21 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 		goto err_put;
 	}
 
-	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &attrs->driver_udata);
-	if (IS_ERR(mw)) {
-		ret = PTR_ERR(mw);
+	mw = rdma_zalloc_drv_obj(ib_dev, ib_mw);
+	if (!mw) {
+		ret = -ENOMEM;
 		goto err_put;
 	}
 
-	mw->device  = pd->device;
-	mw->pd      = pd;
+	mw->device = ib_dev;
+	mw->pd = pd;
 	mw->uobject = uobj;
+	mw->type = cmd.mw_type;
+
+	ret = pd->device->ops.alloc_mw(mw, &attrs->driver_udata);
+	if (ret)
+		goto err_alloc;
+
 	atomic_inc(&pd->usecnt);
 
 	uobj->object = mw;
@@ -925,6 +931,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	resp.mw_handle = uobj->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_alloc:
+	kfree(mw);
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 37794d88b1f3..36ea760f0a28 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -108,8 +108,11 @@ int uverbs_dealloc_mw(struct ib_mw *mw)
 	int ret;
 
 	ret = mw->device->ops.dealloc_mw(mw);
-	if (!ret)
-		atomic_dec(&pd->usecnt);
+	if (ret)
+		return ret;
+
+	atomic_dec(&pd->usecnt);
+	kfree(mw);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index dc65811e6a93..a27899402f59 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -985,8 +985,7 @@ int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		   unsigned int *sg_offset);
 int c4iw_dealloc_mw(struct ib_mw *mw);
 void c4iw_dealloc(struct uld_ctx *ctx);
-struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			    struct ib_udata *udata);
+int c4iw_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 					   u64 length, u64 virt, int acc,
 					   struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 73936c3341b7..5c967fcbb109 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -611,30 +611,23 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(err);
 }
 
-struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			    struct ib_udata *udata)
+int c4iw_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
+	struct c4iw_mw *mhp = to_c4iw_mw(ibmw);
 	struct c4iw_dev *rhp;
 	struct c4iw_pd *php;
-	struct c4iw_mw *mhp;
 	u32 mmid;
 	u32 stag = 0;
 	int ret;
 
-	if (type != IB_MW_TYPE_1)
-		return ERR_PTR(-EINVAL);
+	if (ibmw->type != IB_MW_TYPE_1)
+		return -EINVAL;
 
-	php = to_c4iw_pd(pd);
+	php = to_c4iw_pd(ibmw->pd);
 	rhp = php->rhp;
-	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
-	if (!mhp)
-		return ERR_PTR(-ENOMEM);
-
 	mhp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
-	if (!mhp->wr_waitp) {
-		ret = -ENOMEM;
-		goto free_mhp;
-	}
+	if (!mhp->wr_waitp)
+		return -ENOMEM;
 
 	mhp->dereg_skb = alloc_skb(SGE_MAX_WR_LEN, GFP_KERNEL);
 	if (!mhp->dereg_skb) {
@@ -645,18 +638,19 @@ struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 	ret = allocate_window(&rhp->rdev, &stag, php->pdid, mhp->wr_waitp);
 	if (ret)
 		goto free_skb;
+
 	mhp->rhp = rhp;
 	mhp->attr.pdid = php->pdid;
 	mhp->attr.type = FW_RI_STAG_MW;
 	mhp->attr.stag = stag;
 	mmid = (stag) >> 8;
-	mhp->ibmw.rkey = stag;
+	ibmw->rkey = stag;
 	if (xa_insert_irq(&rhp->mrs, mmid, mhp, GFP_KERNEL)) {
 		ret = -ENOMEM;
 		goto dealloc_win;
 	}
 	pr_debug("mmid 0x%x mhp %p stag 0x%x\n", mmid, mhp, stag);
-	return &(mhp->ibmw);
+	return 0;
 
 dealloc_win:
 	deallocate_window(&rhp->rdev, mhp->attr.stag, mhp->dereg_skb,
@@ -665,9 +659,7 @@ struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 	kfree_skb(mhp->dereg_skb);
 free_wr_wait:
 	c4iw_put_wr_wait(mhp->wr_waitp);
-free_mhp:
-	kfree(mhp);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 int c4iw_dealloc_mw(struct ib_mw *mw)
@@ -684,8 +676,6 @@ int c4iw_dealloc_mw(struct ib_mw *mw)
 			  mhp->wr_waitp);
 	kfree_skb(mhp->dereg_skb);
 	c4iw_put_wr_wait(mhp->wr_waitp);
-	pr_debug("ib_mw %p mmid 0x%x ptr %p\n", mw, mmid, mhp);
-	kfree(mhp);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 5f2b30624512..4b76f2f3f4e4 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -498,8 +498,10 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.query_qp = c4iw_ib_query_qp,
 	.reg_user_mr = c4iw_reg_user_mr,
 	.req_notify_cq = c4iw_arm_cq,
-	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
+
 	INIT_RDMA_OBJ_SIZE(ib_cq, c4iw_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_mw, c4iw_mw, ibmw),
+	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, c4iw_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, c4iw_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 30290a7ce286..3cab23f5ac69 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1204,8 +1204,7 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 			    unsigned long mpt_index);
 unsigned long key_to_hw_index(u32 key);
 
-struct ib_mw *hns_roce_alloc_mw(struct ib_pd *pd, enum ib_mw_type,
-				struct ib_udata *udata);
+int hns_roce_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int hns_roce_dealloc_mw(struct ib_mw *ibmw);
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5907cfd878a6..45f7353bd348 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -454,6 +454,8 @@ static const struct ib_device_ops hns_roce_dev_mr_ops = {
 static const struct ib_device_ops hns_roce_dev_mw_ops = {
 	.alloc_mw = hns_roce_alloc_mw,
 	.dealloc_mw = hns_roce_dealloc_mw,
+
+	INIT_RDMA_OBJ_SIZE(ib_mw, hns_roce_mw, ibmw),
 };
 
 static const struct ib_device_ops hns_roce_dev_frmr_ops = {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index e5df3884b41d..a0ee510aca10 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -589,28 +589,22 @@ static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-struct ib_mw *hns_roce_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
-				struct ib_udata *udata)
+int hns_roce_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_pd->device);
-	struct hns_roce_mw *mw;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
+	struct hns_roce_mw *mw = to_hr_mw(ibmw);
 	unsigned long index = 0;
 	int ret;
 
-	mw = kmalloc(sizeof(*mw), GFP_KERNEL);
-	if (!mw)
-		return ERR_PTR(-ENOMEM);
-
 	/* Allocate a key for mw from bitmap */
 	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
 	if (ret)
-		goto err_bitmap;
+		return ret;
 
 	mw->rkey = hw_index_to_key(index);
 
-	mw->ibmw.rkey = mw->rkey;
-	mw->ibmw.type = type;
-	mw->pdn = to_hr_pd(ib_pd)->pdn;
+	ibmw->rkey = mw->rkey;
+	mw->pdn = to_hr_pd(ibmw->pd)->pdn;
 	mw->pbl_hop_num = hr_dev->caps.pbl_hop_num;
 	mw->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
 	mw->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
@@ -619,15 +613,11 @@ struct ib_mw *hns_roce_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	if (ret)
 		goto err_mw;
 
-	return &mw->ibmw;
+	return 0;
 
 err_mw:
 	hns_roce_mw_free(hr_dev, mw);
-
-err_bitmap:
-	kfree(mw);
-
-	return ERR_PTR(ret);
+	return ret;
 }
 
 int hns_roce_dealloc_mw(struct ib_mw *ibmw)
@@ -636,8 +626,6 @@ int hns_roce_dealloc_mw(struct ib_mw *ibmw)
 	struct hns_roce_mw *mw = to_hr_mw(ibmw);
 
 	hns_roce_mw_free(hr_dev, mw);
-	kfree(mw);
-
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 3a5e3c55dbf8..41c419928a00 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2583,6 +2583,8 @@ static const struct ib_device_ops mlx4_ib_dev_wq_ops = {
 static const struct ib_device_ops mlx4_ib_dev_mw_ops = {
 	.alloc_mw = mlx4_ib_alloc_mw,
 	.dealloc_mw = mlx4_ib_dealloc_mw,
+
+	INIT_RDMA_OBJ_SIZE(ib_mw, mlx4_ib_mw, ibmw),
 };
 
 static const struct ib_device_ops mlx4_ib_dev_xrc_ops = {
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 8f5467c2309a..4e304f48157d 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -731,8 +731,7 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
 				  struct ib_udata *udata);
 int mlx4_ib_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
-struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			       struct ib_udata *udata);
+int mlx4_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int mlx4_ib_dealloc_mw(struct ib_mw *mw);
 struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			       u32 max_num_sg);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 1d5ef0de12c9..6533e0835294 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -610,37 +610,27 @@ int mlx4_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	return 0;
 }
 
-struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			       struct ib_udata *udata)
+int mlx4_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
-	struct mlx4_ib_dev *dev = to_mdev(pd->device);
-	struct mlx4_ib_mw *mw;
+	struct mlx4_ib_dev *dev = to_mdev(ibmw->device);
+	struct mlx4_ib_mw *mw = to_mmw(ibmw);
 	int err;
 
-	mw = kmalloc(sizeof(*mw), GFP_KERNEL);
-	if (!mw)
-		return ERR_PTR(-ENOMEM);
-
-	err = mlx4_mw_alloc(dev->dev, to_mpd(pd)->pdn,
-			    to_mlx4_type(type), &mw->mmw);
+	err = mlx4_mw_alloc(dev->dev, to_mpd(ibmw->pd)->pdn,
+			    to_mlx4_type(ibmw->type), &mw->mmw);
 	if (err)
-		goto err_free;
+		return err;
 
 	err = mlx4_mw_enable(dev->dev, &mw->mmw);
 	if (err)
 		goto err_mw;
 
-	mw->ibmw.rkey = mw->mmw.key;
-
-	return &mw->ibmw;
+	ibmw->rkey = mw->mmw.key;
+	return 0;
 
 err_mw:
 	mlx4_mw_free(dev->dev, &mw->mmw);
-
-err_free:
-	kfree(mw);
-
-	return ERR_PTR(err);
+	return err;
 }
 
 int mlx4_ib_dealloc_mw(struct ib_mw *ibmw)
@@ -648,8 +638,6 @@ int mlx4_ib_dealloc_mw(struct ib_mw *ibmw)
 	struct mlx4_ib_mw *mw = to_mmw(ibmw);
 
 	mlx4_mw_free(to_mdev(ibmw->device)->dev, &mw->mmw);
-	kfree(mw);
-
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 790b874fffe2..d197df0280f8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4087,6 +4087,8 @@ static const struct ib_device_ops mlx5_ib_dev_sriov_ops = {
 static const struct ib_device_ops mlx5_ib_dev_mw_ops = {
 	.alloc_mw = mlx5_ib_alloc_mw,
 	.dealloc_mw = mlx5_ib_dealloc_mw,
+
+	INIT_RDMA_OBJ_SIZE(ib_mw, mlx5_ib_mw, ibmw),
 };
 
 static const struct ib_device_ops mlx5_ib_dev_xrc_ops = {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0a3681463a62..67985ddbfcb0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1166,8 +1166,7 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      struct ib_sge *sg_list,
 		      u32 num_sge,
 		      struct uverbs_attr_bundle *attrs);
-struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			       struct ib_udata *udata);
+int mlx5_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int mlx5_ib_dealloc_mw(struct ib_mw *mw);
 int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index fde8fc2b6b5b..a94e344f1a50 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1991,12 +1991,11 @@ struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
 				  max_num_meta_sg);
 }
 
-struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
-			       struct ib_udata *udata)
+int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct mlx5_ib_dev *dev = to_mdev(ibmw->device);
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	struct mlx5_ib_mw *mw = NULL;
+	struct mlx5_ib_mw *mw = to_mmw(ibmw);
 	u32 *in = NULL;
 	void *mkc;
 	int ndescs;
@@ -2009,21 +2008,20 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 
 	err = ib_copy_from_udata(&req, udata, min(udata->inlen, sizeof(req)));
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	if (req.comp_mask || req.reserved1 || req.reserved2)
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	if (udata->inlen > sizeof(req) &&
 	    !ib_is_udata_cleared(udata, sizeof(req),
 				 udata->inlen - sizeof(req)))
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
 
-	mw = kzalloc(sizeof(*mw), GFP_KERNEL);
 	in = kzalloc(inlen, GFP_KERNEL);
-	if (!mw || !in) {
+	if (!in) {
 		err = -ENOMEM;
 		goto free;
 	}
@@ -2032,11 +2030,11 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+	MLX5_SET(mkc, mkc, pd, to_mpd(ibmw->pd)->pdn);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, lr, 1);
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_KLMS);
-	MLX5_SET(mkc, mkc, en_rinval, !!((type == IB_MW_TYPE_2)));
+	MLX5_SET(mkc, mkc, en_rinval, !!((ibmw->type == IB_MW_TYPE_2)));
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 
 	err = mlx5_ib_create_mkey(dev, &mw->mmkey, in, inlen);
@@ -2044,17 +2042,15 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 		goto free;
 
 	mw->mmkey.type = MLX5_MKEY_MW;
-	mw->ibmw.rkey = mw->mmkey.key;
+	ibmw->rkey = mw->mmkey.key;
 	mw->ndescs = ndescs;
 
 	resp.response_length =
 		min(offsetofend(typeof(resp), response_length), udata->outlen);
 	if (resp.response_length) {
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
-		if (err) {
-			mlx5_core_destroy_mkey(dev->mdev, &mw->mmkey);
-			goto free;
-		}
+		if (err)
+			goto free_mkey;
 	}
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
@@ -2066,21 +2062,19 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 	}
 
 	kfree(in);
-	return &mw->ibmw;
+	return 0;
 
 free_mkey:
 	mlx5_core_destroy_mkey(dev->mdev, &mw->mmkey);
 free:
-	kfree(mw);
 	kfree(in);
-	return ERR_PTR(err);
+	return err;
 }
 
 int mlx5_ib_dealloc_mw(struct ib_mw *mw)
 {
 	struct mlx5_ib_dev *dev = to_mdev(mw->device);
 	struct mlx5_ib_mw *mmw = to_mmw(mw);
-	int err;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mmw->mmkey.key));
@@ -2091,11 +2085,7 @@ int mlx5_ib_dealloc_mw(struct ib_mw *mw)
 		synchronize_srcu(&dev->odp_srcu);
 	}
 
-	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
-	if (err)
-		return err;
-	kfree(mmw);
-	return 0;
+	return mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
 }
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a596f1657c44..18e861f38295 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2452,8 +2452,7 @@ struct ib_device_ops {
 			 unsigned int *sg_offset);
 	int (*check_mr_status)(struct ib_mr *mr, u32 check_mask,
 			       struct ib_mr_status *mr_status);
-	struct ib_mw *(*alloc_mw)(struct ib_pd *pd, enum ib_mw_type type,
-				  struct ib_udata *udata);
+	int (*alloc_mw)(struct ib_mw *mw, struct ib_udata *udata);
 	int (*dealloc_mw)(struct ib_mw *mw);
 	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
@@ -2614,6 +2613,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
+	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
-- 
2.26.2

