Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CAB921FE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfHSLRf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSLRf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:35 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EC82085A;
        Mon, 19 Aug 2019 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213454;
        bh=iCQI4x4JIdcl6S5yE/FVzBg1bu/HtlL84De0JbvijlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4O5AWZBFFVyCopYqqAcpjcVJoNs7Es6kTLyucoNFotAp9Q1VRpA4+MaqLO3RSdnL
         NdaXMXs2x9mFlNuHqZAP7LT2b4KWIHi+bTios/kKreW/Y99Z9Chimp7tSe8D3NhSEO
         jNXmCaxR+QYv1kiOxJ9eQDiUXx86s6EX/vjhfz9o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 06/12] RDMA/odp: Split creating a umem_odp from ib_umem_get
Date:   Mon, 19 Aug 2019 14:17:04 +0300
Message-Id: <20190819111710.18440-7-leon@kernel.org>
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

This is the last creation API that is overloaded for both, there is very
little code sharing and a driver has to be specifically ready for a
umem_odp to be created to use the odp version.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c     | 30 +++----------
 drivers/infiniband/core/umem_odp.c | 67 ++++++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/mem.c   | 13 ------
 drivers/infiniband/hw/mlx5/mr.c    | 34 +++++++++++----
 include/rdma/ib_umem_odp.h         |  9 ++--
 5 files changed, 86 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index f3bedbb7c4ab..ac7376401965 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -184,9 +184,6 @@ EXPORT_SYMBOL(ib_umem_find_best_pgsz);
 /**
  * ib_umem_get - Pin and DMA map userspace memory.
  *
- * If access flags indicate ODP memory, avoid pinning. Instead, stores
- * the mm for future page fault handling in conjunction with MMU notifiers.
- *
  * @udata: userspace context to pin memory for
  * @addr: userspace virtual address to start at
  * @size: length of region to pin
@@ -231,17 +228,12 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
-	if (access & IB_ACCESS_ON_DEMAND) {
-		umem = kzalloc(sizeof(struct ib_umem_odp), GFP_KERNEL);
-		if (!umem)
-			return ERR_PTR(-ENOMEM);
-		umem->is_odp = 1;
-	} else {
-		umem = kzalloc(sizeof(*umem), GFP_KERNEL);
-		if (!umem)
-			return ERR_PTR(-ENOMEM);
-	}
+	if (access & IB_ACCESS_ON_DEMAND)
+		return ERR_PTR(-EOPNOTSUPP);
 
+	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
+	if (!umem)
+		return ERR_PTR(-ENOMEM);
 	umem->context    = context;
 	umem->length     = size;
 	umem->address    = addr;
@@ -249,18 +241,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	umem->owning_mm = mm = current->mm;
 	mmgrab(mm);
 
-	if (access & IB_ACCESS_ON_DEMAND) {
-		if (WARN_ON_ONCE(!context->invalidate_range)) {
-			ret = -EINVAL;
-			goto umem_kfree;
-		}
-
-		ret = ib_umem_odp_get(to_ib_umem_odp(umem), access);
-		if (ret)
-			goto umem_kfree;
-		return umem;
-	}
-
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list) {
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 9b1f779493e9..79995766316a 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -342,6 +342,7 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				     &per_mm->umem_tree);
 		up_write(&per_mm->umem_rwsem);
 	}
+	mmgrab(umem_odp->umem.owning_mm);
 
 	return 0;
 
@@ -396,9 +397,6 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 		kfree(umem_odp);
 		return ERR_PTR(ret);
 	}
-
-	mmgrab(umem->owning_mm);
-
 	return umem_odp;
 }
 EXPORT_SYMBOL(ib_umem_odp_alloc_implicit);
@@ -442,27 +440,51 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 		kfree(odp_data);
 		return ERR_PTR(ret);
 	}
-
-	mmgrab(umem->owning_mm);
-
 	return odp_data;
 }
 EXPORT_SYMBOL(ib_umem_odp_alloc_child);
 
 /**
- * ib_umem_odp_get - Complete ib_umem_get()
+ * ib_umem_odp_get - Create a umem_odp for a userspace va
  *
- * @umem_odp: The partially configured umem from ib_umem_get()
- * @addr: The starting userspace VA
- * @access: ib_reg_mr access flags
+ * @udata: userspace context to pin memory for
+ * @addr: userspace virtual address to start at
+ * @size: length of region to pin
+ * @access: IB_ACCESS_xxx flags for memory being pinned
+ *
+ * The driver should use when the access flags indicate ODP memory. It avoids
+ * pinning, instead, stores the mm for future page fault handling in
+ * conjunction with MMU notifiers.
  */
