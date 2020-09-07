Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC747260384
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgIGRuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgIGMJf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:09:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E832137B;
        Mon,  7 Sep 2020 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480573;
        bh=GNBVjdxlrENxzPP4PJP2D1M8MCcHP0bdqe6pDiMCW04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGyJil++chH81p9Ja7LdSlMupn3Ho6OJWA1jkxPpH4NjK9X3NFH750LDZaNRNfaOX
         Cy2UAfzZBgjQBfYaOiFdHY9ee0Zoa5RcbTNV9ZjEWpIU4lCvtyJiqJWkNE8LFRuO6O
         B74DLYMVMhz+82Hxh6Ma8k7Eo9GPrUd+cCcLS8AM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH rdma-next v2 2/9] RDMA: Restore ability to fail on AH destroy
Date:   Mon,  7 Sep 2020 15:09:14 +0300
Message-Id: <20200907120921.476363-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
References: <20200907120921.476363-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Like any other IB verbs objects, AH are refcounted by ib_core. The release
of those objects are controlled by ib_core with promise that AH destroy
can't fail.

Being SW object for now, this change makes dealloc_ah() to behave like
any other destroy IB flows.

Fixes: d345691471b4 ("RDMA: Handle AH allocations by IB/core")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c                 | 8 ++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        | 3 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        | 2 +-
 drivers/infiniband/hw/efa/efa.h                 | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c           | 5 +++--
 drivers/infiniband/hw/hns/hns_roce_ah.c         | 5 -----
 drivers/infiniband/hw/hns/hns_roce_device.h     | 5 ++++-
 drivers/infiniband/hw/mlx4/ah.c                 | 5 -----
 drivers/infiniband/hw/mlx4/mlx4_ib.h            | 5 ++++-
 drivers/infiniband/hw/mlx5/ah.c                 | 5 -----
 drivers/infiniband/hw/mlx5/mlx5_ib.h            | 5 ++++-
 drivers/infiniband/hw/mthca/mthca_provider.c    | 3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c        | 3 ++-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h        | 2 +-
 drivers/infiniband/hw/qedr/verbs.c              | 3 ++-
 drivers/infiniband/hw/qedr/verbs.h              | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 3 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h | 2 +-
 drivers/infiniband/sw/rdmavt/ah.c               | 3 ++-
 drivers/infiniband/sw/rdmavt/ah.h               | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           | 3 ++-
 include/rdma/ib_verbs.h                         | 8 +++++---
 22 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index a4a2cd378cb4..bd345e7ce913 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -968,18 +968,22 @@ int rdma_destroy_ah_user(struct ib_ah *ah, u32 flags, struct ib_udata *udata)
 {
 	const struct ib_gid_attr *sgid_attr = ah->sgid_attr;
 	struct ib_pd *pd;
+	int ret;
 
 	might_sleep_if(flags & RDMA_DESTROY_AH_SLEEPABLE);
 
 	pd = ah->pd;
 
-	ah->device->ops.destroy_ah(ah, flags);
+	ret = ah->device->ops.destroy_ah(ah, flags);
+	if (ret)
+		return ret;
+
 	atomic_dec(&pd->usecnt);
 	if (sgid_attr)
 		rdma_put_gid_attr(sgid_attr);
 
 	kfree(ah);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(rdma_destroy_ah_user);
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c53f6e329d84..67ebf1996700 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -602,13 +602,14 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 }
 
 /* Address Handles */
-void bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
+int bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
 {
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
 	struct bnxt_re_dev *rdev = ah->rdev;
 
 	bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah,
 			      !(flags & RDMA_DESTROY_AH_SLEEPABLE));
+	return 0;
 }
 
 static u8 bnxt_re_stack_to_dev_nw_type(enum rdma_network_type ntype)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index d9e2e406f66a..b6b56a92b78e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -168,7 +168,7 @@ int bnxt_re_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		      struct ib_udata *udata);
 int bnxt_re_modify_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 int bnxt_re_query_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
-void bnxt_re_destroy_ah(struct ib_ah *ah, u32 flags);
+int bnxt_re_destroy_ah(struct ib_ah *ah, u32 flags);
 int bnxt_re_create_srq(struct ib_srq *srq,
 		       struct ib_srq_init_attr *srq_init_attr,
 		       struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 8547f9d543df..6b06ce87fbfc 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -156,7 +156,7 @@ void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 int efa_create_ah(struct ib_ah *ibah,
 		  struct rdma_ah_init_attr *init_attr,
 		  struct ib_udata *udata);
-void efa_destroy_ah(struct ib_ah *ibah, u32 flags);
+int efa_destroy_ah(struct ib_ah *ibah, u32 flags);
 int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		  int qp_attr_mask, struct ib_udata *udata);
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 383ce126d82f..a03e3514bd8a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1873,7 +1873,7 @@ int efa_create_ah(struct ib_ah *ibah,
 	return err;
 }
 
