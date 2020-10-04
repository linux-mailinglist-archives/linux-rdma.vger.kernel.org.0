Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844D282CA8
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgJDTAE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 15:00:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:32498 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTAE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 15:00:04 -0400
IronPort-SDR: /n4tWDzRIDLTlyKozM/DlZUYhDD+RTpVqD3Eor/ZLBjLicJ5hE5C0iUGhVR+9Od9hvTSXK89O9
 3+dc7fKgBMzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="163406564"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="163406564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 12:00:02 -0700
IronPort-SDR: 3yG7YJtN0czfcZL4a4DMwg99DwtHYnh8OBm3q1cmT3nmeqrP82QWSN79ec7s4wcc87QUVoOJAQ
 FrQFgX3xX/EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="295384726"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2020 12:00:02 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v3 3/4] RDMA/mlx5: Support dma-buf based userspace memory region
Date:   Sun,  4 Oct 2020 12:12:30 -0700
Message-Id: <1601838751-148544-4-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Recognize the new access flag and call the core function to import
dma-buf based memory region.

Since the invalidation callback is called from the dma-buf driver
instead of mmu_interval_notifier, the part inside the ODP pagefault
handler that checks for on-going invalidation is modified to handle
the difference.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 50 +++++++++++++++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/odp.c | 22 ++++++++++++++++--
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3c91e32..d58be20 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -912,6 +912,44 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
 	return 0;
 }
 
+static int mr_umem_dmabuf_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
+			      int dmabuf_fd, int access_flags,
+			      struct ib_umem **umem, int *npages,
+			      int *page_shift, int *ncont, int *order)
+{
+	struct ib_umem *u;
+	struct ib_umem_odp *odp;
+
+	*umem = NULL;
+
+	u = ib_umem_dmabuf_get(&dev->ib_dev, start, length, dmabuf_fd,
+			       access_flags, &mlx5_mn_ops);
+	if (IS_ERR(u)) {
+		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
+		return PTR_ERR(u);
+	}
+
+	odp = to_ib_umem_odp(u);
+	*page_shift = odp->page_shift;
+	*ncont = ib_umem_odp_num_pages(odp);
+	*npages = *ncont << (*page_shift - PAGE_SHIFT);
+	if (order)
+		*order = ilog2(roundup_pow_of_two(*ncont));
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
@@ -1382,9 +1420,15 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd,
 		return &mr->ibmr;
 	}
 
-	err = mr_umem_get(dev, attr->start, attr->length,
-			  attr->access_flags, &umem,
-			  &npages, &page_shift, &ncont, &order);
+	if (attr->access_flags & IB_ACCESS_DMABUF)
+		err = mr_umem_dmabuf_get(dev, attr->start, attr->length,
+					 attr->fd, attr->access_flags,
+					 &umem, &npages, &page_shift, &ncont,
+					 &order);
+	else
+		err = mr_umem_get(dev, attr->start, attr->length,
+				  attr->access_flags, &umem,
+				  &npages, &page_shift, &ncont, &order);
 	if (err < 0)
 		return ERR_PTR(err);
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index cfd7efa..f2ca3f8 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -665,6 +665,24 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
 	dma_fence_odp_mr(mr);
 }
 
+static inline unsigned long notifier_read_begin(struct ib_umem_odp *odp)
+{
+	if (odp->umem.is_dmabuf)
+		return ib_umem_dmabuf_notifier_read_begin(odp);
+	else
+		return mmu_interval_read_begin(&odp->notifier);
+}
+
+static inline int notifier_read_retry(struct ib_umem_odp *odp,
+				      unsigned long current_seq)
+{
+	if (odp->umem.is_dmabuf) {
+		return ib_umem_dmabuf_notifier_read_retry(odp, current_seq);
+	} else {
+		return mmu_interval_read_retry(&odp->notifier, current_seq);
+	}
+}
+
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
@@ -683,7 +701,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
-	current_seq = mmu_interval_read_begin(&odp->notifier);
+	current_seq = notifier_read_begin(odp);
 
 	np = ib_umem_odp_map_dma_pages(odp, user_va, bcnt, access_mask,
 				       current_seq);
@@ -691,7 +709,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 		return np;
 
 	mutex_lock(&odp->umem_mutex);
-	if (!mmu_interval_read_retry(&odp->notifier, current_seq)) {
+	if (!notifier_read_retry(odp, current_seq)) {
 		/*
 		 * No need to check whether the MTTs really belong to
 		 * this MR, since ib_umem_odp_map_dma_pages already
-- 
1.8.3.1