-int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
+struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
+				    size_t size, int access)
 {
-	/*
-	 * NOTE: This must called in a process context where umem->owning_mm
-	 * == current->mm
-	 */
-	struct mm_struct *mm = umem_odp->umem.owning_mm;
+	struct ib_umem_odp *umem_odp;
+	struct ib_ucontext *context;
+	struct mm_struct *mm;
+	int ret;
+
+	if (!udata)
+		return ERR_PTR(-EIO);
+
+	context = container_of(udata, struct uverbs_attr_bundle, driver_udata)
+			  ->context;
+	if (!context)
+		return ERR_PTR(-EIO);
+
+	if (WARN_ON_ONCE(!(access & IB_ACCESS_ON_DEMAND)) ||
+	    WARN_ON_ONCE(!context->invalidate_range))
+		return ERR_PTR(-EINVAL);
+
+	umem_odp = kzalloc(sizeof(struct ib_umem_odp), GFP_KERNEL);
+	if (!umem_odp)
+		return ERR_PTR(-ENOMEM);
+
+	umem_odp->umem.context = context;
+	umem_odp->umem.length = size;
+	umem_odp->umem.address = addr;
+	umem_odp->umem.writable = ib_access_writable(access);
+	umem_odp->umem.owning_mm = mm = current->mm;
 
 	umem_odp->page_shift = PAGE_SHIFT;
 	if (access & IB_ACCESS_HUGETLB) {
@@ -473,15 +495,24 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 		vma = find_vma(mm, ib_umem_start(umem_odp));
 		if (!vma || !is_vm_hugetlb_page(vma)) {
 			up_read(&mm->mmap_sem);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_free;
 		}
 		h = hstate_vma(vma);
 		umem_odp->page_shift = huge_page_shift(h);
 		up_read(&mm->mmap_sem);
 	}
 
-	return ib_init_umem_odp(umem_odp, NULL);
+	ret = ib_init_umem_odp(umem_odp, NULL);
+	if (ret)
+		goto err_free;
+	return umem_odp;
+
+err_free:
+	kfree(umem_odp);
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL(ib_umem_odp_get);
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 {
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index a40e0abf2338..b5aece786b36 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -56,19 +56,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	struct scatterlist *sg;
 	int entry;
 
-	if (umem->is_odp) {
-		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
-		unsigned int page_shift = odp->page_shift;
-
-		*ncont = ib_umem_odp_num_pages(odp);
-		*count = *ncont << (page_shift - PAGE_SHIFT);
-		*shift = page_shift;
-		if (order)
-			*order = ilog2(roundup_pow_of_two(*ncont));
-
-		return;
-	}
-
 	addr = addr >> PAGE_SHIFT;
 	tmp = (unsigned long)addr;
 	m = find_first_bit(&tmp, BITS_PER_LONG);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e0015b612ffd..c9690d3cfb5c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -794,19 +794,37 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		       int *ncont, int *order)
 {
 	struct ib_umem *u;
-	int err;
 
 	*umem = NULL;
 
-	u = ib_umem_get(udata, start, length, access_flags, 0);
-	err = PTR_ERR_OR_ZERO(u);
-	if (err) {
-		mlx5_ib_dbg(dev, "umem get failed (%d)\n", err);
-		return err;
+	if (access_flags & IB_ACCESS_ON_DEMAND) {
+		struct ib_umem_odp *odp;
+
+		odp = ib_umem_odp_get(udata, start, length, access_flags);
+		if (IS_ERR(odp)) {
+			mlx5_ib_dbg(dev, "umem get failed (%ld)\n",
+				    PTR_ERR(odp));
+			return PTR_ERR(odp);
+		}
+
+		u = &odp->umem;
+
+		*page_shift = odp->page_shift;
+		*ncont = ib_umem_odp_num_pages(odp);
+		*npages = *ncont << (*page_shift - PAGE_SHIFT);
+		if (order)
+			*order = ilog2(roundup_pow_of_two(*ncont));
+	} else {
+		u = ib_umem_get(udata, start, length, access_flags, 0);
+		if (IS_ERR(u)) {
+			mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
+			return PTR_ERR(u);
+		}
+
+		mlx5_ib_cont_pages(u, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
+				   page_shift, ncont, order);
 	}
 
-	mlx5_ib_cont_pages(u, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
-			   page_shift, ncont, order);
 	if (!*npages) {
 		mlx5_ib_warn(dev, "avoid zero region\n");
 		ib_umem_release(u);
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 219fe7015e7d..5efb67f97b0a 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -139,7 +139,8 @@ struct ib_ucontext_per_mm {
 	struct rcu_head rcu;
 };
 
-int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access);
+struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
+				    size_t size, int access);
 struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 					       int access);
 struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem,
@@ -199,9 +200,11 @@ static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
 
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
-static inline int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
+static inline struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata,
+						  unsigned long addr,
+						  size_t size, int access)
 {
-	return -EINVAL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline void ib_umem_odp_release(struct ib_umem_odp *umem_odp) {}
-- 
2.20.1

