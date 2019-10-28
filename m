Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A35E79B4
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfJ1UKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40292 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ1UKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id y81so9744492qkb.7
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6qkKhlE377yexDDU3hhVTFW0t+EXROxR6aal9KdQe4=;
        b=S58t6OhprBE5qw20UbAe+Vwse+w2lO/Up0h0lfqdRge/4nS1rXcCCsxlIno+C6MBwn
         eJxkhgL2L64qgxBPmUhWD6RFK5kf5e0ZelEdKRYLUIxrkTpbhVFOlRF9uwIgGHYVhyZn
         p43djgWgjcRWx88FI7pDFwEqr3ezye3qfqni5fPI5bTAKCKpVObL1YPw8nHvp+t0PDWo
         8uNkbZbvEJJD1KQQGq6PO27jpJTe9bYV5khfvnCnHC1ClOhSnanJvpp5MF0tRIO9Gzbt
         bgIWXRYWbjzPF2+LqBI2sTQC4L5/nUfSvol6+joXWujgAwYghBBxAzRmxevNYuzjif4u
         swxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6qkKhlE377yexDDU3hhVTFW0t+EXROxR6aal9KdQe4=;
        b=gSxI0+G/rOaY8OR1YZbpI6ENwBkL9Bt3+hw5iqruEG19EI8bHKz9WQW9GPndoeAPvV
         76rFFqFWbIErVsgy9qObySDCV7G7VNBOUtjXr3yoqv0OdOZfKLah459Bwwwbigz0Sk4F
         9XiV9kPppEIarbRl6Y42V7vQRuo7m8fy/ykVEZBG/SLWvxlIiV80/7PEuUWwK3WPKwSW
         2sZ1O6BntGzkl6nD15uWyFFMHcn9SNl1pcuSumMG7qWNbg28BKXhNRNVaNwEVPeMOxzo
         498WekRymswPccDaBJd4S6qr0Oy6pTq8ZuP64jmPKb56MJ8nF3h1UbOR7TKewe7DtbKF
         VtlQ==
X-Gm-Message-State: APjAAAVHCRWjTvL68t2XuB+B9FO6F9GuAdKU8ZAC8sJV1VPWO4FiBIAr
        x/0zwgJ/BPacsNIDwEnZ0YbODw==
X-Google-Smtp-Source: APXvYqwcJctJ4wjkPX/iRBrM71GSQB516ozrtr/cgoYC3wlErfDwUG/hWnwhh/5dQ5u5+5Pie/tT7A==
X-Received: by 2002:a37:7c42:: with SMTP id x63mr13834494qkc.134.1572293444160;
        Mon, 28 Oct 2019 13:10:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t65sm6325908qkh.23.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001gA-4C; Mon, 28 Oct 2019 17:10:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Date:   Mon, 28 Oct 2019 17:10:19 -0300
Message-Id: <20191028201032.6352-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Of the 13 users of mmu_notifiers, 8 of them use only
invalidate_range_start/end() and immediately intersect the
mmu_notifier_range with some kind of internal list of VAs.  4 use an
interval tree (i915_gem, radeon_mn, umem_odp, hfi1). 4 use a linked list
of some kind (scif_dma, vhost, gntdev, hmm)

And the remaining 5 either don't use invalidate_range_start() or do some
special thing with it.

It turns out that building a correct scheme with an interval tree is
pretty complicated, particularly if the use case is synchronizing against
another thread doing get_user_pages().  Many of these implementations have
various subtle and difficult to fix races.

This approach puts the interval tree as common code at the top of the mmu
notifier call tree and implements a shareable locking scheme.

It includes:
 - An interval tree tracking VA ranges, with per-range callbacks
 - A read/write locking scheme for the interval tree that avoids
   sleeping in the notifier path (for OOM killer)
 - A sequence counter based collision-retry locking scheme to tell
   device page fault that a VA range is being concurrently invalidated.

This is based on various ideas:
- hmm accumulates invalidated VA ranges and releases them when all
  invalidates are done, via active_invalidate_ranges count.
  This approach avoids having to intersect the interval tree twice (as
  umem_odp does) at the potential cost of a longer device page fault.

- kvm/umem_odp use a sequence counter to drive the collision retry,
  via invalidate_seq

