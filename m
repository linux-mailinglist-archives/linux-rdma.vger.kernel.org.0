Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8CE79BC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJ1UKu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39358 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ1UKt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id 15so9760439qkh.6
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRggeho95DncGN+AT9iW7vh5wy6AMhDkR1ylS8BLo3U=;
        b=Z6FPqWY8xhqWHQ1Z1jE+fDSLBwgVSNxVQ8c9GC0HnqL5aTlEoyKukvRT0bLCjEmeO3
         jdEy/Wt8g7+3oLmfDgjRUbD8LM8pbZV8IsUUjEWlnPSUG6xDdecc6GIDe9+nHnX7zFLj
         94H+N0wC5u9gJGFk6UA3/FcBBNDzqp4Gm02HhEfQ+cIEhJMrbcnmOgivf8xIkm8iUAIm
         +FjxdgozOVglobkgBolzICZS/1dqujKTPGQE594CvbYjULQrckQQ2MpdIeH8TmMUu5Kv
         nJepfYhuvVSKeFYEijWIva8OuyV40mQb6yTlSYo5sOvsDPinwvNddf4UMo6en49hpBFG
         RQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRggeho95DncGN+AT9iW7vh5wy6AMhDkR1ylS8BLo3U=;
        b=FlmT0OEdtpDWZzSFdTtLqPAFynbuzX8CPqbEYvDqsDpxueDigDIBQnGfx8hyVnRn0q
         zt8Fwly30mcAVZGNpkyMR8fcaN29nzjm57HOdkKVOiMUyQVJYCV2Jrf3Kv+1ewL5zj42
         NLrxD30kRcgB35TebHRkpfWMAYZpOtoIuAJh9AsZWQCF0byVYeqP3VHmssl8oNC8Y+24
         hfPw+NQib0ecCGDzTYYlv0Imz3UI4M/jLOimwQMPR1TQjaRCuuucxvE3DtOOKnIySG98
         CTlaHWOOoA7cxCQ2/F6RBaCdpNhCTfZEv3VdshJNRaewcf1GrfNa6NXhfa2VDjBnOImK
         2Ddg==
X-Gm-Message-State: APjAAAUTJFERqGrTn/WcZzRV6cFDN+KIjmAQW2UI9e40pYAy5Ulax/6U
        GWkDhOOSs8hmGE6eifax+KPD1g==
X-Google-Smtp-Source: APXvYqy/RbSa3eEPDBlXrh1yGA/H58lhDB5xOYOKxwKTP9IyRxvM48S8YYUitKPIWnrC9+g+LsGdEA==
X-Received: by 2002:a37:7c42:: with SMTP id x63mr13834831qkc.134.1572293448467;
        Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o1sm7821372qtb.82.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001ge-Bn; Mon, 28 Oct 2019 17:10:43 -0300
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
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 07/15] drm/radeon: use mmu_range_notifier_insert
Date:   Mon, 28 Oct 2019 17:10:24 -0300
Message-Id: <20191028201032.6352-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The new API is an exact match for the needs of radeon.

For some reason radeon tries to remove overlapping ranges from the
interval tree, but interval trees (and mmu_range_notifier_insert)
support overlapping ranges directly. Simply delete all this code.

Since this driver is missing a invalidate_range_end callback, but
still calls get_user_pages(), it cannot be correct against all races.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Petr Cvek <petrcvekcz@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/radeon/radeon.h    |   9 +-
 drivers/gpu/drm/radeon/radeon_mn.c | 219 ++++++-----------------------
 2 files changed, 52 insertions(+), 176 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index d59b004f669583..27959f3ace1152 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -68,6 +68,10 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 
+#ifdef CONFIG_MMU_NOTIFIER
+#include <linux/mmu_notifier.h>
+#endif
+
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
@@ -509,8 +513,9 @@ struct radeon_bo {
 	struct ttm_bo_kmap_obj		dma_buf_vmap;
 	pid_t				pid;
 
-	struct radeon_mn		*mn;
-	struct list_head		mn_list;
+#ifdef CONFIG_MMU_NOTIFIER
+	struct mmu_range_notifier	notifier;
+#endif
 };
 #define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo, tbo.base)
 
diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index dbab9a3a969b9e..d3d41e20a64922 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -36,131 +36,51 @@
 
 #include "radeon.h"
 
