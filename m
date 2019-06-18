Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C664AA6E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfFRSz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 14:55:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36201 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbfFRSz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 14:55:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so9296523qkl.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hXnlrwSMDb2KXQ2kUpfowsfYiMjlQHuh1AdwWvUKWgU=;
        b=PCSfTOPJhKvREdZ5xmkF2xPmb8AA5MtPK22PwiRyTbCbI9n4CnJdW/qq3WiSMdiUy4
         6Z/IIW8iNAiO52TupOZYX1bP0ZYvZA2VvIVMD7rhz9DB6xzcL8VhPuHnFJVM+LqaVDy4
         eoh4ivskUQESpEUflxImNhbiMcEzVAwMLSOzW1JZcP/LFSLq2bKsmf5Xe1tMeaMO9a8j
         1awvPochrqqHFzLHQiREBjty59bhtgqM1Hx8EpZVefBLXue+iue6tkPzV3aLPoAa9K/4
         eAlHpkRxnJvQyiQsJsHvbnZ1QoFRrPmfZsAnJSukHSDtbHZzYFbrauhu8anr3n5RV2Tu
         ajGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hXnlrwSMDb2KXQ2kUpfowsfYiMjlQHuh1AdwWvUKWgU=;
        b=Do3OHxoqmv2jw3pZikWLUSiFiQtSMVOIcfRwLFK3OSlHJAsdcbmVaKpDAuSmijG5MD
         aJXsZWYpv1ViWno8rUbSI+ksWj3lhdzdqhX0k8a7HULTgaS36b9pF98tKK5ATekQGOHs
         27EzQHCTLvbhxN0ccWnNXvw0wLLpXnAdyVCE3bwvcDGmrgxac5nP+ccwp0eTiV4Q6IUN
         wNmw8NC0xHXX4jMbSE1URtXfW0GH/1v0sRXV20yQFYX10DbmWfmDz81mNuCOfa3R2AKu
         9S4ZvxpbcOt4O2bttNEg5NaiqNlXDvJfy5faTTcmvwPx28JjODj/txkhX+6+ogYLJ2lz
         5Whg==
X-Gm-Message-State: APjAAAVYe3xmnDhntg/SRE78fKQCI4plGVfiEQ/SwLST10yOe6S2fG04
        S9fKJ5KLTnxlyNx390wn40mBUA==
X-Google-Smtp-Source: APXvYqyd+i6cTg2Tugb4a/2Cz8C0TtEUZL3kmahVSIFwk8sIJzOkIjm/6TLS4YnWGmfBfWmeHHI2Cw==
X-Received: by 2002:a37:680e:: with SMTP id d14mr853394qkc.287.1560884156517;
        Tue, 18 Jun 2019 11:55:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 6sm7888729qkk.69.2019.06.18.11.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 11:55:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdJGt-000090-Km; Tue, 18 Jun 2019 15:55:55 -0300
Date:   Tue, 18 Jun 2019 15:55:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 04/12] mm/hmm: Simplify hmm_get_or_create and make
 it reliable
Message-ID: <20190618185555.GO6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-5-jgg@ziepe.ca>
 <20190615141211.GD17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141211.GD17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:12:11AM -0700, Christoph Hellwig wrote:
> > +	spin_lock(&mm->page_table_lock);
> > +	if (mm->hmm) {
> > +		if (kref_get_unless_zero(&mm->hmm->kref)) {
> > +			spin_unlock(&mm->page_table_lock);
> > +			return mm->hmm;
> > +		}
> > +	}
> > +	spin_unlock(&mm->page_table_lock);
> 
> This could become:
> 
> 	spin_lock(&mm->page_table_lock);
> 	hmm = mm->hmm
> 	if (hmm && kref_get_unless_zero(&hmm->kref))
> 		goto out_unlock;
> 	spin_unlock(&mm->page_table_lock);
> 
> as the last two lines of the function already drop the page_table_lock
> and then return hmm.  Or drop the "hmm = mm->hmm" asignment above and
> return mm->hmm as that should be always identical to hmm at the end
> to save another line.
> 
> > +	/*
> > +	 * The mm->hmm pointer is kept valid while notifier ops can be running
> > +	 * so they don't have to deal with a NULL mm->hmm value
> > +	 */
> 
> The comment confuses me.  How does the page_table_lock relate to
> possibly running notifiers, as I can't find that we take
> page_table_lock?  Or is it just about the fact that we only clear
> mm->hmm in the free callback, and not in hmm_free?

Revised with:

From bdc02a1d502db08457823e6b2b983861a3574a76 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Thu, 23 May 2019 10:24:13 -0300
Subject: [PATCH] mm/hmm: Simplify hmm_get_or_create and make it reliable

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
v4:
- Put the mm->hmm = NULL in the kref release, reduce LOC
  in hmm_get_or_create() (Christoph)
---
 mm/hmm.c | 77 ++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 080b17a2e87e2d..0423f4ca3a7e09 100644
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
@@ -55,11 +45,16 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
  */
 static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
-	bool cleanup = false;
+	struct hmm *hmm;
+
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
-	if (hmm)
-		return hmm;
+	/* Abuse the page_table_lock to also protect mm->hmm. */
+	spin_lock(&mm->page_table_lock);
+	hmm = mm->hmm;
+	if (mm->hmm && kref_get_unless_zero(&mm->hmm->kref))
+		goto out_unlock;
+	spin_unlock(&mm->page_table_lock);
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -74,57 +69,45 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
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
+
+out_unlock:
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
+	mmdrop(hmm->mm);
+	kfree(hmm);
 }
 
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
-	struct mm_struct *mm = hmm->mm;
 
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
+	spin_lock(&hmm->mm->page_table_lock);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	spin_unlock(&hmm->mm->page_table_lock);
 
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

