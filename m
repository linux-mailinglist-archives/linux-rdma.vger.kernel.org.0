Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCB20DE28
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgF2UXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 16:23:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:36333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbgF2TZc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:32 -0400
IronPort-SDR: LD2A947e8MghjUeEumj5mM+ArQMiF6dY1oTmFETZcOdhV4fK03Hw+GZlxORR4NJNGMAc/ofDF9
 IKKsKDdmjt+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143489488"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="143489488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:20:05 -0700
IronPort-SDR: MBlkIlNDTfEi/f/wmRR+fwI29f2jHi2lT8twdxGyB4HdjV5HsSbwFWwrLL7Zb670BUtksOddwF
 vXo+X/VlxkpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="320698720"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 10:20:04 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v2 2/3] RDMA/core: Expand the driver method 'reg_user_mr' to support dma-buf
Date:   Mon, 29 Jun 2020 10:31:42 -0700
Message-Id: <1593451903-30959-3-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a parameter 'fd' for the file descriptor associated with the dma-buf
object to be imported. A negative value indicates that dma-buf is not
used.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/core/uverbs_cmd.c            |  2 +-
 drivers/infiniband/core/verbs.c                 |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  7 +++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |  3 +-
 drivers/infiniband/hw/cxgb4/mem.c               |  8 ++++-
 drivers/infiniband/hw/efa/efa.h                 |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c           |  7 +++-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c         |  7 +++-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  6 ++++
 drivers/infiniband/hw/mlx4/mlx4_ib.h            |  2 +-
 drivers/infiniband/hw/mlx4/mr.c                 |  7 +++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |  2 +-
 drivers/infiniband/hw/mlx5/mr.c                 | 45 ++++++++++++++++++++++---
 drivers/infiniband/hw/mthca/mthca_provider.c    |  8 ++++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  9 ++++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |  3 +-
 drivers/infiniband/hw/qedr/verbs.c              |  8 ++++-
 drivers/infiniband/hw/qedr/verbs.h              |  3 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  8 ++++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    |  6 +++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c               |  6 +++-
 drivers/infiniband/sw/rdmavt/mr.h               |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  6 ++++
 drivers/infiniband/sw/siw/siw_verbs.c           |  8 ++++-
 drivers/infiniband/sw/siw/siw_verbs.h           |  3 +-
 include/rdma/ib_verbs.h                         |  4 +--
 30 files changed, 150 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 060b4eb..0199da2 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -757,7 +757,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
