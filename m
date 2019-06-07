Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE339192
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfFGQGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:06:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41543 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfFGQF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:05:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id s57so2848349qte.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mDQI7vDRgVEqfEUUaCyaBBK+4bOYH5UfB7o3hA1mJXA=;
        b=h6KpvG8kEPwZ4LEZggj55gXJyseLol+sT11VPWvdlbvHuRB/SDV9CdXfnBVmjGGNUR
         rOaB3khRLP9k43hFFlM7JgJrB+xap09v5WEvcNpCcDm+R7q6tjjOEBwesAVq48cJ/83g
         So0nJITGzjxRk4D0uPQp5n7PvmlL4uFKrl/48pOQIl6ZN2eKDvmwWgXQZlPWvyAnWlIw
         yU5ZwpruBe/84KRjpLYqcD9PBjC1jDUG3G9Ohbk+ythU2LvunFU4UkOUnBzmx4hF6Ao0
         Lnzva0XY+uFw0Y+ynwlkcWlHyp6MBQc24OEdhN/d2qSSoB3U9Jw6KgBVG8SRZERqZzkb
         2hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDQI7vDRgVEqfEUUaCyaBBK+4bOYH5UfB7o3hA1mJXA=;
        b=X/GL7PIz6eKagV3lW4idbTtIiblGJ7+EKxMMEHc0I3Qx1YjXumcYbIQGw0SCzeIYmV
         rkBqBrJvaqDh5mkqqU7wKGJWpDzwvKtO3mnbIwYWnMwewUQi8R2rYoRbIi0RX/E/L1Dy
         xCGuN8LF1zXjmGGIEev5Rp3NUTm+D7HzOEKKhOo9ARBU7pjRAYlTDbrLZjumph1PiBcL
         S9DxYW4S5ZHF2y/xOS3CbhGlWB5/IsWXG1NC+IImSEdbq+vEt/W4TjL8OfM4SpbeaMm9
         ucdPVskGhbSwrTj9haV6BMtMqYmr7686jML7h/33DpDXOf9rjlWDF2o5xErXzCrMC5wJ
         Ulug==
X-Gm-Message-State: APjAAAU7iJ4Nm91V2paKfVkm5BD7XfbWRUfMF4K7exhT0x8tllPzhmlz
        RBBV+jz2QcLu2WBkWXpP2NGajg==
X-Google-Smtp-Source: APXvYqwIT1CmduZzPGFrLNflexTC0zIShRnLBlA8OsJP0/v7GZFL6ZhIHAbjBC1Kw7kXZZYVQlIuiQ==
X-Received: by 2002:ac8:1af4:: with SMTP id h49mr38593897qtk.183.1559923558110;
        Fri, 07 Jun 2019 09:05:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n124sm1260323qkf.31.2019.06.07.09.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:05:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZHNN-00008j-5Z; Fri, 07 Jun 2019 13:05:57 -0300
Date:   Fri, 7 Jun 2019 13:05:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 12/11] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
Message-ID: <20190607160557.GA335@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the trylock on the hmm->mirrors_sem fails the function will return
without decrementing the notifiers that were previously incremented. Since
the caller will not call invalidate_range_end() on EAGAIN this will result
in notifiers becoming permanently incremented and deadlock.

If the sync_cpu_device_pagetables() required blocking the function will
not return EAGAIN even though the device continues to touch the
pages. This is a violation of the mmu notifier contract.

Switch, and rename, the ranges_lock to a spin lock so we can reliably
obtain it without blocking during error unwind.

The error unwind is necessary since the notifiers count must be held
incremented across the call to sync_cpu_device_pagetables() as we cannot
allow the range to become marked valid by a parallel
invalidate_start/end() pair while doing sync_cpu_device_pagetables().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  2 +-
 mm/hmm.c            | 77 +++++++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 31 deletions(-)

