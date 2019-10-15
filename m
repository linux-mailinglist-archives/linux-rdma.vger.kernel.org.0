Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22935D7EA6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfJOSQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so12982791pfb.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxqnjxtjZspeclsXsb8TqT2XAaJcx6OqXrPL9/3uTio=;
        b=WiNBwI0GEvMvrWy1ehAPzHRxBZcfkJSDVZrcxckbtOPYt0vilEpIpP8MuNdNVhWXh/
         SoU7AiEKzDV+QL81bsPgbpfq+LBhaGTtTP+QDOvoWJqBswnzIRdWSR+anuvJLw7gZoEz
         MG2BHvGJ2xGRlTL7RhF6fFc30sLQFXJNGWjEm9KetbUqhrj/xaFnsKMGwsr42FtdSvLx
         XqrWoiB1312d7qQdNj5TiQHX313Me5YQ0lbuuEp5CyhbguZepRaNWvZh8D2ULLwEGn8F
         xAFRajXxsiJOuRNHlRfUZavKLGb1h6R5WAprKRtw1VwU9Pgku3H2/DtvLcTXlbyGYLGD
         6i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxqnjxtjZspeclsXsb8TqT2XAaJcx6OqXrPL9/3uTio=;
        b=r9PTBkYf4p2JjmawbjbgMBw7k9tofJMo5hVGxaPm67RPngQi0Z+zHl/synf5oc//0c
         x+je6+eQ9CSe5GRa3nfI8fNWF1KsUgYL47J4IJ5QOCDTnym7UcB5Hhhub5fZZfROFSUD
         EVwf/iDWq5LBHKi0qRXoFJcWC9jE3YMt+ocUZ3nStuES9SVsmmCOasRvMgio/xCbZacd
         BMEkT4LJG4ktEzlOdyG3ilHdU4FBesEQVJUwfaMPGWZ23P0MoDmdtj4N4vIPIE9hcJ3a
         4IMbM6J9JVLBArLxB6jr9SKsWTxtgqw3V+RyeWgCHBRAoWlZXM1O+/rCoexStj4dV7a/
         BGuw==
X-Gm-Message-State: APjAAAWGyodMRt8rUmB4wV4Bfb1m1ZnzTTLaXmBocKjd4q+M+lRND/b/
        gjtzKF8//Hi0/TK22MVgpu7i5w==
X-Google-Smtp-Source: APXvYqw20wAIkHWageKs4SNh5mkhjScT2YJ5H9fLuHv7ambuFgJzJJY4hoXPq9r1gGkqghcn4QMTOQ==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr45187520pjb.2.1571163395890;
        Tue, 15 Oct 2019 11:16:35 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id o11sm19024878pgp.13.2019.10.15.11.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:35 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002CG-Gd; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Petr Cvek <petrcvekcz@gmail.com>
Subject: [PATCH hmm 07/15] drm/radeon: use mmu_range_notifier_insert
Date:   Tue, 15 Oct 2019 15:12:34 -0300
Message-Id: <20191015181242.8343-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
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
 drivers/gpu/drm/radeon/radeon_mn.c | 218 ++++++-----------------------
 2 files changed, 51 insertions(+), 176 deletions(-)

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
index dbab9a3a969b9e..2ea90874c535f5 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -36,131 +36,50 @@
 
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
+				 const struct mmu_notifier_range *range)
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
@@ -174,51 +93,21 @@ static const struct mmu_notifier_ops radeon_mn_ops = {
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
 
@@ -231,27 +120,8 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
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