- a deferred work todo list on unlock scheme like RTNL, via deferred_list.
  This makes adding/removing interval tree members more deterministic

- seqlock, except this version makes the seqlock idea multi-holder on the
  write side by protecting it with active_invalidate_ranges and a spinlock

To minimize MM overhead when only the interval tree is being used, the
entire SRCU and hlist overheads are dropped using some simple
branches. Similarly the interval tree overhead is dropped when in hlist
mode.

The overhead from the mandatory spinlock is broadly the same as most of
existing users which already had a lock (or two) of some sort on the
invalidation path.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h |  98 +++++++
 mm/Kconfig                   |   1 +
 mm/mmu_notifier.c            | 533 +++++++++++++++++++++++++++++++++--
 3 files changed, 607 insertions(+), 25 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 12bd603d318ce7..51b92ba013ddce 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -6,10 +6,12 @@
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
 #include <linux/srcu.h>
+#include <linux/interval_tree.h>
 
 struct mmu_notifier_mm;
 struct mmu_notifier;
 struct mmu_notifier_range;
+struct mmu_range_notifier;
 
 /**
  * enum mmu_notifier_event - reason for the mmu notifier callback
@@ -32,6 +34,9 @@ struct mmu_notifier_range;
  * access flags). User should soft dirty the page in the end callback to make
  * sure that anyone relying on soft dirtyness catch pages that might be written
  * through non CPU mappings.
+ *
+ * @MMU_NOTIFY_RELEASE: used during mmu_range_notifier invalidate to signal that
+ * the mm refcount is zero and the range is no longer accessible.
  */
 enum mmu_notifier_event {
 	MMU_NOTIFY_UNMAP = 0,
@@ -39,6 +44,7 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_PROTECTION_VMA,
 	MMU_NOTIFY_PROTECTION_PAGE,
 	MMU_NOTIFY_SOFT_DIRTY,
+	MMU_NOTIFY_RELEASE,
 };
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
@@ -222,6 +228,26 @@ struct mmu_notifier {
 	unsigned int users;
 };
 
+/**
+ * struct mmu_range_notifier_ops
+ * @invalidate: Upon return the caller must stop using any SPTEs within this
+ *              range, this function can sleep. Return false if blocking was
+ *              required but range is non-blocking
+ */
+struct mmu_range_notifier_ops {
+	bool (*invalidate)(struct mmu_range_notifier *mrn,
+			   const struct mmu_notifier_range *range,
+			   unsigned long cur_seq);
+};
+
+struct mmu_range_notifier {
+	struct interval_tree_node interval_tree;
+	const struct mmu_range_notifier_ops *ops;
+	struct hlist_node deferred_item;
+	unsigned long invalidate_seq;
+	struct mm_struct *mm;
+};
+
 #ifdef CONFIG_MMU_NOTIFIER
 
 #ifdef CONFIG_LOCKDEP
@@ -263,6 +289,78 @@ extern int __mmu_notifier_register(struct mmu_notifier *mn,
 				   struct mm_struct *mm);
 extern void mmu_notifier_unregister(struct mmu_notifier *mn,
 				    struct mm_struct *mm);
