Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A13E04E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgAPQj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 11:39:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37175 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQj7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:39:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so19353846qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiZRVGdlxKuAWDs6j80g1z3iw0vuRrK9yYDhmx+MHfk=;
        b=dRdD9OBwRESEllZVcOvhxHbX3ZeksUbKcngzBsKaz5Ze3/lWEOnAaIdEL4FmVe5yE6
         SETMiEZBfEFd7EzeD2mes2sx+SHuzA3494oYus0GBqQKt9JYnmJljHJ/Zx6/wKfwCyZG
         zzS3GPjGfT6hQ2Cn194dDP/sm9F9JtnuTTNf8LpfWhSJTpcwiebvM6Lja+WDPs1DL/9y
         yKYaMtWydkO3wc1wkz5IBDj8AQbYZYSd07J/KY8+zde94fjXeW8YBo3kKs4Q05g6AUxT
         j5nNTrEja6kcvUb3GECxbSLuZFIsT9w7cdI+AULLTwd0GtGdev1skrT2U4+NOwCs3k6U
         BcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiZRVGdlxKuAWDs6j80g1z3iw0vuRrK9yYDhmx+MHfk=;
        b=nB77ClSxp3IIOPpMe3t9JB1ER3OzuIYgH0OSN5YVIpv2C/3zVv7GAxxh/G1CyczBax
         ahisQ2PzCZYRUTu3L1Od9ibARDtfO58twUm2yGRlR5frhXzV5rl1F6ScjOSS7vfehwyq
         upPuhvaEHXIqdqv75bl/fBcJgKTkLehDQ+3qE7iFCbSgxzJ2LtDc2EXbVpOSbbw+Vo3r
         VEOFnmzhqUUtbf+nFpOsvZv8dJHGREjN4sCXUH0ZjWguur5j9UKBriCi11D/YheNLIXC
         OZd22ecfx9djrauPQ6sSNmOoje5tuvJHbL3EiRdtn16Zc4jCLzG9lXZyNqkKMmNVNFwW
         5qLw==
X-Gm-Message-State: APjAAAV3EXhZvgz2R+kLv8Z5hmhRtSnZS5REplKnObbkQBHPIwPSkQ9f
        i5ywwVB8ua7E9iQKHoKR6FJd3g==
X-Google-Smtp-Source: APXvYqzsd+jGLAzKcxmaMsY1w+6TrXXyW3f9XUjgCYHicAb63jcms9u71v/0g3FJuNSdxwUqVltB+g==
X-Received: by 2002:aed:38c9:: with SMTP id k67mr3346743qte.29.1579192798106;
        Thu, 16 Jan 2020 08:39:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g18sm10336947qki.13.2020.01.16.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 08:39:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8BW-000731-Nz; Thu, 16 Jan 2020 12:39:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 2/3] mm/mmu_notifiers: Use 'subscription' as the variable name for mmu_notifier
Date:   Thu, 16 Jan 2020 12:39:44 -0400
Message-Id: <20200116163945.26956-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116163945.26956-1-jgg@ziepe.ca>
References: <20200116163945.26956-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The 'subscription' is placed on the 'notifier_subscriptions' list.

