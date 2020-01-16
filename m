Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3213E04F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPQkB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 11:40:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36801 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgAPQkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:40:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id i13so19376694qtr.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+I486yiGnrtRS45+27RBFdJzFCAA89xaebs2lYXW6w=;
        b=gtMDqk+yLSCgqKgXoAKpipANsYPsWOrKW48jn1sVM/Yig6kaTXe1w7rYv0uOlCe8Qp
         TFfRcQ+p9oIpqVpDdv4iMMtVht21hDLBCWi2UTby6eEv88AO5PK/OY+kg5NXhKnx0l9H
         Q+X9zdiMVextpfui+65Isx88mlhX0RViYuAIrxNpZOZ8Re6GXMRvQOSPmh1MoCTdk+Wg
         6SlxRvhoqxUPbO/kd+aLD05Kd1ssXESxqEQj5zHqO6hjOEc/eo6KWERjqI2OvuNnwvQ+
         BWxVqGwQ1Dx25D7ERvqr3gTYWchWu/ZC7N0vu1TfJumb5h30PIfnMxUvd4JxGOrc6nHI
         NhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+I486yiGnrtRS45+27RBFdJzFCAA89xaebs2lYXW6w=;
        b=CaUpxWHHJk8kGC3Qu5dzgpedffESsiXN7CZgD97kWmKP7aksTqhCQXo1QViM6LuHd0
         /xk0zbPuQYlWno5bA9p2zEExWXmLQuJnVC69JHdOKkMOV0S1AGa2E9kPMkhlLMGiX/wo
         K9H+iXaO80ud/CKFyTNMjYYOKbyNXtSlLKImdLN2VCiHYaaRzH9Xzr8EljJBKTvXV0ke
         sWQSi33SFizFjv/te1ctaoGH6HBpPi3aCbI4BBIBg7/cxk7GhyiFBUc93cgivCwJme3D
         oIlcHbLbnof7tAbhsNU/748Bxy7xBYslswYaH8GohZ5t7KC6gWfPyYqBQ/XPVAfOTc+j
         dQXQ==
X-Gm-Message-State: APjAAAUnAmNWeKfeT/tPw26GGx2Ktld/tewTMLqWMH3BULEbybs+wN4b
        CmCM1yqcUB/UG6S8dnaa2sDoSw==
X-Google-Smtp-Source: APXvYqxDoGMjhJXn0v3AQ77bXBGe/wbgsKP74IM7YIonzgAAlTgWvWhhZKqFegbT4glk2fg4v3R//w==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr3200677qti.238.1579192799335;
        Thu, 16 Jan 2020 08:39:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y26sm11817744qtc.94.2020.01.16.08.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 08:39:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8BW-000737-PE; Thu, 16 Jan 2020 12:39:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 3/3] mm/mmu_notifiers: Use 'interval_sub' as the variable for mmu_interval_notifier
Date:   Thu, 16 Jan 2020 12:39:45 -0400
Message-Id: <20200116163945.26956-4-jgg@ziepe.ca>
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

The 'interval_sub' is placed on the 'notifier_subscriptions' interval
tree.

This eliminates the poor name 'mni' for this variable.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst     |  20 +++---
 include/linux/mmu_notifier.h |  38 +++++-----
 mm/mmu_notifier.c            | 136 +++++++++++++++++++----------------
 3 files changed, 104 insertions(+), 90 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 893a8ba0e9fefb..95fec596836262 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -149,14 +149,14 @@ CPU page table into a device page table; HMM helps keep both synchronized. A
 device driver that wants to mirror a process address space must start with the
 registration of a mmu_interval_notifier::
 
- mni->ops = &driver_ops;
- int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
-			          unsigned long start, unsigned long length,
-			          struct mm_struct *mm);
+ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
+				  struct mm_struct *mm, unsigned long start,
+				  unsigned long length,
+				  const struct mmu_interval_notifier_ops *ops);
 