+
+unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn);
+int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
+			      unsigned long start, unsigned long length,
+			      struct mm_struct *mm);
+int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
+				     unsigned long start, unsigned long length,
+				     struct mm_struct *mm);
+void mmu_range_notifier_remove(struct mmu_range_notifier *mrn);
+
+/**
+ * mmu_range_set_seq - Save the invalidation sequence
+ * @mrn - The mrn passed to invalidate
+ * @cur_seq - The cur_seq passed to invalidate
+ *
+ * This must be called unconditionally from the invalidate callback of a
+ * struct mmu_range_notifier_ops under the same lock that is used to call
+ * mmu_range_read_retry(). It updates the sequence number for later use by
+ * mmu_range_read_retry().
+ *
+ * If the user does not call mmu_range_read_begin() or mmu_range_read_retry()
+ * then this call is not required.
+ */
+static inline void mmu_range_set_seq(struct mmu_range_notifier *mrn,
+				     unsigned long cur_seq)
+{
+	WRITE_ONCE(mrn->invalidate_seq, cur_seq);
+}
+
+/**
+ * mmu_range_read_retry - End a read side critical section against a VA range
+ * mrn: The range under lock
+ * seq: The return of the paired mmu_range_read_begin()
+ *
+ * This MUST be called under a user provided lock that is also held
+ * unconditionally by op->invalidate() when it calls mmu_range_set_seq().
+ *
+ * Each call should be paired with a single mmu_range_read_begin() and
+ * should be used to conclude the read side.
+ *
+ * Returns true if an invalidation collided with this critical section, and
+ * the caller should retry.
+ */
+static inline bool mmu_range_read_retry(struct mmu_range_notifier *mrn,
+					unsigned long seq)
+{
+	return mrn->invalidate_seq != seq;
+}
+
+/**
+ * mmu_range_check_retry - Test if a collision has occurred
+ * mrn: The range under lock
+ * seq: The return of the matching mmu_range_read_begin()
+ *
+ * This can be used in the critical section between mmu_range_read_begin() and
+ * mmu_range_read_retry().  A return of true indicates an invalidation has
+ * collided with this lock and a future mmu_range_read_retry() will return
+ * true.
+ *
+ * False is not reliable and only suggests a collision has not happened. It
+ * can be called many times and does not have to hold the user provided lock.
+ *
+ * This call can be used as part of loops and other expensive operations to
+ * expedite a retry.
+ */
+static inline bool mmu_range_check_retry(struct mmu_range_notifier *mrn,
+					 unsigned long seq)
+{
+	/* Pairs with the WRITE_ONCE in mmu_range_set_seq() */
+	return READ_ONCE(mrn->invalidate_seq) != seq;
+}
+
 extern void __mmu_notifier_mm_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb510a..d0b5046d9aeffd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -284,6 +284,7 @@ config VIRT_TO_BUS
 config MMU_NOTIFIER
 	bool
 	select SRCU
+	select INTERVAL_TREE
 
 config KSM
 	bool "Enable KSM for page merging"
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 367670cfd02b7b..d02d3c8c223eb7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/err.h>
+#include <linux/interval_tree.h>
 #include <linux/srcu.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
@@ -36,10 +37,243 @@ struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
 struct mmu_notifier_mm {
 	/* all mmu notifiers registered in this mm are queued in this list */
 	struct hlist_head list;
+	bool has_interval;
 	/* to serialize the list modifications and hlist_unhashed */
 	spinlock_t lock;
+	unsigned long invalidate_seq;
+	unsigned long active_invalidate_ranges;
+	struct rb_root_cached itree;
+	wait_queue_head_t wq;
+	struct hlist_head deferred_list;
 };
 