-					 cmd.access_flags,
+					 -1, cmd.access_flags,
 					 &attrs->driver_udata);
 	if (IS_ERR(mr)) {
 		ret = PTR_ERR(mr);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 56a7133..aa067b2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2003,7 +2003,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	}
 
 	mr = pd->device->ops.reg_user_mr(pd, start, length, virt_addr,
-					 access_flags, NULL);
+					 -1, access_flags, NULL);
 
 	if (IS_ERR(mr))
 		return mr;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 95f6d49..af40457 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3695,7 +3695,7 @@ static int fill_umem_pbl_tbl(struct ib_umem *umem, u64 *pbl_tbl_orig,
 
 /* uverbs */
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
-				  u64 virt_addr, int mr_access_flags,
+				  u64 virt_addr, int fd, int mr_access_flags,
 				  struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
@@ -3728,6 +3728,11 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	/* The fixed portion of the rkey is the same as the lkey */
 	mr->ib_mr.rkey = mr->qplib_mr.rkey;
 
+	if (fd >= 0) {
+		rc = -EOPNOTSUPP;
+		goto free_mrw;
+	}
+
 	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
 	if (IS_ERR(umem)) {
 		ibdev_err(&rdev->ibdev, "Failed to get umem");
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 23d972d..040e85e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -203,7 +203,7 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 			       struct ib_udata *udata);
 int bnxt_re_dealloc_mw(struct ib_mw *mw);
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int mr_access_flags,
+				  u64 virt_addr, int fd, int mr_access_flags,
 				  struct ib_udata *udata);
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index e8e11bd..e374f89 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -988,7 +988,8 @@ int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 			    struct ib_udata *udata);
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
-					   u64 length, u64 virt, int acc,
+					   u64 length, u64 virt,
+					   int fd, int acc,
 					   struct ib_udata *udata);
 struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc);
 int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 962dc97..b0b912a 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -506,7 +506,8 @@ struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc)
 }
 
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-			       u64 virt, int acc, struct ib_udata *udata)
+			       u64 virt, int fd, int acc,
+			       struct ib_udata *udata)
 {
 	__be64 *pages;
 	int shift, n, i;
@@ -543,6 +544,11 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	mhp->rhp = rhp;
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err_free_skb;
+	}
+
 	mhp->umem = ib_umem_get(pd->device, start, length, acc);
 	if (IS_ERR(mhp->umem))
 		goto err_free_skb;
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index aa7396a..21872a3 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -142,7 +142,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct ib_udata *udata);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
-			 u64 virt_addr, int access_flags,
+			 u64 virt_addr, int fd, int access_flags,
 			 struct ib_udata *udata);
 int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 int efa_get_port_immutable(struct ib_device *ibdev, u8 port_num,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index bf3120f..1362694 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1346,7 +1346,7 @@ static int efa_create_pbl(struct efa_dev *dev,
 }
 
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
-			 u64 virt_addr, int access_flags,
+			 u64 virt_addr, int fd, int access_flags,
 			 struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
@@ -1386,6 +1386,11 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_out;
 	}
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err_free;
+	}
+
 	mr->umem = ib_umem_get(ibpd->device, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d7dcf6e..c2b94c6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1185,7 +1185,7 @@ int hns_roce_create_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr,
 
 struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				   u64 virt_addr, int access_flags,
+				   u64 virt_addr, int fd, int access_flags,
 				   struct ib_udata *udata);
 int hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start, u64 length,
 			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b9898e7..24dd79a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1130,7 +1130,7 @@ static int hns_roce_ib_umem_write_mr(struct hns_roce_dev *hr_dev,
 }
 
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				   u64 virt_addr, int access_flags,
+				   u64 virt_addr, int fd, int access_flags,
 				   struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
@@ -1145,6 +1145,11 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (fd >= 0) {
+		ret = ERR_PTR(-EOPNOTSUPP);
+		goto err_free;
+	}
+
 	mr->umem = ib_umem_get(pd->device, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		ret = PTR_ERR(mr->umem);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index fa12929..d86bf12 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1727,6 +1727,7 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
  * @start: virtual start address
  * @length: length of mr
  * @virt: virtual address
+ * @fd: file descriptor (for dma-buf)
  * @acc: access of mr
  * @udata: user data
  */
@@ -1734,6 +1735,7 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd *pd,
 				       u64 start,
 				       u64 length,
 				       u64 virt,
+				       int fd,
 				       int acc,
 				       struct ib_udata *udata)
 {
@@ -1764,6 +1766,10 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd *pd,
 
 	if (length > I40IW_MAX_MR_SIZE)
 		return ERR_PTR(-EINVAL);
+
+	if (fd >= 0)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	region = ib_umem_get(pd->device, start, length, acc);
 	if (IS_ERR(region))
 		return (struct ib_mr *)region;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index d188573..d9db34b 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -732,7 +732,7 @@ int mlx4_ib_db_map_user(struct ib_udata *udata, unsigned long virt,
 int mlx4_ib_umem_write_mtt(struct mlx4_ib_dev *dev, struct mlx4_mtt *mtt,
 			   struct ib_umem *umem);
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
+				  u64 virt_addr, int fd, int access_flags,
 				  struct ib_udata *udata);
 int mlx4_ib_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index b0121c9..db45abb 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -402,7 +402,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
 }
 
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
+				  u64 virt_addr, int fd, int access_flags,
 				  struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(pd->device);
