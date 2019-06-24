Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D6251CB1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfFXVCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfFXVCI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so15384279wrr.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hG9eEbhO9ZvVI+JAJ4Kr5jKBUZBlX9y3IyF9CExVuM8=;
        b=Dfnwj7SRwV2PMmn2U0d+WODdclNP+8MKrJJpQxHP3JU1uHDlj7Em+GRbnOVlGf37aZ
         x/iFL81waqsH2R/ZDnogOEsWqssPFpPx6ng2iVzd42Ph8pxRGkGdeHnQFn7WXHxychn7
         qhcCnDDKKA2XJlL0t9jgEmXK5iD+LSA9ISspJalIOTaGOUy2P3iEqUcWHAlRfr10A2Zi
         sVektpaLu8hOSGiRgUg+86mxYZntLzr5JZQnXIkn15UuhOjzFImdCeWJqoAaOquAmGLI
         hpzcweH8Q2CBVObvgPXPT94/km2oYbyVknkNINwL80SwNwAFFuHpdFRRunzkNVq5yivf
         2PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hG9eEbhO9ZvVI+JAJ4Kr5jKBUZBlX9y3IyF9CExVuM8=;
        b=FZERXFWL/lC3/K6oOqm98Rk69+jnVe+zt09mW18NAV6byJHgMA/MUcymZ8Ys9Bzy4h
         MA84Hdx7XOCP1ypLEMGAF3/xoqCwm2WAHK1yxGPEvNGnJNNffwNhs0pxawAqzxCcmY3p
         n8QkTvVcdJfzubM1GIZucqkCaxLug/zMMPLyx7v1dktRJ4Ktp0HZ9QdUZtWC1t7ex3jl
         DJJ9TsSJNWE2dCs4puhAHI0zjHZtaUFPFL3bNZPppahQxm0OZ48+Vu7uTCTiQB+UOaBs
         aHuxoQ0wLN81UYho7wNzSQGeopkminC+ZJA/Hr4VTdKFJkOID3BJHyScjOhDiYdtfx+q
         K64A==
X-Gm-Message-State: APjAAAWBBSaBA5Am9vhKZRnh4I2FbRyyqUgxQSjqchsT0ww2HC8OTEAp
        4lkBcKHhVBMLRk9rEUe3nCLdMQ==
X-Google-Smtp-Source: APXvYqxAEk4qQsJeqyqINse+yHJkRouINtL91JL0sEIFqMM29cMWXWeCvzOgl6HwO/QEFlzvN+y93Q==
X-Received: by 2002:adf:f186:: with SMTP id h6mr21080937wro.274.1561410126128;
        Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id b71sm446129wmb.7.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001M2-OO; Mon, 24 Jun 2019 18:02:00 -0300
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
Subject: [PATCH v4 hmm 01/12] mm/hmm: fix use after free with struct hmm in the mmu notifiers
Date:   Mon, 24 Jun 2019 18:00:59 -0300
Message-Id: <20190624210110.5098-2-jgg@ziepe.ca>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2:
- Spell 'free' properly (Jerome/Ralph)
v3:
- Have only one clearer comment about kref_get_unless_zero (John)
---
 include/linux/hmm.h |  1 +
 mm/hmm.c            | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7007123842ba76..cb01cf1fa3c08b 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -93,6 +93,7 @@ struct hmm {
 	struct mmu_notifier	mmu_notifier;
 	struct rw_semaphore	mirrors_sem;
 	wait_queue_head_t	wq;
+	struct rcu_head		rcu;
 	long			notifiers;
 	bool			dead;
 };
diff --git a/mm/hmm.c b/mm/hmm.c
index 826816ab237799..f6956d78e3cb25 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -104,6 +104,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	return NULL;
 }
 
+static void hmm_free_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct hmm, rcu));
+}
+
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
@@ -116,7 +121,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
-	kfree(hmm);
+	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
 }
 
 static inline void hmm_put(struct hmm *hmm)
@@ -144,10 +149,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
 
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
 
+	/* Bail out if hmm is in the process of being freed */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
+
 	/* Report this HMM as dying. */
 	hmm->dead = true;
 
@@ -185,13 +194,14 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
+	if (!kref_get_unless_zero(&hmm->kref))
+		return 0;
 
 	update.start = nrange->start;
 	update.end = nrange->end;
@@ -236,9 +246,10 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm = mm_get_hmm(nrange->mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 
-	VM_BUG_ON(!hmm);
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
 
 	mutex_lock(&hmm->lock);
 	hmm->notifiers--;
-- 
2.22.0

