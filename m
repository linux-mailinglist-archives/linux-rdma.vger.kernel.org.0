Return-Path: <linux-rdma+bounces-11937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED30AFB982
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E6C1AA6557
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A882E7F35;
	Mon,  7 Jul 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZfWSij0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7422264A0
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907870; cv=none; b=eIfFpQvzJAZmDMkbabEPz/ofGCrk2eWQ2cdgLWJjFdtOxDlq9Ss+UUDcU9ZG6ffgUDJs/lHE/X6/6aORR+2LEvKkAvvJcH+9NHtEsRZiWRUaDeoFk2WJB5HzUd2cJpgSAr7Xl/7Fx32UmVkHXR9rhv1Y72L1RvV/hJkrhGcI7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907870; c=relaxed/simple;
	bh=K9hkkWPj02kJiY2zF+dvCLOZhSH4E9fbS9k2Sm+VQkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq9LmdHrOx2Kca1wyjeMZ3N9pTl9fVzivaqbmfENt0AEo4ONidusQkkgJX39tHhyOh0KWgy1FcMVFVWskkMP4JAv8vAhHUzeEw2C41FRXT8dXhpO2ehCDDBkGErSGjW77+JaBFg5i4y9BN4jyyVhXy+H2ArlNjhVIrHIQX5Bh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZfWSij0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95083C4CEE3;
	Mon,  7 Jul 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907869;
	bh=K9hkkWPj02kJiY2zF+dvCLOZhSH4E9fbS9k2Sm+VQkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZfWSij0A+fVj2gcSClwdkQBemtPEEHtsZojs7bTmpjqXAUN8bkFXGf7GDthAz+3m
	 eQiXzb1EsjBEaIcRVziGXPD1BfK2mNUSoWREqFFHNwG/sWlgGjv2byIXPmkXtsei8j
	 NalLUNMWCi23WXJmw9ZsWhFsJ/a4mYR6rKyO87G1ctoSvPqFPQn7i4EJWhyfk51mmr
	 sxeWbnvBCwpZ7a4APXfZt/GB+m30FYBdtv7zdThqDaeX0aYvg38rd3ZvcghuD6uTCr
	 DYGneqww8qWBoQzF0gUrtwcyYZcdiZrNflaW50sVKM/rgiPAbgzla+FSavVBY2QNoD
	 S9En3x0VcJorA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Date: Mon,  7 Jul 2025 20:03:07 +0300
Message-ID: <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751907231.git.leon@kernel.org>
References: <cover.1751907231.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Extend UVERBS_METHOD_REG_MR to get DMAH and pass it to all drivers.

It will be used in mlx5 driver as part of the next patch from the
series.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          |  2 +-
 drivers/infiniband/core/uverbs_std_types_mr.c | 21 ++++++++++++++++---
 drivers/infiniband/core/verbs.c               |  5 ++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  8 +++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 ++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  1 +
 drivers/infiniband/hw/cxgb4/mem.c             |  6 +++++-
 drivers/infiniband/hw/efa/efa.h               |  2 ++
 drivers/infiniband/hw/efa/efa_verbs.c         |  8 +++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h     |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 ++++
 drivers/infiniband/hw/irdma/verbs.c           |  9 ++++++++
 drivers/infiniband/hw/mana/mana_ib.h          |  2 ++
 drivers/infiniband/hw/mana/mr.c               |  8 +++++++
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  1 +
 drivers/infiniband/hw/mlx4/mr.c               |  4 ++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 ++
 drivers/infiniband/hw/mlx5/mr.c               |  8 ++++---
 drivers/infiniband/hw/mthca/mthca_provider.c  |  6 +++++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 +++++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  3 ++-
 drivers/infiniband/hw/qedr/verbs.c            |  6 +++++-
 drivers/infiniband/hw/qedr/verbs.h            |  3 ++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 ++++
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  5 +++++
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  1 +
 drivers/infiniband/sw/rdmavt/mr.c             |  5 +++++
 drivers/infiniband/sw/rdmavt/mr.h             |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  4 ++++
 drivers/infiniband/sw/siw/siw_verbs.c         |  7 ++++++-
 drivers/infiniband/sw/siw/siw_verbs.h         |  3 ++-
 include/rdma/ib_verbs.h                       |  3 +++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 36 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 88aa8d4599df..ce16404cdfb8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -741,7 +741,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
