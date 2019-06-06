Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1704037C6E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFFSos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43614 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFFSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so2118823qka.10
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lL1gh8nawE6RFwsPdkPriGSJ+VnlR7Td1463Tqz8utE=;
        b=i1eoUPW+Np1ntz3bbKM3DpfMNN3rtSLjFDcmDB0vnq8UBH26kk63yNvtdKWmYVv2TV
         Pi+BVA4ti/NZ/Kxq6fbwoxDlR7kj35FAE/DOaimNUrZ5r1sTA5O/bAcr13jRwmRbnpxo
         TDFODNWEBAT/btsMWcqDTmLq2sZ6BFWqMBX8F+5SG9cP5jttZex0XY8bZAT3yEvhQllA
         Ti/dQpvuTYxWENCc1huucv5i9yrAjKo9CBNJ/Lo8NX9PMfBSb4jhB683uChR8oVThjIV
         ISzCmuSiYW97tizaIYodsqJaggibXGQKh2/eAvL6GclckuApULlhfSiRO/Br537Ceq9G
         qQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lL1gh8nawE6RFwsPdkPriGSJ+VnlR7Td1463Tqz8utE=;
        b=MMWLItN3OWXJagg1VaCFj0HnvntedUfcsIHmA3k5eFqoeBfJTQUkixw2uGxfLNvPjy
         0lwNKLvvrWKHMrgmf78kvIQF0tIRaO7c382pD91jUqG+WrC/vkmpG+nG0SUTQllfHhAE
         eVN3qwU9WM0Iom5dgsfPmYqOEKiMe3yT230BqVJmN75SuH95GAD8MLfWaffEdwJuVuVi
         s100SEPzZBbA78lRWVMoFBTEgsxqsL6ITHXwNuLYNWbG/f6SE8AvPt2Nxtiicq3ze0oH
         oHL8FX8sTM+qThoDPq84EKDygFjuI2Ae8XpSKIlHufZh9okIqXPjYs71raq/RGfoV7U8
         W1RQ==
X-Gm-Message-State: APjAAAX6Fc9TFakbSgNWB9kfkCkbNUuF810UUt57IJ7LyCBbpTtPKV/v
        Iec1RKU4+QQgirXsFOmtiJQRzw==
X-Google-Smtp-Source: APXvYqysUYNwLpFGpXB7aK6DBYGI6cTSoPBzuRqVbpub4N7BK9TEIAgc5KayvZk47O3Fq3EpoC7BwA==
X-Received: by 2002:a37:6f81:: with SMTP id k123mr4055833qkc.321.1559846686738;
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e128sm1194796qkf.90.2019.06.06.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008I5-Dx; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm in the mmu notifiers
Date:   Thu,  6 Jun 2019 15:44:28 -0300
Message-Id: <20190606184438.31646-2-jgg@ziepe.ca>
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
v2:
- Spell 'free' properly (Jerome/Ralph)
---
 include/linux/hmm.h |  1 +
 mm/hmm.c            | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 092f0234bfe917..688c5ca7068795 100644
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
index 8e7403f081f44a..547002f56a163d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
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
@@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
-	kfree(hmm);
+	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
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
@@ -245,9 +256,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
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

