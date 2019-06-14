Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1D450D7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfFNAo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfFNAo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so613453qkc.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOT/1//lPYO2KnTg7JAYlGe+L6wOGbnqhk1iQ3bfzXA=;
        b=KUyynqtgRE6EpplNjkgK7xEKW+4i8YtoCdu847R/HKHbJfnzbjofwdI3Ea6k0EuVSe
         1CZaEOJYQRtMq3h0sFFCemgzzSgbiIlR01ffFmvPX9pmujQZhT4dybPJ0azLpv2M3X9+
         6Tb39zktfnoe3oIet0A0akwq1fikYli3gOB8Ej+qnnX38PCI4BOZsTugxauTr9grN1NY
         o/xA6GHrOsOdFk1lM9xdmnpjoyYypBmE2AejoMzAHHaTMtA6L+OhWLo1qhD7nA3VHByF
         jua1HGswi4DoY/NGhXWwkfny9XYjh5QfCt8aiJgJGRL1dZHZMavFJ9hgwEsQQVXXj1WN
         tnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOT/1//lPYO2KnTg7JAYlGe+L6wOGbnqhk1iQ3bfzXA=;
        b=HwBUA4f6huMSfvlz0FZAJpAOW/gHjfqsBDIh8EejG8Lzf1ho+OKWJe/AMniEOSXAcA
         NtfWYGVc1apieEYcLUXJs2nU40soGRnSpedvPm4dVGtfgOZKKYsbWLBfi0elivmahUBH
         FdpEUjULxjmf3JOpsc8BNuti8b0ojamTM7M4gz5TM5USXcZXZXntzzRMuO/w+wgVtaC8
         ZbujwXhQacwX/LUf1ahE4m8KBptAKIrUg+ygNNHgwcC0SbEHVXvHMBkTbCPi09fTIOHC
         OD1S5Lh46LESKbPLxuzqmn8E9IdXuFg4oHXI1qeDyosu5nToj4iugpRQwuRhfgGC0qA8
         qv/w==
X-Gm-Message-State: APjAAAV129HOSXHt7gVxqKaqF12AHQMbb3rOxgkcoihs5K9QGJV8Nlyu
        drJla4tUIzcm+VHzrZwTEyxDvQ==
X-Google-Smtp-Source: APXvYqxEi3V4pWZnBZ6Egs6ifesaB2oNEQOI04AD8yR+MI7rsCDs0etSdyPsSPlsZHy2Q2fiQCFnwA==
X-Received: by 2002:a05:620a:1310:: with SMTP id o16mr71613012qkj.196.1560473096852;
        Thu, 13 Jun 2019 17:44:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z126sm884276qkb.7.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005K2-Rs; Thu, 13 Jun 2019 21:44:53 -0300
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
Subject: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the lifetime of the range
Date:   Thu, 13 Jun 2019 21:44:44 -0300
Message-Id: <20190614004450.20252-7-jgg@ziepe.ca>
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

Range functions like hmm_range_snapshot() and hmm_range_fault() call
find_vma, which requires hodling the mmget() and the mmap_sem for the mm.

Make this simpler for the callers by holding the mmget() inside the range
for the lifetime of the range. Other functions that accept a range should
only be called if the range is registered.

This has the side effect of directly preventing hmm_release() from
happening while a range is registered. That means range->dead cannot be
false during the lifetime of the range, so remove dead and
hmm_mirror_mm_is_alive() entirely.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2:
 - Use Jerome's idea of just holding the mmget() for the range lifetime,
   rework the patch to use that as as simplification to remove dead in
   one step
---
 include/linux/hmm.h | 26 --------------------------
 mm/hmm.c            | 28 ++++++++++------------------
 2 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 26e7c477490c4e..bf013e96525771 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -82,7 +82,6 @@
  * @mirrors_sem: read/write semaphore protecting the mirrors list
  * @wq: wait queue for user waiting on a range invalidation
  * @notifiers: count of active mmu notifiers
- * @dead: is the mm dead ?
  */
 struct hmm {
 	struct mm_struct	*mm;
@@ -95,7 +94,6 @@ struct hmm {
 	wait_queue_head_t	wq;
 	struct rcu_head		rcu;
 	long			notifiers;
-	bool			dead;
 };
 
 /*
@@ -459,30 +457,6 @@ struct hmm_mirror {
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
-/*
- * hmm_mirror_mm_is_alive() - test if mm is still alive
- * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
- * Return: false if the mm is dead, true otherwise
- *
- * This is an optimization, it will not always accurately return false if the
- * mm is dead; i.e., there can be false negatives (process is being killed but
- * HMM is not yet informed of that). It is only intended to be used to optimize
- * out cases where the driver is about to do something time consuming and it
- * would be better to skip it if the mm is dead.
- */
-static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
-{
-	struct mm_struct *mm;
-
-	if (!mirror || !mirror->hmm)
-		return false;
-	mm = READ_ONCE(mirror->hmm->mm);
-	if (mirror->hmm->dead || !mm)
-		return false;
-
-	return true;
-}
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
diff --git a/mm/hmm.c b/mm/hmm.c
index 4c64d4c32f4825..58712d74edd585 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -70,7 +70,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->dead = false;
 	hmm->mm = mm;
 
 	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
@@ -125,20 +124,17 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
-	struct hmm_range *range;
 
 	/* Bail out if hmm is in the process of being freed */
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	/* Report this HMM as dying. */
-	hmm->dead = true;
-
-	/* Wake-up everyone waiting on any range. */
 	mutex_lock(&hmm->lock);
-	list_for_each_entry(range, &hmm->ranges, list)
-		range->valid = false;
-	wake_up_all(&hmm->wq);
+	/*
+	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
+	 * prevented as long as a range exists.
+	 */
+	WARN_ON(!list_empty(&hmm->ranges));
 	mutex_unlock(&hmm->lock);
 
 	down_write(&hmm->mirrors_sem);
@@ -908,8 +904,8 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
+	/* Prevent hmm_release() from running while the range is valid */
+	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
 
 	/* Initialize range to track CPU page table updates. */
@@ -952,6 +948,7 @@ void hmm_range_unregister(struct hmm_range *range)
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
+	mmput(hmm->mm);
 	hmm_put(hmm);
 	range->hmm = NULL;
 }
@@ -979,10 +976,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 	struct vm_area_struct *vma;
 	struct mm_walk mm_walk;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
-
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 	do {
 		/* If range is no longer valid force retry. */
 		if (!range->valid)
@@ -1077,9 +1071,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 	struct mm_walk mm_walk;
 	int ret;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-- 
2.21.0

