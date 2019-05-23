Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE728156
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfEWPeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36789 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbfEWPep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so7250663qth.3
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncjASLGlHsj22sNocZs8CG3omWgokVRQnVtcSgoF4Do=;
        b=afbPPYk9gBj4SFUfupZZE4bCnA6gDZMhgy4+OgszgUI8N1f+l4L4QbGabEscrkzZio
         04dKwEZTY1ZZpMvvyuXHs/Zur4eepQiD1W+lZazrUaj4nn7/t4j1M+InHHRzuagZXcr8
         KKv520d1DP6I7X4/cfCmplGSWFB7qHZa/I9bvrzKq1ogoyjdw+q2JJfFWS8aPCq+8IpA
         qzget2M+jxJ0rPEHJZXgXf8cijcYlCmoGK6a41MkyHSp5f24D9rssOEcYPsQesCbV+n0
         ERLiPP7EiRneYQ5/ivup+VNYTXqW/BHKDFa3+vKYdV9zuvfZzb8dXYO7o2N+FXeqLQBm
         RkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncjASLGlHsj22sNocZs8CG3omWgokVRQnVtcSgoF4Do=;
        b=Zy5luT8jvUUPBbYIlwoqKoECCIyQFmeD+C9BqdMF5B8gjdiZsKiYA9Zcvd969PiBfF
         drMHk/phPeMWsjpqPma/3aLi/KCx3X6kFZg9kNM6PXBgTE5jgz0WPK9EUrZXea15msC6
         jFk/yZW9W0fQdiRCYZui5AGe1iWPZVyZtlnXMWi0G64Q4cptBa7z/82ujIsP3PQTS6C+
         C2Z6d1kv+qyPtYgc7LzRixrJd9GNIOnW0yBNyGNJqUcPKUq3Jtr8WDTvC6TLUXKs6yi9
         FpjmpEV8WTCuoAcZm11NFdl/AhUsxVZVn/x6+962H+R1lGzyW2IEnWTNcfnF8GqZjqFJ
         xxhg==
X-Gm-Message-State: APjAAAVHhrsX8izTPd1vJiMfTimO557UXpSZfKQ/hJx+O07HvA6l1EhS
        EGbXLrSyRix6/P/88/E9bKTv7uibFn0=
X-Google-Smtp-Source: APXvYqxAz8IO0yDJzMp5j01V0l+mHdFZgyUtfceu0FECv0lekCVZ9tSBPQKcxg2vezV1TSB8NGjW9g==
X-Received: by 2002:ac8:18b8:: with SMTP id s53mr76217225qtj.232.1558625684721;
        Thu, 23 May 2019 08:34:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g65sm2686228qkb.1.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zl-5F; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 07/11] mm/hmm: Delete hmm_mirror_mm_is_alive()
Date:   Thu, 23 May 2019 12:34:32 -0300
Message-Id: <20190523153436.19102-8-jgg@ziepe.ca>
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

Now that it is clarified that callers to hmm_range_dma_map() must hold
the mmap_sem and thus the mmget, there is no purpose for this function.

It was the last user of dead, so delete it as well.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 27 ---------------------------
 mm/hmm.c            |  4 ----
 2 files changed, 31 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7f3b751fcab1ce..6671643703a7ab 100644
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
@@ -466,31 +464,6 @@ struct hmm_mirror {
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
-/*
- * hmm_mirror_mm_is_alive() - test if mm is still alive
- * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
- * Returns: false if the mm is dead, true otherwise
- *
- * This is an optimization it will not accurately always return -EINVAL if the
- * mm is dead ie there can be false negative (process is being kill but HMM is
- * not yet inform of that). It is only intented to be use to optimize out case
- * where driver is about to do something time consuming and it would be better
- * to skip it if the mm is dead.
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
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
diff --git a/mm/hmm.c b/mm/hmm.c
index d97ec293336ea5..2695925c0c5927 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -80,7 +80,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->dead = false;
 	hmm->mm = mm;
 	mmgrab(hmm->mm);
 
@@ -130,9 +129,6 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	/* Report this HMM as dying. */
-	hmm->dead = true;
-
 	/* Wake-up everyone waiting on any range. */
 	mutex_lock(&hmm->lock);
 	list_for_each_entry(range, &hmm->ranges, list) {
-- 
2.21.0

