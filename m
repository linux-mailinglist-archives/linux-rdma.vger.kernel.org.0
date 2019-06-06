Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0437C6F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFFSos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37051 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so3925043qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bW6W0dzfTSD+G2qWpxSPnT6FDkRgs6qYralNDwCWWpM=;
        b=EJVyVO6oJlvHu7MqG8ir6ye0d2E52VzdqGkXefNtzJsbNH/e2vUDKVO4zKcSXAEFek
         RGTHSuR2YRZ1JntKN58PGjvSeSfQolEl6TZyDu5mOklbvcsTapHOZDax5t2QrdVtX4to
         S11U99ZURLmGhJncgXoMHt954BFGp+lQHi/nCQ/NGsZzpVCFFG4kyutLM4kf1TOb9nOO
         tio0c5Uz+BelXNUYQJIQjh7rB+6spPYFY8/2kbAPv75GMFedDdWbqiZJxGEeE5bGDsyy
         mjVC0gpMoewb2qe/MbOH7NBFg26yQBOwn3DW+fWWa28YBIKRIyCP/q4ODTS6P3lKmvV+
         taYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bW6W0dzfTSD+G2qWpxSPnT6FDkRgs6qYralNDwCWWpM=;
        b=DkgVoreL7dcOdXNZx0xSn6RhFXrWPNIqsXxKplrut3GAjZ3Jv2+38i3w2dPenrL7Pt
         KhJLBLE5D1LdqT9Nxyl8pW7YUd/4aVrTeX8GVGmzoBEYY0c+Az3w4w3vYDblP2rkzgsH
         bhEKZX0wAA7mosF8Yxl6CKLjENCWR47CzjD1Q3RxVSASuKPcAQwaV28e2m+7ygP5hY8F
         MURtrM8Yev0pBuZpYMCxnQkWaDZIF66bNlrULVm+bZr+qW0p5gOXoKiapa8KEC+Z16oG
         CvSpBWH1DsEmKaAO5fOjUycZQwqTP8Mbr6cGT8SYABzi4K4bOrUIjZC473LKgz2Pf3za
         u4Qw==
X-Gm-Message-State: APjAAAWVlwFSBRxvP2VlulXMOMHlMGbPK4Qy3Z6Sdv/l7AROuO7ube73
        Scyvuyv9BYSWqgzX0FysoUk4Ww==
X-Google-Smtp-Source: APXvYqzZrmfOR3muOAR1prnBDkAE4ixgQwkLWPMt0LNdVl4lLNKXUZcw+vPND9ViR47fQ9OlYet1CA==
X-Received: by 2002:aed:2a43:: with SMTP id k3mr42504564qtf.301.1559846687527;
        Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm1192064qtj.27.2019.06.06.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008IH-HE; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 03/11] mm/hmm: Hold a mmgrab from hmm to mm
Date:   Thu,  6 Jun 2019 15:44:30 -0300
Message-Id: <20190606184438.31646-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

So long a a struct hmm pointer exists, so should the struct mm it is
linked too. Hold the mmgrab() as soon as a hmm is created, and mmdrop() it
once the hmm refcount goes to zero.

Since mmdrop() (ie a 0 kref on struct mm) is now impossible with a !NULL
mm->hmm delete the hmm_hmm_destroy().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
v2:
 - Fix error unwind paths in hmm_get_or_create (Jerome/Jason)
---
 include/linux/hmm.h |  3 ---
 kernel/fork.c       |  1 -
 mm/hmm.c            | 22 ++++------------------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 2d519797cb134a..4ee3acabe5ed22 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -586,14 +586,11 @@ static inline int hmm_vma_fault(struct hmm_mirror *mirror,
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
index b2b87d450b80b5..588c768ae72451 100644
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
index 8796447299023c..cc7c26fda3300e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
+#include <linux/sched/mm.h>
 #include <linux/jump_label.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmu_notifier.h>
@@ -82,6 +83,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
+	mmgrab(hmm->mm);
 
 	spin_lock(&mm->page_table_lock);
 	if (!mm->hmm)
@@ -109,6 +111,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 error:
+	mmdrop(hmm->mm);
 	kfree(hmm);
 	return NULL;
 }
@@ -130,6 +133,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
+	mmdrop(hmm->mm);
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
 }
 
@@ -138,24 +142,6 @@ static inline void hmm_put(struct hmm *hmm)
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
2.21.0