This eliminates the poor name 'mn' for this variable.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h |  30 +++---
 mm/mmu_notifier.c            | 183 +++++++++++++++++++----------------
 2 files changed, 117 insertions(+), 96 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index a302925fbc6177..4342fa75dc24cd 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -73,7 +73,7 @@ struct mmu_notifier_ops {
 	 * through the gart alias address, so leading to memory
 	 * corruption.
 	 */
-	void (*release)(struct mmu_notifier *mn,
+	void (*release)(struct mmu_notifier *subscription,
 			struct mm_struct *mm);
 
 	/*
@@ -85,7 +85,7 @@ struct mmu_notifier_ops {
 	 * Start-end is necessary in case the secondary MMU is mapping the page
 	 * at a smaller granularity than the primary MMU.
 	 */
-	int (*clear_flush_young)(struct mmu_notifier *mn,
+	int (*clear_flush_young)(struct mmu_notifier *subscription,
 				 struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end);
@@ -95,7 +95,7 @@ struct mmu_notifier_ops {
 	 * latter, it is supposed to test-and-clear the young/accessed bitflag
 	 * in the secondary pte, but it may omit flushing the secondary tlb.
 	 */
-	int (*clear_young)(struct mmu_notifier *mn,
+	int (*clear_young)(struct mmu_notifier *subscription,
 			   struct mm_struct *mm,
 			   unsigned long start,
 			   unsigned long end);
@@ -106,7 +106,7 @@ struct mmu_notifier_ops {
 	 * frequently used without actually clearing the flag or tearing
 	 * down the secondary mapping on the page.
 	 */
-	int (*test_young)(struct mmu_notifier *mn,
+	int (*test_young)(struct mmu_notifier *subscription,
 			  struct mm_struct *mm,
 			  unsigned long address);
 
@@ -114,7 +114,7 @@ struct mmu_notifier_ops {
 	 * change_pte is called in cases that pte mapping to page is changed:
 	 * for example, when ksm remaps pte to point to a new shared page.
 	 */
-	void (*change_pte)(struct mmu_notifier *mn,
+	void (*change_pte)(struct mmu_notifier *subscription,
 			   struct mm_struct *mm,
 			   unsigned long address,
 			   pte_t pte);
@@ -169,9 +169,9 @@ struct mmu_notifier_ops {
 	 * invalidate_range_end.
 	 *
 	 */
-	int (*invalidate_range_start)(struct mmu_notifier *mn,
+	int (*invalidate_range_start)(struct mmu_notifier *subscription,
 				      const struct mmu_notifier_range *range);
-	void (*invalidate_range_end)(struct mmu_notifier *mn,
+	void (*invalidate_range_end)(struct mmu_notifier *subscription,
 				     const struct mmu_notifier_range *range);
 
 	/*
@@ -192,8 +192,10 @@ struct mmu_notifier_ops {
 	 * of what was passed to invalidate_range_start()/end(), if
 	 * called between those functions.
 	 */
-	void (*invalidate_range)(struct mmu_notifier *mn, struct mm_struct *mm,
-				 unsigned long start, unsigned long end);
+	void (*invalidate_range)(struct mmu_notifier *subscription,
+				 struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end);
 
 	/*
 	 * These callbacks are used with the get/put interface to manage the
@@ -206,7 +208,7 @@ struct mmu_notifier_ops {
 	 * and cannot sleep.
 	 */
 	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
-	void (*free_notifier)(struct mmu_notifier *mn);
+	void (*free_notifier)(struct mmu_notifier *subscription);
 };
 
 /*
@@ -280,14 +282,14 @@ mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
 	up_write(&mm->mmap_sem);
 	return ret;
 }
-void mmu_notifier_put(struct mmu_notifier *mn);
+void mmu_notifier_put(struct mmu_notifier *subscription);
 void mmu_notifier_synchronize(void);
 
-extern int mmu_notifier_register(struct mmu_notifier *mn,
+extern int mmu_notifier_register(struct mmu_notifier *subscription,
 				 struct mm_struct *mm);
-extern int __mmu_notifier_register(struct mmu_notifier *mn,
+extern int __mmu_notifier_register(struct mmu_notifier *subscription,
 				   struct mm_struct *mm);
-extern void mmu_notifier_unregister(struct mmu_notifier *mn,
+extern void mmu_notifier_unregister(struct mmu_notifier *subscription,
 				    struct mm_struct *mm);
 
 unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a409abfb9f2652..12b35d8b444a4e 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -294,7 +294,7 @@ static void mn_itree_release(struct mmu_notifier_subscriptions *subscriptions,
 static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
 			     struct mm_struct *mm)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int id;
 
 	/*
@@ -302,27 +302,27 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
 	 * ->release returns.
 	 */
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &subscriptions->list, hlist)
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist)
 		/*
 		 * If ->release runs before mmu_notifier_unregister it must be
 		 * handled, as it's the only way for the driver to flush all
 		 * existing sptes and stop the driver from establishing any more
 		 * sptes before all the pages in the mm are freed.
 		 */
-		if (mn->ops->release)
-			mn->ops->release(mn, mm);
+		if (subscription->ops->release)
+			subscription->ops->release(subscription, mm);
 
 	spin_lock(&subscriptions->lock);
 	while (unlikely(!hlist_empty(&subscriptions->list))) {
-		mn = hlist_entry(subscriptions->list.first, struct mmu_notifier,
-				 hlist);
+		subscription = hlist_entry(subscriptions->list.first,
+					   struct mmu_notifier, hlist);
 		/*
 		 * We arrived before mmu_notifier_unregister so
 		 * mmu_notifier_unregister will do nothing other than to wait
 		 * for ->release to finish and for mmu_notifier_unregister to
 		 * return.
 		 */
-		hlist_del_init_rcu(&mn->hlist);
+		hlist_del_init_rcu(&subscription->hlist);
 	}
 	spin_unlock(&subscriptions->lock);
 	srcu_read_unlock(&srcu, id);
@@ -360,13 +360,15 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long end)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int young = 0, id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list, hlist) {
-		if (mn->ops->clear_flush_young)
-			young |= mn->ops->clear_flush_young(mn, mm, start, end);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops->clear_flush_young)
+			young |= subscription->ops->clear_flush_young(
+				subscription, mm, start, end);
 	}
 	srcu_read_unlock(&srcu, id);
 
@@ -377,13 +379,15 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 			       unsigned long start,
 			       unsigned long end)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int young = 0, id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list, hlist) {
-		if (mn->ops->clear_young)
-			young |= mn->ops->clear_young(mn, mm, start, end);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops->clear_young)
+			young |= subscription->ops->clear_young(subscription,
+								mm, start, end);
 	}
 	srcu_read_unlock(&srcu, id);
 
@@ -393,13 +397,15 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 int __mmu_notifier_test_young(struct mm_struct *mm,
 			      unsigned long address)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int young = 0, id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list, hlist) {
-		if (mn->ops->test_young) {
-			young = mn->ops->test_young(mn, mm, address);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops->test_young) {
+			young = subscription->ops->test_young(subscription, mm,
+							      address);
 			if (young)
 				break;
 		}
@@ -412,14 +418,15 @@ int __mmu_notifier_test_young(struct mm_struct *mm,
 void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
 			       pte_t pte)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list,
-				 hlist) {
-		if (mn->ops->change_pte)
-			mn->ops->change_pte(mn, mm, address, pte);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops->change_pte)
+			subscription->ops->change_pte(subscription, mm, address,
+						      pte);
 	}
 	srcu_read_unlock(&srcu, id);
 }
