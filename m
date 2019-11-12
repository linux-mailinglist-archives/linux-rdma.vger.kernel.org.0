Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4016CF9A7E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLUW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37598 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLUW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id g50so21229506qtb.4
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzBbOWCxKZh+cdtoh3q/T1dV0tEgKiGKeoYY4ENd0lI=;
        b=hxlcUA35dIJ7ZTxuJ6I2F+X4UIQXWwD4F9B/KOdHgDO0MDZk7hbxmngA8xWhHfva0C
         GTO8bcyvcemO0MLGmFzF/zXMzOkdbSZ5S4yyHO9fJwd2bcTqIM/mPrOmqWncKIk9U2Ax
         NMGGAUdYfsMwfC22ZtNajVcLj0d3uLYGr2CEPCP/nLBXpjQ7BYKFo/dWTJEhswSRuzL0
         Zr5FNpZqzYtIVtWp27UHffE0IPoNr1OEttLstivBmu6q+JSsCzebt44ktVwWBjFZO+aS
         ki2L9iCRTAJJcxBI3OwTgSV0FcASoFmHfaUIrliz1rRm3vacNtEtpnrefMkCyM5WcCNG
         wKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzBbOWCxKZh+cdtoh3q/T1dV0tEgKiGKeoYY4ENd0lI=;
        b=SFYc9QPVlHQmnpocp50m9pCxYPMH/HLdnKIgXylfhfT12X1/1sdgIYS6QddKiiZ7ph
         u4e9WQCi1/sHtdMEp2VHYkPFyBKIKi5TGuY2rCc73Dt8BUZSUCzilGpd/fYqzYgvutK+
         CquzCIGqCkBiJIR+HCZfB5vQPmUFPP/hQ8ZsUnnrKPsxpVs+lZgw1a4xDV8sO8q/0TQu
         SiyN+CXJREBUN3Qllb+QOLYeznZWvYYlb6T1/vsW8Yq2CNI8oaY/OoVAUUy+URqFEA6I
         JL3qwL+w/Hkz43+jSv2N3i3KgUBx60J3RdMUA1uhwuJUNE3/8zi3yXPSGEE6tAzbM2oN
         D2CA==
X-Gm-Message-State: APjAAAW7yisE3Jm1wisdPITQ91JmXhOkSQH2hLbMHxgr0yCW9MKwqVxI
        OowvN7QWU1/lrZSaCf/gxw2tGg==
X-Google-Smtp-Source: APXvYqxu7SJ/mVMkw3vmBcyZaKcGGZcaJusbCaEAqmtA8bZg06/oxd/+7uSG8a9wMIOFTEKi4zbLEg==
X-Received: by 2002:ac8:30cd:: with SMTP id w13mr33149349qta.201.1573590174357;
        Tue, 12 Nov 2019 12:22:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o1sm11425992qtb.82.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003jy-C1; Tue, 12 Nov 2019 16:22:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH v3 05/14] RDMA/odp: Use mmu_interval_notifier_insert()
Date:   Tue, 12 Nov 2019 16:22:22 -0400
Message-Id: <20191112202231.3856-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112202231.3856-1-jgg@ziepe.ca>
References: <20191112202231.3856-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Replace the internal interval tree based mmu notifier with the new common
mmu_interval_notifier_insert() API. This removes a lot of code and fixes a
deadlock that can be triggered in ODP:

 zap_page_range()
  mmu_notifier_invalidate_range_start()
   [..]
    ib_umem_notifier_invalidate_range_start()
       down_read(&per_mm->umem_rwsem)
  unmap_single_vma()
    [..]
      __split_huge_page_pmd()
        mmu_notifier_invalidate_range_start()
        [..]
           ib_umem_notifier_invalidate_range_start()
              down_read(&per_mm->umem_rwsem)   // DEADLOCK

        mmu_notifier_invalidate_range_end()
           up_read(&per_mm->umem_rwsem)
  mmu_notifier_invalidate_range_end()
     up_read(&per_mm->umem_rwsem)

The umem_rwsem is held across the range_start/end as the ODP algorithm for
invalidate_range_end cannot tolerate changes to the interval
tree. However, due to the nested invalidation regions the second
down_read() can deadlock if there are competing writers. The new core code
provides an alternative scheme to solve this problem.