-During the driver_ops->invalidate() callback the device driver must perform
-the update action to the range (mark range read only, or fully unmap,
-etc.). The device must complete the update before the driver callback returns.
+During the ops->invalidate() callback the device driver must perform the
+update action to the range (mark range read only, or fully unmap, etc.). The
+device must complete the update before the driver callback returns.
 
 When the device driver wants to populate a range of virtual addresses, it can
 use::
@@ -183,7 +183,7 @@ The usage pattern is::
       struct hmm_range range;
       ...
 
-      range.notifier = &mni;
+      range.notifier = &interval_sub;
       range.start = ...;
       range.end = ...;
       range.pfns = ...;
@@ -191,11 +191,11 @@ The usage pattern is::
       range.values = ...;
       range.pfn_shift = ...;
 
-      if (!mmget_not_zero(mni->notifier.mm))
+      if (!mmget_not_zero(interval_sub->notifier.mm))
           return -EFAULT;
 
  again:
-      range.notifier_seq = mmu_interval_read_begin(&mni);
+      range.notifier_seq = mmu_interval_read_begin(&interval_sub);
       down_read(&mm->mmap_sem);
       ret = hmm_range_fault(&range, HMM_RANGE_SNAPSHOT);
       if (ret) {
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 4342fa75dc24cd..736f6918335edd 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -237,7 +237,7 @@ struct mmu_notifier {
  *              was required but mmu_notifier_range_blockable(range) is false.
  */
 struct mmu_interval_notifier_ops {
-	bool (*invalidate)(struct mmu_interval_notifier *mni,
+	bool (*invalidate)(struct mmu_interval_notifier *interval_sub,
 			   const struct mmu_notifier_range *range,
 			   unsigned long cur_seq);
 };
@@ -292,20 +292,21 @@ extern int __mmu_notifier_register(struct mmu_notifier *subscription,
 extern void mmu_notifier_unregister(struct mmu_notifier *subscription,
 				    struct mm_struct *mm);
 
-unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni);
-int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
+unsigned long
+mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub);
+int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
 				 struct mm_struct *mm, unsigned long start,
 				 unsigned long length,
 				 const struct mmu_interval_notifier_ops *ops);
 int mmu_interval_notifier_insert_locked(
-	struct mmu_interval_notifier *mni, struct mm_struct *mm,
+	struct mmu_interval_notifier *interval_sub, struct mm_struct *mm,
 	unsigned long start, unsigned long length,
 	const struct mmu_interval_notifier_ops *ops);
-void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
+void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub);
 
 /**
  * mmu_interval_set_seq - Save the invalidation sequence
- * @mni - The mni passed to invalidate
+ * @interval_sub - The subscription passed to invalidate
  * @cur_seq - The cur_seq passed to the invalidate() callback
  *
  * This must be called unconditionally from the invalidate callback of a
@@ -316,15 +317,16 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
  * If the caller does not call mmu_interval_read_begin() or
  * mmu_interval_read_retry() then this call is not required.
  */
-static inline void mmu_interval_set_seq(struct mmu_interval_notifier *mni,
-					unsigned long cur_seq)
+static inline void
+mmu_interval_set_seq(struct mmu_interval_notifier *interval_sub,
+		     unsigned long cur_seq)
 {
-	WRITE_ONCE(mni->invalidate_seq, cur_seq);
+	WRITE_ONCE(interval_sub->invalidate_seq, cur_seq);
 }
 
 /**
  * mmu_interval_read_retry - End a read side critical section against a VA range
- * mni: The range
+ * interval_sub: The subscription
  * seq: The return of the paired mmu_interval_read_begin()
  *
  * This MUST be called under a user provided lock that is also held
@@ -336,15 +338,16 @@ static inline void mmu_interval_set_seq(struct mmu_interval_notifier *mni,
  * Returns true if an invalidation collided with this critical section, and
  * the caller should retry.
  */
