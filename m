Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55A451CB6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfFXVCK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfFXVCJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so15401831wrl.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsR/80TrTiUsWjQJpDlrT4mzZAmfUfoSI9FV/A0UaHU=;
        b=eEL2e+Rdsoiw+QWNMAoS5eOmfH9fxVT52iqVy3PrFcraDcKDNUukaiSHGjOkUDbkf4
         8WHJYUyZdN7bf/y/Jstfu3A1fXcJitPxheR1/65Jv090zH+Eo5OQi1q+O4dWucKvZtrF
         Svhl2dcm8mOneehpNFXJVkZ7TYkrWa7CSn4DrBB60/QLpDJEVZeh45IqxTnVZkAWRCWG
         fnhCq6Ea5ODgJg75hQ/Xpeto43ZyjWXSU53z1FdntKD0LH/Otni2IWokQ2rJk9vV5gII
         L0dENrfxVOm9si6Xksz7dp0Ey4NfHgch3yvMfxoEZTAShU86NCM8h0UHtjz8kyN+4J6G
         MbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsR/80TrTiUsWjQJpDlrT4mzZAmfUfoSI9FV/A0UaHU=;
        b=Iieot21NgLDgnQlWYNNbLK6/7AKTU+ozH/AAjFA1B/wyKqlBKxKZPHoLpkaMrZLnz6
         Ms/Py5hhUjveowAXNw1nrk/jUkkg6b/e+fnc8Tj9+TJpCp82INRZT/q064PNjpfgzn9A
         U97wFDliNNY1cJq2ReP76MpIoB34OZTKbT0+0sh6Fb6OjmU3YPMlsY7AlRx1EWusRShd
         LAQb3L5wk61cQ7YKw7piUqmFbu+khKO4o8RrYCEcTjy0rXoy3WEBRAwkQIAaM805jixD
         V5r+sl8tgO0zDJ/vvKWJ11NlB0IRhWNXqIQqDKS1mOmxGxAUnDmk7xmXZ+IhFqkAdyqb
         Kiew==
X-Gm-Message-State: APjAAAVBmn/CEqSCJEBOHI7qAwv8vtiziz9Ko9c86+hVYiPQRtW3joaT
        9PY9XMTFrT1KagDlmrkANBOjTA==
X-Google-Smtp-Source: APXvYqyzrTyoPhYHFWjo48jic83g1/CALuSvPyW3MCerg+RPA+Kf+K4POtxSR/W0sWmHBTVwQ3b5Mw==
X-Received: by 2002:adf:a312:: with SMTP id c18mr18493691wrb.332.1561410127528;
        Mon, 24 Jun 2019 14:02:07 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id x11sm469692wmg.23.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001MW-VA; Mon, 24 Jun 2019 18:02:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v4 hmm 07/12] mm/hmm: Hold on to the mmget for the lifetime of the range
Date:   Mon, 24 Jun 2019 18:01:05 -0300
Message-Id: <20190624210110.5098-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2:
 - Use Jerome's idea of just holding the mmget() for the range lifetime,
   rework the patch to use that as as simplification to remove dead in
   one step
v3:
 - Use list_del_careful (Christoph)
---
 include/linux/hmm.h | 26 --------------------------
 mm/hmm.c            | 32 +++++++++++---------------------
 2 files changed, 11 insertions(+), 47 deletions(-)

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
index 73c8af4827fe87..1eddda45cefae7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -67,7 +67,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->dead = false;
 	hmm->mm = mm;
 
 	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
@@ -120,21 +119,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
-	mutex_lock(&hmm->lock);
-	list_for_each_entry(range, &hmm->ranges, list)
-		range->valid = false;
-	wake_up_all(&hmm->wq);
-	mutex_unlock(&hmm->lock);
+	/*
+	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
+	 * prevented as long as a range exists.
+	 */
+	WARN_ON(!list_empty_careful(&hmm->ranges));
 
 	down_write(&hmm->mirrors_sem);
 	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
@@ -903,8 +897,8 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
+	/* Prevent hmm_release() from running while the range is valid */
+	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
 
 	/* Initialize range to track CPU page table updates. */
@@ -942,11 +936,12 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del(&range->list);
+	list_del_init(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
+	mmput(hmm->mm);
 	hmm_put(hmm);
 	range->hmm = NULL;
 }
@@ -974,10 +969,7 @@ long hmm_range_snapshot(struct hmm_range *range)
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
@@ -1072,9 +1064,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 	struct mm_walk mm_walk;
 	int ret;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-- 
2.22.0

