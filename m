Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1B3D71F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404917AbfFKToe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 15:44:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35075 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbfFKToe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 15:44:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so16051022qto.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wVahQWOtZqsHwcjYboXhZ8xmvq6TDZROratpn9jK+o=;
        b=lg2OoIxPWMt+YSmGaILIbusgcWDifxTW7e65EX3sxhPnEuWqY6ckfwdIVK6bxYaj4D
         /Se9H+/UoWB8E+yMPOmrgaYspQrEAAZyUYnQxUu+iqUlSZ1Me2XihuQrIKfgMT8rinY6
         YIYI4Q3iwlrjTv+fj0zBV+Br3GlIUBY2JhCCOIewMutojUG5+eNPUgQQrVAs+ekBpROY
         HQE4TKOpYj3dFgp7sSamfF8zqcH+Rfq/54vQXhisztrLw7tHaNKZCI7Nac/f1kKE67PU
         BtZBqAhXEkoTT4hsun+6H9rzcpJKSh0DE3SM+Cfh1UZgPU0RBSVysGgTWs/dUH2Pz8yj
         LNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wVahQWOtZqsHwcjYboXhZ8xmvq6TDZROratpn9jK+o=;
        b=NjrxELeKc3Dc927ncv6ProztPSrd9o4fSR+4rLsId1AD3u6cfZz+Yi+20XWEpTcRAj
         xBA8yaKfKByHCRrdP0a+grbAFq+aLtg7fmfepY0ghJfY9LncBaJwnGxRNWQxaVu4aqZ1
         m+S7oTYKtRjrNhJMWE6ASq0aMG7ZcOxjDlfTqMORt4SpalDn8jy8wzdcbfh23hG2b6wK
         7L2xqy+w3VguFlI97Jcc0d4wkU45x2u/bIpO4281n691eEhVi9XasDt0wNhtG4y3uDst
         B8W7d8EO+Bv4WbJ5Es3MA1Bi+VMtla3Njr7YdhxYjUjCXMuTl+ymNAR4UoNfJpHXFIkp
         J2WQ==
X-Gm-Message-State: APjAAAV2PxZNJie2VM1xu9sD0bxHKtGUP63814cnMFEEZjdI00nLG7XF
        tGnCVdNkDxEubLjY4k+PlzSDIQ==
X-Google-Smtp-Source: APXvYqxN1rsrdbPLpnUSRUIFougVtrUocqVp5o5RzenZEH/EseHKCc1Fa1UBz9VWttmJTii4ojTTrg==
X-Received: by 2002:ac8:4619:: with SMTP id p25mr33781429qtn.73.1560282272851;
        Tue, 11 Jun 2019 12:44:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z1sm8154500qth.7.2019.06.11.12.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 12:44:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hamh5-0007DI-P7; Tue, 11 Jun 2019 16:44:31 -0300
Date:   Tue, 11 Jun 2019 16:44:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190611194431.GC29375@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <20190608085425.GB32185@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608085425.GB32185@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 01:54:25AM -0700, Christoph Hellwig wrote:
> FYI, I very much disagree with the direction this is moving.
> 
> struct hmm_mirror literally is a trivial duplication of the
> mmu_notifiers.  All these drivers should just use the mmu_notifiers
> directly for the mirroring part instead of building a thing wrapper
> that adds nothing but helping to manage the lifetime of struct hmm,
> which shouldn't exist to start with.

Christoph: What do you think about this sketch below?

It would replace the hmm_range/mirror/etc with a different way to
build the same locking scheme using some optional helpers linked to
the mmu notifier?

(just a sketch, still needs a lot more thinking)

Jason

From 5a91d17bc3b8fcaa685abddaaae5c5aea6f82dca Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Tue, 11 Jun 2019 16:33:33 -0300
Subject: [PATCH] RFC mm: Provide helpers to implement the common mmu_notifier
 locking

Many users of mmu_notifiers require a read/write lock that is write locked
during the invalidate_range_start/end period to protect against a parallel
thread reading the page tables while another thread is invalidating them.