@@ -456,24 +463,28 @@ static int mn_hlist_invalidate_range_start(
 	struct mmu_notifier_subscriptions *subscriptions,
 	struct mmu_notifier_range *range)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int ret = 0;
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &subscriptions->list, hlist) {
-		if (mn->ops->invalidate_range_start) {
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
+		const struct mmu_notifier_ops *ops = subscription->ops;
+
+		if (ops->invalidate_range_start) {
 			int _ret;
 
 			if (!mmu_notifier_range_blockable(range))
 				non_block_start();
-			_ret = mn->ops->invalidate_range_start(mn, range);
+			_ret = ops->invalidate_range_start(subscription, range);
 			if (!mmu_notifier_range_blockable(range))
 				non_block_end();
 			if (_ret) {
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
-					mn->ops->invalidate_range_start, _ret,
-					!mmu_notifier_range_blockable(range) ? "non-" : "");
+					ops->invalidate_range_start, _ret,
+					!mmu_notifier_range_blockable(range) ?
+						"non-" :
+						"");
 				WARN_ON(mmu_notifier_range_blockable(range) ||
 					_ret != -EAGAIN);
 				ret = _ret;
@@ -505,11 +516,11 @@ static void
 mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
 			struct mmu_notifier_range *range, bool only_end)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &subscriptions->list, hlist) {
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
 		/*
 		 * Call invalidate_range here too to avoid the need for the
 		 * subsystem of having to register an invalidate_range_end
@@ -523,14 +534,16 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
 		 * is safe to do when we know that a call to invalidate_range()
 		 * already happen under page table lock.
 		 */
-		if (!only_end && mn->ops->invalidate_range)
-			mn->ops->invalidate_range(mn, range->mm,
-						  range->start,
-						  range->end);
-		if (mn->ops->invalidate_range_end) {
+		if (!only_end && subscription->ops->invalidate_range)
+			subscription->ops->invalidate_range(subscription,
+							    range->mm,
+							    range->start,
+							    range->end);
+		if (subscription->ops->invalidate_range_end) {
 			if (!mmu_notifier_range_blockable(range))
 				non_block_start();
-			mn->ops->invalidate_range_end(mn, range);
+			subscription->ops->invalidate_range_end(subscription,
+								range);
 			if (!mmu_notifier_range_blockable(range))
 				non_block_end();
 		}
@@ -556,13 +569,15 @@ void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list, hlist) {
-		if (mn->ops->invalidate_range)
-			mn->ops->invalidate_range(mn, mm, start, end);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops->invalidate_range)
+			subscription->ops->invalidate_range(subscription, mm,
+							    start, end);
 	}
 	srcu_read_unlock(&srcu, id);
 }
