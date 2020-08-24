Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819724FB90
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgHXKff (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHXKc5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:32:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B552074D;
        Mon, 24 Aug 2020 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265176;
        bh=VQmr4cOyu2KIWhNoWdO6cBRPmsZSb8KfdtCvIuH8WYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7+0OUlRFmHHLiB+Woyy3cWOrL22LI3LimmRJ6T6bbbaAyhS2OMOpu+WYMVzg8ViF
         8aGI//Cknoi0qB3jzmNf3gXO3qN0BRexxLq1iBy9znU0FSAKXcsEdP0uixVd7Nod5Z
         +kIGcFMQuHX1uuMC4/r5v/gVVWumWhhzrejRm28A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD deallocate
Date:   Mon, 24 Aug 2020 13:32:38 +0300
Message-Id: <20200824103247.1088464-2-leon@kernel.org>
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

The IB verbs objects are counted by the kernel and ib_core ensures
that deallocate PD will success so it will be called once all
other objects that depends on PD will be released. This is achieved
by managing various reference counters on such objects.

The mlx5 driver didn't follow this standard flow when allowed DEVX
objects that are not managed by ib_core to be interleaved with the
ones under ib_core responsibility.

In such interleaved scenarios deallocate command can fail and ib_core
will leave uobject in internal DB and attempt to clean it later to
free resources anyway.

This change partially restores returned value from dealloc_pd() for
all drivers, but keeping in mind that non-DEVX devices and kernel verbs
paths shouldn't fail.

Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_std_types.c      |  3 +--
 drivers/infiniband/core/verbs.c                 |  8 ++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  3 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c          |  3 ++-
 drivers/infiniband/hw/efa/efa.h                 |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c           |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c         |  3 ++-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  3 ++-
 drivers/infiniband/hw/mlx4/main.c               |  3 ++-
 drivers/infiniband/hw/mlx5/cmd.c                |  4 ++--
 drivers/infiniband/hw/mlx5/cmd.h                |  2 +-
 drivers/infiniband/hw/mlx5/main.c               |  4 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c    |  3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |  2 +-
 drivers/infiniband/hw/qedr/verbs.c              |  3 ++-
 drivers/infiniband/hw/qedr/verbs.h              |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  3 ++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  5 +++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |  2 +-
 drivers/infiniband/sw/rdmavt/pd.c               |  3 ++-
 drivers/infiniband/sw/rdmavt/pd.h               |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  3 ++-
 drivers/infiniband/sw/siw/siw_verbs.c           |  3 ++-
 drivers/infiniband/sw/siw/siw_verbs.h           |  2 +-
 include/rdma/ib_verbs.h                         | 13 +++++--------
 29 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 08c39cfb1bd9..2932e832f48f 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -122,8 +122,7 @@ static int uverbs_free_pd(struct ib_uobject *uobject,
 	if (ret)
 		return ret;

-	ib_dealloc_pd_user(pd, &attrs->driver_udata);
-	return 0;
+	return ib_dealloc_pd_user(pd, &attrs->driver_udata);
 }

 void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3096e73797b7..688b34bf0268 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -329,7 +329,7 @@ EXPORT_SYMBOL(__ib_alloc_pd);
  * exist.  The caller is responsible to synchronously destroy them and
  * guarantee no new allocations will happen.
  */
-void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
+int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 {
 	int ret;

@@ -343,9 +343,13 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 	   requires the caller to guarantee we can't race here. */
 	WARN_ON(atomic_read(&pd->usecnt));

+	ret = pd->device->ops.dealloc_pd(pd, udata);
+	if (ret && udata)
+		return ret;
+
 	rdma_restrack_del(&pd->res);
-	pd->device->ops.dealloc_pd(pd, udata);
 	kfree(pd);
+	return ret;
 }
 EXPORT_SYMBOL(ib_dealloc_pd_user);

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3f18efc0c297..05abce09b23c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -532,7 +532,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 }

 /* Protection Domains */
