Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16C215701
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgGFMEx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:04:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:24335 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFMEx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 08:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594037090; x=1625573090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFaPGGb2yt9MDJc7pGsRlYpltLskCpiGcWO9xCgvShE=;
  b=fs+CxuC5DW4knpwMz1MFyB423JEzxKdyr952VsLopkH+SWLflmCQ5C1C
   UaHn5N+Fp24y+2V1eTvpiRtgKysiZRhfyTwKMr6titAoYzLe9vG06QqHQ
   wMIe2LevRyKajOyAZNX6JoLQkl9+ZLdvETBexSfQcHr8X/GnF3bDaCj2+
   4=;
IronPort-SDR: r6rek1ZBtmaRsiACto/H7mba66D/n5aB3xqsiNRakgI9ELtjWVmI74aZ+QVe8ED2Mam5MGEww7
 s64E1P0SwtRA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="41659793"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Jul 2020 12:04:47 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id B8EBFA17EF;
        Mon,  6 Jul 2020 12:04:45 +0000 (UTC)
Received: from EX13D29UWC002.ant.amazon.com (10.43.162.254) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:40 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D29UWC002.ant.amazon.com (10.43.162.254) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:39 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.24) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 6 Jul 2020 12:04:32 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 3/3] RDMA: Remove the udata parameter from alloc_mr callback
Date:   Mon, 6 Jul 2020 15:03:43 +0300
Message-ID: <20200706120343.10816-4-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706120343.10816-1-galpress@amazon.com>
References: <20200706120343.10816-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allocating an MR flow can only be initiated by kernel users, and not
from userspace so a udata parameter is redundant.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/verbs.c                 | 2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        | 2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        | 2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          | 2 +-
 drivers/infiniband/hw/cxgb4/mem.c               | 2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h     | 2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c         | 2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c       | 3 +--
 drivers/infiniband/hw/mlx4/mlx4_ib.h            | 2 +-
 drivers/infiniband/hw/mlx4/mr.c                 | 2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h            | 2 +-
 drivers/infiniband/hw/mlx5/mr.c                 | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     | 2 +-
 drivers/infiniband/hw/qedr/verbs.c              | 2 +-
 drivers/infiniband/hw/qedr/verbs.h              | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h | 2 +-
 drivers/infiniband/sw/rdmavt/mr.c               | 2 +-
 drivers/infiniband/sw/rdmavt/mr.h               | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c           | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.h           | 2 +-
 include/rdma/ib_verbs.h                         | 2 +-
 24 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5242155ced47..26f1de76da99 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2131,7 +2131,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 		goto out;
 	}
 
-	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, NULL);
+	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg);
 	if (IS_ERR(mr))
 		goto out;
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 8b6ad5cddfce..f32c7e85ae05 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3569,7 +3569,7 @@ int bnxt_re_map_mr_sg(struct ib_mr *ib_mr, struct scatterlist *sg, int sg_nents,
 }
 
 struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
-			       u32 max_num_sg, struct ib_udata *udata)
+			       u32 max_num_sg)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index e5fbbeba6d28..b4a06b553b04 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -201,7 +201,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
 int bnxt_re_map_mr_sg(struct ib_mr *ib_mr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset);
 struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata);
+			       u32 max_num_sg);
 int bnxt_re_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 			       struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 27da0705c88a..2b2b009b371a 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -980,7 +980,7 @@ int c4iw_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
 void c4iw_qp_add_ref(struct ib_qp *qp);
 void c4iw_qp_rem_ref(struct ib_qp *qp);
 struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			    u32 max_num_sg, struct ib_udata *udata);
+			    u32 max_num_sg);
 int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		   unsigned int *sg_offset);
 int c4iw_dealloc_mw(struct ib_mw *mw);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 962dc97a8ff2..ea6fb2c5b1a7 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -691,7 +691,7 @@ int c4iw_dealloc_mw(struct ib_mw *mw)
 }
 
 struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			    u32 max_num_sg, struct ib_udata *udata)
+			    u32 max_num_sg)
 {
 	struct c4iw_dev *rhp;
 	struct c4iw_pd *php;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a61f0c4d4dbb..5b946b5bd586 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1191,7 +1191,7 @@ int hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start, u64 length,
 			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
 			   struct ib_udata *udata);
 struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-				u32 max_num_sg, struct ib_udata *udata);
+				u32 max_num_sg);
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		       unsigned int *sg_offset);
 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 4c0bbb12770d..1380cdab5701 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -414,7 +414,7 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 }
 
 struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-				u32 max_num_sg, struct ib_udata *udata)
+				u32 max_num_sg)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct device *dev = hr_dev->dev;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 19af29a48c55..f9ef3ac2f4cd 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1543,10 +1543,9 @@ static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr
  * @pd: ibpd pointer
  * @mr_type: memory for stag registrion
  * @max_num_sg: man number of pages
- * @udata: user data or NULL for kernel objects
  */
 static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-				    u32 max_num_sg, struct ib_udata *udata)
+				    u32 max_num_sg)
 {
 	struct i40iw_pd *iwpd = to_iwpd(pd);
 	struct i40iw_device *iwdev = to_iwdev(pd->device);
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 6f4ea1067095..38e87a700a2a 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -729,7 +729,7 @@ struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 			       struct ib_udata *udata);
 int mlx4_ib_dealloc_mw(struct ib_mw *mw);
 struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata);