@@ -572,7 +587,8 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
  * write mode. A NULL mn signals the notifier is being registered for itree
  * mode.
  */
-int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
+int __mmu_notifier_register(struct mmu_notifier *subscription,
+			    struct mm_struct *mm)
 {
 	struct mmu_notifier_subscriptions *subscriptions = NULL;
 	int ret;
@@ -629,14 +645,14 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	if (subscriptions)
 		smp_store_release(&mm->notifier_subscriptions, subscriptions);
 
-	if (mn) {
+	if (subscription) {
 		/* Pairs with the mmdrop in mmu_notifier_unregister_* */
 		mmgrab(mm);
-		mn->mm = mm;
-		mn->users = 1;
+		subscription->mm = mm;
+		subscription->users = 1;
 
 		spin_lock(&mm->notifier_subscriptions->lock);
-		hlist_add_head_rcu(&mn->hlist,
+		hlist_add_head_rcu(&subscription->hlist,
 				   &mm->notifier_subscriptions->list);
 		spin_unlock(&mm->notifier_subscriptions->lock);
 	} else
@@ -668,15 +684,16 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_register);
  * mmu_notifier_unregister() or mmu_notifier_put() must be always called to
  * unregister the notifier.
  *
- * While the caller has a mmu_notifier get the mn->mm pointer will remain
+ * While the caller has a mmu_notifier get the subscription->mm pointer will remain
  * valid, and can be converted to an active mm pointer via mmget_not_zero().
  */
-int mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
+int mmu_notifier_register(struct mmu_notifier *subscription,
+			  struct mm_struct *mm)
 {
 	int ret;
 
 	down_write(&mm->mmap_sem);
-	ret = __mmu_notifier_register(mn, mm);
+	ret = __mmu_notifier_register(subscription, mm);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -685,20 +702,20 @@ EXPORT_SYMBOL_GPL(mmu_notifier_register);
 static struct mmu_notifier *
 find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 
 	spin_lock(&mm->notifier_subscriptions->lock);
-	hlist_for_each_entry_rcu(mn, &mm->notifier_subscriptions->list,
-				 hlist) {
-		if (mn->ops != ops)
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist) {
+		if (subscription->ops != ops)
 			continue;
 
-		if (likely(mn->users != UINT_MAX))
-			mn->users++;
+		if (likely(subscription->users != UINT_MAX))
+			subscription->users++;
 		else
-			mn = ERR_PTR(-EOVERFLOW);
+			subscription = ERR_PTR(-EOVERFLOW);
 		spin_unlock(&mm->notifier_subscriptions->lock);
-		return mn;
+		return subscription;
 	}
 	spin_unlock(&mm->notifier_subscriptions->lock);
 	return NULL;
@@ -724,27 +741,27 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 					     struct mm_struct *mm)
 {
-	struct mmu_notifier *mn;
+	struct mmu_notifier *subscription;
 	int ret;
 
 	lockdep_assert_held_write(&mm->mmap_sem);
 
 	if (mm->notifier_subscriptions) {
-		mn = find_get_mmu_notifier(mm, ops);
-		if (mn)
-			return mn;
+		subscription = find_get_mmu_notifier(mm, ops);
+		if (subscription)
+			return subscription;
 	}
 
-	mn = ops->alloc_notifier(mm);
-	if (IS_ERR(mn))
-		return mn;
-	mn->ops = ops;
-	ret = __mmu_notifier_register(mn, mm);
+	subscription = ops->alloc_notifier(mm);
+	if (IS_ERR(subscription))
+		return subscription;
+	subscription->ops = ops;
+	ret = __mmu_notifier_register(subscription, mm);
 	if (ret)
 		goto out_free;
-	return mn;
+	return subscription;
 out_free:
-	mn->ops->free_notifier(mn);
+	subscription->ops->free_notifier(subscription);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_get_locked);
@@ -767,11 +784,12 @@ void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
  * and only after mmu_notifier_unregister returned we're guaranteed
  * that ->release or any other method can't run anymore.
  */
-void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
+void mmu_notifier_unregister(struct mmu_notifier *subscription,
+			     struct mm_struct *mm)
 {
 	BUG_ON(atomic_read(&mm->mm_count) <= 0);
 
-	if (!hlist_unhashed(&mn->hlist)) {
+	if (!hlist_unhashed(&subscription->hlist)) {
 		/*
 		 * SRCU here will force exit_mmap to wait for ->release to
 		 * finish before freeing the pages.
@@ -783,8 +801,8 @@ void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
 		 * exit_mmap will block in mmu_notifier_release to guarantee
 		 * that ->release is called before freeing the pages.
 		 */
-		if (mn->ops->release)
-			mn->ops->release(mn, mm);
+		if (subscription->ops->release)
+			subscription->ops->release(subscription, mm);
 		srcu_read_unlock(&srcu, id);
 
 		spin_lock(&mm->notifier_subscriptions->lock);
@@ -792,7 +810,7 @@ void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
 		 * Can not use list_del_rcu() since __mmu_notifier_release
 		 * can delete it before we hold the lock.
 		 */
-		hlist_del_init_rcu(&mn->hlist);
+		hlist_del_init_rcu(&subscription->hlist);
 		spin_unlock(&mm->notifier_subscriptions->lock);
 	}
 
@@ -810,10 +828,11 @@ EXPORT_SYMBOL_GPL(mmu_notifier_unregister);
 
 static void mmu_notifier_free_rcu(struct rcu_head *rcu)
 {
-	struct mmu_notifier *mn = container_of(rcu, struct mmu_notifier, rcu);
-	struct mm_struct *mm = mn->mm;
+	struct mmu_notifier *subscription =
+		container_of(rcu, struct mmu_notifier, rcu);
+	struct mm_struct *mm = subscription->mm;
 
-	mn->ops->free_notifier(mn);
+	subscription->ops->free_notifier(subscription);
 	/* Pairs with the get in __mmu_notifier_register() */
 	mmdrop(mm);
 }
@@ -840,17 +859,17 @@ static void mmu_notifier_free_rcu(struct rcu_head *rcu)
  * Modules calling this function must call mmu_notifier_synchronize() in
  * their __exit functions to ensure the async work is completed.
  */
-void mmu_notifier_put(struct mmu_notifier *mn)
+void mmu_notifier_put(struct mmu_notifier *subscription)
 {
-	struct mm_struct *mm = mn->mm;
+	struct mm_struct *mm = subscription->mm;
 
 	spin_lock(&mm->notifier_subscriptions->lock);
-	if (WARN_ON(!mn->users) || --mn->users)
+	if (WARN_ON(!subscription->users) || --subscription->users)
 		goto out_unlock;
-	hlist_del_init_rcu(&mn->hlist);
+	hlist_del_init_rcu(&subscription->hlist);
 	spin_unlock(&mm->notifier_subscriptions->lock);
 
-	call_srcu(&srcu, &mn->rcu, mmu_notifier_free_rcu);
+	call_srcu(&srcu, &subscription->rcu, mmu_notifier_free_rcu);
 	return;
 
 out_unlock:
-- 
2.24.1

