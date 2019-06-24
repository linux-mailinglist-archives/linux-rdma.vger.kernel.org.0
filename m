Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8059551CAD
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfFXVCG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfFXVCG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so696685wma.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJQSyx5I9WQIuat3hBB7cHn44HQ02+T6fWrOLMHDIpE=;
        b=oMvQEeOW3jlA/jInbebXvBiNOpipgFRfSGqcRm7zQTy9n0fBZhNWc+HqRdsBGvfoas
         9ZagIA6tsA27jF8jJhsuzXhsn1FXmqG0j5xv4shnb4nwTXoKwmM7oJ2k65yF3t5gXBSE
         xlXz3qHDEErdU0D2pMcseGextk7OdhnOkqInYbmQI1gUO7qrtJE1uX0pyvlz3YlLnknO
         sqCZVvuYR+lhn6UVq6Z9jO7x/rArDqufw9dwJ5VG1vfgusW9/rg/xQREUYZgy4+U1mqN
         JQUgexOwqWQrBjbYL4JVl6Alf5y/LhMUNGKdzg0+gQVKP467Kb+hNL89aBTa4xHO/0eq
         Mg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJQSyx5I9WQIuat3hBB7cHn44HQ02+T6fWrOLMHDIpE=;
        b=O56F+h6CtbrqALf3MwspBXYJ7LDBuRYMEJ7y/E2OrXBWmvLhoxwk7lxiCRz5ab9kSY
         9UdeYindI2dyGF555paXhhwZ1uxqtz10JLYOE0VcgaYEYYfy56KCu9i7xLrTMhileDgj
         AWLm09DhlXB9PZaV/eXne5rAfBCwRBajARrGHy1ySSQDrjM9oS8lwi5xsjh8Hh8cl8EA
         c+4zRedOGU5y/yZC5W+JcWd0qi6nxj/f7saslEoZoF362uVwWYCg60SQAbup0ZEbScex
         5BKv6eCzjriauNQACfPEs3F9s+SAUZfh1yRjhGBdeqtxTfAiN+kNhW0uQpns6Ui1HMwU
         pFbg==
X-Gm-Message-State: APjAAAUsHYJSQ/chIYBnJU4bV2qh7lbAhaajtiUbfrHhRpJg3O4/hmkm
        K+BW9x+6CCwf6KyMo+WmJdaLVg==
X-Google-Smtp-Source: APXvYqy/o9BJkcVraqWn87goYHtDioMKUZC2UcYj3qjd4Ok68R0RasKDzib4jR1bwJteEjTWcnZR4g==
X-Received: by 2002:a05:600c:20c3:: with SMTP id y3mr17777867wmm.3.1561410124814;
        Mon, 24 Jun 2019 14:02:04 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id l8sm26977546wrg.40.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001MC-Qe; Mon, 24 Jun 2019 18:02:00 -0300
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
Subject: [PATCH v4 hmm 03/12] mm/hmm: Hold a mmgrab from hmm to mm
Date:   Mon, 24 Jun 2019 18:01:01 -0300
Message-Id: <20190624210110.5098-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

So long as a struct hmm pointer exists, so should the struct mm it is
linked too. Hold the mmgrab() as soon as a hmm is created, and mmdrop() it
once the hmm refcount goes to zero.

Since mmdrop() (ie a 0 kref on struct mm) is now impossible with a !NULL
mm->hmm delete the hmm_hmm_destroy().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2:
 - Fix error unwind paths in hmm_get_or_create (Jerome/Jason)
---
 include/linux/hmm.h |  3 ---
 kernel/fork.c       |  1 -
 mm/hmm.c            | 22 ++++------------------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 1fba6979adf460..1d97b6d62c5bcf 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -577,14 +577,11 @@ static inline int hmm_vma_fault(struct hmm_mirror *mirror,
 }
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
-void hmm_mm_destroy(struct mm_struct *mm);
-
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
 #else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
 #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6dfd3..c704c3cedee78d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -673,7 +673,6 @@ void __mmdrop(struct mm_struct *mm)
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
-	hmm_mm_destroy(mm);
 	mmu_notifier_mm_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
diff --git a/mm/hmm.c b/mm/hmm.c
index 22a97ada108b4e..080b17a2e87e2d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -20,6 +20,7 @@
 #include <linux/swapops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
+#include <linux/sched/mm.h>
 #include <linux/jump_label.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmu_notifier.h>
@@ -73,6 +74,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
+	mmgrab(hmm->mm);
 
 	spin_lock(&mm->page_table_lock);
 	if (!mm->hmm)
@@ -100,6 +102,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 error:
+	mmdrop(hmm->mm);
 	kfree(hmm);
 	return NULL;
 }
@@ -121,6 +124,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
+	mmdrop(hmm->mm);
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
 }
 
@@ -129,24 +133,6 @@ static inline void hmm_put(struct hmm *hmm)
 	kref_put(&hmm->kref, hmm_free);
 }
 
-void hmm_mm_destroy(struct mm_struct *mm)
-{
-	struct hmm *hmm;
-
-	spin_lock(&mm->page_table_lock);
-	hmm = mm_get_hmm(mm);
-	mm->hmm = NULL;
-	if (hmm) {
-		hmm->mm = NULL;
-		hmm->dead = true;
-		spin_unlock(&mm->page_table_lock);
-		hmm_put(hmm);
-		return;
-	}
-
-	spin_unlock(&mm->page_table_lock);
-}
-
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-- 
2.22.0