-					 cmd.access_flags,
+					 cmd.access_flags, NULL,
 					 &attrs->driver_udata);
 	if (IS_ERR(mr)) {
 		ret = PTR_ERR(mr);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 1bd4b17b5515..711ae6379509 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -238,7 +238,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 		return ret;
 
 	mr = pd->device->ops.reg_user_mr_dmabuf(pd, offset, length, iova, fd,
-						access_flags,
+						access_flags, NULL,
 						attrs);
 	if (IS_ERR(mr))
 		return PTR_ERR(mr);
@@ -276,6 +276,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 	u32 valid_access_flags = IB_ACCESS_SUPPORTED;
 	u64 length, iova, fd_offset = 0, addr = 0;
 	struct ib_device *ib_dev = pd->device;
+	struct ib_dmah *dmah = NULL;
 	bool has_fd_offset = false;
 	bool has_addr = false;
 	bool has_fd = false;
@@ -340,6 +341,12 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 			return -EINVAL;
 	}
 
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_REG_MR_DMA_HANDLE)) {
+		dmah = uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_MR_DMA_HANDLE);
+		if (IS_ERR(dmah))
+			return PTR_ERR(dmah);
+	}
+
 	ret = uverbs_get_flags32(&access_flags, attrs,
 				 UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
 				 valid_access_flags);
@@ -352,10 +359,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 
 	if (has_fd)
 		mr = pd->device->ops.reg_user_mr_dmabuf(pd, fd_offset, length, iova,
-							fd, access_flags, attrs);
+							fd, access_flags, dmah, attrs);
 	else
 		mr = pd->device->ops.reg_user_mr(pd, addr, length,
-						 iova, access_flags, NULL);
+						 iova, access_flags, dmah, NULL);
 
 	if (IS_ERR(mr))
 		return PTR_ERR(mr);
@@ -365,6 +372,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 	mr->type = IB_MR_TYPE_USER;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
+	if (dmah) {
+		mr->dmah = dmah;
+		atomic_inc(&dmah->usecnt);
+	}
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_set_name(&mr->res, NULL);
 	rdma_restrack_add(&mr->res);
@@ -488,6 +499,10 @@ DECLARE_UVERBS_NAMED_METHOD(
 			UVERBS_OBJECT_PD,
 			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
+	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_DMA_HANDLE,
+			UVERBS_OBJECT_DMAH,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL),
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_IOVA,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_MANDATORY),
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 75fde0fe9989..3a5f81402d2f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2223,7 +2223,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	}
 
 	mr = pd->device->ops.reg_user_mr(pd, start, length, virt_addr,
-					 access_flags, NULL);
+					 access_flags, NULL, NULL);
 
 	if (IS_ERR(mr))
 		return mr;
@@ -2262,6 +2262,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 {
 	struct ib_pd *pd = mr->pd;
 	struct ib_dm *dm = mr->dm;
+	struct ib_dmah *dmah = mr->dmah;
 	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
 	int ret;
 
@@ -2272,6 +2273,8 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 		atomic_dec(&pd->usecnt);
 		if (dm)
 			atomic_dec(&dm->usecnt);
+		if (dmah)
+			atomic_dec(&dmah->usecnt);
 		kfree(sig_attrs);
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3a627acb82ce..37c2bc3bdba5 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4235,6 +4235,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 				  u64 virt_addr, int mr_access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
@@ -4242,6 +4243,9 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct ib_umem *umem;
 	struct ib_mr *ib_mr;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
@@ -4255,6 +4259,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
 					 u64 length, u64 virt_addr, int fd,
 					 int mr_access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
@@ -4263,6 +4268,9 @@ struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
 	struct ib_umem *umem;
 	struct ib_mr *ib_mr;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, start, length,
 						fd, mr_access_flags);
 	if (IS_ERR(umem_dmabuf))
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 22c9eb8e9cfc..fe00ab691a51 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -258,10 +258,12 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 int bnxt_re_dealloc_mw(struct ib_mw *mw);
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int mr_access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata);
 struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
 					 u64 length, u64 virt_addr,
 					 int fd, int mr_access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs);
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 5b3007acaa1f..e17c1252536b 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1006,6 +1006,7 @@ int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 void c4iw_dealloc(struct uld_ctx *ctx);
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 					   u64 length, u64 virt, int acc,
+					   struct ib_dmah *dmah,
 					   struct ib_udata *udata);
 struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc);
 int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index a2c71a1d93d5..dcdfe250bdbe 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -489,7 +489,8 @@ struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc)
 }
 
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-			       u64 virt, int acc, struct ib_udata *udata)
+			       u64 virt, int acc, struct ib_dmah *dmah,
+			       struct ib_udata *udata)
 {
 	__be64 *pages;
 	int shift, n, i;
@@ -501,6 +502,9 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	pr_debug("ib_pd %p\n", pd);
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (length == ~0ULL)
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 838182d0409c..15cfca04fab8 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -164,10 +164,12 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
+			 struct ib_dmah *dmah,
 			 struct ib_udata *udata);
 struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 				     u64 length, u64 virt_addr,
 				     int fd, int access_flags,