Fixes: ca748c39ea3f ("RDMA/umem: Get rid of per_mm->notifier_count")
Tested-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/device.c     |   1 -
 drivers/infiniband/core/umem_odp.c   | 303 ++++-----------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   7 +-
 drivers/infiniband/hw/mlx5/mr.c      |   3 +-
 drivers/infiniband/hw/mlx5/odp.c     |  50 ++---
 include/rdma/ib_umem_odp.h           |  68 ++----
 include/rdma/ib_verbs.h              |   2 -
 7 files changed, 82 insertions(+), 352 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2dd2cfe9b56136..ac7924b3c73abe 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2617,7 +2617,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
 	SET_DEVICE_OP(dev_ops, init_port);
-	SET_DEVICE_OP(dev_ops, invalidate_range);
 	SET_DEVICE_OP(dev_ops, iw_accept);
 	SET_DEVICE_OP(dev_ops, iw_add_ref);
 	SET_DEVICE_OP(dev_ops, iw_connect);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index d7d5fadf0899ad..e42d44e501fd54 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -48,197 +48,33 @@
 
 #include "uverbs.h"
 
-static void ib_umem_notifier_start_account(struct ib_umem_odp *umem_odp)
+static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
+				   const struct mmu_interval_notifier_ops *ops)
 {
-	mutex_lock(&umem_odp->umem_mutex);
-	if (umem_odp->notifiers_count++ == 0)
-		/*
-		 * Initialize the completion object for waiting on
-		 * notifiers. Since notifier_count is zero, no one should be
-		 * waiting right now.
-		 */
-		reinit_completion(&umem_odp->notifier_completion);
-	mutex_unlock(&umem_odp->umem_mutex);
-}
-
-static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
-{
-	mutex_lock(&umem_odp->umem_mutex);
-	/*
-	 * This sequence increase will notify the QP page fault that the page
-	 * that is going to be mapped in the spte could have been freed.
-	 */
-	++umem_odp->notifiers_seq;
-	if (--umem_odp->notifiers_count == 0)
-		complete_all(&umem_odp->notifier_completion);
-	mutex_unlock(&umem_odp->umem_mutex);
-}
-
-static void ib_umem_notifier_release(struct mmu_notifier *mn,
-				     struct mm_struct *mm)
-{
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-	struct rb_node *node;
-
-	down_read(&per_mm->umem_rwsem);
-	if (!per_mm->mn.users)
-		goto out;
-
-	for (node = rb_first_cached(&per_mm->umem_tree); node;
-	     node = rb_next(node)) {
-		struct ib_umem_odp *umem_odp =
-			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
-
-		/*
-		 * Increase the number of notifiers running, to prevent any
-		 * further fault handling on this MR.
-		 */
-		ib_umem_notifier_start_account(umem_odp);
-		complete_all(&umem_odp->notifier_completion);
-		umem_odp->umem.ibdev->ops.invalidate_range(
-			umem_odp, ib_umem_start(umem_odp),
-			ib_umem_end(umem_odp));
-	}
-
-out:
-	up_read(&per_mm->umem_rwsem);
-}
-
-static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
-					     u64 start, u64 end, void *cookie)
-{
-	ib_umem_notifier_start_account(item);
-	item->umem.ibdev->ops.invalidate_range(item, start, end);
-	return 0;
-}
-
-static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
-				const struct mmu_notifier_range *range)
-{
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-	int rc;
-
-	if (mmu_notifier_range_blockable(range))
-		down_read(&per_mm->umem_rwsem);
-	else if (!down_read_trylock(&per_mm->umem_rwsem))
-		return -EAGAIN;
-
-	if (!per_mm->mn.users) {
-		up_read(&per_mm->umem_rwsem);
-		/*
-		 * At this point users is permanently zero and visible to this
-		 * CPU without a lock, that fact is relied on to skip the unlock
-		 * in range_end.
-		 */
-		return 0;
-	}
-
-	rc = rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
-					   range->end,
-					   invalidate_range_start_trampoline,
-					   mmu_notifier_range_blockable(range),
-					   NULL);
-	if (rc)
-		up_read(&per_mm->umem_rwsem);
-	return rc;
-}
-
-static int invalidate_range_end_trampoline(struct ib_umem_odp *item, u64 start,
-					   u64 end, void *cookie)
-{
-	ib_umem_notifier_end_account(item);
-	return 0;
-}
-
-static void ib_umem_notifier_invalidate_range_end(struct mmu_notifier *mn,
-				const struct mmu_notifier_range *range)
-{
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-
-	if (unlikely(!per_mm->mn.users))
-		return;
-
-	rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
-				      range->end,
-				      invalidate_range_end_trampoline, true, NULL);
-	up_read(&per_mm->umem_rwsem);
-}
-
-static struct mmu_notifier *ib_umem_alloc_notifier(struct mm_struct *mm)
-{
-	struct ib_ucontext_per_mm *per_mm;
-
-	per_mm = kzalloc(sizeof(*per_mm), GFP_KERNEL);
-	if (!per_mm)
-		return ERR_PTR(-ENOMEM);
-
-	per_mm->umem_tree = RB_ROOT_CACHED;
-	init_rwsem(&per_mm->umem_rwsem);
-
-	WARN_ON(mm != current->mm);
-	rcu_read_lock();
-	per_mm->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
-	rcu_read_unlock();
-	return &per_mm->mn;
-}
-
-static void ib_umem_free_notifier(struct mmu_notifier *mn)
-{
-	struct ib_ucontext_per_mm *per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-
-	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
-
-	put_pid(per_mm->tgid);
-	kfree(per_mm);
-}
-
-static const struct mmu_notifier_ops ib_umem_notifiers = {
-	.release                    = ib_umem_notifier_release,
-	.invalidate_range_start     = ib_umem_notifier_invalidate_range_start,
-	.invalidate_range_end       = ib_umem_notifier_invalidate_range_end,
-	.alloc_notifier		    = ib_umem_alloc_notifier,
-	.free_notifier		    = ib_umem_free_notifier,
-};
-
-static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
-{
-	struct ib_ucontext_per_mm *per_mm;
-	struct mmu_notifier *mn;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
+	mutex_init(&umem_odp->umem_mutex);
+
 	if (!umem_odp->is_implicit_odp) {
 		size_t page_size = 1UL << umem_odp->page_shift;
+		unsigned long start;
+		unsigned long end;
 		size_t pages;
 
-		umem_odp->interval_tree.start =
-			ALIGN_DOWN(umem_odp->umem.address, page_size);
+		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
 		if (check_add_overflow(umem_odp->umem.address,
 				       (unsigned long)umem_odp->umem.length,
-				       &umem_odp->interval_tree.last))
+				       &end))
 			return -EOVERFLOW;
