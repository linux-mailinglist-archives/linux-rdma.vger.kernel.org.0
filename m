Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1EC92203
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfHSLRt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLRt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:49 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76E62085A;
        Mon, 19 Aug 2019 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213468;
        bh=LyqzCzb4bb4PLX6qvZQCcU2RcM3A/qYLlX48oe0SEHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaeJt/E9ud73piwlBqSOihCqS2JTQle4J0sQqIJGImuGDEbeOSgO4FtbCN9FtUEHD
         FijNB2hbAGYOPffFXUAL57jT7SwMHgx26hzlH/D2y9KywVt10tG2WDTdW+/O6xVTUI
         buDJeY9s6mekezaBj8J7Qi8OR9QT8eZXA3tndo7o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 05/12] RDMA/odp: Make the three ways to create a umem_odp clear
Date:   Mon, 19 Aug 2019 14:17:03 +0300
Message-Id: <20190819111710.18440-6-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The three paths to build the umem_odps are kind of muddled, they are:
- As a normal ib_mr umem
- As a child in an implicit ODP umem tree
- As the root of an implicit ODP umem tree

Only the first two are actually umem's, the last is an abuse.

The implicit case can only be triggered by explicit driver request, it
should never be co-mingled with the normal case. While we are here, make
sensible function names and add some comments to make this clearer.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 80 +++++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/odp.c   | 23 ++++-----
 include/rdma/ib_umem_odp.h         |  6 ++-
 3 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 487a6371a053..9b1f779493e9 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -46,6 +46,8 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 
+#include "uverbs.h"
+
 static void ib_umem_notifier_start_account(struct ib_umem_odp *umem_odp)
 {
 	mutex_lock(&umem_odp->umem_mutex);
@@ -351,8 +353,67 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	return ret;
 }
 
-struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
-				      unsigned long addr, size_t size)
+/**
+ * ib_umem_odp_alloc_implicit - Allocate a parent implicit ODP umem
+ *
+ * Implicit ODP umems do not have a VA range and do not have any page lists.
+ * They exist only to hold the per_mm reference to help the driver create
+ * children umems.
+ *
+ * @udata: udata from the syscall being used to create the umem
+ * @access: ib_reg_mr access flags
+ */
+struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
+					       int access)
+{
+	struct ib_ucontext *context =
+		container_of(udata, struct uverbs_attr_bundle, driver_udata)
+			->context;
+	struct ib_umem *umem;
+	struct ib_umem_odp *umem_odp;
+	int ret;
+
+	if (access & IB_ACCESS_HUGETLB)
+		return ERR_PTR(-EINVAL);
+
+	if (!context)
+		return ERR_PTR(-EIO);
+	if (WARN_ON_ONCE(!context->invalidate_range))
+		return ERR_PTR(-EINVAL);
+
+	umem_odp = kzalloc(sizeof(*umem_odp), GFP_KERNEL);
+	if (!umem_odp)
+		return ERR_PTR(-ENOMEM);
+	umem = &umem_odp->umem;
+	umem->context = context;
+	umem->writable = ib_access_writable(access);
+	umem->owning_mm = current->mm;
+	umem_odp->is_implicit_odp = 1;
+	umem_odp->page_shift = PAGE_SHIFT;
+
+	ret = ib_init_umem_odp(umem_odp, NULL);
+	if (ret) {
+		kfree(umem_odp);
+		return ERR_PTR(ret);
+	}
+
+	mmgrab(umem->owning_mm);
+
+	return umem_odp;
+}
+EXPORT_SYMBOL(ib_umem_odp_alloc_implicit);
+
+/**
+ * ib_umem_odp_alloc_child - Allocate a child ODP umem under an implicit
+ *                           parent ODP umem
+ *
+ * @root: The parent umem enclosing the child. This must be allocated using
+ *        ib_alloc_implicit_odp_umem()
+ * @addr: The starting userspace VA
+ * @size: The length of the userspace VA
+ */
+struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
+					    unsigned long addr, size_t size)
 {
 	/*
 	 * Caller must ensure that root cannot be freed during the call to
@@ -362,6 +423,9 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 	struct ib_umem *umem;
 	int ret;
 
+	if (WARN_ON(!root->is_implicit_odp))
+		return ERR_PTR(-EINVAL);
+
 	odp_data = kzalloc(sizeof(*odp_data), GFP_KERNEL);
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
@@ -383,8 +447,15 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 
 	return odp_data;
 }
-EXPORT_SYMBOL(ib_alloc_odp_umem);
+EXPORT_SYMBOL(ib_umem_odp_alloc_child);
 
+/**
+ * ib_umem_odp_get - Complete ib_umem_get()
+ *
+ * @umem_odp: The partially configured umem from ib_umem_get()
+ * @addr: The starting userspace VA
+ * @access: ib_reg_mr access flags
+ */
 int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 {
 	/*
@@ -393,9 +464,6 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 	 */
 	struct mm_struct *mm = umem_odp->umem.owning_mm;
 
-	if (umem_odp->umem.address == 0 && umem_odp->umem.length == 0)
-		umem_odp->is_implicit_odp = 1;
-
 	umem_odp->page_shift = PAGE_SHIFT;
 	if (access & IB_ACCESS_HUGETLB) {
 		struct vm_area_struct *vma;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 5b6b2afa26a6..4371fc759c23 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -384,7 +384,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 }
 
 static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
-					    struct ib_umem *umem,
+					    struct ib_umem_odp *umem_odp,
 					    bool ksm, int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -402,7 +402,7 @@ static struct mlx5_ib_mr *implicit_mr_alloc(struct ib_pd *pd,
 	mr->dev = dev;
 	mr->access_flags = access_flags;
 	mr->mmkey.iova = 0;
-	mr->umem = umem;
+	mr->umem = &umem_odp->umem;
 
 	if (ksm) {
 		err = mlx5_ib_update_xlt(mr, 0,
@@ -462,14 +462,13 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *mr,
 		if (nentries)
 			nentries++;
 	} else {
-		odp = ib_alloc_odp_umem(odp_mr, addr,
-					MLX5_IMR_MTT_SIZE);
+		odp = ib_umem_odp_alloc_child(odp_mr, addr, MLX5_IMR_MTT_SIZE);
 		if (IS_ERR(odp)) {
 			mutex_unlock(&odp_mr->umem_mutex);
 			return ERR_CAST(odp);
 		}
 
-		mtt = implicit_mr_alloc(mr->ibmr.pd, &odp->umem, 0,
+		mtt = implicit_mr_alloc(mr->ibmr.pd, odp, 0,
 					mr->access_flags);
 		if (IS_ERR(mtt)) {
 			mutex_unlock(&odp_mr->umem_mutex);
@@ -519,19 +518,19 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags)
 {
 	struct mlx5_ib_mr *imr;
-	struct ib_umem *umem;
+	struct ib_umem_odp *umem_odp;
 
-	umem = ib_umem_get(udata, 0, 0, access_flags, 0);
-	if (IS_ERR(umem))
-		return ERR_CAST(umem);
+	umem_odp = ib_umem_odp_alloc_implicit(udata, access_flags);
+	if (IS_ERR(umem_odp))
+		return ERR_CAST(umem_odp);
 
-	imr = implicit_mr_alloc(&pd->ibpd, umem, 1, access_flags);
+	imr = implicit_mr_alloc(&pd->ibpd, umem_odp, 1, access_flags);
 	if (IS_ERR(imr)) {
-		ib_umem_release(umem);
+		ib_umem_release(&umem_odp->umem);
 		return ERR_CAST(imr);
 	}
 
-	imr->umem = umem;
+	imr->umem = &umem_odp->umem;
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 14b38b4459c5..219fe7015e7d 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -140,8 +140,10 @@ struct ib_ucontext_per_mm {
 };
 
 int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access);
-struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root_umem,
-				      unsigned long addr, size_t size);
+struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
+					       int access);
+struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem,
+					    unsigned long addr, size_t size);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);
 
 int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
-- 
2.20.1

