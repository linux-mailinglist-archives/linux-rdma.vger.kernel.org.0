Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8B24FB88
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHXKdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHXKdY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:33:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0DE20FC3;
        Mon, 24 Aug 2020 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265202;
        bh=OOkUFGicFQsn1GXM+aPitzDKsJUu0dv7ca810/US8U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKN2dXmR8KdnS1aV2odnf+m9TESAr6RBWc7P+uGYM/x07yrAxJv1gxKlQEihqp+wq
         DrwJsUwGEzgQecRG6M0/PCMRCc/sDYA43GYdCVTAOi9kWZEJDqb4VS0idQgq6n+LL4
         xMnDttnguZ9XqIFmbvwSGFOrUDQv4ow4Odb9Ae18=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH rdma-next 05/10] RDMA: Restore ability to fail on SRQ destroy
Date:   Mon, 24 Aug 2020 13:32:42 +0300
Message-Id: <20200824103247.1088464-6-leon@kernel.org>
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

In similar way to other IB objects, restore ability to return
error on SRQ destroy. Strictly saying, this change is not necessary,
and provided here to ensure symmetrical interface to be like any other
destroy command.

Fixes: 68e326dea1db ("RDMA: Handle SRQ allocations by IB/core")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c               |  8 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  3 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/cxgb4/qp.c              |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  3 ++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/srq.c              |  3 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/srq.c              | 26 +++++++++----------
 drivers/infiniband/hw/mlx5/srq.h              |  2 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c          |  7 ++---
 drivers/infiniband/hw/mthca/mthca_provider.c  |  3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            |  3 ++-
 drivers/infiniband/hw/qedr/verbs.h            |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  3 ++-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 +-
 drivers/infiniband/sw/rdmavt/srq.c            |  3 ++-
 drivers/infiniband/sw/rdmavt/srq.h            |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 ++-
 drivers/infiniband/sw/siw/siw_verbs.c         |  3 ++-
 drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       |  6 +----
 include/rdma/ib_verbs.h                       |  8 +++---
 27 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5b4ad90ef6e6..8ce6fc14677a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1068,10 +1068,14 @@ EXPORT_SYMBOL(ib_query_srq);
 
 int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 {
+	int ret;
+
 	if (atomic_read(&srq->usecnt))
 		return -EBUSY;
 
-	srq->device->ops.destroy_srq(srq, udata);
+	ret = srq->device->ops.destroy_srq(srq, udata);
+	if (ret && udata)
+		return ret;
 
 	atomic_dec(&srq->pd->usecnt);
 	if (srq->srq_type == IB_SRQT_XRC)
@@ -1080,7 +1084,7 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 		atomic_dec(&srq->ext.cq->usecnt);
 	kfree(srq);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(ib_destroy_srq_user);
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e950a0792518..13460fd31c8d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1570,7 +1570,7 @@ static enum ib_mtu __to_ib_mtu(u32 mtu)
 }
 
 /* Shared Receive Queues */
-void bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
+int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 {
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
 					       ib_srq);
@@ -1585,6 +1585,7 @@ void bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	atomic_dec(&rdev->srq_count);
 	if (nq)
 		nq->budget--;
+	return 0;
 }
 
 static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b6b56a92b78e..7ca232809466 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -176,7 +176,7 @@ int bnxt_re_modify_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr,
 		       enum ib_srq_attr_mask srq_attr_mask,
 		       struct ib_udata *udata);
 int bnxt_re_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
-void bnxt_re_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
+int bnxt_re_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
 int bnxt_re_post_srq_recv(struct ib_srq *srq, const struct ib_recv_wr *recv_wr,
 			  const struct ib_recv_wr **bad_recv_wr);
 struct ib_qp *bnxt_re_create_qp(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 2b2b009b371a..fa91e80869c0 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -999,7 +999,7 @@ int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int c4iw_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *attr,
 		    enum ib_srq_attr_mask srq_attr_mask,
 		    struct ib_udata *udata);
-void c4iw_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata);
+int c4iw_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata);
 int c4iw_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *attrs,
 		    struct ib_udata *udata);
 int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index ac48012c992f..dbee730342af 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2797,7 +2797,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	return ret;
 }
 