+/*
+ * This is a collision-retry read-side/write-side 'lock', a lot like a
+ * seqcount, however this allows multiple write-sides to hold it at
+ * once. Conceptually the write side is protecting the values of the PTEs in
+ * this mm, such that PTES cannot be read into SPTEs while any writer exists.
+ *
+ * Note that the core mm creates nested invalidate_range_start()/end() regions
+ * within the same thread, and runs invalidate_range_start()/end() in parallel
+ * on multiple CPUs. This is designed to not reduce concurrency or block
+ * progress on the mm side.
+ *
+ * As a secondary function, holding the full write side also serves to prevent
+ * writers for the itree, this is an optimization to avoid extra locking
+ * during invalidate_range_start/end notifiers.
+ *
+ * The write side has two states, fully excluded:
+ *  - mm->active_invalidate_ranges != 0
+ *  - mnn->invalidate_seq & 1 == True
+ *  - some range on the mm_struct is being invalidated
+ *  - the itree is not allowed to change
+ *
+ * And partially excluded:
+ *  - mm->active_invalidate_ranges != 0
+ *  - some range on the mm_struct is being invalidated
+ *  - the itree is allowed to change
+ *
+ * The later state avoids some expensive work on inv_end in the common case of
+ * no mrn monitoring the VA.
+ */
+static bool mn_itree_is_invalidating(struct mmu_notifier_mm *mmn_mm)
+{
+	lockdep_assert_held(&mmn_mm->lock);
+	return mmn_mm->invalidate_seq & 1;
+}
+
+static struct mmu_range_notifier *
+mn_itree_inv_start_range(struct mmu_notifier_mm *mmn_mm,
+			 const struct mmu_notifier_range *range,
+			 unsigned long *seq)
+{
+	struct interval_tree_node *node;
+	struct mmu_range_notifier *res = NULL;
+
+	spin_lock(&mmn_mm->lock);
+	mmn_mm->active_invalidate_ranges++;
+	node = interval_tree_iter_first(&mmn_mm->itree, range->start,
+					range->end - 1);
+	if (node) {
+		mmn_mm->invalidate_seq |= 1;
+		res = container_of(node, struct mmu_range_notifier,
+				   interval_tree);
+	}
+
+	*seq = mmn_mm->invalidate_seq;
+	spin_unlock(&mmn_mm->lock);
+	return res;
+}
+
+static struct mmu_range_notifier *
+mn_itree_inv_next(struct mmu_range_notifier *mrn,
+		  const struct mmu_notifier_range *range)
+{
+	struct interval_tree_node *node;
+
+	node = interval_tree_iter_next(&mrn->interval_tree, range->start,
+				       range->end - 1);
+	if (!node)
+		return NULL;
+	return container_of(node, struct mmu_range_notifier, interval_tree);
+}
+
+static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
+{
+	struct mmu_range_notifier *mrn;
+	struct hlist_node *next;
+	bool need_wake = false;
+
+	spin_lock(&mmn_mm->lock);
+	if (--mmn_mm->active_invalidate_ranges ||
+	    !mn_itree_is_invalidating(mmn_mm)) {
+		spin_unlock(&mmn_mm->lock);
+		return;
+	}
+
+	mmn_mm->invalidate_seq++;
+	need_wake = true;
+
+	/*
+	 * The inv_end incorporates a deferred mechanism like
+	 * rtnl_lock(). Adds and removes are queued until the final inv_end
+	 * happens then they are progressed. This arrangement for tree updates
+	 * is used to avoid using a blocking lock during
+	 * invalidate_range_start.
+	 */
+	hlist_for_each_entry_safe(mrn, next, &mmn_mm->deferred_list,
+				  deferred_item) {
+		if (RB_EMPTY_NODE(&mrn->interval_tree.rb))
+			interval_tree_insert(&mrn->interval_tree,
+					     &mmn_mm->itree);
+		else
+			interval_tree_remove(&mrn->interval_tree,
+					     &mmn_mm->itree);
+		hlist_del(&mrn->deferred_item);
+	}
+	spin_unlock(&mmn_mm->lock);
+
+	/*
+	 * TODO: Since we already have a spinlock above, this would be faster
+	 * as wake_up_q
+	 */
+	if (need_wake)
+		wake_up_all(&mmn_mm->wq);
+}
+
+/**
+ * mmu_range_read_begin - Begin a read side critical section against a VA range
+ * mrn: The range to lock
+ *
+ * mmu_range_read_begin()/mmu_range_read_retry() implement a collision-retry
+ * locking scheme similar to seqcount for the VA range under mrn. If the mm
+ * invokes invalidation during the critical section then
+ * mmu_range_read_retry() will return true.
+ *
+ * This is useful to obtain shadow PTEs where teardown or setup of the SPTEs
+ * require a blocking context.  The critical region formed by this lock can
+ * sleep, and the required 'user_lock' can also be a sleeping lock.
+ *
+ * The caller is required to provide a 'user_lock' to serialize both teardown
+ * and setup.
+ *
+ * The return value should be passed to mmu_range_read_retry().
+ */
+unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn)
+{
+	struct mmu_notifier_mm *mmn_mm = mrn->mm->mmu_notifier_mm;
+	unsigned long seq;
+	bool is_invalidating;
+
+	/*
+	 * If the mrn has a different seq value under the user_lock than we
+	 * started with then it has collided.
+	 *
+	 * If the mrn currently has the same seq value as the mmn_mm seq, then
+	 * it is currently between invalidate_start/end and is colliding.
+	 *
+	 * The locking looks broadly like this:
+	 *   mn_tree_invalidate_start():          mmu_range_read_begin():
+	 *                                         spin_lock
+	 *                                          seq = READ_ONCE(mrn->invalidate_seq);
+	 *                                          seq == mmn_mm->invalidate_seq
+	 *                                         spin_unlock
+	 *    spin_lock
+	 *     seq = ++mmn_mm->invalidate_seq
+	 *    spin_unlock
+	 *     op->invalidate_range():
+	 *       user_lock
+	 *        mmu_range_set_seq()
+	 *         mrn->invalidate_seq = seq
+	 *       user_unlock
+	 *
+	 *                          [Required: mmu_range_read_retry() == true]
+	 *
+	 *   mn_itree_inv_end():
+	 *    spin_lock
+	 *     seq = ++mmn_mm->invalidate_seq
+	 *    spin_unlock
+	 *
+	 *                                        user_lock
+	 *                                         mmu_range_read_retry():
+	 *                                          mrn->invalidate_seq != seq
+	 *                                        user_unlock
+	 *
+	 * Barriers are not needed here as any races here are closed by an
+	 * eventual mmu_range_read_retry(), which provides a barrier via the
+	 * user_lock.
+	 */
+	spin_lock(&mmn_mm->lock);
+	/* Pairs with the WRITE_ONCE in mmu_range_set_seq() */
+	seq = READ_ONCE(mrn->invalidate_seq);
+	is_invalidating = seq == mmn_mm->invalidate_seq;
+	spin_unlock(&mmn_mm->lock);
+
+	/*
+	 * mrn->invalidate_seq is always set to an odd value. This ensures
+	 * that if seq does wrap we will always clear the below sleep in some
+	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
+	 * state.
+	 */
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+	if (is_invalidating)
+		wait_event(mmn_mm->wq,
+			   READ_ONCE(mmn_mm->invalidate_seq) != seq);
+
+	/*
+	 * Notice that mmu_range_read_retry() can already be true at this
+	 * point, avoiding loops here allows the user of this lock to provide
+	 * a global time bound.
+	 */
+
+	return seq;
+}
+EXPORT_SYMBOL_GPL(mmu_range_read_begin);
+
+static void mn_itree_release(struct mmu_notifier_mm *mmn_mm,
+			     struct mm_struct *mm)
+{
+	struct mmu_notifier_range range = {
+		.flags = MMU_NOTIFIER_RANGE_BLOCKABLE,
+		.event = MMU_NOTIFY_RELEASE,
+		.mm = mm,
+		.start = 0,
+		.end = ULONG_MAX,
+	};
+	struct mmu_range_notifier *mrn;
+	unsigned long cur_seq;
+	bool ret;
+
+	for (mrn = mn_itree_inv_start_range(mmn_mm, &range, &cur_seq); mrn;
+	     mrn = mn_itree_inv_next(mrn, &range)) {
+		ret = mrn->ops->invalidate(mrn, &range, cur_seq);
+		WARN_ON(!ret);
+	}
+
+	mn_itree_inv_end(mmn_mm);
+}
+
 /*
  * This function can't run concurrently against mmu_notifier_register
  * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
@@ -52,17 +286,24 @@ struct mmu_notifier_mm {
  * can't go away from under us as exit_mmap holds an mm_count pin
  * itself.
  */