-void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
+int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct efa_dev *dev = to_edev(ibah->pd->device);
 	struct efa_ah *ah = to_eah(ibah);
@@ -1883,10 +1883,11 @@ void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 	if (!(flags & RDMA_DESTROY_AH_SLEEPABLE)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Destroy address handle is not supported in atomic context\n");
-		return;
+		return -EOPNOTSUPP;
 	}
 
 	efa_ah_destroy(dev, ah);
+	return 0;
 }
 
 struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u8 port_num)
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 54cadbc0724e..75b06db60f7c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -116,8 +116,3 @@ int hns_roce_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 
 	return 0;
 }
-
-void hns_roce_destroy_ah(struct ib_ah *ah, u32 flags)
-{
-	return;
-}
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 9688240d7fce..da3e8ed916f8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1179,7 +1179,10 @@ void hns_roce_bitmap_free_range(struct hns_roce_bitmap *bitmap,
 int hns_roce_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		       struct ib_udata *udata);
 int hns_roce_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
-void hns_roce_destroy_ah(struct ib_ah *ah, u32 flags);
+static inline int hns_roce_destroy_ah(struct ib_ah *ah, u32 flags)
+{
+	return 0;
+}
 
 int hns_roce_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx4/ah.c b/drivers/infiniband/hw/mlx4/ah.c
index 5f8f8d5c0ce0..7321d6ab5fe1 100644
--- a/drivers/infiniband/hw/mlx4/ah.c
+++ b/drivers/infiniband/hw/mlx4/ah.c
@@ -232,8 +232,3 @@ int mlx4_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 
 	return 0;
 }
-
-void mlx4_ib_destroy_ah(struct ib_ah *ah, u32 flags)
-{
-	return;
-}
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index bcac8fc50317..6d51653edaf8 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -753,7 +753,10 @@ int mlx4_ib_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 int mlx4_ib_create_ah_slave(struct ib_ah *ah, struct rdma_ah_attr *ah_attr,
 			    int slave_sgid_index, u8 *s_mac, u16 vlan_tag);
 int mlx4_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
-void mlx4_ib_destroy_ah(struct ib_ah *ah, u32 flags);
+static inline int mlx4_ib_destroy_ah(struct ib_ah *ah, u32 flags)
+{
+	return 0;
+}
 
 int mlx4_ib_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 		       struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 4a60e693a04d..505bc47fd575 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -147,8 +147,3 @@ int mlx5_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 
 	return 0;
 }
-
-void mlx5_ib_destroy_ah(struct ib_ah *ah, u32 flags)
-{
-	return;
-}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5287fc868662..1e5f77d3e86b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1119,7 +1119,10 @@ void mlx5_ib_free_srq_wqe(struct mlx5_ib_srq *srq, int wqe_index);
 int mlx5_ib_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		      struct ib_udata *udata);
 int mlx5_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
-void mlx5_ib_destroy_ah(struct ib_ah *ah, u32 flags);
+static inline int mlx5_ib_destroy_ah(struct ib_ah *ah, u32 flags)
+{
+	return 0;
+}
 int mlx5_ib_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 		       struct ib_udata *udata);
 int mlx5_ib_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index d3ed7c19b2ef..12b7c5349004 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -390,9 +390,10 @@ static int mthca_ah_create(struct ib_ah *ibah,
 			       init_attr->ah_attr, ah);
 }
 
-static void mthca_ah_destroy(struct ib_ah *ah, u32 flags)
+static int mthca_ah_destroy(struct ib_ah *ah, u32 flags)
 {
 	mthca_destroy_ah(to_mdev(ah->device), to_mah(ah));
+	return 0;
 }
 
 static int mthca_create_srq(struct ib_srq *ibsrq,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
index 6eea02b18968..699a8b719ed6 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.c
@@ -215,12 +215,13 @@ int ocrdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	return status;
 }
 
-void ocrdma_destroy_ah(struct ib_ah *ibah, u32 flags)
+int ocrdma_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct ocrdma_ah *ah = get_ocrdma_ah(ibah);
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibah->device);
 
 	ocrdma_free_av(dev, ah);
+	return 0;
 }
 
 int ocrdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_ah.h b/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
index 8b73b3489f3a..35cf2e2ff391 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_ah.h
@@ -53,7 +53,7 @@ enum {
 
 int ocrdma_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		     struct ib_udata *udata);
