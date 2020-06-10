Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE31F5C1D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 21:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgFJTlM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgFJTlK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 15:41:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBDEC03E96B
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 12:41:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so2928130wml.1
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxGiZ/VHfKf+6Jo1ghbbgRFFU0Zpi0zAhXpkfpvcMXw=;
        b=QO43K+f+PF/xLiTpv5fDsVtVSydeT7uPLF+Enxz5VFclJnaOck+rXYyRTUj445JJoQ
         iY+mTtt4R940gyiSI9j99dCM9ig3G8TLgGy9L/b9UxDNKcMsNLWt1U1TTSV5dEL6MpeU
         DJtYNjXJdn5mo7Ineqcws0gBkdQPEIswb0e00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxGiZ/VHfKf+6Jo1ghbbgRFFU0Zpi0zAhXpkfpvcMXw=;
        b=GqdYHjXC1VdLPc9zjRo1rktCnbMsOITJ5MOolvHssfEybfVuN/7Mfe48ebBb1DIts5
         kponKyKMZtk85VcoYbUDODo/0Wg5p/Wh+Bz/fKAhI3ZMkSmZooDY3avGccxiPX+62Kne
         ia9taHhJaJV/XvJj+byYZ5hQSxY9v4juzn8wX8IjlxhDxwBhmQ/SiMtAB/gpXBxoPLmG
         Tw8aFI7ZmbLYdPZLIR6Gf3XIjzSFSQn1sdsT+jEe56gvM4Pg0nk8RXPYtKxadwLCscBh
         yIq8XxOKiLGRtGXceAlJqY55ifn3d761S5EvJgH3nObilRPsTWWyt3xQ3deC2Ad8Z26E
         r0yw==
X-Gm-Message-State: AOAM533jJmVnddv5S9W46eFT4o8N8+mJyQFxNlGW4W68vc2d5kkk71T2
        +U4l+7X74Mfn7mNqEXNDTC/g/g==
X-Google-Smtp-Source: ABdhPJxKthaR5TwT0o9vsCRPCbSs/REQdSbjo9kmrGkxY4OSEangZEFENs5GwyD2RFirbsf1gQB4qQ==
X-Received: by 2002:a1c:a403:: with SMTP id n3mr4536352wme.2.1591818067664;
        Wed, 10 Jun 2020 12:41:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 138sm963623wma.23.2020.06.10.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:41:06 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
Date:   Wed, 10 Jun 2020 21:41:01 +0200
Message-Id: <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

fs_reclaim_acquire/release nicely catch recursion issues when
allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
to use to keep the excessive caches in check). For mmu notifier
recursions we do have lockdep annotations since 23b68395c7c7
("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").

But these only fire if a path actually results in some pte
invalidation - for most small allocations that's very rarely the case.
The other trouble is that pte invalidation can happen any time when
__GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
recursion.

I was pondering whether we should just do the general annotation, but
there's always the risk for false positives. Plus I'm assuming that
the core fs and io code is a lot better reviewed and tested than
random mmu notifier code in drivers. Hence why I decide to only
annotate for that specific case.

Furthermore even if we'd create a lockdep map for direct reclaim, we'd
still need to explicit pull in the mmu notifier map - there's a lot
more places that do pte invalidation than just direct reclaim, these
two contexts arent the same.

Note that the mmu notifiers needing their own independent lockdep map
is also the reason we can't hold them from fs_reclaim_acquire to
fs_reclaim_release - it would nest with the acquistion in the pte
invalidation code, causing a lockdep splat. And we can't remove the
annotations from pte invalidation and all the other places since
they're called from many other places than page reclaim. Hence we can
only do the equivalent of might_lock, but on the raw lockdep map.

With this we can also remove the lockdep priming added in 66204f1d2d1b
("mm/mmu_notifiers: prime lockdep") since the new annotations are
strictly more powerful.

v2: Review from Thomas Hellstrom:
- unbotch the fs_reclaim context check, I accidentally inverted it,
  but it didn't blow up because I inverted it immediately
- fix compiling for !CONFIG_MMU_NOTIFIER

Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-mm@kvack.org
Cc: linux-rdma@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
This is part of a gpu lockdep annotation series simply because it
really helps to catch issues where gpu subsystem locks and primitives
can deadlock with themselves through allocations and mmu notifiers.
But aside from that motivation it should be completely free-standing,
and can land through -mm/-rdma/-hmm or any other tree really whenever.
-Daniel
---
 mm/mmu_notifier.c |  7 -------
 mm/page_alloc.c   | 25 ++++++++++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 06852b896fa6..5d578b9122f8 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -612,13 +612,6 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	if (IS_ENABLED(CONFIG_LOCKDEP)) {
-		fs_reclaim_acquire(GFP_KERNEL);
-		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-		fs_reclaim_release(GFP_KERNEL);
-	}
-
 	if (!mm->notifier_subscriptions) {
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 13cc653122b7..7536faaaa0fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -57,6 +57,7 @@
 #include <trace/events/oom.h>
 #include <linux/prefetch.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/rt.h>
@@ -4124,7 +4125,7 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 static struct lockdep_map __fs_reclaim_map =
 	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
 
-static bool __need_fs_reclaim(gfp_t gfp_mask)
+static bool __need_reclaim(gfp_t gfp_mask)
 {
 	gfp_mask = current_gfp_context(gfp_mask);
 
@@ -4136,10 +4137,6 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
 	if (current->flags & PF_MEMALLOC)
 		return false;
 
-	/* We're only interested __GFP_FS allocations for now */
-	if (!(gfp_mask & __GFP_FS))
-		return false;
-
 	if (gfp_mask & __GFP_NOLOCKDEP)
 		return false;
 
@@ -4158,15 +4155,25 @@ void __fs_reclaim_release(void)
 
 void fs_reclaim_acquire(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_acquire();
+	if (__need_reclaim(gfp_mask)) {
+		if (gfp_mask & __GFP_FS)
+			__fs_reclaim_acquire();
+
+#ifdef CONFIG_MMU_NOTIFIER
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+#endif
+
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
 
 void fs_reclaim_release(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_release();
+	if (__need_reclaim(gfp_mask)) {
+		if (gfp_mask & __GFP_FS)
+			__fs_reclaim_release();
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_release);
 #endif
-- 
2.26.2

