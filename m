Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EFB450D8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFNAo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37414 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFNAo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so615154qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQFZUVD3bm8q29tG8rKodDV9niV08KJ4TO1srbmenK4=;
        b=UA1C5NPqvlm8z++G2laNCnwB/GWT7FWVDsQKpzNw396EnXD5grCbfeRcH4MVcv9Pxt
         Bw608pa0SQVwTZPesERpsVjDiheiUA0ZxpcaOhSCg3wFfLyCKPSY6m0rcqgkt0F7+Btu
         VcnvcuEPLZ4+31oNvXwgQ7Mzr5sdaFHqpO9DtB7bD2Mphja5lK5GoftxQttJJRITdM9l
         ZjsrOqKbZRdEDMQmdCny9EgekTtIr+yc7ps9gI2Z9j+YV7fGRjNJ2Dq2ZT34qRz8bx4L
         2H+VNusPv5/abMz/Jh+ee/Y2I8OCp7Q6Wc38Z0vyw+mbGlfjmn34SHlMrcpzNY0sbebl
         RR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQFZUVD3bm8q29tG8rKodDV9niV08KJ4TO1srbmenK4=;
        b=L5HcLkLP64gH0mm8Q7nwSKADk33n6BFAcK5y4/F75rCjRkUOtDwA6LfQMLy/f57fmG
         LzCEcieINa1SZbaJDZbwPbBen2VjY62LhzhAdlCpq5JYsu2WYmzy0mt4auZ/68uZC26Y
         M2xxMfXo5+VkQ6xtV59ir7IldnR5tuC9MkJLWr8UcljCi+7dt59DR4HsDWdLkD1Qfqr8
         XnlZvonLqWAFWfznQ/wOzY9yYigO/1RZaY8lttWz6SZs+Xz7tIcBUAtm86uYf6QjF1SJ
         fYSXv12LiGyUXoittAlQ3R33qR8OVfzwoaBbxR4K40Z+TiBaT8V055uSwRlxr8aGD9C/
         yzgA==
X-Gm-Message-State: APjAAAXFkI3B+IfiKB4IR6CZ6QOdLgdi5ZMDozdS03LAkX+62VMxQQwP
        G6Fe8ciAMj29RpAzVzy/SL1vpw==
X-Google-Smtp-Source: APXvYqw56kQGKLPlj2Zgzkw2ysxgtbRlSboLCdNQH17EQruEZjbScaFJD3FwSz5lL9I3GIRJGcwbsg==
X-Received: by 2002:a0c:afa2:: with SMTP id s31mr5894610qvc.186.1560473096316;
        Thu, 13 Jun 2019 17:44:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l3sm683628qkd.49.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005Jq-Ni; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 04/12] mm/hmm: Simplify hmm_get_or_create and make it reliable
Date:   Thu, 13 Jun 2019 21:44:42 -0300
Message-Id: <20190614004450.20252-5-jgg@ziepe.ca>
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
---
 mm/hmm.c | 84 ++++++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 080b17a2e87e2d..4c64d4c32f4825 100644
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
@@ -55,11 +45,19 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
  */
 static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
-	bool cleanup = false;
+	struct hmm *hmm;
 
-	if (hmm)
-		return hmm;
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
+
+	/* Abuse the page_table_lock to also protect mm->hmm. */
+	spin_lock(&mm->page_table_lock);
+	if (mm->hmm) {
+		if (kref_get_unless_zero(&mm->hmm->kref)) {
+			spin_unlock(&mm->page_table_lock);
+			return mm->hmm;
+		}
+	}
+	spin_unlock(&mm->page_table_lock);
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -74,57 +72,47 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
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
+	/*
+	 * The mm->hmm pointer is kept valid while notifier ops can be running
+	 * so they don't have to deal with a NULL mm->hmm value
+	 */
+	spin_lock(&hmm->mm->page_table_lock);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	spin_unlock(&hmm->mm->page_table_lock);
+	mmdrop(hmm->mm);
+
+	kfree(hmm);
 }
 
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
-	struct mm_struct *mm = hmm->mm;
-
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
 
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
2.21.0

