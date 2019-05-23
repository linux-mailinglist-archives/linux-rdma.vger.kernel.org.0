Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C266F2814F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfEWPem (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36909 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWPem (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so7238417qtp.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UYOs1b1m4kqMa2Hcebr2aPMxfP9lZp6i0AyhspLKIc=;
        b=LV2mKDWl6z86EAVgXFrAKp9hIarl1v5CuBTZz0h3rmucixSlFycPZyRubUjCdCgxLA
         AtK7gRpiNk4P4k7v2McacqOVxWDzHDj1SIjoKD7Ak5PnFKzLI5rh/G1hioQExJlxX/qo
         1aRAcCTHLzYgrrxhfgpVo6ETGueE0agyf8qN0BMT7WPG19ZYlmnMrra6KUdEXX3cEkGG
         BDEIIdpCyEyvvS0QDao0w2v4CajWdmWOKQIXYRhlqugAFNyeY4ReYthg9OXsCqyFabSi
         X0vD7hp+cgUvC8GCSciZF5t9Od7M9Jbnz3qcwMPWB1g/F6XF9aS65QgPOkraL59krHZQ
         OSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UYOs1b1m4kqMa2Hcebr2aPMxfP9lZp6i0AyhspLKIc=;
        b=EbvAJRXEq8C3RkBnBpU+oLuKIe//FOY7fXP6tDNcrxg26c/bEelsbiE1YzF1NGEePW
         Jg1KJz0m9mTVB8cAgEuLR0ggZ5BCRBDXvc3wB2vb522nJRtwA6lk16uDs+aVnS3evJca
         hVqtzewubiQm+wW2I0dxKaoksmsi7mV6eHIbd9tyRPN8zr2rYvGEZLl1tSz5o3Fovxk2
         GXIXKRNDAl3CBeZdl9A6ZLeAPScimq60ZZocZLgrnzOsEYInnO2Am2NmA4jtAs0D6XJg
         dftuWLtvV/63hes4RAbUmx021tNLLQj7ebz2prhe2ChHi9hwjqo0NEH04dSeZ1e8KQFG
         pEew==
X-Gm-Message-State: APjAAAVDP1CxmeYAJxIlSqfP+hFg5UBkZ3Qa4z9ykFSJ1F89AVa+QG6L
        mBhGtRDA8YhEC9KfGZ1EPTt79eoZdKQ=
X-Google-Smtp-Source: APXvYqx4TikclVwMPUpuo7NFKA6Xd+Jq88ZLLLLwtvyEZvxo6rVnUXsWNS36lZk+68Gag43lw4B0JA==
X-Received: by 2002:a0c:ad85:: with SMTP id w5mr8251178qvc.242.1558625680953;
        Thu, 23 May 2019 08:34:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id k53sm13877244qtb.65.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zT-1F; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 04/11] mm/hmm: Simplify hmm_get_or_create and make it reliable
Date:   Thu, 23 May 2019 12:34:29 -0300
Message-Id: <20190523153436.19102-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
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
 mm/hmm.c | 75 ++++++++++++++++++++------------------------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e27058e92508b9..ec54be54d81135 100644
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
+	lockdep_assert_held_exclusive(mm->mmap_sem);
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
@@ -85,54 +84,34 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->mm = mm;
 	mmgrab(hmm->mm);
 
-	spin_lock(&mm->page_table_lock);
-	if (!mm->hmm)
-		mm->hmm = hmm;
-	else
-		cleanup = true;
-	spin_unlock(&mm->page_table_lock);
-
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
 
+	mm->hmm = hmm;
 	return hmm;
-
-error_mm:
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
-	spin_unlock(&mm->page_table_lock);
-error:
-	kfree(hmm);
-	return NULL;
 }
 
 static void hmm_fee_rcu(struct rcu_head *rcu)
 {
+	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
+
+	down_write(&hmm->mm->mmap_sem);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	up_write(&hmm->mm->mmap_sem);
+	mmdrop(hmm->mm);
+
 	kfree(container_of(rcu, struct hmm, rcu));
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
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
 }
 
-- 
2.21.0