-void c4iw_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+int c4iw_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct c4iw_dev *rhp;
 	struct c4iw_srq *srq;
@@ -2813,4 +2813,5 @@ void c4iw_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 		       srq->wr_waitp);
 	c4iw_free_srq_idx(&rhp->rdev, srq->idx);
 	c4iw_put_wr_wait(srq->wr_waitp);
+	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7100127c7d1c..ce0bec4a73c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1225,7 +1225,7 @@ int hns_roce_create_srq(struct ib_srq *srq,
 int hns_roce_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
 			enum ib_srq_attr_mask srq_attr_mask,
 			struct ib_udata *udata);
-void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
+int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 
 struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 				 struct ib_qp_init_attr *init_attr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index f40a000e94ee..17585b127d3a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -363,7 +363,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	return ret;
 }
 
-void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
@@ -372,6 +372,7 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	free_srq_idx(hr_dev, srq);
 	free_srq_wrid(srq);
 	free_srq_buf(hr_dev, srq);
+	return 0;
 }
 
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 6d51653edaf8..392a5a7c2a31 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -763,7 +763,7 @@ int mlx4_ib_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 int mlx4_ib_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		       enum ib_srq_attr_mask attr_mask, struct ib_udata *udata);
 int mlx4_ib_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
-void mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
+int mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
 void mlx4_ib_free_srq_wqe(struct mlx4_ib_srq *srq, int wqe_index);
 int mlx4_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			  const struct ib_recv_wr **bad_wr);
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 8f9d5035142d..2651b68a1c04 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -260,7 +260,7 @@ int mlx4_ib_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 	return 0;
 }
 
-void mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
+int mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(srq->device);
 	struct mlx4_ib_srq *msrq = to_msrq(srq);
@@ -282,6 +282,7 @@ void mlx4_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 		mlx4_db_free(dev->dev, &msrq->db);
 	}
 	ib_umem_release(msrq->umem);
+	return 0;
 }
 
 void mlx4_ib_free_srq_wqe(struct mlx4_ib_srq *srq, int wqe_index)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 1e5f77d3e86b..b7b00e9e180b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1128,7 +1128,7 @@ int mlx5_ib_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 int mlx5_ib_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		       enum ib_srq_attr_mask attr_mask, struct ib_udata *udata);
 int mlx5_ib_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr);
-void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
+int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
 int mlx5_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			  const struct ib_recv_wr **bad_wr);
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 1b54fe4ea21d..3d7561f37742 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -389,24 +389,24 @@ int mlx5_ib_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 	return ret;
 }
 
-void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
+int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(srq->device);
 	struct mlx5_ib_srq *msrq = to_msrq(srq);
+	int ret;
+
+	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
+	if (ret && udata)
+		return ret;
 
-	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
-
-	if (srq->uobject) {
-		mlx5_ib_db_unmap_user(
-			rdma_udata_to_drv_context(
-				udata,
-				struct mlx5_ib_ucontext,
-				ibucontext),
-			&msrq->db);
-		ib_umem_release(msrq->umem);
-	} else {
-		destroy_srq_kernel(dev, msrq);
+	if (udata) {
+		destroy_srq_user(srq->pd, msrq, udata);
+		return 0;
 	}
+
+	/* We are cleaning kernel resources anyway */
+	destroy_srq_kernel(dev, msrq);
+	return ret;
 }
 
 void mlx5_ib_free_srq_wqe(struct mlx5_ib_srq *srq, int wqe_index)
diff --git a/drivers/infiniband/hw/mlx5/srq.h b/drivers/infiniband/hw/mlx5/srq.h
index af197c36d757..2c3627b2509d 100644
--- a/drivers/infiniband/hw/mlx5/srq.h
+++ b/drivers/infiniband/hw/mlx5/srq.h
@@ -56,7 +56,7 @@ struct mlx5_srq_table {
 
 int mlx5_cmd_create_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			struct mlx5_srq_attr *in);
-void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq);
+int mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq);
 int mlx5_cmd_query_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 		       struct mlx5_srq_attr *out);
 int mlx5_cmd_arm_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index c6d807f04d9d..d590bac684eb 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -590,7 +590,7 @@ int mlx5_cmd_create_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	return err;
 }
 