+				     struct ib_dmah *dmah,
 				     struct uverbs_attr_bundle *attrs);
 int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 int efa_get_port_immutable(struct ib_device *ibdev, u32 port_num,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a8645a40730f..9cc5b224995f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1727,6 +1727,7 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
 struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 				     u64 length, u64 virt_addr,
 				     int fd, int access_flags,
+				     struct ib_dmah *dmah,
 				     struct uverbs_attr_bundle *attrs)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
@@ -1734,6 +1735,9 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 	struct efa_mr *mr;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = efa_alloc_mr(ibpd, access_flags, &attrs->driver_udata);
 	if (IS_ERR(mr)) {
 		err = PTR_ERR(mr);
@@ -1766,12 +1770,16 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
+			 struct ib_dmah *dmah,
 			 struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_mr *mr;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = efa_alloc_mr(ibpd, access_flags, udata);
 	if (IS_ERR(mr)) {
 		err = PTR_ERR(mr);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index ec0ad4086066..94c211df09d8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1200,13 +1200,17 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 }
 
 struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				u64 virt, int access, struct ib_udata *udata)
+				u64 virt, int access, struct ib_dmah *dmah,
+				struct ib_udata *udata)
 {
 	struct erdma_mr *mr = NULL;
 	struct erdma_dev *dev = to_edev(ibpd->device);
 	u32 stag;
 	int ret;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!len || len > dev->attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index f9408ccc8bad..ef411b81fbd7 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -452,7 +452,8 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext);
 int erdma_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				u64 virt, int access, struct ib_udata *udata);
+				u64 virt, int access, struct ib_dmah *dmah,
+				struct ib_udata *udata);
 struct ib_mr *erdma_get_dma_mr(struct ib_pd *ibpd, int rights);
 int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *data);
 int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 25f77b1fa773..78ee04a48a74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1219,6 +1219,7 @@ int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				   u64 virt_addr, int access_flags,
+				   struct ib_dmah *dmah,
 				   struct ib_udata *udata);
 struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 				     u64 length, u64 virt_addr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index ebef93559225..03af842dd9d3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -231,12 +231,16 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				   u64 virt_addr, int access_flags,
+				   struct ib_dmah *dmah,
 				   struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_mr *mr;
 	int ret;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr) {
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1e8c92826de2..da5a41b275d8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3013,10 +3013,12 @@ static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
  * @len: length of mr
  * @virt: virtual address
  * @access: access of mr
+ * @dmah: dma handle
  * @udata: user data
  */
 static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 				       u64 virt, int access,
+				       struct ib_dmah *dmah,
 				       struct ib_udata *udata)
 {
 #define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
@@ -3026,6 +3028,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct irdma_mr *iwmr = NULL;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
@@ -3085,6 +3090,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 					      u64 len, u64 virt,
 					      int fd, int access,
+					      struct ib_dmah *dmah,
 					      struct uverbs_attr_bundle *attrs)
 {
 	struct irdma_device *iwdev = to_iwdev(pd->device);
@@ -3092,6 +3098,9 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	struct irdma_mr *iwmr;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index eddd0a83b97e..03a1cb039343 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -624,6 +624,7 @@ struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags);
 
 struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 iova, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata);
 
 int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