-void ocrdma_destroy_ah(struct ib_ah *ah, u32 flags);
+int ocrdma_destroy_ah(struct ib_ah *ah, u32 flags);
 int ocrdma_query_ah(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 
 int ocrdma_process_mad(struct ib_device *dev, int process_mad_flags,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index c81d1e547295..f85e916bec7d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2767,11 +2767,12 @@ int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	return 0;
 }
 
-void qedr_destroy_ah(struct ib_ah *ibah, u32 flags)
+int qedr_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct qedr_ah *ah = get_qedr_ah(ibah);
 
 	rdma_destroy_ah_attr(&ah->attr);
+	return 0;
 }
 
 static void free_mr_info(struct qedr_dev *dev, struct mr_info *info)
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 1b450919ba9c..1b4ed8d37f5e 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -72,7 +72,7 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		       const struct ib_recv_wr **bad_recv_wr);
 int qedr_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		   struct ib_udata *udata);
-void qedr_destroy_ah(struct ib_ah *ibah, u32 flags);
+int qedr_destroy_ah(struct ib_ah *ibah, u32 flags);
 
 int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 struct ib_mr *qedr_get_dma_mr(struct ib_pd *, int acc);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index 678c94531e68..fc412cbfd042 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -548,9 +548,10 @@ int pvrdma_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
  * @flags: destroy address handle flags (see enum rdma_destroy_ah_flags)
  *
  */
-void pvrdma_destroy_ah(struct ib_ah *ah, u32 flags)
+int pvrdma_destroy_ah(struct ib_ah *ah, u32 flags)
 {
 	struct pvrdma_dev *dev = to_vdev(ah->device);
 
 	atomic_dec(&dev->num_ahs);
+	return 0;
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 7bf33a654275..58b41a3e8b7e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -416,7 +416,7 @@ int pvrdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int pvrdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
 int pvrdma_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		     struct ib_udata *udata);
-void pvrdma_destroy_ah(struct ib_ah *ah, u32 flags);
+int pvrdma_destroy_ah(struct ib_ah *ah, u32 flags);
 
 int pvrdma_create_srq(struct ib_srq *srq, struct ib_srq_init_attr *init_attr,
 		      struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index 75a04b1497c4..b938c4ffa99a 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -132,7 +132,7 @@ int rvt_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
  *
  * Return: 0 on success
  */
-void rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
+int rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
 {
 	struct rvt_dev_info *dev = ib_to_rvt(ibah->device);
 	struct rvt_ah *ah = ibah_to_rvtah(ibah);
@@ -143,6 +143,7 @@ void rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
 	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 
 	rdma_destroy_ah_attr(&ah->attr);
+	return 0;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rdmavt/ah.h b/drivers/infiniband/sw/rdmavt/ah.h
index 40b7123fec76..5a85edd06491 100644
--- a/drivers/infiniband/sw/rdmavt/ah.h
+++ b/drivers/infiniband/sw/rdmavt/ah.h
@@ -52,7 +52,7 @@
 
 int rvt_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		  struct ib_udata *udata);
-void rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags);
+int rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags);
 int rvt_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
 int rvt_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7fe7316bd287..c346b0295a99 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -201,11 +201,12 @@ static int rxe_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 	return 0;
 }
 
-static void rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
+static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_drop_ref(ah);
+	return 0;
 }
 
 static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9ff4c28009c6..b9d1765c6e42 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2409,7 +2409,7 @@ struct ib_device_ops {
 			 struct ib_udata *udata);
 	int (*modify_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
 	int (*query_ah)(struct ib_ah *ah, struct rdma_ah_attr *ah_attr);
-	void (*destroy_ah)(struct ib_ah *ah, u32 flags);
+	int (*destroy_ah)(struct ib_ah *ah, u32 flags);
 	int (*create_srq)(struct ib_srq *srq,
 			  struct ib_srq_init_attr *srq_init_attr,
 			  struct ib_udata *udata);
@@ -3602,9 +3602,11 @@ int rdma_destroy_ah_user(struct ib_ah *ah, u32 flags, struct ib_udata *udata);
  *
  * NOTE: for user ah use rdma_destroy_ah_user with valid udata!
  */
-static inline int rdma_destroy_ah(struct ib_ah *ah, u32 flags)
+static inline void rdma_destroy_ah(struct ib_ah *ah, u32 flags)
 {
-	return rdma_destroy_ah_user(ah, flags, NULL);
+	int ret = rdma_destroy_ah_user(ah, flags, NULL);
+
+	WARN_ONCE(ret, "Destroy of kernel AH shouldn't fail");
 }
 
 struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
-- 
2.26.2