-		umem_odp->interval_tree.last =
-			ALIGN(umem_odp->interval_tree.last, page_size);
-		if (unlikely(umem_odp->interval_tree.last < page_size))
+		end = ALIGN(end, page_size);
+		if (unlikely(end < page_size))
 			return -EOVERFLOW;
 
-		pages = (umem_odp->interval_tree.last -
-			 umem_odp->interval_tree.start) >>
-			umem_odp->page_shift;
+		pages = (end - start) >> umem_odp->page_shift;
 		if (!pages)
 			return -EINVAL;
 
-		/*
-		 * Note that the representation of the intervals in the
-		 * interval tree considers the ending point as contained in
-		 * the interval.
-		 */
-		umem_odp->interval_tree.last--;
-
 		umem_odp->page_list = kvcalloc(
 			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
 		if (!umem_odp->page_list)
@@ -250,26 +86,13 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
 			ret = -ENOMEM;
 			goto out_page_list;
 		}
-	}
 
-	mn = mmu_notifier_get(&ib_umem_notifiers, umem_odp->umem.owning_mm);
-	if (IS_ERR(mn)) {
-		ret = PTR_ERR(mn);
-		goto out_dma_list;
+		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
+						   umem_odp->umem.owning_mm,
+						   start, end - start, ops);
+		if (ret)
+			goto out_dma_list;
 	}
-	umem_odp->per_mm = per_mm =
-		container_of(mn, struct ib_ucontext_per_mm, mn);
-
-	mutex_init(&umem_odp->umem_mutex);
-	init_completion(&umem_odp->notifier_completion);
-
-	if (!umem_odp->is_implicit_odp) {
-		down_write(&per_mm->umem_rwsem);
-		interval_tree_insert(&umem_odp->interval_tree,
-				     &per_mm->umem_tree);
-		up_write(&per_mm->umem_rwsem);
-	}
-	mmgrab(umem_odp->umem.owning_mm);
 
 	return 0;
 