@@ -713,5 +714,6 @@ int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 
 struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
 					 u64 iova, int fd, int mr_access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs);
 #endif
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 6d974d0a8400..55701046ffba 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -106,6 +106,7 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
 
 struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 				  u64 iova, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata)
 {
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
@@ -116,6 +117,9 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	u64 dma_region_handle;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	ibdev_dbg(ibdev,
@@ -188,6 +192,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 
 struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
 					 u64 iova, int fd, int access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs)
 {
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
@@ -199,6 +204,9 @@ struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 leng
 	u64 dma_region_handle;
 	int err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	access_flags &= ~IB_ACCESS_OPTIONAL;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index f53b1846594c..5df5b955114e 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -759,6 +759,7 @@ int mlx4_ib_umem_write_mtt(struct mlx4_ib_dev *dev, struct mlx4_mtt *mtt,
 			   struct ib_umem *umem);
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata);
 int mlx4_ib_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 int mlx4_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index e77645a673fb..94464f1694d9 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -139,6 +139,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
 
 struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(pd->device);
@@ -147,6 +148,9 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	int err;
 	int n;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a012e24d3afe..71916d730be0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1380,10 +1380,12 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata);
 struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 					 u64 length, u64 virt_addr,
 					 int fd, int access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs);
 int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      enum ib_uverbs_advise_mr_advice advice,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 41e897a7e652..8deff7cdf048 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1564,13 +1564,14 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 iova, int access_flags,
+				  struct ib_dmah *dmah,
 				  struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct ib_umem *umem;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(dev, "start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
@@ -1724,6 +1725,7 @@ reg_user_mr_dmabuf_by_data_direct(struct ib_pd *pd, u64 offset,
 struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 					 u64 length, u64 virt_addr,
 					 int fd, int access_flags,
+					 struct ib_dmah *dmah,
 					 struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -1731,7 +1733,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) ||
-	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) || dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_REG_DMABUF_MR_ACCESS_FLAGS)) {
@@ -1937,7 +1939,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	 */
 recreate:
 	return mlx5_ib_reg_user_mr(new_pd, start, length, iova,
-				   new_access_flags, udata);
+				   new_access_flags, NULL, udata);
 }
 
 static int
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6a1e2e79ddc3..dd572d76866c 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -825,7 +825,8 @@ static struct ib_mr *mthca_get_dma_mr(struct ib_pd *pd, int acc)
 }
 
 static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				       u64 virt, int acc, struct ib_udata *udata)
+				       u64 virt, int acc, struct ib_dmah *dmah,
+				       struct ib_udata *udata)
 {
 	struct mthca_dev *dev = to_mdev(pd->device);
 	struct ib_block_iter biter;
@@ -838,6 +839,9 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	int err = 0;
 	int write_mtt_size;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (udata->inlen < sizeof ucmd) {
 		if (!context->reg_mr_warned) {
 			mthca_warn(dev, "Process '%s' did not pass in MR attrs.\n",
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 979de8f8df14..46d911fd38de 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -847,13 +847,17 @@ static void build_user_pbes(struct ocrdma_dev *dev, struct ocrdma_mr *mr)
 }
 
 struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-				 u64 usr_addr, int acc, struct ib_udata *udata)
+				 u64 usr_addr, int acc, struct ib_dmah *dmah,
+				 struct ib_udata *udata)
 {
 	int status = -ENOMEM;
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibpd->device);
 	struct ocrdma_mr *mr;
 	struct ocrdma_pd *pd;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	pd = get_ocrdma_pd(ibpd);
 
 	if (acc & IB_ACCESS_REMOTE_WRITE && !(acc & IB_ACCESS_LOCAL_WRITE))
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 0644346d8d98..6c5c3755b8a9 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -98,7 +98,8 @@ int ocrdma_post_srq_recv(struct ib_srq *, const struct ib_recv_wr *,
 int ocrdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 struct ib_mr *ocrdma_get_dma_mr(struct ib_pd *, int acc);
 struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *, u64 start, u64 length,
-				 u64 virt, int acc, struct ib_udata *);
+				 u64 virt, int acc, struct ib_dmah *dmah,
+				 struct ib_udata *);
 struct ib_mr *ocrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			      u32 max_num_sg);
 int ocrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 568a5b18803f..ab9bf0922979 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2953,13 +2953,17 @@ static int init_mr_info(struct qedr_dev *dev, struct mr_info *info,
 }
 
 struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
