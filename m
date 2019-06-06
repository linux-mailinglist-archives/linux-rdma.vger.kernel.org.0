Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2537C72
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfFFSou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39668 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFFSot (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so3899816qta.6
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDRIilFVldnvkbkMJDKjjlCneF+91QuQaIvOaI3TwIs=;
        b=QCSARRqkANiDuo9Zt0gh3n3vfALB6ijEiRwqIMaXCX3/qGzEYVq5zDKzohmDrx2kEq
         E/nLyL1hf/Yw2YVKQK2mevK/3x7wbrlWVevgrKFbIiCf3/EB6QRExm5LWe5UtxC9rV5d
         UQwAlzEs9kATjD+x85Cuz49AhNxPFC7gKS60FnQfbxtiMvkSooOuUBX+Iv5TIFtZIcqQ
         Aee5zzJxne/q8crQAD9Is+y1upCG3grwwPRQuj39icbmd1uTk0pCmr+5K/a+fe+W+cWn
         Ye97kdTtyZ2qAfyBP9hoRiiA8P1jinSjAUnj4sUnxQAhfyk59Kal+WLdZQytIQm+fu8L
         ZYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDRIilFVldnvkbkMJDKjjlCneF+91QuQaIvOaI3TwIs=;
        b=aZXXKT23UX3wmvg2/2yS+b+f78aRsJq6QqAvkSeVjXBW6dH7dHRJ71wEQEnpaTQrnO
         NAygboDEUxS16JtDtFR4lsAzFldB83ckhUwjv01JcHw6MQA32C9YeMp3LNY12laKZMIx
         O9fh7ZDfFgdL4exbGShG8TjDOxH4nFFxW3qHF3BV2QMr4pv8VjfgQlQWI5P0QSD+cF4u
         mVnv7xE3NhpOVBGzT+lb53AMNUEGuTTn+x3aNbYJUMnDty6Jfw68RWj1JBKDbRQC8zOU
         woqW3kl1vT+yaBrOE75Fnq1UYC4U2AtMiCFU4mnNqaQZa/DfUQ+ql6lvHBfAldhGHCn/
         cySA==
X-Gm-Message-State: APjAAAUdvSPWOfAXFboqW3Fb2rYgk4EM8XTxIccvsFWDNsYaO+e47LI9
        f/19Rz894SWY5LTEfuCeHZZoTA==
X-Google-Smtp-Source: APXvYqxDHwC4C9hnk7VytBkovRfN98/hasmwmCm/dELdXMnufTdP+P+aFJn1ExmavzkvjsH0ryaMNg==
X-Received: by 2002:ac8:28dd:: with SMTP id j29mr42963672qtj.34.1559846688561;
        Thu, 06 Jun 2019 11:44:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 77sm871850qkd.59.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008IZ-M7; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 06/11] mm/hmm: Hold on to the mmget for the lifetime of the range
Date:   Thu,  6 Jun 2019 15:44:33 -0300
Message-Id: <20190606184438.31646-7-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
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
index 2ab35b40992b24..0e20566802967a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -91,7 +91,6 @@
  * @mirrors_sem: read/write semaphore protecting the mirrors list
  * @wq: wait queue for user waiting on a range invalidation
  * @notifiers: count of active mmu notifiers
- * @dead: is the mm dead ?
  */
 struct hmm {
 	struct mm_struct	*mm;
@@ -104,7 +103,6 @@ struct hmm {
 	wait_queue_head_t	wq;
 	struct rcu_head		rcu;
 	long			notifiers;
-	bool			dead;
 };
 
 /*
@@ -469,30 +467,6 @@ struct hmm_mirror {
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
index dc30edad9a8a02..f67ba32983d9f1 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -80,7 +80,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->dead = false;
 	hmm->mm = mm;
 
 	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
@@ -124,20 +123,17 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
-	struct hmm_range *range;
 
 	/* hmm is in progress to free */
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
@@ -909,8 +905,8 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
+	/* Prevent hmm_release() from running while the range is valid */
+	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
 
 	range->hmm = hmm;
@@ -955,6 +951,7 @@ void hmm_range_unregister(struct hmm_range *range)
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
+	mmput(hmm->mm);
 	hmm_put(hmm);
 	range->hmm = NULL;
 }
@@ -982,10 +979,7 @@ long hmm_range_snapshot(struct hmm_range *range)
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
@@ -1080,9 +1074,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
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