kvm uses a collision-retry lock built with something like a sequence
count, and many mmu_notifiers users have copied this approach with various
levels of success.

Provide a common set of helpers that build a sleepable read side lock
using a collision retry scheme. The general usage pattern is:

driver pagefault():
  struct mmu_invlock_state st = MMU_INVLOCK_STATE_INIT;

again:
  mmu_invlock_write_start_and_lock(&driver->mn, &st)

  /* read vmas and page data under mmap_sem */
  /* maybe sleep */

  take_lock(&driver->lock);
  if (mn_invlock_end_write_and_unlock(&driver->mn, &st)) {
      unlock(&driver->lock);
      goto again;
  }
  /* make data visible to the device */
  /* does not sleep */
  unlock(&driver->lock);

The driver is responsible to provide the 'driver->lock', which is the same
lock it must hold during invalidate_range_start. By holding this lock the
sequence count is fully locked, and invalidations are prevented, so it is
safe to make the work visible to the device.

Since it is possible for this to live lock it uses the write side of the
mmap_sem to create a slow path if there are repeated collisions.

This is based off the design of the hmm_range and the RDMA ODP locking
scheme, with some additional refinements.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h | 83 ++++++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 71 ++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b6c004bd9f6ad9..0417f9452f2a09 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
 #include <linux/srcu.h>
+#include <linux/sched.h>
 
 struct mmu_notifier;
 struct mmu_notifier_ops;