-void __mmu_notifier_release(struct mm_struct *mm)
+static void mn_hlist_release(struct mmu_notifier_mm *mmn_mm,
+			     struct mm_struct *mm)
 {
 	struct mmu_notifier *mn;
 	int id;
 
+	if (mmn_mm->has_interval)
+		mn_itree_release(mmn_mm, mm);
+
+	if (hlist_empty(&mmn_mm->list))
+		return;
+
 	/*
 	 * SRCU here will block mmu_notifier_unregister until
 	 * ->release returns.
 	 */
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist)
+	hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist)
 		/*
 		 * If ->release runs before mmu_notifier_unregister it must be
 		 * handled, as it's the only way for the driver to flush all
@@ -72,9 +313,9 @@ void __mmu_notifier_release(struct mm_struct *mm)
 		if (mn->ops->release)
 			mn->ops->release(mn, mm);
 
-	spin_lock(&mm->mmu_notifier_mm->lock);
-	while (unlikely(!hlist_empty(&mm->mmu_notifier_mm->list))) {
-		mn = hlist_entry(mm->mmu_notifier_mm->list.first,
+	spin_lock(&mmn_mm->lock);
+	while (unlikely(!hlist_empty(&mmn_mm->list))) {
+		mn = hlist_entry(mmn_mm->list.first,
 				 struct mmu_notifier,
 				 hlist);
 		/*
@@ -85,7 +326,7 @@ void __mmu_notifier_release(struct mm_struct *mm)
 		 */
 		hlist_del_init_rcu(&mn->hlist);
 	}