@@ -415,6 +415,11 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err_free;
+	}
+
 	mr->umem = mlx4_get_umem_mr(pd->device, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2e42258..5df9f0e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1189,7 +1189,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
+				  u64 virt_addr, int fd, int access_flags,
 				  struct ib_udata *udata);
 int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      enum ib_uverbs_advise_mr_advice advice,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6fa0a83..bd06e35 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -797,6 +797,39 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
 	return 0;
 }
 
+static int mr_umem_dmabuf_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
+			      int dmabuf_fd, int access_flags,
+			      struct ib_umem **umem, int *npages,
+			      int *page_shift, int *ncont, int *order)
+{
+	struct ib_umem *u;
+
+	*umem = NULL;
+
+	u = ib_umem_dmabuf_get(&dev->ib_dev, start, length, dmabuf_fd,
+			       access_flags);
+	if (IS_ERR(u)) {
+		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
+		return PTR_ERR(u);
+	}
+
+	mlx5_ib_cont_pages(u, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
+			   page_shift, ncont, order);
+
+	if (!*npages) {
+		mlx5_ib_warn(dev, "avoid zero region\n");
+		ib_umem_release(u);
+		return -EINVAL;
+	}
+
+	*umem = u;
+
+	mlx5_ib_dbg(dev, "npages %d, ncont %d, order %d, page_shift %d\n",
+		    *npages, *ncont, *order, *page_shift);
+
+	return 0;
+}
+
 static void mlx5_ib_umr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct mlx5_ib_umr_context *context =
@@ -1228,7 +1261,7 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 }
 
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
+				  u64 virt_addr, int fd, int access_flags,
 				  struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -1261,9 +1294,13 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return &mr->ibmr;
 	}
 
-	err = mr_umem_get(dev, start, length, access_flags, &umem,
-			  &npages, &page_shift, &ncont, &order);
-
+	if (fd < 0)
+		err = mr_umem_get(dev, start, length, access_flags, &umem,
+				  &npages, &page_shift, &ncont, &order);
+	else
+		err = mr_umem_dmabuf_get(dev, start, length, fd, access_flags,
+					 &umem, &npages, &page_shift, &ncont,
+					 &order);
 	if (err < 0)
 		return ERR_PTR(err);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 69a3e4f..f1f93af 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -852,7 +852,8 @@ static struct ib_mr *mthca_get_dma_mr(struct ib_pd *pd, int acc)
 }
 
 static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				       u64 virt, int acc, struct ib_udata *udata)
+				       u64 virt, int fd, int acc,
+				       struct ib_udata *udata)
 {
 	struct mthca_dev *dev = to_mdev(pd->device);
 	struct sg_dma_page_iter sg_iter;
@@ -880,6 +881,11 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
 	mr->umem = ib_umem_get(pd->device, start, length, acc);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 10e3438..2c25244 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -853,7 +853,8 @@ static void build_user_pbes(struct ocrdma_dev *dev, struct ocrdma_mr *mr,
 }
 
 struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				 u64 usr_addr, int acc, struct ib_udata *udata)
+				 u64 usr_addr, int fd, int acc,
+				 struct ib_udata *udata)
 {
 	int status = -ENOMEM;
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibpd->device);
@@ -869,6 +870,12 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(status);
+
+	if (fd >= 0) {
+		status = -EOPNOTSUPP;
+		goto umem_err;
+	}
+
 	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		status = -EFAULT;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 3a50108..bc3660e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -99,7 +99,8 @@ int ocrdma_post_srq_recv(struct ib_srq *, const struct ib_recv_wr *,
 int ocrdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 struct ib_mr *ocrdma_get_dma_mr(struct ib_pd *, int acc);
 struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *, u64 start, u64 length,
-				 u64 virt, int acc, struct ib_udata *);
+				 u64 virt, int fd, int acc,
+				 struct ib_udata *);
 struct ib_mr *ocrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			      u32 max_num_sg, struct ib_udata *udata);
 int ocrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index a5bd3ad..95e865c 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2828,7 +2828,8 @@ static int init_mr_info(struct qedr_dev *dev, struct mr_info *info,
 }
 
 struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-			       u64 usr_addr, int acc, struct ib_udata *udata)