-void bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
+int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
@@ -542,6 +542,7 @@ void bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 	if (pd->qplib_pd.id)
 		bnxt_qplib_dealloc_pd(&rdev->qplib_res, &rdev->qplib_res.pd_tbl,
 				      &pd->qplib_pd);
+	return 0;
 }

 int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 1daeb30e06fd..d9e2e406f66a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -163,7 +163,7 @@ int bnxt_re_query_gid(struct ib_device *ibdev, u8 port_num,
 enum rdma_link_layer bnxt_re_get_link_layer(struct ib_device *ibdev,
 					    u8 port_num);
 int bnxt_re_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void bnxt_re_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
+int bnxt_re_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 int bnxt_re_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		      struct ib_udata *udata);
 int bnxt_re_modify_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 6c579d2d3997..5f2b30624512 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -190,7 +190,7 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	return ret;
 }

-static void c4iw_deallocate_pd(struct ib_pd *pd, struct ib_udata *udata)
+static int c4iw_deallocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct c4iw_dev *rhp;
 	struct c4iw_pd *php;
@@ -202,6 +202,7 @@ static void c4iw_deallocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	mutex_lock(&rhp->rdev.stats.lock);
 	rhp->rdev.stats.pd.cur--;
 	mutex_unlock(&rhp->rdev.stats.lock);
+	return 0;
 }

 static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 1889dd172a25..8547f9d543df 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
 int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
 		   u16 *pkey);
 int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
-void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 			    struct ib_qp_init_attr *init_attr,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 3f7f19b9f463..660a69943e02 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return err;
 }

-void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_pd *pd = to_epd(ibpd);

 	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
 	efa_pd_dealloc(dev, pd->pdn);
+	return 0;
 }

 static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index da9888deff8c..e2d544a76bb3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1183,7 +1183,7 @@ int hns_roce_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
 void hns_roce_destroy_ah(struct ib_ah *ah, u32 flags);

 int hns_roce_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
+int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);

 struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index b10c50b8736e..98f69496adb4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -82,9 +82,10 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-void hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	hns_roce_pd_free(to_hr_dev(pd->device), to_hr_pd(pd)->pdn);
+	return 0;
 }

 int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 6957e4f3404b..360b037f90e7 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -328,12 +328,13 @@ static int i40iw_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
  * @ibpd: ptr of pd to be deallocated
  * @udata: user data or null for kernel object
  */
-static void i40iw_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+static int i40iw_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct i40iw_pd *iwpd = to_iwpd(ibpd);
 	struct i40iw_device *iwdev = to_iwdev(ibpd->device);

 	i40iw_rem_pdusecount(iwpd, iwdev);
