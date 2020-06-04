Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27131EDF90
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFDIMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFDIMf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B73C03E96E
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so5045217wru.6
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdFnY1g4TiO7TC07GhFyr/JbIyM/VV8gIgkQFmLlHDQ=;
        b=E/pgUYI2SY0xaGSewMfnWU5m8fnHDao7z+E7QBf31znuNz2UmnVw8X4hz5J+Pz1dU+
         aLdb+YCMIJuRPgJ3X1a4V5egheABOcDbYfV7ZXg66Rhzcni1oFNwjMZqwC2tNLCdA8d2
         X6YoGl1DDs7upjvieXVFaK7T0OJ5RiE807N3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdFnY1g4TiO7TC07GhFyr/JbIyM/VV8gIgkQFmLlHDQ=;
        b=TFZzHaykRjtbXV7lIWJ+9za8nUqh4yXbK00EV0i7hbWM4wMyo9St1ZFln6mhq9ZL1W
         BnQqlgpkphnjJAp13om76fN9jfbZgCZhwqTkzw42+vkPruOUXjpWy6CjLRQ+GTincHxK
         rGO0J5QG3G1S+9jLuyehVwQwWMARPthaiAWs2pryGEFUpeo5C0hH4iK8+l/J2vA/Qnzt
         SYIG811YFZmqbOO3G+sHegVRok6Su1UYRsAtvIoWyaVUtdCLkHumEbcUnlhr+E0qfXl3
         fMl35BQM/5pFled2JOGgwfoReZyi8Uf+StzY/23bojQ6k6TFNM09H/mLy9/U4W07Dq6U
         S4sw==
X-Gm-Message-State: AOAM532MPeqMfyr3mqh+4Ia5w5dKirkJbIIUW6qwAkg+KpSpNEeVVJga
        lKYaXQse9PXZ3GzDrAIBGsxxkE8cqk0=
X-Google-Smtp-Source: ABdhPJzIRvuD8WMXGKIijFhhfc+ctkeCbHFIpWW5UM3euiKyXNUz7hZchjZUK8wCqpLkRmBOh919xg==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr3447032wrv.77.1591258353390;
        Thu, 04 Jun 2020 01:12:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:32 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 01/18] mm: Track mmu notifiers in fs_reclaim_acquire/release
Date:   Thu,  4 Jun 2020 10:12:07 +0200
Message-Id: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
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
 mm/page_alloc.c   | 23 ++++++++++++++---------
 2 files changed, 14 insertions(+), 16 deletions(-)

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
index 13cc653122b7..f8a222db4a53 100644
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
 
@@ -4158,15 +4155,23 @@ void __fs_reclaim_release(void)
 
 void fs_reclaim_acquire(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_acquire();
+	if (__need_reclaim(gfp_mask)) {
+		if (!(gfp_mask & __GFP_FS))
+			__fs_reclaim_acquire();
+
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
 
 void fs_reclaim_release(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_release();
+	if (__need_reclaim(gfp_mask)) {
+		if (!(gfp_mask & __GFP_FS))
+			__fs_reclaim_release();
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_release);
 #endif
-- 
2.26.2