+			       u64 usr_addr, int fd, int acc,
+			       struct ib_udata *udata)
 {
 	struct qedr_dev *dev = get_qedr_dev(ibpd->device);
 	struct qedr_mr *mr;
@@ -2849,6 +2850,11 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	mr->type = QEDR_MR_USER;
 
+	if (fd >= 0) {
+		rc = -EOPNOTSUPP;
+		goto err0;
+	}
+
 	mr->umem = ib_umem_get(ibpd->device, start, len, acc);
 	if (IS_ERR(mr->umem)) {
 		rc = -EFAULT;
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 1802784..78effd1 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -78,7 +78,8 @@ int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr, u32 flags,
 struct ib_mr *qedr_get_dma_mr(struct ib_pd *, int acc);
 
 struct ib_mr *qedr_reg_user_mr(struct ib_pd *, u64 start, u64 length,
-			       u64 virt, int acc, struct ib_udata *);
+			       u64 virt, int fd, int acc,
+			       struct ib_udata *);
 
 int qedr_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		   int sg_nents, unsigned int *sg_offset);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 71f8233..58ed9d1 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -603,7 +603,8 @@ void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 }
 
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
-					u64 virt_addr, int access_flags,
+					u64 virt_addr, int fd,
+					int access_flags,
 					struct ib_udata *udata)
 {
 	struct usnic_ib_mr *mr;
@@ -616,6 +617,11 @@ struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err_free;
+	}
+
 	mr->umem = usnic_uiom_reg_get(to_upd(pd)->umem_pd, start, length,
 					access_flags, 0);
 	if (IS_ERR_OR_NULL(mr->umem)) {
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 2aedf78..42ba8b7 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -62,7 +62,7 @@ int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		       struct ib_udata *udata);
 void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
-				u64 virt_addr, int access_flags,
+				u64 virt_addr, int fd, int access_flags,
 				struct ib_udata *udata);
 int usnic_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 int usnic_ib_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index b039f1f..8b8b10c 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -103,13 +103,14 @@ struct ib_mr *pvrdma_get_dma_mr(struct ib_pd *pd, int acc)
  * @start: starting address
  * @length: length of region
  * @virt_addr: I/O virtual address
+ * @fd: file descriptor (for dma-buf)
  * @access_flags: access flags for memory region
  * @udata: user data
  *
  * @return: ib_mr pointer on success, otherwise returns an errno.
  */
 struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				 u64 virt_addr, int access_flags,