-	spin_unlock(&mm->mmu_notifier_mm->lock);
+	spin_unlock(&mmn_mm->lock);
 	srcu_read_unlock(&srcu, id);
 
 	/*
@@ -100,6 +341,17 @@ void __mmu_notifier_release(struct mm_struct *mm)
 	synchronize_srcu(&srcu);
 }
 
+void __mmu_notifier_release(struct mm_struct *mm)
+{
+	struct mmu_notifier_mm *mmn_mm = mm->mmu_notifier_mm;
+
+	if (mmn_mm->has_interval)
+		mn_itree_release(mmn_mm, mm);
+
+	if (!hlist_empty(&mmn_mm->list))
+		mn_hlist_release(mmn_mm, mm);
+}
+
 /*
  * If no young bitflag is supported by the hardware, ->clear_flush_young can
  * unmap the address and return 1 or 0 depending if the mapping previously
@@ -172,14 +424,43 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
 	srcu_read_unlock(&srcu, id);
 }
 
-int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
+static int mn_itree_invalidate(struct mmu_notifier_mm *mmn_mm,
+				     const struct mmu_notifier_range *range)
+{
+	struct mmu_range_notifier *mrn;
+	unsigned long cur_seq;
+
+	for (mrn = mn_itree_inv_start_range(mmn_mm, range, &cur_seq); mrn;
+	     mrn = mn_itree_inv_next(mrn, range)) {
+		bool ret;
+
+		ret = mrn->ops->invalidate(mrn, range, cur_seq);
+		if (!ret) {
+			if (WARN_ON(mmu_notifier_range_blockable(range)))
+				continue;
+			goto out_would_block;
+		}
+	}
+	return 0;
+
+out_would_block:
+	/*
+	 * On -EAGAIN the non-blocking caller is not allowed to call
+	 * invalidate_range_end()
+	 */
+	mn_itree_inv_end(mmn_mm);
+	return -EAGAIN;
+}
+
+static int mn_hlist_invalidate_range_start(struct mmu_notifier_mm *mmn_mm,
+					   struct mmu_notifier_range *range)
 {
 	struct mmu_notifier *mn;
 	int ret = 0;
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
+	hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist) {
 		if (mn->ops->invalidate_range_start) {
 			int _ret;
 
@@ -203,15 +484,30 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 	return ret;
 }
 
-void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
-					 bool only_end)
+int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_mm *mmn_mm = range->mm->mmu_notifier_mm;
+	int ret = 0;
+
+	if (mmn_mm->has_interval) {
+		ret = mn_itree_invalidate(mmn_mm, range);
+		if (ret)
+			return ret;
+	}
+	if (!hlist_empty(&mmn_mm->list))
+		return mn_hlist_invalidate_range_start(mmn_mm, range);
+	return 0;
+}
+
+static void mn_hlist_invalidate_end(struct mmu_notifier_mm *mmn_mm,
+				    struct mmu_notifier_range *range,
+				    bool only_end)
 {
 	struct mmu_notifier *mn;
 	int id;
 
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
+	hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist) {
 		/*
 		 * Call invalidate_range here too to avoid the need for the
 		 * subsystem of having to register an invalidate_range_end
@@ -238,6 +534,19 @@ void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 		}
 	}
 	srcu_read_unlock(&srcu, id);
+}
+
+void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
+					 bool only_end)
+{
+	struct mmu_notifier_mm *mmn_mm = range->mm->mmu_notifier_mm;
+
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+	if (mmn_mm->has_interval)
+		mn_itree_inv_end(mmn_mm);
+
+	if (!hlist_empty(&mmn_mm->list))
+		mn_hlist_invalidate_end(mmn_mm, range, only_end);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
@@ -256,8 +565,9 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 }
 
 /*
- * Same as mmu_notifier_register but here the caller must hold the
- * mmap_sem in write mode.
+ * Same as mmu_notifier_register but here the caller must hold the mmap_sem in
+ * write mode. A NULL mn signals the notifier is being registered for itree
+ * mode.
  */
 int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
@@ -274,9 +584,6 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 		fs_reclaim_release(GFP_KERNEL);
 	}
 