-static inline bool mmu_interval_read_retry(struct mmu_interval_notifier *mni,
-					   unsigned long seq)
+static inline bool
+mmu_interval_read_retry(struct mmu_interval_notifier *interval_sub,
+			unsigned long seq)
 {
-	return mni->invalidate_seq != seq;
+	return interval_sub->invalidate_seq != seq;
 }
 
 /**
  * mmu_interval_check_retry - Test if a collision has occurred
- * mni: The range
+ * interval_sub: The subscription
  * seq: The return of the matching mmu_interval_read_begin()
  *
  * This can be used in the critical section between mmu_interval_read_begin()
@@ -359,11 +362,12 @@ static inline bool mmu_interval_read_retry(struct mmu_interval_notifier *mni,
  * This call can be used as part of loops and other expensive operations to
  * expedite a retry.
  */
-static inline bool mmu_interval_check_retry(struct mmu_interval_notifier *mni,
-					    unsigned long seq)
+static inline bool
+mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,
+			 unsigned long seq)
 {
 	/* Pairs with the WRITE_ONCE in mmu_interval_set_seq() */
-	return READ_ONCE(mni->invalidate_seq) != seq;
+	return READ_ONCE(interval_sub->invalidate_seq) != seq;
 }
 
 extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 12b35d8b444a4e..ef3973a5d34a94 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -81,7 +81,7 @@ struct mmu_notifier_subscriptions {
  *    seq & 1   # True if a writer exists
  *
  * The later state avoids some expensive work on inv_end in the common case of
- * no mni monitoring the VA.
+ * no mmu_interval_notifier monitoring the VA.
  */
 static bool
 mn_itree_is_invalidating(struct mmu_notifier_subscriptions *subscriptions)
@@ -114,13 +114,13 @@ mn_itree_inv_start_range(struct mmu_notifier_subscriptions *subscriptions,
 }
 
 static struct mmu_interval_notifier *
-mn_itree_inv_next(struct mmu_interval_notifier *mni,
+mn_itree_inv_next(struct mmu_interval_notifier *interval_sub,
 		  const struct mmu_notifier_range *range)
 {
 	struct interval_tree_node *node;
 
-	node = interval_tree_iter_next(&mni->interval_tree, range->start,
-				       range->end - 1);
+	node = interval_tree_iter_next(&interval_sub->interval_tree,
+				       range->start, range->end - 1);
 	if (!node)
 		return NULL;
 	return container_of(node, struct mmu_interval_notifier, interval_tree);
@@ -128,7 +128,7 @@ mn_itree_inv_next(struct mmu_interval_notifier *mni,
 
 static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 {
-	struct mmu_interval_notifier *mni;
+	struct mmu_interval_notifier *interval_sub;
 	struct hlist_node *next;
 
 	spin_lock(&subscriptions->lock);
@@ -147,15 +147,16 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 	 * they are progressed. This arrangement for tree updates is used to
 	 * avoid using a blocking lock during invalidate_range_start.
 	 */
-	hlist_for_each_entry_safe(mni, next, &subscriptions->deferred_list,
+	hlist_for_each_entry_safe(interval_sub, next,
+				  &subscriptions->deferred_list,
 				  deferred_item) {
-		if (RB_EMPTY_NODE(&mni->interval_tree.rb))
-			interval_tree_insert(&mni->interval_tree,
+		if (RB_EMPTY_NODE(&interval_sub->interval_tree.rb))
+			interval_tree_insert(&interval_sub->interval_tree,
 					     &subscriptions->itree);
 		else
-			interval_tree_remove(&mni->interval_tree,
+			interval_tree_remove(&interval_sub->interval_tree,
 					     &subscriptions->itree);
-		hlist_del(&mni->deferred_item);
+		hlist_del(&interval_sub->deferred_item);
 	}
 	spin_unlock(&subscriptions->lock);
 
@@ -165,12 +166,12 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 /**
  * mmu_interval_read_begin - Begin a read side critical section against a VA
  *                           range
- * mni: The range to use
+ * interval_sub: The interval subscription
  *
  * mmu_iterval_read_begin()/mmu_iterval_read_retry() implement a
- * collision-retry scheme similar to seqcount for the VA range under mni. If
- * the mm invokes invalidation during the critical section then
- * mmu_interval_read_retry() will return true.
+ * collision-retry scheme similar to seqcount for the VA range under
+ * subscription. If the mm invokes invalidation during the critical section
+ * then mmu_interval_read_retry() will return true.
  *
  * This is useful to obtain shadow PTEs where teardown or setup of the SPTEs
  * require a blocking context.  The critical region formed by this can sleep,
@@ -181,25 +182,26 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
  *
  * The return value should be passed to mmu_interval_read_retry().
  */
-unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni)
+unsigned long
+mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 {
 	struct mmu_notifier_subscriptions *subscriptions =
-		mni->mm->notifier_subscriptions;
+		interval_sub->mm->notifier_subscriptions;
 	unsigned long seq;
 	bool is_invalidating;
 
 	/*
-	 * If the mni has a different seq value under the user_lock than we
-	 * started with then it has collided.
+	 * If the subscription has a different seq value under the user_lock
+	 * than we started with then it has collided.
 	 *
-	 * If the mni currently has the same seq value as the subscriptions
-	 * seq, then it is currently between invalidate_start/end and is
-	 * colliding.
+	 * If the subscription currently has the same seq value as the
+	 * subscriptions seq, then it is currently between
+	 * invalidate_start/end and is colliding.
 	 *
 	 * The locking looks broadly like this:
 	 *   mn_tree_invalidate_start():          mmu_interval_read_begin():
 	 *                                         spin_lock
-	 *                                          seq = READ_ONCE(mni->invalidate_seq);
+	 *                                          seq = READ_ONCE(interval_sub->invalidate_seq);
 	 *                                          seq == subs->invalidate_seq
 	 *                                         spin_unlock
 	 *    spin_lock
@@ -208,7 +210,7 @@ unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni)
 	 *     op->invalidate_range():
 	 *       user_lock
 	 *        mmu_interval_set_seq()
-	 *         mni->invalidate_seq = seq
+	 *         interval_sub->invalidate_seq = seq
 	 *       user_unlock
 	 *
 	 *                          [Required: mmu_interval_read_retry() == true]
@@ -220,7 +222,7 @@ unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni)
 	 *
 	 *                                        user_lock
 	 *                                         mmu_interval_read_retry():
-	 *                                          mni->invalidate_seq != seq
+	 *                                          interval_sub->invalidate_seq != seq
 	 *                                        user_unlock
 	 *
 	 * Barriers are not needed here as any races here are closed by an
@@ -229,12 +231,12 @@ unsigned long mmu_interval_read_begin(struct mmu_interval_notifier *mni)
 	 */
 	spin_lock(&subscriptions->lock);
 	/* Pairs with the WRITE_ONCE in mmu_interval_set_seq() */
-	seq = READ_ONCE(mni->invalidate_seq);
+	seq = READ_ONCE(interval_sub->invalidate_seq);
 	is_invalidating = seq == subscriptions->invalidate_seq;
 	spin_unlock(&subscriptions->lock);
 
 	/*
-	 * mni->invalidate_seq must always be set to an odd value via
+	 * interval_sub->invalidate_seq must always be set to an odd value via
 	 * mmu_interval_set_seq() using the provided cur_seq from
 	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
 	 * will always clear the below sleep in some reasonable time as
@@ -266,13 +268,16 @@ static void mn_itree_release(struct mmu_notifier_subscriptions *subscriptions,
 		.start = 0,
 		.end = ULONG_MAX,
 	};
-	struct mmu_interval_notifier *mni;
+	struct mmu_interval_notifier *interval_sub;
 	unsigned long cur_seq;
 	bool ret;
 
-	for (mni = mn_itree_inv_start_range(subscriptions, &range, &cur_seq);
-	     mni; mni = mn_itree_inv_next(mni, &range)) {
-		ret = mni->ops->invalidate(mni, &range, cur_seq);
+	for (interval_sub =
+		     mn_itree_inv_start_range(subscriptions, &range, &cur_seq);
+	     interval_sub;
+	     interval_sub = mn_itree_inv_next(interval_sub, &range)) {
+		ret = interval_sub->ops->invalidate(interval_sub, &range,
+						    cur_seq);
 		WARN_ON(!ret);
 	}
 
@@ -434,14 +439,17 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
 static int mn_itree_invalidate(struct mmu_notifier_subscriptions *subscriptions,
 			       const struct mmu_notifier_range *range)
 {
-	struct mmu_interval_notifier *mni;
+	struct mmu_interval_notifier *interval_sub;
 	unsigned long cur_seq;
 
-	for (mni = mn_itree_inv_start_range(subscriptions, range, &cur_seq);
-	     mni; mni = mn_itree_inv_next(mni, range)) {
+	for (interval_sub =
+		     mn_itree_inv_start_range(subscriptions, range, &cur_seq);
+	     interval_sub;
+	     interval_sub = mn_itree_inv_next(interval_sub, range)) {
 		bool ret;
 
-		ret = mni->ops->invalidate(mni, range, cur_seq);
+		ret = interval_sub->ops->invalidate(interval_sub, range,
+						    cur_seq);
 		if (!ret) {
 			if (WARN_ON(mmu_notifier_range_blockable(range)))
 				continue;
@@ -878,20 +886,21 @@ void mmu_notifier_put(struct mmu_notifier *subscription)
 EXPORT_SYMBOL_GPL(mmu_notifier_put);
 
 static int __mmu_interval_notifier_insert(
-	struct mmu_interval_notifier *mni, struct mm_struct *mm,
+	struct mmu_interval_notifier *interval_sub, struct mm_struct *mm,
 	struct mmu_notifier_subscriptions *subscriptions, unsigned long start,
 	unsigned long length, const struct mmu_interval_notifier_ops *ops)
 {
-	mni->mm = mm;
-	mni->ops = ops;
-	RB_CLEAR_NODE(&mni->interval_tree.rb);
-	mni->interval_tree.start = start;
+	interval_sub->mm = mm;
+	interval_sub->ops = ops;
+	RB_CLEAR_NODE(&interval_sub->interval_tree.rb);
+	interval_sub->interval_tree.start = start;
 	/*
 	 * Note that the representation of the intervals in the interval tree
 	 * considers the ending point as contained in the interval.
 	 */
 	if (length == 0 ||
-	    check_add_overflow(start, length - 1, &mni->interval_tree.last))
+	    check_add_overflow(start, length - 1,
+			       &interval_sub->interval_tree.last))
 		return -EOVERFLOW;
 
 	/* Must call with a mmget() held */
@@ -911,30 +920,31 @@ static int __mmu_interval_notifier_insert(
 	 * possibility for live lock, instead defer the add to
 	 * mn_itree_inv_end() so this algorithm is deterministic.
 	 *
-	 * In all cases the value for the mni->invalidate_seq should be
+	 * In all cases the value for the interval_sub->invalidate_seq should be
 	 * odd, see mmu_interval_read_begin()
 	 */
 	spin_lock(&subscriptions->lock);
 	if (subscriptions->active_invalidate_ranges) {
 		if (mn_itree_is_invalidating(subscriptions))
-			hlist_add_head(&mni->deferred_item,
+			hlist_add_head(&interval_sub->deferred_item,
 				       &subscriptions->deferred_list);
 		else {
 			subscriptions->invalidate_seq |= 1;
-			interval_tree_insert(&mni->interval_tree,
+			interval_tree_insert(&interval_sub->interval_tree,
 					     &subscriptions->itree);
 		}
-		mni->invalidate_seq = subscriptions->invalidate_seq;
+		interval_sub->invalidate_seq = subscriptions->invalidate_seq;
 	} else {
 		WARN_ON(mn_itree_is_invalidating(subscriptions));
 		/*
-		 * The starting seq for a mni not under invalidation should be
-		 * odd, not equal to the current invalidate_seq and
+		 * The starting seq for a subscription not under invalidation
+		 * should be odd, not equal to the current invalidate_seq and
 		 * invalidate_seq should not 'wrap' to the new seq any time
 		 * soon.
 		 */
-		mni->invalidate_seq = subscriptions->invalidate_seq - 1;
-		interval_tree_insert(&mni->interval_tree,
+		interval_sub->invalidate_seq =
+			subscriptions->invalidate_seq - 1;
+		interval_tree_insert(&interval_sub->interval_tree,
 				     &subscriptions->itree);
 	}
 	spin_unlock(&subscriptions->lock);
@@ -943,7 +953,7 @@ static int __mmu_interval_notifier_insert(
 
 /**
  * mmu_interval_notifier_insert - Insert an interval notifier
- * @mni: Interval notifier to register
+ * @interval_sub: Interval subscription to register
  * @start: Starting virtual address to monitor
  * @length: Length of the range to monitor
  * @mm : mm_struct to attach to
@@ -956,7 +966,7 @@ static int __mmu_interval_notifier_insert(
  * The caller must use the normal interval notifier read flow via
  * mmu_interval_read_begin() to establish SPTEs for this range.
  */
-int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
+int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
 				 struct mm_struct *mm, unsigned long start,
 				 unsigned long length,
 				 const struct mmu_interval_notifier_ops *ops)
@@ -973,13 +983,13 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
 			return ret;
 		subscriptions = mm->notifier_subscriptions;
 	}
-	return __mmu_interval_notifier_insert(mni, mm, subscriptions, start,
-					      length, ops);
+	return __mmu_interval_notifier_insert(interval_sub, mm, subscriptions,
+					      start, length, ops);
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert);
 
 int mmu_interval_notifier_insert_locked(
-	struct mmu_interval_notifier *mni, struct mm_struct *mm,
+	struct mmu_interval_notifier *interval_sub, struct mm_struct *mm,
 	unsigned long start, unsigned long length,
 	const struct mmu_interval_notifier_ops *ops)
 {
@@ -995,14 +1005,14 @@ int mmu_interval_notifier_insert_locked(
 			return ret;
 		subscriptions = mm->notifier_subscriptions;
 	}
-	return __mmu_interval_notifier_insert(mni, mm, subscriptions, start,
-					      length, ops);
+	return __mmu_interval_notifier_insert(interval_sub, mm, subscriptions,
+					      start, length, ops);
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
 
 /**
  * mmu_interval_notifier_remove - Remove a interval notifier
- * @mni: Interval notifier to unregister
+ * @interval_sub: Interval subscription to unregister
  *
  * This function must be paired with mmu_interval_notifier_insert(). It cannot
  * be called from any ops callback.
@@ -1010,9 +1020,9 @@ EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
  * Once this returns ops callbacks are no longer running on other CPUs and
  * will not be called in future.
  */
-void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni)
+void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 {
-	struct mm_struct *mm = mni->mm;
+	struct mm_struct *mm = interval_sub->mm;
 	struct mmu_notifier_subscriptions *subscriptions =
 		mm->notifier_subscriptions;
 	unsigned long seq = 0;
@@ -1025,16 +1035,16 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni)
 		 * remove is being called after insert put this on the
 		 * deferred list, but before the deferred list was processed.
 		 */
-		if (RB_EMPTY_NODE(&mni->interval_tree.rb)) {
-			hlist_del(&mni->deferred_item);
+		if (RB_EMPTY_NODE(&interval_sub->interval_tree.rb)) {
+			hlist_del(&interval_sub->deferred_item);
 		} else {
-			hlist_add_head(&mni->deferred_item,
+			hlist_add_head(&interval_sub->deferred_item,
 				       &subscriptions->deferred_list);
 			seq = subscriptions->invalidate_seq;
 		}
 	} else {
-		WARN_ON(RB_EMPTY_NODE(&mni->interval_tree.rb));
-		interval_tree_remove(&mni->interval_tree,
+		WARN_ON(RB_EMPTY_NODE(&interval_sub->interval_tree.rb));
+		interval_tree_remove(&interval_sub->interval_tree,
 				     &subscriptions->itree);
 	}
 	spin_unlock(&subscriptions->lock);
-- 
2.24.1

