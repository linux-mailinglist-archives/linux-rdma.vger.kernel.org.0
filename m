Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7575A37C73
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFFSou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42394 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfFFSot (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so2115752qkc.9
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cde22D2D/SQ7DjRMRDYakpeqSceiEmLYAy9R4sDRFZ4=;
        b=lSL5uWTCwCDgnbM/9/jrfQbxzPhWl8p/lDEgf4FT0uXH6Y+QewAJIhobM0Y5pnTV9Q
         mHJJmWUwI+A1PUB/WHWHue/Bz0y86gLvYZNesbGU1EQLEO4zSV4kHiD4h1a3k/MFDCdt
         WER1Mq2EaZX18rAxQeUToKW/nL69Y1jxs8Z6SnX3i9uxlnWxabF1Y6RuKi6OeGO9ieDQ
         MKnU5o9rvxa7nvv/y/bNKbuZLHNH9r7rBleushaJ37/rgvNJIPoVwIFEEjE9KU47+m6B
         Zk1tFH65d0SU9drWp7Mv6gBGKQ18TW6fwuehe84ewVEWflPwK/zZvOf9mFM3yphUj1/7
         R/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cde22D2D/SQ7DjRMRDYakpeqSceiEmLYAy9R4sDRFZ4=;
        b=EwDslcXAwKjghj5bRpIAqKwCJU2d1u8JAXwf/JPl5reM0hSwfDXs34a66txotkPRLy
         dU/HzHaISAxRStnYEahavZId/TlZsWVRWvJ+fk0qvr2OJeptQCzq9nqJwwVwO/Lj0NXm
         TSBNMM8ebR2cwSfwEjqJ36U6XZamaMA74RqEeukLXcsQlC4YNXpb6JqIOP6x1/s+jsDM
         umWvMPhbQKtpyq1oDAD0Al6cxs4FP1mQ4SRkRsOlQ8FtSo+Sq6BBP9vr0oukiyJzMxRz
         JNXA135ItsKVJZw7WYfIhJk/nF8yZ3VAuJ8CcvI46FaqLW/JGHkJUgZ+H2MlA8vW7rRA
         f64g==
X-Gm-Message-State: APjAAAUPwq6EPoLLmBn4nGE1QtnBa9C7EhdNqtLdEibFMFdse0iCJXv1
        JQ84hAUDyEKq9UJl8XBQj53hNw==
X-Google-Smtp-Source: APXvYqxTSq7xbg9zxLiy0kEDCOrZTnZLTLbqUahJa+pbRkNf/2oRcK31kQh3sfGGk+OlBqVQE/baDQ==
X-Received: by 2002:a37:4fca:: with SMTP id d193mr40455150qkb.298.1559846688185;
        Thu, 06 Jun 2019 11:44:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o38sm1731656qto.96.2019.06.06.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008IN-IO; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 04/11] mm/hmm: Simplify hmm_get_or_create and make it reliable
Date:   Thu,  6 Jun 2019 15:44:31 -0300
Message-Id: <20190606184438.31646-5-jgg@ziepe.ca>
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

As coded this function can false-fail in various racy situations. Make it
reliable by running only under the write side of the mmap_sem and avoiding
the false-failing compare/exchange pattern.

Also make the locking very easy to understand by only ever reading or
writing mm->hmm while holding the write side of the mmap_sem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
v2:
- Fix error unwind of mmgrab (Jerome)
- Use hmm local instead of 2nd container_of (Jerome)
---
 mm/hmm.c | 80 ++++++++++++++++++++------------------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index cc7c26fda3300e..dc30edad9a8a02 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -40,16 +40,6 @@
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
@@ -64,11 +54,20 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
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
+	if (mm->hmm) {
+		if (kref_get_unless_zero(&mm->hmm->kref))
+			return mm->hmm;
+		/*
+		 * The hmm is being freed by some other CPU and is pending a
+		 * RCU grace period, but this CPU can NULL now it since we
+		 * have the mmap_sem.
+		 */
+		mm->hmm = NULL;
+	}
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -83,57 +82,36 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
-	mmgrab(hmm->mm);
-
-	spin_lock(&mm->page_table_lock);
-	if (!mm->hmm)
-		mm->hmm = hmm;
-	else
-		cleanup = true;
-	spin_unlock(&mm->page_table_lock);
 
-	if (cleanup)
-		goto error;
-
-	/*
-	 * We should only get here if hold the mmap_sem in write mode ie on
-	 * registration of first mirror through hmm_mirror_register()
-	 */
 	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
-	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
-		goto error_mm;
+	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
+		kfree(hmm);
+		return NULL;
+	}
 
+	mmgrab(hmm->mm);
+	mm->hmm = hmm;
 	return hmm;
-
-error_mm:
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
-	spin_unlock(&mm->page_table_lock);
-error:
-	mmdrop(hmm->mm);
-	kfree(hmm);
-	return NULL;
 }
 
 static void hmm_free_rcu(struct rcu_head *rcu)
 {
-	kfree(container_of(rcu, struct hmm, rcu));
+	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
+
+	down_write(&hmm->mm->mmap_sem);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	up_write(&hmm->mm->mmap_sem);
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