+	return 0;
 }

 /**
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 2543062c0cb0..1be0108db992 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1214,9 +1214,10 @@ static int mlx4_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-static void mlx4_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+static int mlx4_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	mlx4_pd_free(to_mdev(pd->device)->dev, to_mpd(pd)->pdn);
+	return 0;
 }

 static int mlx4_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index ebb2f108b64f..f5aac53cebf0 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -209,14 +209,14 @@ void mlx5_cmd_dealloc_transport_domain(struct mlx5_core_dev *dev, u32 tdn,
 	mlx5_cmd_exec_in(dev, dealloc_transport_domain, in);
 }

-void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid)
+int mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid)
 {
 	u32 in[MLX5_ST_SZ_DW(dealloc_pd_in)] = {};

 	MLX5_SET(dealloc_pd_in, in, opcode, MLX5_CMD_OP_DEALLOC_PD);
 	MLX5_SET(dealloc_pd_in, in, pd, pdn);
 	MLX5_SET(dealloc_pd_in, in, uid, uid);
-	mlx5_cmd_exec_in(dev, dealloc_pd, in);
+	return mlx5_cmd_exec_in(dev, dealloc_pd, in);
 }

 int mlx5_cmd_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 1d192a8ca87d..ca3afa7d73a3 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -44,7 +44,7 @@ int mlx5_cmd_query_cong_params(struct mlx5_core_dev *dev, int cong_point,
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
 void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
-void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
+int mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
 void mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fbc45a5e76c5..4960e3b31c94 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2569,12 +2569,12 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-static void mlx5_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+static int mlx5_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *mdev = to_mdev(pd->device);
 	struct mlx5_ib_pd *mpd = to_mpd(pd);

-	mlx5_cmd_dealloc_pd(mdev->mdev, mpd->pdn, mpd->uid);
+	return mlx5_cmd_dealloc_pd(mdev->mdev, mpd->pdn, mpd->uid);
 }

 static int mlx5_ib_mcg_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 9fa2f9164a47..d3ed7c19b2ef 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -373,9 +373,10 @@ static int mthca_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-static void mthca_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+static int mthca_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	mthca_pd_free(to_mdev(pd->device), to_mpd(pd));
+	return 0;
 }

 static int mthca_ah_create(struct ib_ah *ibah,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 6cdbec13756a..4b9295c8d4f3 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -664,7 +664,7 @@ int ocrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return status;
 }

-void ocrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+int ocrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct ocrdma_pd *pd = get_ocrdma_pd(ibpd);
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibpd->device);
@@ -682,10 +682,11 @@ void ocrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)

 		if (is_ucontext_pd(uctx, pd)) {
 			ocrdma_release_ucontext_pd(uctx);
-			return;
+			return 0;
 		}
 	}
 	_ocrdma_dealloc_pd(dev, pd);
+	return 0;
 }

 static int ocrdma_alloc_lkey(struct ocrdma_dev *dev, struct ocrdma_mr *mr,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index df8e3b923a44..4c85be43507c 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -67,7 +67,7 @@ void ocrdma_dealloc_ucontext(struct ib_ucontext *uctx);
 int ocrdma_mmap(struct ib_ucontext *, struct vm_area_struct *vma);

 int ocrdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void ocrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
+int ocrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);

 int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 4ce4e2eef6cc..93ee1740a2d2 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -471,13 +471,14 @@ int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-void qedr_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+int qedr_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct qedr_dev *dev = get_qedr_dev(ibpd->device);
 	struct qedr_pd *pd = get_qedr_pd(ibpd);

 	DP_DEBUG(dev, QEDR_MSG_INIT, "Deallocating PD %d\n", pd->pd_id);
 	dev->ops->rdma_dealloc_pd(dev->rdma_ctx, pd->pd_id);
+	return 0;
 }

 static void qedr_free_pbl(struct qedr_dev *dev,
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 39dd6286ba39..1b450919ba9c 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -47,7 +47,7 @@ void qedr_dealloc_ucontext(struct ib_ucontext *uctx);
 int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
 void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
+int qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);

 int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index b8a77ce11590..17fc3af138f1 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -460,9 +460,10 @@ int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }

-void usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+int usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	usnic_uiom_dealloc_pd((to_upd(pd))->umem_pd);
+	return 0;
 }

 struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 2aedf78c13cf..7d9c75a66905 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -51,7 +51,7 @@ int usnic_ib_query_gid(struct ib_device *ibdev, u8 port, int index,
 int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
 				u16 *pkey);
 int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
-void usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
+int usnic_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
 					struct ib_qp_init_attr *init_attr,
 					struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index ccbded2d26ce..06f5e753c821 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -479,9 +479,9 @@ int pvrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
  * @pd: the protection domain to be released
  * @udata: user data or null for kernel object
  *
- * @return: 0 on success, otherwise errno.
+ * @return: Always 0
  */
-void pvrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+int pvrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct pvrdma_dev *dev = to_vdev(pd->device);
 	union pvrdma_cmd_req req = {};
@@ -498,6 +498,7 @@ void pvrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 			 ret);

 	atomic_dec(&dev->num_pds);