+				 u64 virt_addr, int fd, int access_flags,
 				 struct ib_udata *udata)
 {
 	struct pvrdma_dev *dev = to_vdev(pd->device);
@@ -126,6 +127,9 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (fd >= 0)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	umem = ib_umem_get(pd->device, start, length, access_flags);
 	if (IS_ERR(umem)) {
 		dev_warn(&dev->pdev->dev,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index e4a48f5..7bee943 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -402,7 +402,7 @@ int pvrdma_modify_port(struct ib_device *ibdev, u8 port,
 void pvrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 struct ib_mr *pvrdma_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				 u64 virt_addr, int access_flags,
+				 u64 virt_addr, int fd, int access_flags,
 				 struct ib_udata *udata);
 int pvrdma_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 72f6534..cbd54de 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -372,13 +372,14 @@ struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc)
  * @pd: protection domain for this memory region
  * @start: starting userspace address
  * @length: length of region to register
+ * @fd: file descriptor (for dma-buf)
  * @mr_access_flags: access flags for this memory region
  * @udata: unused by the driver
  *
  * Return: the memory region on success, otherwise returns an errno.
  */
 struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-			      u64 virt_addr, int mr_access_flags,
+			      u64 virt_addr, int fd, int mr_access_flags,
 			      struct ib_udata *udata)
 {
 	struct rvt_mr *mr;
@@ -390,6 +391,9 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (length == 0)
 		return ERR_PTR(-EINVAL);
 
+	if (fd >= 0)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	umem = ib_umem_get(pd->device, start, length, mr_access_flags);
 	if (IS_ERR(umem))
 		return (void *)umem;
diff --git a/drivers/infiniband/sw/rdmavt/mr.h b/drivers/infiniband/sw/rdmavt/mr.h
index 2c8d075..9d38d7d 100644
--- a/drivers/infiniband/sw/rdmavt/mr.h
+++ b/drivers/infiniband/sw/rdmavt/mr.h
@@ -76,7 +76,7 @@ static inline struct rvt_mr *to_imr(struct ib_mr *ibmr)
 /* Mem Regions */
 struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-			      u64 virt_addr, int mr_access_flags,
+			      u64 virt_addr, int fd, int mr_access_flags,
 			      struct ib_udata *udata);
 int rvt_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9dd4bd7..f5f4cbe 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -930,6 +930,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 				     u64 start,
 				     u64 length,
 				     u64 iova,
+				     int fd,
 				     int access, struct ib_udata *udata)
 {
 	int err;
@@ -947,6 +948,11 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_ref(pd);
 
+	if (fd >= 0) {
+		err = -EOPNOTSUPP;
+		goto err3;
+	}
+
 	err = rxe_mem_init_user(pd, start, length, iova,
 				access, udata, mr);
 	if (err)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index aeb842b..e88c077 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1275,11 +1275,13 @@ int siw_dereg_mr(struct ib_mr *base_mr, struct ib_udata *udata)
  * @start:	starting address of MR (virtual address)
  * @len:	len of MR
  * @rnic_va:	not used by siw
+ * @fd:		file descriptor (for dma-buf)
  * @rights:	MR access rights
  * @udata:	user buffer to communicate STag and Key.
  */
 struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
-			      u64 rnic_va, int rights, struct ib_udata *udata)
+			      u64 rnic_va, int fd, int rights,
+			      struct ib_udata *udata)
 {
 	struct siw_mr *mr = NULL;
 	struct siw_umem *umem = NULL;
@@ -1315,6 +1317,10 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			goto err_out;
 		}
 	}
+	if (fd >= 0) {
+		rv = -EOPNOTSPP;
+		goto err_out;
+	}
 	umem = siw_umem_get(start, len, ib_access_writable(rights));
 	if (IS_ERR(umem)) {
 		rv = PTR_ERR(umem);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 1a73198..e08bf51 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -67,7 +67,8 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 int siw_poll_cq(struct ib_cq *base_cq, int num_entries, struct ib_wc *wc);
 int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags);
 struct ib_mr *siw_reg_user_mr(struct ib_pd *base_pd, u64 start, u64 len,
-			      u64 rnic_va, int rights, struct ib_udata *udata);
+			      u64 rnic_va, int fd, int rights,
+			      struct ib_udata *udata);
 struct ib_mr *siw_alloc_mr(struct ib_pd *base_pd, enum ib_mr_type mr_type,
 			   u32 max_sge, struct ib_udata *udata);
 struct ib_mr *siw_get_dma_mr(struct ib_pd *base_pd, int rights);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bbc5cfb..12a45a7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
  * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
- * Copyright (c) 2004 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2004, 2020 Intel Corporation.  All rights reserved.
  * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
  * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
  * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
@@ -2431,7 +2431,7 @@ struct ib_device_ops {
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
 	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
-				     u64 virt_addr, int mr_access_flags,
+				     u64 virt_addr, int fd, int mr_access_flags,
 				     struct ib_udata *udata);
 	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
 			     u64 virt_addr, int mr_access_flags,
-- 
1.8.3.1

