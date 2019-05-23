Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBA2814C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfEWPel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45413 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWPek (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so4038342qkk.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gR5B+R57dzhfm++AjZVD0k9PFQ5ymVIe8oDIOybm+/Y=;
        b=K8z8HnLIYzj0CvIlrQpPXO2d+uOz8Pq+97N2YabABx1Vrr+qMaFLmh2VnVLx7a2oGq
         wOLg9W+DBwbkikfS0ff5K3MxYHAk3TSgoQYOvWZ/gmtirGdLKUC9DG9R8Ipu8mV0wg1O
         AVWPOOkR7fDNM3E0R1Ft5vDpgr37TJcvqhe3MhUEFNRKFUO4zvfCWS/qD4Zi6BZH+zi+
         2nHw0N8KVoBb1X1p7s0lsRt99Yq5hmwdLBLjHEaLE1oOXEBXSTOo4PBEa5CReklY8/7U
         mJVOX/VX4CF+TvyigLMWsvggRdPp9oUrqqQAiJtfOXeUBS65Sy7nS52+0lUgbQD2cN4+
         7aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR5B+R57dzhfm++AjZVD0k9PFQ5ymVIe8oDIOybm+/Y=;
        b=g/H2oOkZRt4A+/C7mA4gr564mpztCUY0cFPnUX8Sh/qL5C94AMaLAKQi3jN1SA0trO
         ARvxFpyOVB7AjbeXbbHxOMvJHDdhc/tazrzGyW/XcdYyp9SGQxkv9knTAbFbO5dwuTxE
         ox9aZkAqJFjpVQnVpDxBhh2KfR9bm2ZBpYvY5R3gJUzqTPesBHFEtIzB0T29UtuOlHlw
         SIyETnrnApV7kR4gy/3206mOVRw0O/R/1fVFmmBenPneH1PahaouPkJcXai85gOg5tqm
         zLfTLYyV0uk2v5S/KNLWI0m7KSiffF21y0vG3E95oGFX94YovBr6zuHGcrX/6EmPMAq5
         sJmA==
X-Gm-Message-State: APjAAAVecPG/csG21m59Ow1ZaoHr5uVLoXXkMU0griVWZLrkunXfPvox
        zT4TFEVWTtsL+A0zPh9hTePmRbI1uUE=
X-Google-Smtp-Source: APXvYqx/CGFpFj+ej4XSzm0t6zCGOlTT7rmKjSiwJVztU6ABpwKrdUJowycnkB+WIld4Nb1SIXkSCw==
X-Received: by 2002:a37:c445:: with SMTP id h5mr48174135qkm.105.1558625679185;
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v126sm13212129qkh.86.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjp-0004zA-Sv; Thu, 23 May 2019 12:34:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 01/11] mm/hmm: Fix use after free with struct hmm in the mmu notifiers
Date:   Thu, 23 May 2019 12:34:26 -0300
Message-Id: <20190523153436.19102-2-jgg@ziepe.ca>
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

mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
system will continue to reference hmm->mn until the srcu grace period
expires.

Resulting in use after free races like this:

         CPU0                                     CPU1
                                               __mmu_notifier_invalidate_range_start()
                                                 srcu_read_lock
                                                 hlist_for_each ()
                                                   // mn == hmm->mn
hmm_mirror_unregister()
  hmm_put()
    hmm_free()
      mmu_notifier_unregister_no_release()
         hlist_del_init_rcu(hmm-mn->list)
			                           mn->ops->invalidate_range_start(mn, range);
					             mm_get_hmm()
      mm->hmm = NULL;
      kfree(hmm)
                                                     mutex_lock(&hmm->lock);

Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
existing. Get the now-safe hmm struct through container_of and directly
check kref_get_unless_zero to lock it against free.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  1 +
 mm/hmm.c            | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 51ec27a8466816..8b91c90d3b88cb 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -102,6 +102,7 @@ struct hmm {
 	struct mmu_notifier	mmu_notifier;
 	struct rw_semaphore	mirrors_sem;
 	wait_queue_head_t	wq;
+	struct rcu_head		rcu;
 	long			notifiers;
 	bool			dead;
 };
diff --git a/mm/hmm.c b/mm/hmm.c
index 816c2356f2449f..824e7e160d8167 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	return NULL;
 }
 
+static void hmm_fee_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct hmm, rcu));
+}
+
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
@@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
-	kfree(hmm);
+	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
 }
 
 static inline void hmm_put(struct hmm *hmm)
@@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
 
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
 
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
+
 	/* Report this HMM as dying. */
 	hmm->dead = true;
 
@@ -194,13 +203,15 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm = mm_get_hmm(nrange->mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
 	int ret = 0;
 
-	VM_BUG_ON(!hmm);
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return 0;
 
 	update.start = nrange->start;
 	update.end = nrange->end;
@@ -248,9 +259,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm = mm_get_hmm(nrange->mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 
-	VM_BUG_ON(!hmm);
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
 
 	mutex_lock(&hmm->lock);
 	hmm->notifiers--;
-- 
2.21.0

