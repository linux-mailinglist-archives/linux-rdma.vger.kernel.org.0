Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7587451CB3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfFXVCJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35599 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfFXVCI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so726139wml.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QRiWs/DQbjPzNp3Mmcykk+AEBHTNlfm8mEd5w/KsEk=;
        b=QHyBSbiaOkKGu/MxsSMUiXu2VTSCzVLYMxWwINOB/2Q6vPwGK/3fpuJ8DeqVV/RHuy
         PlWt0PKGF2DxILefQKepmvvAs9zfo0sJ/4JuHPb0QB5wuqyBLoHp42kHvsETulBVPEc1
         nqIqqhYShDyfMHcp9pog0fds+dL+EL98KHWdrqc1jzmg4ngIMYHE16t7uPvX3+VkB4vI
         bsZkTMXkFYDGzt6JPUksZtjhk0vmx/AJejbnSzHMAh8/EfzJ0wiL46ukX5ePRnoNGE/1
         nJ7mvYjHCVInsefIPkoIGcN7Hka7i1yS3Hv0kHKhgEn2UJ3p9gHquSgDjpsddvKgWt95
         ZSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QRiWs/DQbjPzNp3Mmcykk+AEBHTNlfm8mEd5w/KsEk=;
        b=DqHc62ppNvZ/25I7Hi8DXDx14E6pq6/PktUFwznJRXbfUXUyPFXZ6N81rp8sY77wCh
         P7ghIhwBJxBwN7lV7UJaca7oZkZNOjJr6og157S/W8aVbCuHaoY/UUF8vYGK4Xr14bv4
         LjKTlL87QeyinhIc0qgKs/hqbGjjp1MOjYEQQexf18GD4sO8Qr9kr0e2vkizuE0aVWt2
         lIColyTwct9qm3e6C0kSjAD4BIfqg8vo1eEN80YNrw7FKZyPtr68z/LYLSFRgvzi1oqr
         mbRIZyGgpNED8DKEDnAaEvydQ7CkJmIDR2m7+cKIRvWgQCZhiZQjYhsFYv3req4h7VAq
         Ps4A==
X-Gm-Message-State: APjAAAWxgsGecv/Aee01fiFBj4gVYnUYZzSv56CEAQSr2IEK80BWWtIP
        Xzh2qErlt5/DfuznWT2R+KDj6Q==
X-Google-Smtp-Source: APXvYqyUO9q1BVm7bVuWFkSD3xUfLwXJTWFUz+E3q3pTmFAgmdWwYSJRzm7jgl6xIMlY4/wE2Sy8yg==
X-Received: by 2002:a1c:2311:: with SMTP id j17mr9036341wmj.84.1561410125783;
        Mon, 24 Jun 2019 14:02:05 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id d5sm10927937wrc.17.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001MH-Rm; Mon, 24 Jun 2019 18:02:00 -0300
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
Subject: [PATCH v4 hmm 04/12] mm/hmm: Simplify hmm_get_or_create and make it reliable
Date:   Mon, 24 Jun 2019 18:01:02 -0300
Message-Id: <20190624210110.5098-5-jgg@ziepe.ca>
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

As coded this function can false-fail in various racy situations. Make it
reliable and simpler by running under the write side of the mmap_sem and
avoiding the false-failing compare/exchange pattern. Due to the mmap_sem
this no longer has to avoid racing with a 2nd parallel
hmm_get_or_create().

Unfortunately this still has to use the page_table_lock as the
non-sleeping lock protecting mm->hmm, since the contexts where we free the
hmm are incompatible with mmap_sem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2:
- Fix error unwind of mmgrab (Jerome)
- Use hmm local instead of 2nd container_of (Jerome)
v3:
- Can't use mmap_sem in the SRCU callback, keep using the
  page_table_lock (Philip)
v4:
- Put the mm->hmm = NULL in the kref release, reduce LOC
  in hmm_get_or_create() (Christoph)
---
 mm/hmm.c | 77 ++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 080b17a2e87e2d..0423f4ca3a7e09 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -31,16 +31,6 @@
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
-static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
-{
-	struct hmm *hmm = READ_ONCE(mm->hmm);
-
-	if (hmm && kref_get_unless_zero(&hmm->kref))
-		return hmm;
-
-	return NULL;
-}
-
 /**
  * hmm_get_or_create - register HMM against an mm (HMM internal)
  *
@@ -55,11 +45,16 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
  */
 static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
-	bool cleanup = false;
+	struct hmm *hmm;
+
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
-	if (hmm)
-		return hmm;
+	/* Abuse the page_table_lock to also protect mm->hmm. */
+	spin_lock(&mm->page_table_lock);
+	hmm = mm->hmm;
+	if (mm->hmm && kref_get_unless_zero(&mm->hmm->kref))
+		goto out_unlock;
+	spin_unlock(&mm->page_table_lock);
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -74,57 +69,45 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
-	mmgrab(hmm->mm);
 
-	spin_lock(&mm->page_table_lock);
-	if (!mm->hmm)
-		mm->hmm = hmm;
-	else
-		cleanup = true;
-	spin_unlock(&mm->page_table_lock);
+	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
+	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
+		kfree(hmm);
+		return NULL;
+	}
 
-	if (cleanup)
-		goto error;
+	mmgrab(hmm->mm);
 
 	/*
-	 * We should only get here if hold the mmap_sem in write mode ie on
-	 * registration of first mirror through hmm_mirror_register()
+	 * We hold the exclusive mmap_sem here so we know that mm->hmm is
+	 * still NULL or 0 kref, and is safe to update.
 	 */
-	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
-	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
-		goto error_mm;
-
-	return hmm;
-
-error_mm:
 	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
+	mm->hmm = hmm;
+
+out_unlock:
 	spin_unlock(&mm->page_table_lock);
-error:
-	mmdrop(hmm->mm);
-	kfree(hmm);
-	return NULL;
+	return hmm;
 }
 
 static void hmm_free_rcu(struct rcu_head *rcu)
 {
-	kfree(container_of(rcu, struct hmm, rcu));
+	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
+
+	mmdrop(hmm->mm);
+	kfree(hmm);
 }
 
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
-	struct mm_struct *mm = hmm->mm;
 
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
+	spin_lock(&hmm->mm->page_table_lock);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	spin_unlock(&hmm->mm->page_table_lock);
 
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
-	spin_unlock(&mm->page_table_lock);
-
-	mmdrop(hmm->mm);
+	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
 }
 
-- 
2.22.0