-	mn->mm = mm;
-	mn->users = 1;
-
 	if (!mm->mmu_notifier_mm) {
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
@@ -284,21 +591,22 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 		 * the write side of the mmap_sem.
 		 */
 		mmu_notifier_mm =
-			kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
+			kzalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
 		if (!mmu_notifier_mm)
 			return -ENOMEM;
 
 		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
 		spin_lock_init(&mmu_notifier_mm->lock);
+		mmu_notifier_mm->invalidate_seq = 2;
+		mmu_notifier_mm->itree = RB_ROOT_CACHED;
+		init_waitqueue_head(&mmu_notifier_mm->wq);
+		INIT_HLIST_HEAD(&mmu_notifier_mm->deferred_list);
 	}
 
 	ret = mm_take_all_locks(mm);
 	if (unlikely(ret))
 		goto out_clean;
 
-	/* Pairs with the mmdrop in mmu_notifier_unregister_* */
-	mmgrab(mm);
-
 	/*
 	 * Serialize the update against mmu_notifier_unregister. A
 	 * side note: mmu_notifier_release can't run concurrently with
@@ -306,13 +614,28 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * current->mm or explicitly with get_task_mm() or similar).
 	 * We can't race against any other mmu notifier method either
 	 * thanks to mm_take_all_locks().
+	 *
+	 * release semantics on the initialization of the mmu_notifier_mm's
+         * contents are provided for unlocked readers.  acquire can only be
+         * used while holding the mmgrab or mmget, and is safe because once
+         * created the mmu_notififer_mm is not freed until the mm is
+         * destroyed.  As above, users holding the mmap_sem or one of the
+         * mm_take_all_locks() do not need to use acquire semantics.
 	 */
 	if (mmu_notifier_mm)
-		mm->mmu_notifier_mm = mmu_notifier_mm;
+		smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);
 
-	spin_lock(&mm->mmu_notifier_mm->lock);
-	hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
-	spin_unlock(&mm->mmu_notifier_mm->lock);
+	if (mn) {
+		/* Pairs with the mmdrop in mmu_notifier_unregister_* */
+		mmgrab(mm);
+		mn->mm = mm;
+		mn->users = 1;
+
+		spin_lock(&mm->mmu_notifier_mm->lock);
+		hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
+		spin_unlock(&mm->mmu_notifier_mm->lock);
+	} else
+		mm->mmu_notifier_mm->has_interval = true;
 
 	mm_drop_all_locks(mm);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
@@ -529,6 +852,166 @@ void mmu_notifier_put(struct mmu_notifier *mn)
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_put);
 