@@ -305,8 +128,6 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 
 	if (!context)
 		return ERR_PTR(-EIO);
-	if (WARN_ON_ONCE(!context->device->ops.invalidate_range))
-		return ERR_PTR(-EINVAL);
 
 	umem_odp = kzalloc(sizeof(*umem_odp), GFP_KERNEL);
 	if (!umem_odp)
@@ -318,8 +139,10 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 	umem_odp->is_implicit_odp = 1;
 	umem_odp->page_shift = PAGE_SHIFT;
 
-	ret = ib_init_umem_odp(umem_odp);
+	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
+	ret = ib_init_umem_odp(umem_odp, NULL);
 	if (ret) {
+		put_pid(umem_odp->tgid);
 		kfree(umem_odp);
 		return ERR_PTR(ret);
 	}
@@ -336,8 +159,10 @@ EXPORT_SYMBOL(ib_umem_odp_alloc_implicit);
  * @addr: The starting userspace VA
  * @size: The length of the userspace VA
  */
-struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
-					    unsigned long addr, size_t size)
+struct ib_umem_odp *
+ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
+			size_t size,
+			const struct mmu_interval_notifier_ops *ops)
 {
 	/*
 	 * Caller must ensure that root cannot be freed during the call to
@@ -360,9 +185,12 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 	umem->writable   = root->umem.writable;
 	umem->owning_mm  = root->umem.owning_mm;
 	odp_data->page_shift = PAGE_SHIFT;
+	odp_data->notifier.ops = ops;
 
-	ret = ib_init_umem_odp(odp_data);
+	odp_data->tgid = get_pid(root->tgid);
+	ret = ib_init_umem_odp(odp_data, ops);
 	if (ret) {
+		put_pid(odp_data->tgid);
 		kfree(odp_data);
 		return ERR_PTR(ret);
 	}
@@ -383,7 +211,8 @@ EXPORT_SYMBOL(ib_umem_odp_alloc_child);
  * conjunction with MMU notifiers.
  */
 struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
-				    size_t size, int access)
+				    size_t size, int access,
+				    const struct mmu_interval_notifier_ops *ops)
 {
 	struct ib_umem_odp *umem_odp;
 	struct ib_ucontext *context;
@@ -398,8 +227,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 	if (!context)
 		return ERR_PTR(-EIO);
 
-	if (WARN_ON_ONCE(!(access & IB_ACCESS_ON_DEMAND)) ||
-	    WARN_ON_ONCE(!context->device->ops.invalidate_range))
+	if (WARN_ON_ONCE(!(access & IB_ACCESS_ON_DEMAND)))
 		return ERR_PTR(-EINVAL);
 
 	umem_odp = kzalloc(sizeof(struct ib_umem_odp), GFP_KERNEL);
@@ -411,6 +239,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 	umem_odp->umem.address = addr;
 	umem_odp->umem.writable = ib_access_writable(access);
 	umem_odp->umem.owning_mm = mm = current->mm;
+	umem_odp->notifier.ops = ops;
 
 	umem_odp->page_shift = PAGE_SHIFT;
 	if (access & IB_ACCESS_HUGETLB) {
@@ -429,11 +258,14 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 		up_read(&mm->mmap_sem);
 	}
 
-	ret = ib_init_umem_odp(umem_odp);
+	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
+	ret = ib_init_umem_odp(umem_odp, ops);
 	if (ret)
-		goto err_free;
+		goto err_put_pid;
 	return umem_odp;
 
+err_put_pid:
+	put_pid(umem_odp->tgid);
 err_free:
 	kfree(umem_odp);
 	return ERR_PTR(ret);
@@ -442,8 +274,6 @@ EXPORT_SYMBOL(ib_umem_odp_get);
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 {
-	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-
 	/*
 	 * Ensure that no more pages are mapped in the umem.
 	 *
@@ -455,28 +285,11 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
 					    ib_umem_end(umem_odp));
 		mutex_unlock(&umem_odp->umem_mutex);
+		mmu_interval_notifier_remove(&umem_odp->notifier);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->page_list);
+		put_pid(umem_odp->tgid);
 	}
-
-	down_write(&per_mm->umem_rwsem);
-	if (!umem_odp->is_implicit_odp) {
-		interval_tree_remove(&umem_odp->interval_tree,
-				     &per_mm->umem_tree);
-		complete_all(&umem_odp->notifier_completion);
-	}
-	/*
-	 * NOTE! mmu_notifier_unregister() can happen between a start/end
-	 * callback, resulting in a missing end, and thus an unbalanced
-	 * lock. This doesn't really matter to us since we are about to kfree
-	 * the memory that holds the lock, however LOCKDEP doesn't like this.
-	 * Thus we call the mmu_notifier_put under the rwsem and test the
-	 * internal users count to reliably see if we are past this point.
-	 */
-	mmu_notifier_put(&per_mm->mn);
-	up_write(&per_mm->umem_rwsem);
-
-	mmdrop(umem_odp->umem.owning_mm);
 	kfree(umem_odp);
 }
 EXPORT_SYMBOL(ib_umem_odp_release);
@@ -501,7 +314,7 @@ EXPORT_SYMBOL(ib_umem_odp_release);
  */
 static int ib_umem_odp_map_dma_single_page(
 		struct ib_umem_odp *umem_odp,
-		int page_index,
+		unsigned int page_index,
 		struct page *page,
 		u64 access_mask,
 		unsigned long current_seq)
@@ -510,12 +323,7 @@ static int ib_umem_odp_map_dma_single_page(
 	dma_addr_t dma_addr;
 	int ret = 0;
 
-	/*
-	 * Note: we avoid writing if seq is different from the initial seq, to
-	 * handle case of a racing notifier. This check also allows us to bail
-	 * early if we have a notifier running in parallel with us.
-	 */
-	if (ib_umem_mmu_notifier_retry(umem_odp, current_seq)) {
+	if (mmu_interval_check_retry(&umem_odp->notifier, current_seq)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -618,7 +426,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 	 * existing beyond the lifetime of the originating process.. Presumably
 	 * mmget_not_zero will fail in this case.
 	 */
-	owning_process = get_pid_task(umem_odp->per_mm->tgid, PIDTYPE_PID);
+	owning_process = get_pid_task(umem_odp->tgid, PIDTYPE_PID);
 	if (!owning_process || !mmget_not_zero(owning_mm)) {
 		ret = -EINVAL;
 		goto out_put_task;
@@ -762,32 +570,3 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 	}
 }
 EXPORT_SYMBOL(ib_umem_odp_unmap_dma_pages);
-
-/* @last is not a part of the interval. See comment for function
- * node_last.
- */
-int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
-				  u64 start, u64 last,
-				  umem_call_back cb,
-				  bool blockable,
-				  void *cookie)
-{
-	int ret_val = 0;
-	struct interval_tree_node *node, *next;
-	struct ib_umem_odp *umem;
-
-	if (unlikely(start == last))
-		return ret_val;
-
-	for (node = interval_tree_iter_first(root, start, last - 1);
-			node; node = next) {
-		/* TODO move the blockable decision up to the callback */
-		if (!blockable)
-			return -EAGAIN;
-		next = interval_tree_iter_next(node, start, last - 1);
-		umem = container_of(node, struct ib_umem_odp, interval_tree);
-		ret_val = cb(umem, start, last, cookie) || ret_val;
-	}
-
-	return ret_val;
-}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f61d4005c6c379..108cadf9af1fda 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1263,8 +1263,6 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
-			      unsigned long end);
 void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent);
 void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
 			   size_t nentries, struct mlx5_ib_mr *mr, int flags);