-			       u64 usr_addr, int acc, struct ib_udata *udata)
+			       u64 usr_addr, int acc, struct ib_dmah *dmah,
+			       struct ib_udata *udata)
 {
 	struct qedr_dev *dev = get_qedr_dev(ibpd->device);
 	struct qedr_mr *mr;
 	struct qedr_pd *pd;
 	int rc = -ENOMEM;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	pd = get_qedr_pd(ibpd);
 	DP_DEBUG(dev, QEDR_MSG_MR,
 		 "qedr_register user mr pd = %d start = %lld, len = %lld, usr_addr = %lld, acc = %d\n",
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 5731458abb06..62420a15101b 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -79,7 +79,8 @@ int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 struct ib_mr *qedr_get_dma_mr(struct ib_pd *, int acc);
 
 struct ib_mr *qedr_reg_user_mr(struct ib_pd *, u64 start, u64 length,
-			       u64 virt, int acc, struct ib_udata *);
+			       u64 virt, int acc, struct ib_dmah *dmah,
+			       struct ib_udata *);
 
 int qedr_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		   int sg_nents, unsigned int *sg_offset);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 217af34e82b3..ae5df96589d9 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -592,6 +592,7 @@ int usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 					u64 virt_addr, int access_flags,
+					struct ib_dmah *dmah,
 					struct ib_udata *udata)
 {
 	struct usnic_ib_mr *mr;
@@ -600,6 +601,9 @@ struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 	usnic_dbg("start 0x%llx va 0x%llx length 0x%llx\n", start,
 			virt_addr, length);
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 53f53f2d53be..e3031ac32488 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -60,6 +60,7 @@ int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 int usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 				u64 virt_addr, int access_flags,
+				struct ib_dmah *dmah,
 				struct ib_udata *udata);
 int usnic_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 int usnic_ib_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
index e80848bfb3bd..ec7a00c8285b 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -104,12 +104,14 @@ struct ib_mr *pvrdma_get_dma_mr(struct ib_pd *pd, int acc)
  * @length: length of region
  * @virt_addr: I/O virtual address
  * @access_flags: access flags for memory region
+ * @dmah: dma handle
  * @udata: user data
  *
  * @return: ib_mr pointer on success, otherwise returns an errno.
  */
 struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				 u64 virt_addr, int access_flags,
+				 struct ib_dmah *dmah,
 				 struct ib_udata *udata)
 {
 	struct pvrdma_dev *dev = to_vdev(pd->device);
@@ -121,6 +123,9 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	struct pvrdma_cmd_create_mr_resp *resp = &rsp.create_mr_resp;
 	int ret, npages;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (length == 0 || length > dev->dsr->caps.max_mr_size) {
 		dev_warn(&dev->pdev->dev, "invalid mem region length\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index fd47b0b1df5c..603e5a9311eb 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -366,6 +366,7 @@ int pvrdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 struct ib_mr *pvrdma_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				 u64 virt_addr, int access_flags,
+				 struct ib_dmah *dmah,
 				 struct ib_udata *udata);
 int pvrdma_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
 struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 5ed5cfc2b280..86e482593a85 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -329,12 +329,14 @@ struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc)
  * @length: length of region to register
  * @virt_addr: associated virtual address
  * @mr_access_flags: access flags for this memory region
+ * @dmah: dma handle
  * @udata: unused by the driver
  *
  * Return: the memory region on success, otherwise returns an errno.
  */
 struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			      u64 virt_addr, int mr_access_flags,
+			      struct ib_dmah *dmah,
 			      struct ib_udata *udata)
 {
 	struct rvt_mr *mr;
@@ -343,6 +345,9 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	int n, m;
 	struct ib_mr *ret;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (length == 0)
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/infiniband/sw/rdmavt/mr.h b/drivers/infiniband/sw/rdmavt/mr.h
index 44afe2731741..72dab48307b7 100644
--- a/drivers/infiniband/sw/rdmavt/mr.h
+++ b/drivers/infiniband/sw/rdmavt/mr.h
@@ -26,6 +26,7 @@ void rvt_mr_exit(struct rvt_dev_info *rdi);
 struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			      u64 virt_addr, int mr_access_flags,
+			      struct ib_dmah *dmah,
 			      struct ib_udata *udata);
 int rvt_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2331e698a65b..f48d6e132954 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1271,6 +1271,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 				     u64 length, u64 iova, int access,