-struct radeon_mn {
-	struct mmu_notifier	mn;
-
-	/* objects protected by lock */
-	struct mutex		lock;
-	struct rb_root_cached	objects;
-};
-
-struct radeon_mn_node {
-	struct interval_tree_node	it;
-	struct list_head		bos;
-};
-
 /**
- * radeon_mn_invalidate_range_start - callback to notify about mm change
+ * radeon_mn_invalidate - callback to notify about mm change
  *
  * @mn: our notifier
- * @mn: the mm this callback is about
- * @start: start of updated range
- * @end: end of updated range
+ * @range: the VMA under invalidation
  *
  * We block for all BOs between start and end to be idle and
  * unmap them by move them into system domain again.
  */
-static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
-				const struct mmu_notifier_range *range)
+static bool radeon_mn_invalidate(struct mmu_range_notifier *mn,
+				 const struct mmu_notifier_range *range,
+				 unsigned long cur_seq)
 {
-	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
+	struct radeon_bo *bo = container_of(mn, struct radeon_bo, notifier);
 	struct ttm_operation_ctx ctx = { false, false };
-	struct interval_tree_node *it;
-	unsigned long end;
-	int ret = 0;
-
-	/* notification is exclusive, but interval is inclusive */
-	end = range->end - 1;
-
-	/* TODO we should be able to split locking for interval tree and
-	 * the tear down.
-	 */
-	if (mmu_notifier_range_blockable(range))
-		mutex_lock(&rmn->lock);
-	else if (!mutex_trylock(&rmn->lock))
-		return -EAGAIN;
-
-	it = interval_tree_iter_first(&rmn->objects, range->start, end);
-	while (it) {
-		struct radeon_mn_node *node;
-		struct radeon_bo *bo;
-		long r;
-
-		if (!mmu_notifier_range_blockable(range)) {
-			ret = -EAGAIN;
-			goto out_unlock;
-		}
-
-		node = container_of(it, struct radeon_mn_node, it);
-		it = interval_tree_iter_next(it, range->start, end);
+	long r;
 
-		list_for_each_entry(bo, &node->bos, mn_list) {
+	if (!bo->tbo.ttm || bo->tbo.ttm->state != tt_bound)
+		return true;
 
-			if (!bo->tbo.ttm || bo->tbo.ttm->state != tt_bound)
-				continue;
+	if (!mmu_notifier_range_blockable(range))
+		return false;
 
-			r = radeon_bo_reserve(bo, true);
-			if (r) {
-				DRM_ERROR("(%ld) failed to reserve user bo\n", r);
-				continue;
-			}
-
-			r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
-				true, false, MAX_SCHEDULE_TIMEOUT);
-			if (r <= 0)
-				DRM_ERROR("(%ld) failed to wait for user bo\n", r);
-
-			radeon_ttm_placement_from_domain(bo, RADEON_GEM_DOMAIN_CPU);
-			r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-			if (r)
-				DRM_ERROR("(%ld) failed to validate user bo\n", r);
-
-			radeon_bo_unreserve(bo);
-		}
+	r = radeon_bo_reserve(bo, true);
+	if (r) {
+		DRM_ERROR("(%ld) failed to reserve user bo\n", r);
+		return true;
 	}
-	
-out_unlock:
-	mutex_unlock(&rmn->lock);
-
-	return ret;
-}
-
-static void radeon_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
-{
-	struct mmu_notifier_range range = {
-		.mm = mm,
-		.start = 0,
-		.end = ULONG_MAX,
-		.flags = 0,
-		.event = MMU_NOTIFY_UNMAP,
-	};
-
-	radeon_mn_invalidate_range_start(mn, &range);
-}
-
-static struct mmu_notifier *radeon_mn_alloc_notifier(struct mm_struct *mm)
-{
-	struct radeon_mn *rmn;
 
-	rmn = kzalloc(sizeof(*rmn), GFP_KERNEL);
-	if (!rmn)
-		return ERR_PTR(-ENOMEM);
+	r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv, true, false,
+				      MAX_SCHEDULE_TIMEOUT);
+	if (r <= 0)
+		DRM_ERROR("(%ld) failed to wait for user bo\n", r);
 
