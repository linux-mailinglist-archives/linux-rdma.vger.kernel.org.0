Return-Path: <linux-rdma+bounces-3185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA44909E75
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2276D1F212B3
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52821BC23;
	Sun, 16 Jun 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXWz8lSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFE1B960
	for <linux-rdma@vger.kernel.org>; Sun, 16 Jun 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554573; cv=none; b=t44iOZ1NYuGcRlGxkb38ABaHEibdoUGFftRsJ0nDuhhJcyc4kma2Bfnfu+3tS+ZUkIwD1ADmilEgkVx5idtBlMYEobp0dmGwUQ/11CPxwG40NYaJZJUoMqeL9Ycx9XntmdNvsxJfc2FMc7m3iCV9se1AgsSMv9t55bQXxtm0g1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554573; c=relaxed/simple;
	bh=7Rr0Xl+9AXZLkaaj4EbY66oNgYGjm63Y0tQCnkAkiHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ1FZFwaS8UFQjuFFe0MruJ7fscyQThg19xP0TC3zbOdZWKXu1L5GOA5GIj7jm53MvzBjnSgavfvFVLzTbBIkKHpgss1wQ95M2pCwSSSfHZwx3Zp0wHmRkGKegHAIx9Ay6xY4C8A+APrY63WKIAzASbKgr8oV/kxuwlCrNgsraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXWz8lSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C20C32786;
	Sun, 16 Jun 2024 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554573;
	bh=7Rr0Xl+9AXZLkaaj4EbY66oNgYGjm63Y0tQCnkAkiHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXWz8lSexHNHf0HpVZ9Qca3p7MKmdtaT5GR7yP3l1UrZ2S0+oyHBynnudtPMGQZhC
	 leGXmteG9/PFjZ94pKWIOJm4umxqKXYiozNFtFlK58rU1pu2ulXj+EOVpoORKOteeg
	 TgMi9X21WIZPc1ETcPmdKbmtExEIR23sUzGcSZ7ByxoJGiYK5oVNBL+AVUmjCw5nzr
	 vUy+BIJCAWIELcT+lW6BYSN7CNSkyzO/8GRE14Kx1WtbMg4tJSUs3VEsXMxe8TN9Zw
	 JgBGcmxbcgd42H02vXDv2g3NWHUBB+c2TkzwJh62EUR/215Ak43jYygNK3RrAyc41H
	 bbogIZa5Im7Sg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to create cq function
Date: Sun, 16 Jun 2024 19:15:57 +0300
Message-ID: <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718554263.git.leon@kernel.org>
References: <cover.1718554263.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akiva Goldberger <agoldberger@nvidia.com>

Changes the create_cq verb signature by sending the entire uverbs attr
bundle as a parameter. This allows drivers to send driver specific attrs
through ioctl for the create_cq verb and access them in their driver
specific code.

Also adds a new enum value for driver specific ioctl attritbutes for
methods already supporting UHW.

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 2 +-
 drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 3 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      | 2 +-
 drivers/infiniband/hw/cxgb4/cq.c              | 3 ++-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        | 2 +-
 drivers/infiniband/hw/efa/efa.h               | 2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         | 3 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.c     | 3 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.h     | 2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 3 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h   | 2 +-
 drivers/infiniband/hw/irdma/verbs.c           | 5 +++--
 drivers/infiniband/hw/mana/cq.c               | 2 +-
 drivers/infiniband/hw/mana/mana_ib.h          | 2 +-
 drivers/infiniband/hw/mlx4/cq.c               | 3 ++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          | 2 +-
 drivers/infiniband/hw/mlx5/cq.c               | 3 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 3 ++-
 drivers/infiniband/sw/siw/siw_verbs.c         | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.h         | 2 +-
 include/rdma/ib_verbs.h                       | 2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        | 1 +
 25 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 3d3ee3eca983..1b3ea71f2c33 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1051,7 +1051,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
+	ret = ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 	rdma_restrack_add(&cq->res);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 370ad7c83f88..432054f0a8a4 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -128,7 +128,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
+	ret = ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d261b09025ca..e453ca701e87 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2948,10 +2948,11 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 }
 
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata)
+		      struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index b267d6d5975f..e98cb1717338 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -221,7 +221,7 @@ int bnxt_re_post_send(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata);
+		      struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 7e2835dcbc1c..5111421f9473 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -995,8 +995,9 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 }
 
 int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		   struct ib_udata *udata)
+		   struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index fb8a0c248866..f838bb6718af 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -978,7 +978,7 @@ int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 void c4iw_cq_rem_ref(struct c4iw_cq *chp);
 int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		   struct ib_udata *udata);
+		   struct uverbs_attr_bundle *attrs);
 int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int c4iw_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *attr,
 		    enum ib_srq_attr_mask srq_attr_mask,
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 926f9ff1f60f..e580e087e9da 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -161,7 +161,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		  struct ib_udata *udata);
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct ib_udata *udata);
+		  struct uverbs_attr_bundle *attrs);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 8f7a13b79cdc..9ced560d7f42 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1084,8 +1084,9 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 }
 
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct ib_udata *udata)
+		  struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct efa_ucontext, ibucontext);
 	struct efa_com_create_cq_params params = {};
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 40c9b6e46b82..d7e1cbf9f5c2 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1628,8 +1628,9 @@ static int erdma_init_kernel_cq(struct erdma_cq *cq)
 }
 
 int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		    struct ib_udata *udata)