+static int __mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
+				       unsigned long start,
+				       unsigned long length,
+				       struct mmu_notifier_mm *mmn_mm,
+				       struct mm_struct *mm)
+{
+	mrn->mm = mm;
+	RB_CLEAR_NODE(&mrn->interval_tree.rb);
+	mrn->interval_tree.start = start;
+	/*
+	 * Note that the representation of the intervals in the interval tree
+	 * considers the ending point as contained in the interval.
+	 */
+	if (length == 0 ||
+	    check_add_overflow(start, length - 1, &mrn->interval_tree.last))
+		return -EOVERFLOW;
+
+	/* pairs with mmdrop in mmu_range_notifier_remove() */
+	mmgrab(mm);
+
+	/*
+	 * If some invalidate_range_start/end region is going on in parallel
+	 * we don't know what VA ranges are affected, so we must assume this
+	 * new range is included.
+	 *
+	 * If the itree is invalidating then we are not allowed to change
+	 * it. Retrying until invalidation is done is tricky due to the
+	 * possibility for live lock, instead defer the add to the unlock so
+	 * this algorithm is deterministic.
+	 *
+	 * In all cases the value for the mrn->mr_invalidate_seq should be
+	 * odd, see mmu_range_read_begin()
+	 */
+	spin_lock(&mmn_mm->lock);
+	if (mmn_mm->active_invalidate_ranges) {
+		if (mn_itree_is_invalidating(mmn_mm))
+			hlist_add_head(&mrn->deferred_item,
+				       &mmn_mm->deferred_list);
+		else {
+			mmn_mm->invalidate_seq |= 1;
+			interval_tree_insert(&mrn->interval_tree,
+					     &mmn_mm->itree);
+		}
+		mrn->invalidate_seq = mmn_mm->invalidate_seq;
+	} else {
+		WARN_ON(mn_itree_is_invalidating(mmn_mm));
+		mrn->invalidate_seq = mmn_mm->invalidate_seq - 1;
+		interval_tree_insert(&mrn->interval_tree, &mmn_mm->itree);
+	}
+	spin_unlock(&mmn_mm->lock);
+	return 0;
+}
+
+/**
+ * mmu_range_notifier_insert - Insert a range notifier
+ * @mrn: Range notifier to register
+ * @start: Starting virtual address to monitor
+ * @length: Length of the range to monitor
+ * @mm : mm_struct to attach to
+ *
+ * This function subscribes the range notifier for notifications from the mm.
+ * Upon return the ops related to mmu_range_notifier will be called whenever
+ * an event that intersects with the given range occurs.
+ *
+ * Upon return the range_notifier may not be present in the interval tree yet.
+ * The caller must use the normal range notifier locking flow via
+ * mmu_range_read_begin() to establish SPTEs for this range.
+ */
+int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
+			      unsigned long start, unsigned long length,
+			      struct mm_struct *mm)
+{
+	struct mmu_notifier_mm *mmn_mm;
+	int ret;
+
+	might_lock(&mm->mmap_sem);
+
+	mmn_mm = smp_load_acquire(&mm->mmu_notifier_mm);
+	if (!mmn_mm || !mmn_mm->has_interval) {
+		ret = mmu_notifier_register(NULL, mm);
+		if (ret)
+			return ret;
+		mmn_mm = mm->mmu_notifier_mm;
+	}
+	return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm);
+}
+EXPORT_SYMBOL_GPL(mmu_range_notifier_insert);
+
+int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
+				     unsigned long start, unsigned long length,
+				     struct mm_struct *mm)
+{
+	struct mmu_notifier_mm *mmn_mm;
+	int ret;
+
+	lockdep_assert_held_write(&mm->mmap_sem);
+
+	mmn_mm = mm->mmu_notifier_mm;
+	if (!mmn_mm || !mmn_mm->has_interval) {
+		ret = __mmu_notifier_register(NULL, mm);
+		if (ret)
+			return ret;
+		mmn_mm = mm->mmu_notifier_mm;
+	}
+	return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm);
+}
+EXPORT_SYMBOL_GPL(mmu_range_notifier_insert_locked);
+
+/**
+ * mmu_range_notifier_remove - Remove a range notifier
+ * @mrn: Range notifier to unregister
+ *
+ * This function must be paired with mmu_range_notifier_insert(). It cannot be
+ * called from any ops callback.
+ *
+ * Once this returns ops callbacks are no longer running on other CPUs and
+ * will not be called in future.
+ */
+void mmu_range_notifier_remove(struct mmu_range_notifier *mrn)
+{
+	struct mm_struct *mm = mrn->mm;
+	struct mmu_notifier_mm *mmn_mm = mm->mmu_notifier_mm;
+	unsigned long seq = 0;
+
+	might_sleep();
+
+	spin_lock(&mmn_mm->lock);
+	if (mn_itree_is_invalidating(mmn_mm)) {
+		/*
+		 * remove is being called after insert put this on the
+		 * deferred list, but before the deferred list was processed.
+		 */
+		if (RB_EMPTY_NODE(&mrn->interval_tree.rb)) {
+			hlist_del(&mrn->deferred_item);
+		} else {
+			hlist_add_head(&mrn->deferred_item,
+				       &mmn_mm->deferred_list);
+			seq = mmn_mm->invalidate_seq;
+		}
+	} else {
+		WARN_ON(RB_EMPTY_NODE(&mrn->interval_tree.rb));
+		interval_tree_remove(&mrn->interval_tree, &mmn_mm->itree);
+	}
+	spin_unlock(&mmn_mm->lock);
+
+	/*
+	 * The possible sleep on progress in the invalidation requires the
+	 * caller not hold any locks held by invalidation callbacks.
+	 */
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+	if (seq)
+		wait_event(mmn_mm->wq,
+			   READ_ONCE(mmn_mm->invalidate_seq) != seq);
+
+	/* pairs with mmgrab in mmu_range_notifier_insert() */
+	mmdrop(mm);
+}
+EXPORT_SYMBOL_GPL(mmu_range_notifier_remove);
+
 /**
  * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
  *
-- 
2.23.0