+				     struct ib_dmah *dmah,
 				     struct ib_udata *udata)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
@@ -1278,6 +1279,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	struct rxe_mr *mr;
 	int err, cleanup_err;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
 		rxe_err_pd(pd, "access = %#x not supported (%#x)\n", access,
 				RXE_ACCESS_SUPPORTED_MR);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 2b2a7b8e93b0..b784e18db463 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1321,10 +1321,12 @@ int siw_dereg_mr(struct ib_mr *base_mr, struct ib_udata *udata)
  * @len:	len of MR
  * @rnic_va:	not used by siw
  * @rights:	MR access rights
+ * @dmah:	dma handle
  * @udata:	user buffer to communicate STag and Key.
  */
 struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
-			      u64 rnic_va, int rights, struct ib_udata *udata)
+			      u64 rnic_va, int rights,  struct ib_dmah *dmah,
+			      struct ib_udata *udata)
 {
 	struct siw_mr *mr = NULL;
 	struct siw_umem *umem = NULL;
@@ -1332,6 +1334,9 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	int rv;
 
+	if (dmah)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	siw_dbg_pd(pd, "start: 0x%p, va: 0x%p, len: %llu\n",
 		   (void *)(uintptr_t)start, (void *)(uintptr_t)rnic_va,
 		   (unsigned long long)len);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 1f1a305540af..e9f4463aecdc 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -65,7 +65,8 @@ int siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata);
 int siw_poll_cq(struct ib_cq *base_cq, int num_entries, struct ib_wc *wc);
 int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags);
 struct ib_mr *siw_reg_user_mr(struct ib_pd *base_pd, u64 start, u64 len,
-			      u64 rnic_va, int rights, struct ib_udata *udata);
+			      u64 rnic_va, int rights, struct ib_dmah *dmah,
+			      struct ib_udata *udata);
 struct ib_mr *siw_alloc_mr(struct ib_pd *base_pd, enum ib_mr_type mr_type,
 			   u32 max_sge);
 struct ib_mr *siw_get_dma_mr(struct ib_pd *base_pd, int rights);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d7ee762b87e9..c263327a0205 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1887,6 +1887,7 @@ struct ib_mr {
 
 	struct ib_dm      *dm;
 	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
+	struct ib_dmah *dmah;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -2525,10 +2526,12 @@ struct ib_device_ops {
 	struct ib_mr *(*get_dma_mr)(struct ib_pd *pd, int mr_access_flags);
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
+				     struct ib_dmah *dmah,
 				     struct ib_udata *udata);
 	struct ib_mr *(*reg_user_mr_dmabuf)(struct ib_pd *pd, u64 offset,
 					    u64 length, u64 virt_addr, int fd,
 					    int mr_access_flags,
+					    struct ib_dmah *dmah,
 					    struct uverbs_attr_bundle *attrs);
 	struct ib_mr *(*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start,
 				       u64 length, u64 virt_addr,
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index a0b1130423f0..17f963014eca 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -307,6 +307,7 @@ enum uverbs_attrs_reg_dmabuf_mr_cmd_attr_ids {
 enum uverbs_attrs_reg_mr_cmd_attr_ids {
 	UVERBS_ATTR_REG_MR_HANDLE,
 	UVERBS_ATTR_REG_MR_PD_HANDLE,
+	UVERBS_ATTR_REG_MR_DMA_HANDLE,
 	UVERBS_ATTR_REG_MR_IOVA,
 	UVERBS_ATTR_REG_MR_ADDR,
 	UVERBS_ATTR_REG_MR_LENGTH,
-- 
2.50.0