I almost lost this patch - it is part of the series, hasn't been
posted before, and wasn't sent with the rest, sorry.

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index bf013e96525771..0fa8ea34ccef6d 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -86,7 +86,7 @@
 struct hmm {
 	struct mm_struct	*mm;
 	struct kref		kref;
-	struct mutex		lock;
+	spinlock_t		ranges_lock;
 	struct list_head	ranges;
 	struct list_head	mirrors;
 	struct mmu_notifier	mmu_notifier;
diff --git a/mm/hmm.c b/mm/hmm.c
index 4215edf737ef5b..10103a24e9b7b3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -68,7 +68,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	init_rwsem(&hmm->mirrors_sem);
 	hmm->mmu_notifier.ops = NULL;
 	INIT_LIST_HEAD(&hmm->ranges);
-	mutex_init(&hmm->lock);
+	spin_lock_init(&hmm->ranges_lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
 	hmm->mm = mm;
@@ -114,18 +114,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
+	unsigned long flags;
 
 	/* Bail out if hmm is in the process of being freed */
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	/*
 	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
 	 * prevented as long as a range exists.
 	 */
 	WARN_ON(!list_empty(&hmm->ranges));
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	down_read(&hmm->mirrors_sem);
 	list_for_each_entry(mirror, &hmm->mirrors, list) {
@@ -141,6 +142,23 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	hmm_put(hmm);
 }
 
+static void notifiers_decrement(struct hmm *hmm)
+{
+	lockdep_assert_held(&hmm->ranges_lock);
+
+	hmm->notifiers--;
+	if (!hmm->notifiers) {
+		struct hmm_range *range;
+
+		list_for_each_entry(range, &hmm->ranges, list) {
+			if (range->valid)
+				continue;
+			range->valid = true;
+		}
+		wake_up_all(&hmm->wq);
+	}
+}
+
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
@@ -148,6 +166,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
+	unsigned long flags;
 	int ret = 0;
 
 	if (!kref_get_unless_zero(&hmm->kref))
@@ -158,12 +177,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 	update.event = HMM_UPDATE_INVALIDATE;
 	update.blockable = mmu_notifier_range_blockable(nrange);
 
-	if (mmu_notifier_range_blockable(nrange))
-		mutex_lock(&hmm->lock);
-	else if (!mutex_trylock(&hmm->lock)) {
-		ret = -EAGAIN;
-		goto out;
-	}
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	hmm->notifiers++;
 	list_for_each_entry(range, &hmm->ranges, list) {
 		if (update.end < range->start || update.start >= range->end)
@@ -171,7 +185,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 
 		range->valid = false;
 	}
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	if (mmu_notifier_range_blockable(nrange))
 		down_read(&hmm->mirrors_sem);
@@ -179,16 +193,26 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 		ret = -EAGAIN;
 		goto out;
 	}
+
 	list_for_each_entry(mirror, &hmm->mirrors, list) {
-		int ret;
+		int rc;
 
-		ret = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
-		if (!update.blockable && ret == -EAGAIN)
+		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
+		if (rc) {
+			if (WARN_ON(update.blockable || rc != -EAGAIN))
+				continue;
+			ret = -EAGAIN;
 			break;
+		}
 	}
 	up_read(&hmm->mirrors_sem);
 
 out:
+	if (ret) {
+		spin_lock_irqsave(&hmm->ranges_lock, flags);
+		notifiers_decrement(hmm);
+		spin_unlock_irqrestore(&hmm->ranges_lock, flags);
+	}
 	hmm_put(hmm);
 	return ret;
 }
@@ -197,23 +221,14 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
+	unsigned long flags;
 
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	mutex_lock(&hmm->lock);
-	hmm->notifiers--;
-	if (!hmm->notifiers) {
-		struct hmm_range *range;
-
-		list_for_each_entry(range, &hmm->ranges, list) {
-			if (range->valid)
-				continue;
-			range->valid = true;
-		}
-		wake_up_all(&hmm->wq);
-	}
-	mutex_unlock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
+	notifiers_decrement(hmm);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	hmm_put(hmm);
 }
@@ -866,6 +881,7 @@ int hmm_range_register(struct hmm_range *range,
 {
 	unsigned long mask = ((1UL << page_shift) - 1UL);
 	struct hmm *hmm = mirror->hmm;
+	unsigned long flags;
 
 	range->valid = false;
 	range->hmm = NULL;
@@ -887,7 +903,7 @@ int hmm_range_register(struct hmm_range *range,
 	kref_get(&hmm->kref);
 
 	/* Initialize range to track CPU page table updates. */
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 
 	range->hmm = hmm;
 	list_add(&range->list, &hmm->ranges);
@@ -898,7 +914,7 @@ int hmm_range_register(struct hmm_range *range,
 	 */
 	if (!hmm->notifiers)
 		range->valid = true;
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	return 0;
 }
@@ -914,13 +930,14 @@ EXPORT_SYMBOL(hmm_range_register);
 void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
+	unsigned long flags;
 
 	if (WARN_ON(range->end <= range->start))
 		return;
 
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	list_del(&range->list);
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
-- 
2.21.0

