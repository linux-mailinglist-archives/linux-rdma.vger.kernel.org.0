Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F79921FD
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfHSLRb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSLRb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:31 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA97A20989;
        Mon, 19 Aug 2019 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213450;
        bh=sviunBYRIfhAPFQ0P/Ts+x66xXFrc4MCM6jQ8xFFFVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sf/eTkEwimEC5n9NxBr75GM3aG/meV7OslbWXkSSWsd6gI+CiVAt8ZhLESCRu2VEu
         ICE7mU2L0PF7yVY3+B6HoqwVSsCNFn0x2jn5lJhqRCSiBhMm5f62P/iPZ+sXrOhzi6
         W1rAgPJRbc4V8StraSwwu29POQwcMLx309J3T904=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 04/12] RMDA/odp: Consolidate umem_odp initialization
Date:   Mon, 19 Aug 2019 14:17:02 +0300
Message-Id: <20190819111710.18440-5-leon@kernel.org>
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

This is done in two different places, consolidate all the post-allocation
initialization into a single function.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 200 +++++++++++++----------------
 1 file changed, 86 insertions(+), 114 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2eb184a5374a..487a6371a053 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -178,23 +178,6 @@ static const struct mmu_notifier_ops ib_umem_notifiers = {
 	.invalidate_range_end       = ib_umem_notifier_invalidate_range_end,
 };
 
-static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
-{
-	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-
-	down_write(&per_mm->umem_rwsem);
-	/*
-	 * Note that the representation of the intervals in the interval tree
-	 * considers the ending point as contained in the interval, while the
-	 * function ib_umem_end returns the first address which is not
-	 * contained in the umem.
-	 */
-	umem_odp->interval_tree.start = ib_umem_start(umem_odp);
-	umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
-	interval_tree_insert(&umem_odp->interval_tree, &per_mm->umem_tree);
-	up_write(&per_mm->umem_rwsem);
-}
-
 static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
 {
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
@@ -244,33 +227,23 @@ static struct ib_ucontext_per_mm *alloc_per_mm(struct ib_ucontext *ctx,
 	return ERR_PTR(ret);
 }
 
-static int get_per_mm(struct ib_umem_odp *umem_odp)
+static struct ib_ucontext_per_mm *get_per_mm(struct ib_umem_odp *umem_odp)
 {
 	struct ib_ucontext *ctx = umem_odp->umem.context;
 	struct ib_ucontext_per_mm *per_mm;
 
+	lockdep_assert_held(&ctx->per_mm_list_lock);
+
 	/*
 	 * Generally speaking we expect only one or two per_mm in this list,
 	 * so no reason to optimize this search today.
 	 */
-	mutex_lock(&ctx->per_mm_list_lock);
 	list_for_each_entry(per_mm, &ctx->per_mm_list, ucontext_list) {
 		if (per_mm->mm == umem_odp->umem.owning_mm)
-			goto found;
-	}
-
-	per_mm = alloc_per_mm(ctx, umem_odp->umem.owning_mm);
-	if (IS_ERR(per_mm)) {
-		mutex_unlock(&ctx->per_mm_list_lock);
-		return PTR_ERR(per_mm);
+			return per_mm;
 	}
 
-found:
-	umem_odp->per_mm = per_mm;
-	per_mm->odp_mrs_count++;
-	mutex_unlock(&ctx->per_mm_list_lock);
-
-	return 0;
+	return alloc_per_mm(ctx, umem_odp->umem.owning_mm);
 }
 
 static void free_per_mm(struct rcu_head *rcu)
@@ -311,79 +284,114 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
 	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
 }
 