@@ -1294,11 +1292,10 @@ mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 {
 	return -EOPNOTSUPP;
 }
-static inline void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp,
-					    unsigned long start,
-					    unsigned long end){};
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
+extern const struct mmu_interval_notifier_ops mlx5_mn_ops;
+
 /* Needed for rep profile */
 void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 199f7959aaa510..fbe31830b22807 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -743,7 +743,8 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (access_flags & IB_ACCESS_ON_DEMAND) {
 		struct ib_umem_odp *odp;
 
-		odp = ib_umem_odp_get(udata, start, length, access_flags);
+		odp = ib_umem_odp_get(udata, start, length, access_flags,
+				      &mlx5_mn_ops);
 		if (IS_ERR(odp)) {
 			mlx5_ib_dbg(dev, "umem get failed (%ld)\n",
 				    PTR_ERR(odp));
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index bcfc098466977e..63e0ebd1ae9d0c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -241,17 +241,26 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	xa_unlock(&imr->implicit_children);
 }
 
-void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
-			      unsigned long end)
+static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
+				     const struct mmu_notifier_range *range,
+				     unsigned long cur_seq)
 {
+	struct ib_umem_odp *umem_odp =
+		container_of(mni, struct ib_umem_odp, notifier);
 	struct mlx5_ib_mr *mr;
 	const u64 umr_block_mask = (MLX5_UMR_MTT_ALIGNMENT /
 				    sizeof(struct mlx5_mtt)) - 1;
 	u64 idx = 0, blk_start_idx = 0;
+	unsigned long start;
+	unsigned long end;
 	int in_block = 0;
 	u64 addr;
 
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
 	mutex_lock(&umem_odp->umem_mutex);
+	mmu_interval_set_seq(mni, cur_seq);
 	/*
 	 * If npages is zero then umem_odp->private may not be setup yet. This
 	 * does not complete until after the first page is mapped for DMA.
@@ -260,8 +269,8 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 		goto out;
 	mr = umem_odp->private;
 
-	start = max_t(u64, ib_umem_start(umem_odp), start);
-	end = min_t(u64, ib_umem_end(umem_odp), end);
+	start = max_t(u64, ib_umem_start(umem_odp), range->start);
+	end = min_t(u64, ib_umem_end(umem_odp), range->end);
 
 	/*
 	 * Iteration one - zap the HW's MTTs. The notifiers_count ensures that
@@ -312,8 +321,13 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 		destroy_unused_implicit_child_mr(mr);
 out:
 	mutex_unlock(&umem_odp->umem_mutex);
+	return true;
 }
 
+const struct mmu_interval_notifier_ops mlx5_mn_ops = {
+	.invalidate = mlx5_ib_invalidate_range,
+};
+
 void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 {
 	struct ib_odp_caps *caps = &dev->odp_caps;
@@ -414,7 +428,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 
 	odp = ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),
 				      idx * MLX5_IMR_MTT_SIZE,
-				      MLX5_IMR_MTT_SIZE);
+				      MLX5_IMR_MTT_SIZE, &mlx5_mn_ops);
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
@@ -600,8 +614,9 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
 			     u32 flags)
 {
-	int current_seq, page_shift, ret, np;
+	int page_shift, ret, np;
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
+	unsigned long current_seq;
 	u64 access_mask;
 	u64 start_idx, page_mask;
 
@@ -613,12 +628,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
-	current_seq = READ_ONCE(odp->notifiers_seq);
-	/*
-	 * Ensure the sequence number is valid for some time before we call
-	 * gup.
-	 */
-	smp_rmb();
+	current_seq = mmu_interval_read_begin(&odp->notifier);
 
 	np = ib_umem_odp_map_dma_pages(odp, user_va, bcnt, access_mask,
 				       current_seq);
@@ -626,7 +636,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 		return np;
 
 	mutex_lock(&odp->umem_mutex);
-	if (!ib_umem_mmu_notifier_retry(odp, current_seq)) {
+	if (!mmu_interval_read_retry(&odp->notifier, current_seq)) {
 		/*
 		 * No need to check whether the MTTs really belong to
 		 * this MR, since ib_umem_odp_map_dma_pages already
@@ -656,19 +666,6 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	return np << (page_shift - PAGE_SHIFT);
 
 out:
-	if (ret == -EAGAIN) {
-		unsigned long timeout = msecs_to_jiffies(MMU_NOTIFIER_TIMEOUT);
-
-		if (!wait_for_completion_timeout(&odp->notifier_completion,
-						 timeout)) {
-			mlx5_ib_warn(
-				mr->dev,
-				"timeout waiting for mmu notifier. seq %d against %d. notifiers_count=%d\n",
-				current_seq, odp->notifiers_seq,
-				odp->notifiers_count);
-		}
-	}
-
 	return ret;
 }
 
@@ -1609,7 +1606,6 @@ void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent)
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
 	.advise_mr = mlx5_ib_advise_mr,
-	.invalidate_range = mlx5_ib_invalidate_range,
 };
 
 int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 09b0e4494986a9..81429acc825774 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -35,11 +35,11 @@
 
 #include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
-#include <linux/interval_tree.h>
 
 struct ib_umem_odp {
 	struct ib_umem umem;
-	struct ib_ucontext_per_mm *per_mm;
+	struct mmu_interval_notifier notifier;
+	struct pid *tgid;
 
 	/*
 	 * An array of the pages included in the on-demand paging umem.
@@ -62,13 +62,8 @@ struct ib_umem_odp {
 	struct mutex		umem_mutex;
 	void			*private; /* for the HW driver to use. */
 
-	int notifiers_seq;
-	int notifiers_count;
 	int npages;
 
-	/* Tree tracking */
-	struct interval_tree_node interval_tree;
-
 	/*
 	 * An implicit odp umem cannot be DMA mapped, has 0 length, and serves
 	 * only as an anchor for the driver to hold onto the per_mm. FIXME:
@@ -77,7 +72,6 @@ struct ib_umem_odp {
 	 */
 	bool is_implicit_odp;
 
-	struct completion	notifier_completion;
 	unsigned int		page_shift;
 };
 
@@ -89,13 +83,13 @@ static inline struct ib_umem_odp *to_ib_umem_odp(struct ib_umem *umem)
 /* Returns the first page of an ODP umem. */
 static inline unsigned long ib_umem_start(struct ib_umem_odp *umem_odp)
 {
-	return umem_odp->interval_tree.start;
+	return umem_odp->notifier.interval_tree.start;
 }
 
 /* Returns the address of the page after the last one of an ODP umem. */
 static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
 {
-	return umem_odp->interval_tree.last + 1;
+	return umem_odp->notifier.interval_tree.last + 1;
 }
 
 static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
@@ -119,21 +113,15 @@ static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
 
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 
-struct ib_ucontext_per_mm {
-	struct mmu_notifier mn;
-	struct pid *tgid;
-
-	struct rb_root_cached umem_tree;
-	/* Protects umem_tree */
-	struct rw_semaphore umem_rwsem;
-};
-
-struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
-				    size_t size, int access);
+struct ib_umem_odp *
+ib_umem_odp_get(struct ib_udata *udata, unsigned long addr, size_t size,
+		int access, const struct mmu_interval_notifier_ops *ops);
 struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 					       int access);
-struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem,
-					    unsigned long addr, size_t size);
+struct ib_umem_odp *
+ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem, unsigned long addr,
+			size_t size,
+			const struct mmu_interval_notifier_ops *ops);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);
 
 int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
@@ -143,39 +131,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
 				 u64 bound);
 
-typedef int (*umem_call_back)(struct ib_umem_odp *item, u64 start, u64 end,
-			      void *cookie);
-/*
- * Call the callback on each ib_umem in the range. Returns the logical or of
- * the return values of the functions called.
- */
-int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
-				  u64 start, u64 end,
-				  umem_call_back cb,
-				  bool blockable, void *cookie);
-
-static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
-					     unsigned long mmu_seq)
-{
-	/*
-	 * This code is strongly based on the KVM code from
-	 * mmu_notifier_retry. Should be called with
-	 * the relevant locks taken (umem_odp->umem_mutex
-	 * and the ucontext umem_mutex semaphore locked for read).
-	 */
-
-	if (unlikely(umem_odp->notifiers_count))
-		return 1;
-	if (umem_odp->notifiers_seq != mmu_seq)
-		return 1;
-	return 0;
-}
-
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
-static inline struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata,
-						  unsigned long addr,
-						  size_t size, int access)
+static inline struct ib_umem_odp *
+ib_umem_odp_get(struct ib_udata *udata, unsigned long addr, size_t size,
+		int access, const struct mmu_interval_notifier_ops *ops)
 {
 	return ERR_PTR(-EINVAL);
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba85c54c11..2c30c859ae0d13 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2422,8 +2422,6 @@ struct ib_device_ops {
 			    u64 iova);
 	int (*unmap_fmr)(struct list_head *fmr_list);
 	int (*dealloc_fmr)(struct ib_fmr *fmr);
-	void (*invalidate_range)(struct ib_umem_odp *umem_odp,
-				 unsigned long start, unsigned long end);
 	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	struct ib_xrcd *(*alloc_xrcd)(struct ib_device *device,
-- 
2.24.0