-void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
+int mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 {
 	struct mlx5_srq_table *table = &dev->srq_table;
 	struct mlx5_core_srq *tmp;
@@ -599,7 +599,7 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 	/* Delete entry, but leave index occupied */
 	tmp = xa_store_irq(&table->array, srq->srqn, NULL, 0);
 	if (WARN_ON(!tmp || tmp != srq))
-		return;
+		return -EINVAL;
 
 	err = destroy_srq_split(dev, srq);
 	if (err) {
@@ -609,12 +609,13 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 		 * entry and it can't fail at this stage.
 		 */
 		xa_store_irq(&table->array, srq->srqn, srq, 0);
-		return;
+		return err;
 	}
 	xa_erase_irq(&table->array, srq->srqn);
 
 	mlx5_core_res_put(&srq->common);
 	wait_for_completion(&srq->common.free);
+	return 0;
 }
 
 int mlx5_cmd_query_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 12b7c5349004..5d1e17214f0c 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -442,7 +442,7 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 	return 0;
 }
 
-static void mthca_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
+static int mthca_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
 	if (udata) {
 		struct mthca_ucontext *context =
@@ -456,6 +456,7 @@ static void mthca_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 	}
 
 	mthca_free_srq(to_mdev(srq->device), to_msrq(srq));
+	return 0;
 }
 
 static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 4b9295c8d4f3..220bb09d6431 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1858,7 +1858,7 @@ int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 	return status;
 }
 
-void ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct ocrdma_srq *srq;
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibsrq->device);
@@ -1873,6 +1873,7 @@ void ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	kfree(srq->idx_bit_fields);
 	kfree(srq->rqe_wr_id_tbl);
+	return 0;
 }
 
 /* unprivileged verbs and their support functions. */
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 4c85be43507c..4f6806f16e61 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -92,7 +92,7 @@ int ocrdma_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *attr,
 int ocrdma_modify_srq(struct ib_srq *, struct ib_srq_attr *,
 		      enum ib_srq_attr_mask, struct ib_udata *);
 int ocrdma_query_srq(struct ib_srq *, struct ib_srq_attr *);
-void ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
+int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 int ocrdma_post_srq_recv(struct ib_srq *, const struct ib_recv_wr *,
 			 const struct ib_recv_wr **bad_recv_wr);
 
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 53ac0a4d32f2..d75300d7df95 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1592,7 +1592,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	return -EFAULT;
 }
 
-void qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+int qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct qed_rdma_destroy_srq_in_params in_params = {};
 	struct qedr_dev *dev = get_qedr_dev(ibsrq->device);
@@ -1610,6 +1610,7 @@ void qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	DP_DEBUG(dev, QEDR_MSG_SRQ,
 		 "destroy srq: destroyed srq with srq_id=0x%0x\n",
 		 srq->srq_id);
+	return 0;
 }
 
 int qedr_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 1b4ed8d37f5e..a78b206d8b5a 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -67,7 +67,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *attr,
 int qedr_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		    enum ib_srq_attr_mask attr_mask, struct ib_udata *udata);
 int qedr_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr);
-void qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
+int qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		       const struct ib_recv_wr **bad_recv_wr);
 int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d330decfb80a..b5068cb2578a 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -240,7 +240,7 @@ static void pvrdma_free_srq(struct pvrdma_dev *dev, struct pvrdma_srq *srq)
  *
  * @return: 0 for success.
  */
-void pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
+int pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
 	struct pvrdma_srq *vsrq = to_vsrq(srq);
 	union pvrdma_cmd_req req;
@@ -259,6 +259,7 @@ void pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 			 ret);
 
 	pvrdma_free_srq(dev, vsrq);
+	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 58b41a3e8b7e..f9edce71b79b 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -423,7 +423,7 @@ int pvrdma_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 int pvrdma_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		      enum ib_srq_attr_mask attr_mask, struct ib_udata *udata);
 int pvrdma_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
