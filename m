Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30781450D4
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNAo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFNAo4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so594500qtn.7
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwIeL+wG8OH0fR+HAJUAqgJL6j2cGj41BLXWfdyXw+8=;
        b=ceFocxAlhwC8ooDNQRZa8uwa3+dU+B2w/i8m8E2hFOYMSjwgE+QDjK2xkLm6VD72gE
         WwLJsyaKZvlbLH1T3GBNub1NlDlCK6BubNsnv1WbkKG8RNUlggQq8bBRTYJ5ZD3RlBUe
         5Xc4hRx6laHCPEGJWrsK7S9WLrDOWPmFo5Th/r3RbossSgw6mMZGxENAPWZu3X3SfIxe
         NKWPsMMCkPfwjaA/cZXhWZkA83335+sxM+8H517upoEyeM0OgJPsn7GyvWZ56NeXZYZ/
         EkASXeoAhhhAsXq8AEvm382rhtOeMbcMdaynxt6xBN1zXqpJZUfvbUeY29aKi9gpY3TE
         tkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwIeL+wG8OH0fR+HAJUAqgJL6j2cGj41BLXWfdyXw+8=;
        b=goZHSM81fK2TY5qVM3mPL5gws6cRs7a1furKGX7NDrUUOES4MJi/FcRthXVbfSw0mY
         r3gMQEA+OsPIi3pFAKbQ+A7AcKzY96zqDJJkaJXSJK85/6QanTsy3Uc1l/2zVnPJe3DO
         iDqwFTM/WdoNJ/giA1OCbYf5WuBYE0XSSfMqzTPkNubOSSlPSt4QO0k4XpMcXz2Czco6
         GO7zqjGdxEZTiFjUCMMIT+aVJ1jQjfY5mpebjMbJ5GRp7D/rpr2rb1WSauIfLlY5ZjZ+
         SaU6wEuRIPnHBnUJxPpP3jPz+RXdYuamEpNcnpTp9vtpf6aJw33m4MHPCJcRefp4ZWMB
         vstw==
X-Gm-Message-State: APjAAAWIiqcB1G0qABsKtg2Jc3HG+St1lpWXrLYutM9ItX7MH4w01Ml1
        rXg/Lc2uUm8FsB9fLijTMip/Vg==
X-Google-Smtp-Source: APXvYqwfWvFSMiMgzDqFFMCY1VR/I1m7UwfYWn0XpXg+QyDkHYMt7hRBdXD727WohxKVcOUw6fUB+w==
X-Received: by 2002:ac8:1a3c:: with SMTP id v57mr77400825qtj.339.1560473094617;
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w55sm902620qtw.11.2019.06.13.17.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005JX-Je; Thu, 13 Jun 2019 21:44:53 -0300
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
Subject: [PATCH v3 hmm 01/12] mm/hmm: fix use after free with struct hmm in the mmu notifiers
Date:   Thu, 13 Jun 2019 21:44:39 -0300
Message-Id: <20190614004450.20252-2-jgg@ziepe.ca>
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
2.21.0