+	return 0;
 }

 /**
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 699b20849a7e..7bf33a654275 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -399,7 +399,7 @@ int pvrdma_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
 void pvrdma_dealloc_ucontext(struct ib_ucontext *context);
 int pvrdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void pvrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int pvrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 struct ib_mr *pvrdma_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				 u64 virt_addr, int access_flags,
diff --git a/drivers/infiniband/sw/rdmavt/pd.c b/drivers/infiniband/sw/rdmavt/pd.c
index a403718f0b5e..01b7abf91520 100644
--- a/drivers/infiniband/sw/rdmavt/pd.c
+++ b/drivers/infiniband/sw/rdmavt/pd.c
@@ -95,11 +95,12 @@ int rvt_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
  *
  * Return: always 0
  */
-void rvt_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+int rvt_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rvt_dev_info *dev = ib_to_rvt(ibpd->device);

 	spin_lock(&dev->n_pds_lock);
 	dev->n_pds_allocated--;
 	spin_unlock(&dev->n_pds_lock);
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rdmavt/pd.h b/drivers/infiniband/sw/rdmavt/pd.h
index 71ba76d72b1d..06a6a38beedc 100644
--- a/drivers/infiniband/sw/rdmavt/pd.h
+++ b/drivers/infiniband/sw/rdmavt/pd.h
@@ -51,6 +51,6 @@
 #include <rdma/rdma_vt.h>

 int rvt_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-void rvt_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int rvt_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);

 #endif          /* DEF_RDMAVTPD_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bb61e534e468..d23bc6aa30e2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -175,11 +175,12 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return rxe_add_to_pool(&rxe->pd_pool, &pd->pelem);
 }

-static void rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);

 	rxe_drop_ref(pd);
+	return 0;
 }

 static int rxe_create_ah(struct ib_ah *ibah,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index adafa1b8bebe..2d2b6df0b027 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -234,12 +234,13 @@ int siw_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	return 0;
 }

-void siw_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
+int siw_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct siw_device *sdev = to_siw_dev(pd->device);

 	siw_dbg_pd(pd, "free PD\n");
 	atomic_dec(&sdev->num_pd);
+	return 0;
 }

 void siw_qp_get_ref(struct ib_qp *base_qp)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index d9572275a6b6..3dbab78579cb 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -49,7 +49,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 int siw_query_gid(struct ib_device *base_dev, u8 port, int idx,
 		  union ib_gid *gid);
 int siw_alloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
-void siw_dealloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
+int siw_dealloc_pd(struct ib_pd *base_pd, struct ib_udata *udata);
 struct ib_qp *siw_create_qp(struct ib_pd *base_pd,
 			    struct ib_qp_init_attr *attr,
 			    struct ib_udata *udata);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 969561f6e70e..98e9ea1f693b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2404,7 +2404,7 @@ struct ib_device_ops {
 	void (*mmap_free)(struct rdma_user_mmap_entry *entry);
 	void (*disassociate_ucontext)(struct ib_ucontext *ibcontext);
 	int (*alloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
-	void (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
+	int (*dealloc_pd)(struct ib_pd *pd, struct ib_udata *udata);
 	int (*create_ah)(struct ib_ah *ah, struct rdma_ah_init_attr *attr,
 			 struct ib_udata *udata);
 	int (*modify_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
@@ -3462,12 +3462,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 #define ib_alloc_pd(device, flags) \
 	__ib_alloc_pd((device), (flags), KBUILD_MODNAME)

-/**
- * ib_dealloc_pd_user - Deallocate kernel/user PD
- * @pd: The protection domain
- * @udata: Valid user data or NULL for kernel objects
- */
-void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata);
+int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata);

 /**
  * ib_dealloc_pd - Deallocate kernel PD
@@ -3477,7 +3472,9 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata);
  */
 static inline void ib_dealloc_pd(struct ib_pd *pd)
 {
-	ib_dealloc_pd_user(pd, NULL);
+	int ret = ib_dealloc_pd_user(pd, NULL);
+
+	WARN_ONCE(ret, "Destroy of kernel PD shouldn't fail");
 }

 enum rdma_create_ah_flags {
--
2.26.2