-void pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
+int pvrdma_destroy_srq(struct ib_srq *srq, struct ib_udata *udata);
 
 struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 			       struct ib_qp_init_attr *init_attr,
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index f547c115af03..64d98bf238ab 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -332,7 +332,7 @@ int rvt_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
  * @ibsrq: srq object to destroy
  *
  */
-void rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+int rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
@@ -343,4 +343,5 @@ void rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->ip)
 		kref_put(&srq->ip->ref, rvt_release_mmap_info);
 	kvfree(srq->rq.kwq);
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rdmavt/srq.h b/drivers/infiniband/sw/rdmavt/srq.h
index 6427d7d62a9a..d5a1a053b1b9 100644
--- a/drivers/infiniband/sw/rdmavt/srq.h
+++ b/drivers/infiniband/sw/rdmavt/srq.h
@@ -56,6 +56,6 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		   enum ib_srq_attr_mask attr_mask,
 		   struct ib_udata *udata);
 int rvt_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr);
-void rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
+int rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 
 #endif          /* DEF_RVTSRQ_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4c7df057da54..7303edbc293b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -367,7 +367,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	return 0;
 }
 
-static void rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
@@ -376,6 +376,7 @@ static void rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
+	return 0;
 }
 
 static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 2d2b6df0b027..a6ec1e968fb4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1691,7 +1691,7 @@ int siw_query_srq(struct ib_srq *base_srq, struct ib_srq_attr *attrs)
  * QP anymore - the code trusts the RDMA core environment to keep track
  * of QP references.
  */
-void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
+int siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
 {
 	struct siw_srq *srq = to_siw_srq(base_srq);
 	struct siw_device *sdev = to_siw_dev(base_srq->device);
@@ -1703,6 +1703,7 @@ void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata)
 		rdma_user_mmap_entry_remove(srq->srq_entry);
 	vfree(srq->recvq);
 	atomic_dec(&sdev->num_srq);
+	return 0;
 }
 
 /*
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 3dbab78579cb..ed2d8ac2f967 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -78,7 +78,7 @@ int siw_create_srq(struct ib_srq *base_srq, struct ib_srq_init_attr *attr,
 int siw_modify_srq(struct ib_srq *base_srq, struct ib_srq_attr *attr,
 		   enum ib_srq_attr_mask mask, struct ib_udata *udata);
 int siw_query_srq(struct ib_srq *base_srq, struct ib_srq_attr *attr);
-void siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata);
+int siw_destroy_srq(struct ib_srq *base_srq, struct ib_udata *udata);
 int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr);
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 9bf0fa30df28..dca86abb3012 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1647,17 +1647,13 @@ int ipoib_cm_dev_init(struct net_device *dev)
 void ipoib_cm_dev_cleanup(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-	int ret;
 
 	if (!priv->cm.srq)
 		return;
 
 	ipoib_dbg(priv, "Cleanup ipoib connected mode.\n");
 
-	ret = ib_destroy_srq(priv->cm.srq);
-	if (ret)
-		ipoib_warn(priv, "ib_destroy_srq failed: %d\n", ret);
-
+	ib_destroy_srq(priv->cm.srq);
 	priv->cm.srq = NULL;
 	if (!priv->cm.srq_ring)
 		return;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 38d34b85138f..2ea278b0494a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2417,7 +2417,7 @@ struct ib_device_ops {
 			  enum ib_srq_attr_mask srq_attr_mask,
 			  struct ib_udata *udata);
 	int (*query_srq)(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
-	void (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
+	int (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
 	struct ib_qp *(*create_qp)(struct ib_pd *pd,
 				   struct ib_qp_init_attr *qp_init_attr,
 				   struct ib_udata *udata);
@@ -3660,9 +3660,11 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata);
  *
  * NOTE: for user srq use ib_destroy_srq_user with valid udata!
  */
-static inline int ib_destroy_srq(struct ib_srq *srq)
+static inline void ib_destroy_srq(struct ib_srq *srq)
 {
-	return ib_destroy_srq_user(srq, NULL);
+	int ret = ib_destroy_srq_user(srq, NULL);
+
+	WARN_ONCE(ret, "Destroy of kernel SRQ shouldn't fail");
 }
 
 /**
-- 
2.26.2

