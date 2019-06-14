Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5553450DE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFNApC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:45:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35949 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNApB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:45:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so622117qtl.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81jT1Hdc80WGYZ0NolRfY9wVErFdmf0CnSOj/bK3nzo=;
        b=kJzXO444RBh00bh7hl3AxI0tIXExReIacqR5hmZGVB/6O2TxYzqutiFQfsr4MDUAv8
         wCBoArV0Ho5b23f6oN/r3cbv5i9u9XYGWevXpsUuafVa4rMh8Li+8TSsMcLyTYxfzKNd
         iMm+0vRb+qSK6K4qKnf3QAfbRS8WkHLXwRL82O0/+MxT69BHfBer1KbhPSo7UAdtHxtl
         Quupwe3y5+dEUrrEHpCsVgVJCiyZ35e+8ARRZsziW+azHgQiqcHz2E/7IPNRpVG3unMJ
         cddZbQk+ZL6uk83JsBLSVP50bQsfaNZatZde6LJ9+w+IwAMgEIIss93Hv8qv8WHSIJoS
         AKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81jT1Hdc80WGYZ0NolRfY9wVErFdmf0CnSOj/bK3nzo=;
        b=iZ5XWX1m4k+MYL0k851zdSvjnOYOdNnxj2o2E+mpK9IuRofyT+NxI8iC9xFSGtuizn
         WI+F15bh4D7qNJqzGaxLDgQqGWuVAGzO9T/akou4YXr6D3O7CX6hH31KOolYwCxqGac2
         2skW4QuRHvbhKI3qNCtVegSItRc1ohh/3z6GSqv38gtywhBLnPnjn6deVJutq4pPSRo6
         9rcWvs9mcAHyAJFPShfvhZKG7V+i4XsqxrnPExjp5pGsxLBSrkSeOt6h6MjGrdmAk1hI
         9a+HuR/KE1o92T/usTGwxkEXlNxPuKsXngfreqDf48eKDV7jo2jBmhzR1pQm76RFKikT
         eQCg==
X-Gm-Message-State: APjAAAXX6IPTP/1i5YZ87nmQLitiLcLPLfE38VGF/soNAbsiQcOGYsqZ
        z5S+8o/b4DVWJ+m2DS0Jx9Y/xw==
X-Google-Smtp-Source: APXvYqzrXFiUSgzqu3ffxXhDqird+PVtZh0YXGYvXI5ZHYMZM5dV6GcQ4Vg9uZ1+KYqYHu1zRMYt4w==
X-Received: by 2002:a0c:bd9a:: with SMTP id n26mr5905854qvg.25.1560473099585;
        Thu, 13 Jun 2019 17:44:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r5sm756136qkc.42.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKs-0005Kc-4A; Thu, 13 Jun 2019 21:44:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 12/12] mm/hmm: Fix error flows in hmm_invalidate_range_start
Date:   Thu, 13 Jun 2019 21:44:50 -0300
Message-Id: <20190614004450.20252-13-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

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
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 include/linux/hmm.h |  2 +-
 mm/hmm.c            | 77 +++++++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 31 deletions(-)

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
index c0d43302fd6b2f..1172a4f0206963 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -67,7 +67,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	init_rwsem(&hmm->mirrors_sem);
 	hmm->mmu_notifier.ops = NULL;
 	INIT_LIST_HEAD(&hmm->ranges);
-	mutex_init(&hmm->lock);
+	spin_lock_init(&hmm->ranges_lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
 	hmm->mm = mm;
@@ -124,18 +124,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
@@ -151,6 +152,23 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
@@ -158,6 +176,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
+	unsigned long flags;
 	int ret = 0;
 
 	if (!kref_get_unless_zero(&hmm->kref))
@@ -168,12 +187,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
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
@@ -181,7 +195,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 
 		range->valid = false;
 	}
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	if (mmu_notifier_range_blockable(nrange))
 		down_read(&hmm->mirrors_sem);
@@ -189,16 +203,26 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
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
@@ -207,23 +231,14 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
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
@@ -876,6 +891,7 @@ int hmm_range_register(struct hmm_range *range,
 {
 	unsigned long mask = ((1UL << page_shift) - 1UL);
 	struct hmm *hmm = mirror->hmm;
+	unsigned long flags;
 
 	range->valid = false;
 	range->hmm = NULL;
@@ -894,7 +910,7 @@ int hmm_range_register(struct hmm_range *range,
 		return -EFAULT;
 
 	/* Initialize range to track CPU page table updates. */
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 
 	range->hmm = hmm;
 	kref_get(&hmm->kref);
@@ -906,7 +922,7 @@ int hmm_range_register(struct hmm_range *range,
 	 */
 	if (!hmm->notifiers)
 		range->valid = true;
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	return 0;
 }
@@ -922,10 +938,11 @@ EXPORT_SYMBOL(hmm_range_register);
 void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
+	unsigned long flags;
 
-	mutex_lock(&hmm->lock);
+	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	list_del(&range->list);
-	mutex_unlock(&hmm->lock);
+	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
 
 	/* Drop reference taken by hmm_range_register() */
 	mmput(hmm->mm);
-- 
2.21.0

