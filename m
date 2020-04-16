Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0730E1ACE31
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbgDPQ5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 12:57:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:39706 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390274AbgDPQ5m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 12:57:42 -0400
IronPort-SDR: Go6C5bNrm2qBOQhhp9pexrtN1s0TtN28m9kLhBDKdli+FgiM0xerxy7E21Iw5dsRlbaK/Mq1wo
 6ZcfFDrelwAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:57:39 -0700
IronPort-SDR: qRH3Qf0t9pC9I55x662QydQOFMF/BG+xOWqsNr7naKiFj6eZCSCozvwvidq1SZBM4DUFaJNuuO
 skmXEKW5WYeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="364053040"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 09:57:38 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [RFC PATCH 3/3] RDMA/mlx5: Support new uverbs commands for registering fd-based MR
Date:   Thu, 16 Apr 2020 10:09:33 -0700
Message-Id: <1587056973-101760-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the new 'reg_user_mr_fd' and 'rereg_user_mr_fd' functions of
'struct ib_device_ops' for the mlx5 RDMA driver. This serves as an
example on how vendor RDMA drivers can be updated to support the new
uverbs commands.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  6 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  7 +++
 drivers/infiniband/hw/mlx5/mr.c      | 85 +++++++++++++++++++++++++++++++-----
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9c3993c..88d4c31 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6483,8 +6483,10 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 	.query_srq = mlx5_ib_query_srq,
 	.read_counters = mlx5_ib_read_counters,
 	.reg_user_mr = mlx5_ib_reg_user_mr,
+	.reg_user_mr_fd = mlx5_ib_reg_user_mr_fd,
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
+	.rereg_user_mr_fd = mlx5_ib_rereg_user_mr_fd,
 	.resize_cq = mlx5_ib_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
@@ -6588,7 +6590,9 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_CREATE_XSRQ)		|
-		(1ull << IB_USER_VERBS_CMD_OPEN_QP);
+		(1ull << IB_USER_VERBS_CMD_OPEN_QP)		|
+		(1ull << IB_USER_VERBS_CMD_REG_MR_FD)		|
+		(1ull << IB_USER_VERBS_CMD_REREG_MR_FD);
 	dev->ib_dev.uverbs_ex_cmd_mask =
 		(1ull << IB_USER_VERBS_EX_CMD_QUERY_DEVICE)	|
 		(1ull << IB_USER_VERBS_EX_CMD_CREATE_CQ)	|
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2e42258..3b7076a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1191,6 +1191,9 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
 				  struct ib_udata *udata);
+struct ib_mr *mlx5_ib_reg_user_mr_fd(struct ib_pd *pd, u64 start, u64 length,
+				     u64 virt_addr, int fd_type, int fd,
+				     int access_flags, struct ib_udata *udata);
 int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      enum ib_uverbs_advise_mr_advice advice,
 		      u32 flags,
@@ -1210,6 +1213,10 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			  u64 length, u64 virt_addr, int access_flags,
 			  struct ib_pd *pd, struct ib_udata *udata);
+int mlx5_ib_rereg_user_mr_fd(struct ib_mr *ib_mr, int flags, u64 start,
+			     u64 length, u64 virt_addr, int fd_type, int fd,
+			     int access_flags, struct ib_pd *pd,
+			     struct ib_udata *udata);
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			       u32 max_num_sg, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6fa0a83..a04fd30 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
+#include <rdma/ib_umem_dmabuf.h>
 #include <rdma/ib_verbs.h>
 #include "mlx5_ib.h"
 
@@ -797,6 +798,39 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
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
@@ -1227,9 +1261,9 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				 attr->access_flags, mode);
 }
 
-struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
-				  struct ib_udata *udata)
+struct ib_mr *mlx5_ib_reg_user_mr_fd(struct ib_pd *pd, u64 start, u64 length,
+				     u64 virt_addr, int fd_type, int fd,
+				     int access_flags, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
@@ -1261,8 +1295,13 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return &mr->ibmr;
 	}
 
-	err = mr_umem_get(dev, start, length, access_flags, &umem,
-			  &npages, &page_shift, &ncont, &order);
+	if (fd_type == IB_UMEM_FD_TYPE_DMABUF)
+		err = mr_umem_dmabuf_get(dev, start, length, fd, access_flags,
+					 &umem, &npages, &page_shift, &ncont,
+					 &order);
+	else
+		err = mr_umem_get(dev, start, length, access_flags, &umem,
+				  &npages, &page_shift, &ncont, &order);
 
 	if (err < 0)
 		return ERR_PTR(err);
@@ -1335,6 +1374,15 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
+				  u64 virt_addr, int access_flags,
+				  struct ib_udata *udata)
+{
+	return mlx5_ib_reg_user_mr_fd(pd, start, length, virt_addr,
+				      IB_UMEM_FD_TYPE_NONE, 0, access_flags,
+				      udata);
+}
+
 /**
  * mlx5_mr_cache_invalidate - Fence all DMA on the MR
  * @mr: The MR to fence
@@ -1383,9 +1431,10 @@ static int rereg_umr(struct ib_pd *pd, struct mlx5_ib_mr *mr,
 	return err;
 }
 
-int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
-			  u64 length, u64 virt_addr, int new_access_flags,
-			  struct ib_pd *new_pd, struct ib_udata *udata)
+int mlx5_ib_rereg_user_mr_fd(struct ib_mr *ib_mr, int flags, u64 start,
+			     u64 length, u64 virt_addr, int fd_type, int fd,
+			     int new_access_flags, struct ib_pd *new_pd,
+			     struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ib_mr->device);
 	struct mlx5_ib_mr *mr = to_mmr(ib_mr);
@@ -1428,8 +1477,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		flags |= IB_MR_REREG_TRANS;
 		ib_umem_release(mr->umem);
 		mr->umem = NULL;
-		err = mr_umem_get(dev, addr, len, access_flags, &mr->umem,
-				  &npages, &page_shift, &ncont, &order);
+		if (fd_type == IB_UMEM_FD_TYPE_DMABUF)
+			err = mr_umem_dmabuf_get(dev, addr, len, fd,
+						 access_flags, &mr->umem,
+						 &npages, &page_shift,
+						 &ncont, &order);
+		else
+			err = mr_umem_get(dev, addr, len, access_flags,
+					  &mr->umem, &npages, &page_shift,
+					  &ncont, &order);
 		if (err)
 			goto err;
 	}
@@ -1494,6 +1550,15 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	return err;
 }
 
+int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
+			  u64 length, u64 virt_addr, int new_access_flags,
+			  struct ib_pd *new_pd, struct ib_udata *udata)
+{
+	return mlx5_ib_rereg_user_mr_fd(ib_mr, flags, start, length, virt_addr,
+					IB_UMEM_FD_TYPE_NONE, 0,
+					new_access_flags, new_pd, udata);
+}
+
 static int
 mlx5_alloc_priv_descs(struct ib_device *device,
 		      struct mlx5_ib_mr *mr,
-- 
1.8.3.1