+			       u32 max_num_sg);
 int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset);
 int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 7e0b205c05eb..6eecedeff2d3 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -655,7 +655,7 @@ int mlx4_ib_dealloc_mw(struct ib_mw *ibmw)
 }
 
 struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata)
+			       u32 max_num_sg)
 {
 	struct mlx4_ib_dev *dev = to_mdev(pd->device);
 	struct mlx4_ib_mr *mr;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index da03d762c6a2..68035a6bb659 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1205,7 +1205,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			  struct ib_pd *pd, struct ib_udata *udata);
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata);
+			       u32 max_num_sg);
 struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
 					 u32 max_num_sg,
 					 u32 max_num_meta_sg);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 44683073be0c..3e6f2f9c6655 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1961,7 +1961,7 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 }
 
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			       u32 max_num_sg, struct ib_udata *udata)
+			       u32 max_num_sg)
 {
 	return __mlx5_ib_alloc_mr(pd, mr_type, max_num_sg, 0);
 }
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index d11c74390a12..6cdbec13756a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -2901,7 +2901,7 @@ int ocrdma_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags cq_flags)
 }
 
 struct ib_mr *ocrdma_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
-			      u32 max_num_sg, struct ib_udata *udata)
+			      u32 max_num_sg)
 {
 	int status;
 	struct ocrdma_mr *mr;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 3a5010881be5..df8e3b923a44 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -101,7 +101,7 @@ struct ib_mr *ocrdma_get_dma_mr(struct ib_pd *, int acc);
 struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *, u64 start, u64 length,
 				 u64 virt, int acc, struct ib_udata *);
 struct ib_mr *ocrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			      u32 max_num_sg, struct ib_udata *udata);
+			      u32 max_num_sg);
 int ocrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		     unsigned int *sg_offset);
 
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 9b9e80266367..3d7d5617818f 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3003,7 +3003,7 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 }
 
 struct ib_mr *qedr_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
-			    u32 max_num_sg, struct ib_udata *udata)
+			    u32 max_num_sg)
 {
 	struct qedr_mr *mr;
 
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 5e02387e068d..39dd6286ba39 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -84,7 +84,7 @@ int qedr_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		   int sg_nents, unsigned int *sg_offset);
 
 struct ib_mr *qedr_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			    u32 max_num_sg, struct ib_udata *udata);
+			    u32 max_num_sg);
 int qedr_poll_cq(struct ib_cq *, int num_entries, struct ib_wc *wc);
 int qedr_post_send(struct ib_qp *, const struct ib_send_wr *,
 		   const struct ib_send_wr **bad_wr);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index b039f1f00e05..77a010e68208 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -202,7 +202,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
  * @return: ib_mr pointer on success, otherwise returns an errno.
  */
 struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			      u32 max_num_sg, struct ib_udata *udata)
+			      u32 max_num_sg)
 {
 	struct pvrdma_dev *dev = to_vdev(pd->device);
 	struct pvrdma_user_mr *mr;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 267702226f10..699b20849a7e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -406,7 +406,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				 struct ib_udata *udata);
 int pvrdma_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			      u32 max_num_sg, struct ib_udata *udata);
+			      u32 max_num_sg);
 int pvrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		     int sg_nents, unsigned int *sg_offset);
 int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 60864e5ca7cb..2f7c25fea44a 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -576,7 +576,7 @@ int rvt_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
  * Return: the memory region on success, otherwise return an errno.
  */
 struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			   u32 max_num_sg, struct ib_udata *udata)
+			   u32 max_num_sg)
 {
 	struct rvt_mr *mr;
 
diff --git a/drivers/infiniband/sw/rdmavt/mr.h b/drivers/infiniband/sw/rdmavt/mr.h
index 780fc63af98b..b3aba359401b 100644
--- a/drivers/infiniband/sw/rdmavt/mr.h
+++ b/drivers/infiniband/sw/rdmavt/mr.h
@@ -71,7 +71,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			      struct ib_udata *udata);
 int rvt_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			   u32 max_num_sg, struct ib_udata *udata);
+			   u32 max_num_sg);
 int rvt_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b8a22af724e8..0472df52d36d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -975,7 +975,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 }
 
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
-				  u32 max_num_sg, struct ib_udata *udata)
+				  u32 max_num_sg)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 987e2ba05dbc..0d509f7a10a6 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1373,7 +1373,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 }
 
 struct ib_mr *siw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
-			   u32 max_sge, struct ib_udata *udata)
+			   u32 max_sge)
 {
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mr *mr = NULL;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 1a731989fad6..9335c48c01de 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -69,7 +69,7 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags);
 struct ib_mr *siw_reg_user_mr(struct ib_pd *base_pd, u64 start, u64 len,
 			      u64 rnic_va, int rights, struct ib_udata *udata);
 struct ib_mr *siw_alloc_mr(struct ib_pd *base_pd, enum ib_mr_type mr_type,
-			   u32 max_sge, struct ib_udata *udata);
+			   u32 max_sge);
 struct ib_mr *siw_get_dma_mr(struct ib_pd *base_pd, int rights);
 int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 		  unsigned int *sg_off);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3b53fdc975f6..f80e60fe97ea 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2477,7 +2477,7 @@ struct ib_device_ops {
 			     struct ib_pd *pd, struct ib_udata *udata);
 	int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
 	struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
-				  u32 max_num_sg, struct ib_udata *udata);
+				  u32 max_num_sg);
 	struct ib_mr *(*alloc_mr_integrity)(struct ib_pd *pd,
 					    u32 max_num_data_sg,
 					    u32 max_num_meta_sg);
-- 
2.27.0