+static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
+				   struct ib_ucontext_per_mm *per_mm)
+{
+	struct ib_ucontext *ctx = umem_odp->umem.context;
+	int ret;
+
+	umem_odp->umem.is_odp = 1;
+	if (!umem_odp->is_implicit_odp) {
+		size_t pages = ib_umem_odp_num_pages(umem_odp);
+
+		if (!pages)
+			return -EINVAL;
+
+		/*
+		 * Note that the representation of the intervals in the
+		 * interval tree considers the ending point as contained in
+		 * the interval, while the function ib_umem_end returns the
+		 * first address which is not contained in the umem.
+		 */
+		umem_odp->interval_tree.start = ib_umem_start(umem_odp);
+		umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
+
+		umem_odp->page_list = vzalloc(
+			array_size(sizeof(*umem_odp->page_list), pages));
+		if (!umem_odp->page_list)
+			return -ENOMEM;
+
+		umem_odp->dma_list =
+			vzalloc(array_size(sizeof(*umem_odp->dma_list), pages));
+		if (!umem_odp->dma_list) {
+			ret = -ENOMEM;
+			goto out_page_list;
+		}
+	}
+
+	mutex_lock(&ctx->per_mm_list_lock);
+	if (!per_mm) {
+		per_mm = get_per_mm(umem_odp);
+		if (IS_ERR(per_mm)) {
+			ret = PTR_ERR(per_mm);
+			goto out_unlock;
+		}
+	}
+	umem_odp->per_mm = per_mm;
+	per_mm->odp_mrs_count++;
+	mutex_unlock(&ctx->per_mm_list_lock);
+
+	mutex_init(&umem_odp->umem_mutex);
+	init_completion(&umem_odp->notifier_completion);
+
+	if (!umem_odp->is_implicit_odp) {
+		down_write(&per_mm->umem_rwsem);
+		interval_tree_insert(&umem_odp->interval_tree,
+				     &per_mm->umem_tree);
+		up_write(&per_mm->umem_rwsem);
+	}
+
+	return 0;
+
+out_unlock:
+	mutex_unlock(&ctx->per_mm_list_lock);
+	vfree(umem_odp->dma_list);
+out_page_list:
+	vfree(umem_odp->page_list);
+	return ret;
+}
+
 struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 				      unsigned long addr, size_t size)
 {
-	struct ib_ucontext_per_mm *per_mm = root->per_mm;
-	struct ib_ucontext *ctx = per_mm->context;
+	/*
+	 * Caller must ensure that root cannot be freed during the call to
+	 * ib_alloc_odp_umem.
+	 */
 	struct ib_umem_odp *odp_data;
 	struct ib_umem *umem;
-	int pages = size >> PAGE_SHIFT;
 	int ret;
 
-	if (!size)
-		return ERR_PTR(-EINVAL);
-
 	odp_data = kzalloc(sizeof(*odp_data), GFP_KERNEL);
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
 	umem = &odp_data->umem;
-	umem->context    = ctx;
+	umem->context    = root->umem.context;
 	umem->length     = size;
 	umem->address    = addr;
-	odp_data->page_shift = PAGE_SHIFT;
 	umem->writable   = root->umem.writable;
-	umem->is_odp = 1;
-	odp_data->per_mm = per_mm;
-	umem->owning_mm  = per_mm->mm;
-	mmgrab(umem->owning_mm);
-
-	mutex_init(&odp_data->umem_mutex);
-	init_completion(&odp_data->notifier_completion);
-
-	odp_data->page_list =
-		vzalloc(array_size(pages, sizeof(*odp_data->page_list)));
-	if (!odp_data->page_list) {
-		ret = -ENOMEM;
-		goto out_odp_data;
-	}
+	umem->owning_mm  = root->umem.owning_mm;
+	odp_data->page_shift = PAGE_SHIFT;
 
-	odp_data->dma_list =
-		vzalloc(array_size(pages, sizeof(*odp_data->dma_list)));
-	if (!odp_data->dma_list) {
-		ret = -ENOMEM;
-		goto out_page_list;
+	ret = ib_init_umem_odp(odp_data, root->per_mm);
+	if (ret) {
+		kfree(odp_data);
+		return ERR_PTR(ret);
 	}
 
-	/*
-	 * Caller must ensure that the umem_odp that the per_mm came from
-	 * cannot be freed during the call to ib_alloc_odp_umem.
-	 */
-	mutex_lock(&ctx->per_mm_list_lock);
-	per_mm->odp_mrs_count++;
-	mutex_unlock(&ctx->per_mm_list_lock);
-	add_umem_to_per_mm(odp_data);
+	mmgrab(umem->owning_mm);
 
 	return odp_data;
-
-out_page_list:
-	vfree(odp_data->page_list);
-out_odp_data:
-	mmdrop(umem->owning_mm);
-	kfree(odp_data);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(ib_alloc_odp_umem);
 
 int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 {
-	struct ib_umem *umem = &umem_odp->umem;
 	/*
 	 * NOTE: This must called in a process context where umem->owning_mm
 	 * == current->mm
 	 */
-	struct mm_struct *mm = umem->owning_mm;
-	int ret_val;
+	struct mm_struct *mm = umem_odp->umem.owning_mm;
 
 	if (umem_odp->umem.address == 0 && umem_odp->umem.length == 0)
 		umem_odp->is_implicit_odp = 1;
@@ -404,43 +412,7 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 		up_read(&mm->mmap_sem);
 	}
 
-	mutex_init(&umem_odp->umem_mutex);
-
-	init_completion(&umem_odp->notifier_completion);
-
-	if (!umem_odp->is_implicit_odp) {
-		if (!ib_umem_odp_num_pages(umem_odp))
-			return -EINVAL;
-
-		umem_odp->page_list =
-			vzalloc(array_size(sizeof(*umem_odp->page_list),
-					   ib_umem_odp_num_pages(umem_odp)));
-		if (!umem_odp->page_list)
-			return -ENOMEM;
-
-		umem_odp->dma_list =
-			vzalloc(array_size(sizeof(*umem_odp->dma_list),
-					   ib_umem_odp_num_pages(umem_odp)));
-		if (!umem_odp->dma_list) {
-			ret_val = -ENOMEM;
-			goto out_page_list;
-		}
-	}
-
-	ret_val = get_per_mm(umem_odp);
-	if (ret_val)
-		goto out_dma_list;
-
-	if (!umem_odp->is_implicit_odp)
-		add_umem_to_per_mm(umem_odp);
-
-	return 0;
-
-out_dma_list:
-	vfree(umem_odp->dma_list);
-out_page_list:
-	vfree(umem_odp->page_list);
-	return ret_val;
+	return ib_init_umem_odp(umem_odp, NULL);
 }
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
-- 
2.20.1