+		    struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct erdma_cq *cq = to_ecq(ibcq);
 	struct erdma_dev *dev = to_edev(ibcq->device);
 	unsigned int depth = attr->cqe;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 4f02ba06b210..6afdc02f5869 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -329,7 +329,7 @@ int erdma_query_device(struct ib_device *dev, struct ib_device_attr *attr,
 int erdma_get_port_immutable(struct ib_device *dev, u32 port,
 			     struct ib_port_immutable *ib_port_immutable);
 int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		    struct ib_udata *data);
+		    struct uverbs_attr_bundle *attrs);
 int erdma_query_port(struct ib_device *dev, u32 port,
 		     struct ib_port_attr *attr);
 int erdma_query_gid(struct ib_device *dev, u32 port, int idx,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 56dc3908da2f..4ec66611a143 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -353,9 +353,10 @@ static int set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
 }
 
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
-		       struct ib_udata *udata)
+		       struct uverbs_attr_bundle *attrs)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct hns_roce_ib_create_cq_resp resp = {};
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ff0b3f68ee3a..ef50cd03f489 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1267,7 +1267,7 @@ __be32 send_ieth(const struct ib_send_wr *wr);
 int to_hr_qp_type(int qp_type);
 
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
-		       struct ib_udata *udata);
+		       struct uverbs_attr_bundle *attrs);
 
 int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 12704efb7b19..fc0ce35da14e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2035,14 +2035,15 @@ static inline int cq_validate_flags(u32 flags, u8 hw_rev)
  * irdma_create_cq - create cq
  * @ibcq: CQ allocated
  * @attr: attributes for cq
- * @udata: user data
+ * @attrs: uverbs attribute bundle
  */
 static int irdma_create_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
-			   struct ib_udata *udata)
+			   struct uverbs_attr_bundle *attrs)
 {
 #define IRDMA_CREATE_CQ_MIN_REQ_LEN offsetofend(struct irdma_create_cq_req, user_cq_buf)
 #define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
 	struct irdma_device *iwdev = to_iwdev(ibdev);
 	struct irdma_pci_f *rf = iwdev->rf;
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index c6a3fd57a196..4bf95df30eb6 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -6,7 +6,7 @@
 #include "mana_ib.h"
 
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata)
+		      struct ib_udata *udata, struct uverbs_attr_bundle *attrs)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct mana_ib_create_cq_resp resp = {};
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 977da9569701..522e2d79eae8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -429,7 +429,7 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 			 u32 port);
 
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata);
+		      struct ib_udata *udata, struct uverbs_attr_bundle *attrs);
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 4cd738aae53c..aa9ea6ba26e5 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -172,8 +172,9 @@ static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev,
 
 #define CQ_CREATE_FLAGS_SUPPORTED IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION
 int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata)
+		      struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 41ca1114a995..b52bceff7d97 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -767,7 +767,7 @@ int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
 int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata);
+		      struct uverbs_attr_bundle *attrs);
 int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx4_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx4_ib_arm_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 4429bf7c746b..172f3987fc87 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -942,8 +942,9 @@ static void notify_soft_wc_handler(struct work_struct *work)
 }
 
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata)
+		      struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bf25ddb17bce..2b03e607561e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1332,7 +1332,7 @@ int mlx5_ib_read_wqe_rq(struct mlx5_ib_qp *qp, int wqe_index, void *buffer,
 int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void *buffer,
 			 size_t buflen, size_t *bc);
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct ib_udata *udata);
+		      struct uverbs_attr_bundle *attrs);
 int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e1325f2927d6..677ebb145dbf 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -574,7 +574,8 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 
 static int mthca_create_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
-			   struct ib_udata *udata)
+			   struct ib_udata *udata,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c7d4d8ab5a09..82bb7f33290c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1053,8 +1053,9 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 /* cq */
 static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-			 struct ib_udata *udata)
+			 struct uverbs_attr_bundle *attrs)
 {
+	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *dev = ibcq->device;
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index ecf0444666b4..ce7ef5b5ef89 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1128,7 +1128,7 @@ int siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
  */
 
 int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
-		  struct ib_udata *udata)
+		  struct ib_udata *udata, struct uverbs_attr_bundle *attrs)
 {
 	struct siw_device *sdev = to_siw_dev(base_cq->device);
 	struct siw_cq *cq = to_siw_cq(base_cq);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 4b57a4fb7237..5c4c7074eef0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -43,7 +43,7 @@ int siw_get_port_immutable(struct ib_device *base_dev, u32 port,
 int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 		     struct ib_udata *udata);
 int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
-		  struct ib_udata *udata);
+		  struct ib_udata *udata, struct uverbs_attr_bundle *attrs);
 int siw_query_port(struct ib_device *base_dev, u32 port,
 		   struct ib_port_attr *attr);
 int siw_query_gid(struct ib_device *base_dev, u32 port, int idx,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c20571618798..432a81c8c7b7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2463,7 +2463,7 @@ struct ib_device_ops {
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
 	int (*create_cq)(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
-			 struct ib_udata *udata);
+			 struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index dafc7ebe545b..bfb34c23cf1c 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -63,6 +63,7 @@ enum uverbs_default_objects {
 enum {
 	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
 	UVERBS_ATTR_UHW_OUT,
+	UVERBS_ATTR_UHW_DRIVER_DATA,
 };
 
 enum uverbs_methods_device {
-- 
2.45.2