-	mutex_init(&rmn->lock);
-	rmn->objects = RB_ROOT_CACHED;
-	return &rmn->mn;
-}
+	radeon_ttm_placement_from_domain(bo, RADEON_GEM_DOMAIN_CPU);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r)
+		DRM_ERROR("(%ld) failed to validate user bo\n", r);
 
-static void radeon_mn_free_notifier(struct mmu_notifier *mn)
-{
-	kfree(container_of(mn, struct radeon_mn, mn));
+	radeon_bo_unreserve(bo);
+	return true;
 }
 
-static const struct mmu_notifier_ops radeon_mn_ops = {
-	.release = radeon_mn_release,
-	.invalidate_range_start = radeon_mn_invalidate_range_start,
-	.alloc_notifier = radeon_mn_alloc_notifier,
-	.free_notifier = radeon_mn_free_notifier,
+static const struct mmu_range_notifier_ops radeon_mn_ops = {
+	.invalidate = radeon_mn_invalidate,
 };
 
 /**
@@ -174,51 +94,21 @@ static const struct mmu_notifier_ops radeon_mn_ops = {
  */
 int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 {
-	unsigned long end = addr + radeon_bo_size(bo) - 1;
-	struct mmu_notifier *mn;
-	struct radeon_mn *rmn;
-	struct radeon_mn_node *node = NULL;
-	struct list_head bos;
-	struct interval_tree_node *it;
-
-	mn = mmu_notifier_get(&radeon_mn_ops, current->mm);
-	if (IS_ERR(mn))
-		return PTR_ERR(mn);
-	rmn = container_of(mn, struct radeon_mn, mn);
-
-	INIT_LIST_HEAD(&bos);
-
-	mutex_lock(&rmn->lock);
-
-	while ((it = interval_tree_iter_first(&rmn->objects, addr, end))) {
-		kfree(node);
-		node = container_of(it, struct radeon_mn_node, it);
-		interval_tree_remove(&node->it, &rmn->objects);
-		addr = min(it->start, addr);
-		end = max(it->last, end);
-		list_splice(&node->bos, &bos);
-	}
-
-	if (!node) {
-		node = kmalloc(sizeof(struct radeon_mn_node), GFP_KERNEL);
-		if (!node) {
-			mutex_unlock(&rmn->lock);
-			return -ENOMEM;
-		}
-	}
-
-	bo->mn = rmn;
-
-	node->it.start = addr;
-	node->it.last = end;
-	INIT_LIST_HEAD(&node->bos);
-	list_splice(&bos, &node->bos);
-	list_add(&bo->mn_list, &node->bos);
-
-	interval_tree_insert(&node->it, &rmn->objects);
-
-	mutex_unlock(&rmn->lock);
-
+	int ret;
+
+	bo->notifier.ops = &radeon_mn_ops;
+	ret = mmu_range_notifier_insert(&bo->notifier, addr, radeon_bo_size(bo),
+					current->mm);
+	if (ret)
+		return ret;
+
+	/*
+	 * FIXME: radeon appears to allow get_user_pages to run during
+	 * invalidate_range_start/end, which is not a safe way to read the
+	 * PTEs. It should use the mmu_range_read_begin() scheme around the
+	 * get_user_pages to ensure that the PTEs are read properly
+	 */
+	mmu_range_read_begin(&bo->notifier);
 	return 0;
 }
 
@@ -231,27 +121,8 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
  */
 void radeon_mn_unregister(struct radeon_bo *bo)
 {
-	struct radeon_mn *rmn = bo->mn;
-	struct list_head *head;
-
-	if (!rmn)
+	if (!bo->notifier.mm)
 		return;
-
-	mutex_lock(&rmn->lock);
-	/* save the next list entry for later */
-	head = bo->mn_list.next;
-
-	list_del(&bo->mn_list);
-
-	if (list_empty(head)) {
-		struct radeon_mn_node *node;
-		node = container_of(head, struct radeon_mn_node, bos);
-		interval_tree_remove(&node->it, &rmn->objects);
-		kfree(node);
-	}
-
-	mutex_unlock(&rmn->lock);
-
-	mmu_notifier_put(&rmn->mn);
-	bo->mn = NULL;
+	mmu_range_notifier_remove(&bo->notifier);
+	bo->notifier.mm = NULL;
 }
-- 
2.23.0