@@ -227,8 +228,90 @@ struct mmu_notifier_ops {
 struct mmu_notifier {
 	struct hlist_node hlist;
 	const struct mmu_notifier_ops *ops;
+
+	/*
+	 * mmu_invlock is a set of helpers to allow the caller to provide a
+	 * read/write lock scheme where the write side of the lock is held
+	 * between invalidate_start -> end, and the read side can be obtained
+	 * on some other thread. This is a common usage pattern for mmu
+	 * notifier users that want to lock against changes to the mmu.
+	 */
+	struct mm_struct *mm;
+	unsigned int active_invalidates;
+	seqcount_t invalidate_seq;
+	wait_queue_head_t wq;
 };
 
+struct mmu_invlock_state
+{
+	unsigned long timeout;
+	unsigned int update_seq;
+	bool write_locked;
+};
+
+#define MMU_INVLOCK_STATE_INIT {.timeout = msecs_to_jiffies(1000)}
+
+// FIXME: needs a seqcount helper
+static inline bool is_locked_seqcount(const seqcount_t *s)
+{
+	return s->sequence & 1;
+}
+
+void mmu_invlock_write_start_and_lock(struct mmu_notifier *mn,
+				      struct mmu_invlock_state *st);
+bool mmu_invlock_write_end(struct mmu_notifier *mn);
+
+/**
+ * mmu_invlock_inv_start - Call during invalidate_range_start
+ * @mn - mmu_notifier
+ * @lock - True if the supplied range is interesting and should cause the
+ *         write side of the lock lock to be held.
+ *
+ * Updates the locking state as part of the invalidate_range_start callback.
+ * This must be called under a user supplied lock, and it must be called for
+ * every invalidate_range_start.
+ */
+static inline void mmu_invlock_inv_start(struct mmu_notifier *mn, bool lock)
+{
+	if (lock && !mn->active_invalidates)
+		write_seqcount_begin(&mn->invalidate_seq);
+	mn->active_invalidates++;
+}
+
+/**
+ * mmu_invlock_inv_start - Call during invalidate_range_start
+ * @mn - mmu_notifier
+ *
+ * Updates the locking state as part of the invalidate_range_start callback.
+ * This must be called under a user supplied lock, and it must be called for
+ * every invalidate_range_end.
+ */
+static inline void mmu_invlock_inv_end(struct mmu_notifier *mn)
+{
+	mn->active_invalidates++;
+	if (!mn->active_invalidates &&
+	    is_locked_seqcount(&mn->invalidate_seq)) {
+		write_seqcount_end(&mn->invalidate_seq);
+		wake_up_all(&mn->wq);
+	}
+}
+
+/**
+ * mmu_invlock_write_needs_retry - Check if the write lock has collided
+ * @mn - mmu_notifier
+ * @st - lock state set by mmu_invlock_write_start_and_lock()
+ *
+ * The nlock uses a collision retry scheme for the fast path. If a parallel
+ * invalidate has collided with the lock then it should be restarted again
+ * from mmu_invlock_write_start_and_lock()
+ */
+static inline bool mmu_invlock_write_needs_retry(struct mmu_notifier *mn,
+						 struct mmu_invlock_state *st)
+{
+	return !st->write_locked &&
+	       read_seqcount_retry(&mn->invalidate_seq, st->update_seq);
+}
+
 static inline int mm_has_notifiers(struct mm_struct *mm)
 {
 	return unlikely(mm->mmu_notifier_mm);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ee36068077b6e5..3db8cdd7211285 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -247,6 +247,11 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
 
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
+	mn->mm = mm;
+	mn->active_invalidates = 0;
+	seqcount_init(&mn->invalidate_seq);
+	init_waitqueue_head(&mn->wq);
+
 	ret = -ENOMEM;
 	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
 	if (unlikely(!mmu_notifier_mm))
@@ -405,3 +410,69 @@ mmu_notifier_range_update_to_read_only(const struct mmu_notifier_range *range)
 	return range->vma->vm_flags & VM_READ;
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_range_update_to_read_only);
+
+/**
+ * mm_invlock_start_write_and_lock - Start a read critical section
+ * @mn - mmu_notifier
+ * @st - lock state set initialized by MMU_INVLOCK_STATE_INIT
+ *
+ * This should be called with the mmap sem unlocked. It will wait for any
+ * parallel invalidations to complete and return with the mmap_sem locked. The
+ * mmap_sem may be locked for read or write.
+ *
+ * The critical section must always be ended by
+ * mn_invlock_end_write_and_unlock().
+ */
+void mm_invlock_start_write_and_lock(struct mmu_notifier *mn, struct mmu_invlock_state *st)
+{
+	long ret;
+
+	if (st->timeout == 0)
+		goto write_out;
+
+	ret = wait_event_timeout(
+		mn->wq, !is_locked_seqcount(&mn->invalidate_seq), st->timeout);
+	if (ret == 0)
+		goto write_out;
+
+	if (ret == 1)
+		st->timeout = 0;
+	else
+		st->timeout = ret;
+	down_read(&mn->mm->mmap_sem);
+	return;
+
+write_out:
+	/*
+	 * If we ran out of time then fall back to using the mmap_sem write
+	 * side to block concurrent invalidations. The seqcount is an
+	 * optimization to try and avoid this expensive lock.
+	 */
+	down_write(&mn->mm->mmap_sem);
+	st->write_locked = true;
+}
+EXPORT_SYMBOL_GPL(mm_invlock_start_write_and_lock);
+
+/**
+ * mn_invlock_end_write_and_unlock - End a read critical section
+ * @mn - mmu_notifier
+ * @st - lock state set by mmu_invlock_write_start_and_lock()
+ *
+ * This completes the read side critical section. If it returns false the
+ * caller must call mm_invlock_start_write_and_lock again.  Upon success the
+ * mmap_sem is unlocked.
+ *
+ * The caller must hold the same lock that is held while calling
+ * mmu_invlock_inv_start()
+ */
+bool mn_invlock_end_write_and_unlock(struct mmu_notifier *mn,
+				     struct mmu_invlock_state *st)
+{
+	if (st->write_locked) {
+		up_write(&mn->mm->mmap_sem);
+		return true;
+	}
+	up_read(&mn->mm->mmap_sem);
+	return mmu_invlock_write_needs_retry(mn, st);
+}
+EXPORT_SYMBOL_GPL(mn_invlock_end_write_and_unlock);
-- 
2.21.0

