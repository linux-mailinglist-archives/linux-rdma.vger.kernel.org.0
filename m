Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5AE79C1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfJ1UKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43526 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ1UKx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id a194so9752611qkg.10
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oam7ohQj1kc8X7oZ0yNH5Qsiwr3vqfv4zRUy2hYn6VU=;
        b=N7d4nLhTvUMAd7m6ziC7Fnj8Fj2CROvNmQEOjInKL4+Co2BowIq9/67UGOKMH9lu3l
         v1lJgY60Lvap2Ol+aPfOvbu+ct1M49IJCP9kjFJybc7MSm13Yz19vQFIxnvZauHYQnAq
         Tyed+DS0BV73Lk3U+Muf7IdAsRNmnvS9FYFHJIPWiXHxqb+A8SR5sOQbGgk6pbNcNCbe
         ZJlgb5V8MwBEuEU6SiQQOf3ZhxPQw5OpEsa0GUzFj1giRGyCsV+YkmtWVYDal1QylK/X
         j/hvQvUBbitvFj7W8XAgGK6FWzI9bi2GEb/fFY0CTm8OtYBVd8K8YIP27/9hLoeA7SOy
         TP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oam7ohQj1kc8X7oZ0yNH5Qsiwr3vqfv4zRUy2hYn6VU=;
        b=XyNhdKG2DvakB4tT+vRhZf+pdYX/BLTZyhxnsZ0OPJIaz8ijPJG7yBuLlsQR7BH1BF
         jkptU4WTFPJu38VesxZTVOng5I93lYpd4RnTkClJiBV1kd+UUIHDOVjBuU/XvfCWT2/C
         imZw6TzKPIGCeUTmWoCYQibwBIfEIXXeoWg1v3la2jwxNbGpjTj+ctzu7wdAXQWHJP/X
         6etxFqpn/3ZX02eWUJGWlbh9pzfXuN0/INx3/IQYZNxgkRN2qPcIiaA7YKMtdWDWuhBr
         pM/RYdVz1paK7ytj/ZOTAMxck55n7GUEdX3eWvHyHA+GiXhHxEmZhw4eQ2ckOPi667Uu
         I/Ew==
X-Gm-Message-State: APjAAAUI38A3lJB+/5ePiBHkk/ItmipklqXvQNon4kpMmwzkqq+udRW+
        mTFc6Kdg8lDYL5AawI04YQx5LA==
X-Google-Smtp-Source: APXvYqzFOk0mWTm9zmmEUnrvaGyK7qwShQOI+2XOcxc/OnuoCxvgWFx41ArWQecOobsikGRR1SYw3A==
X-Received: by 2002:a37:ac0b:: with SMTP id e11mr9437740qkm.454.1572293451378;
        Mon, 28 Oct 2019 13:10:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d10sm1589264qkk.99.2019.10.28.13.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001hR-OF; Mon, 28 Oct 2019 17:10:43 -0300
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
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 15/15] mm/hmm: remove hmm_mirror and related
Date:   Mon, 28 Oct 2019 17:10:32 -0300
Message-Id: <20191028201032.6352-16-jgg@ziepe.ca>
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

The only two users of this are now converted to use mmu_range_notifier,
delete all the code and update hmm.rst.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst | 105 ++++-----------
 include/linux/hmm.h      | 183 +------------------------
 mm/Kconfig               |   1 -
 mm/hmm.c                 | 284 +--------------------------------------
 4 files changed, 33 insertions(+), 540 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 0a5960beccf76d..a247643035c4e2 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -147,49 +147,16 @@ Address space mirroring implementation and API
 Address space mirroring's main objective is to allow duplication of a range of
 CPU page table into a device page table; HMM helps keep both synchronized. A
 device driver that wants to mirror a process address space must start with the
-registration of an hmm_mirror struct::
-
- int hmm_mirror_register(struct hmm_mirror *mirror,
-                         struct mm_struct *mm);
-
-The mirror struct has a set of callbacks that are used
-to propagate CPU page tables::
-
- struct hmm_mirror_ops {
-     /* release() - release hmm_mirror
-      *
-      * @mirror: pointer to struct hmm_mirror
-      *
-      * This is called when the mm_struct is being released.  The callback
-      * must ensure that all access to any pages obtained from this mirror
-      * is halted before the callback returns. All future access should
-      * fault.
-      */
-     void (*release)(struct hmm_mirror *mirror);
-
-     /* sync_cpu_device_pagetables() - synchronize page tables
-      *
-      * @mirror: pointer to struct hmm_mirror
-      * @update: update information (see struct mmu_notifier_range)
-      * Return: -EAGAIN if update.blockable false and callback need to
-      *         block, 0 otherwise.
-      *
-      * This callback ultimately originates from mmu_notifiers when the CPU
-      * page table is updated. The device driver must update its page table
-      * in response to this callback. The update argument tells what action
-      * to perform.
-      *
-      * The device driver must not return from this callback until the device
-      * page tables are completely updated (TLBs flushed, etc); this is a
-      * synchronous call.
-      */
-     int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-                                       const struct hmm_update *update);
- };
-
-The device driver must perform the update action to the range (mark range
-read only, or fully unmap, etc.). The device must complete the update before
-the driver callback returns.
+registration of a mmu_range_notifier::
+
+ mrn->ops = &driver_ops;
+ int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
+			      unsigned long start, unsigned long length,
+			      struct mm_struct *mm);
+
+During the driver_ops->invalidate() callback the device driver must perform
+the update action to the range (mark range read only, or fully unmap,
+etc.). The device must complete the update before the driver callback returns.
 
 When the device driver wants to populate a range of virtual addresses, it can
 use::
@@ -216,70 +183,46 @@ The usage pattern is::
       struct hmm_range range;
       ...
 
+      range.notifier = &mrn;
       range.start = ...;
       range.end = ...;
       range.pfns = ...;
       range.flags = ...;
       range.values = ...;
       range.pfn_shift = ...;
-      hmm_range_register(&range, mirror);
 
-      /*
-       * Just wait for range to be valid, safe to ignore return value as we
-       * will use the return value of hmm_range_fault() below under the
-       * mmap_sem to ascertain the validity of the range.
-       */
-      hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
+      if (!mmget_not_zero(mrn->notifier.mm))
+          return -EFAULT;
 
  again:
+      range.notifier_seq = mmu_range_read_begin(&mrn);
       down_read(&mm->mmap_sem);
       ret = hmm_range_fault(&range, HMM_RANGE_SNAPSHOT);
       if (ret) {
           up_read(&mm->mmap_sem);
-          if (ret == -EBUSY) {
-            /*
-             * No need to check hmm_range_wait_until_valid() return value
-             * on retry we will get proper error with hmm_range_fault()
-             */
-            hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
-            goto again;
-          }
-          hmm_range_unregister(&range);
+          if (ret == -EBUSY)
+                 goto again;
           return ret;
       }
+      up_read(&mm->mmap_sem);
+
       take_lock(driver->update);
-      if (!hmm_range_valid(&range)) {
+      if (mmu_range_read_retry(&mrn, range.notifier_seq) {
           release_lock(driver->update);
-          up_read(&mm->mmap_sem);
           goto again;
       }
 
-      // Use pfns array content to update device page table
+      /* Use pfns array content to update device page table,
+       * under the update lock */
 
-      hmm_range_unregister(&range);
       release_lock(driver->update);
-      up_read(&mm->mmap_sem);
       return 0;
  }
 
 The driver->update lock is the same lock that the driver takes inside its
-sync_cpu_device_pagetables() callback. That lock must be held before calling
-hmm_range_valid() to avoid any race with a concurrent CPU page table update.
-
-HMM implements all this on top of the mmu_notifier API because we wanted a
-simpler API and also to be able to perform optimizations latter on like doing
-concurrent device updates in multi-devices scenario.
-
-HMM also serves as an impedance mismatch between how CPU page table updates
-are done (by CPU write to the page table and TLB flushes) and how devices
-update their own page table. Device updates are a multi-step process. First,
-appropriate commands are written to a buffer, then this buffer is scheduled for
-execution on the device. It is only once the device has executed commands in
-the buffer that the update is done. Creating and scheduling the update command
-buffer can happen concurrently for multiple devices. Waiting for each device to
-report commands as executed is serialized (there is no point in doing this
-concurrently).
-
+invalidate() callback. That lock must be held before calling
+mmu_range_read_retry() to avoid any race with a concurrent CPU page table
+update.
 
 Leverage default_flags and pfn_flags_mask
 =========================================
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 2666eb08a40615..b4af5173523232 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -68,29 +68,6 @@
 #include <linux/completion.h>
 #include <linux/mmu_notifier.h>
 
-
-/*
- * struct hmm - HMM per mm struct
- *
- * @mm: mm struct this HMM struct is bound to
- * @lock: lock protecting ranges list
- * @ranges: list of range being snapshotted
- * @mirrors: list of mirrors for this mm
- * @mmu_notifier: mmu notifier to track updates to CPU page table
- * @mirrors_sem: read/write semaphore protecting the mirrors list
- * @wq: wait queue for user waiting on a range invalidation
- * @notifiers: count of active mmu notifiers
- */
-struct hmm {
-	struct mmu_notifier	mmu_notifier;
-	spinlock_t		ranges_lock;
-	struct list_head	ranges;
-	struct list_head	mirrors;
-	struct rw_semaphore	mirrors_sem;
-	wait_queue_head_t	wq;
-	long			notifiers;
-};
-
 /*
  * hmm_pfn_flag_e - HMM flag enums
  *
@@ -143,9 +120,8 @@ enum hmm_pfn_value_e {
 /*
  * struct hmm_range - track invalidation lock on virtual address range
  *
- * @notifier: an optional mmu_range_notifier
- * @notifier_seq: when notifier is used this is the result of
- *                mmu_range_read_begin()
+ * @notifier: a mmu_range_notifier that includes the start/end
+ * @notifier_seq: result of mmu_range_read_begin()
  * @hmm: the core HMM structure this range is active against
  * @vma: the vm area struct for the range
  * @list: all range lock are on a list
@@ -162,8 +138,6 @@ enum hmm_pfn_value_e {
 struct hmm_range {
 	struct mmu_range_notifier *notifier;
 	unsigned long		notifier_seq;
-	struct hmm		*hmm;
-	struct list_head	list;
 	unsigned long		start;
 	unsigned long		end;
 	uint64_t		*pfns;
@@ -172,32 +146,8 @@ struct hmm_range {
 	uint64_t		default_flags;
 	uint64_t		pfn_flags_mask;
 	uint8_t			pfn_shift;
-	bool			valid;
 };
 
-/*
- * hmm_range_wait_until_valid() - wait for range to be valid
- * @range: range affected by invalidation to wait on
- * @timeout: time out for wait in ms (ie abort wait after that period of time)
- * Return: true if the range is valid, false otherwise.
- */
-static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
-					      unsigned long timeout)
-{
-	return wait_event_timeout(range->hmm->wq, range->valid,
-				  msecs_to_jiffies(timeout)) != 0;
-}
-
-/*
- * hmm_range_valid() - test if a range is valid or not
- * @range: range
- * Return: true if the range is valid, false otherwise.
- */
-static inline bool hmm_range_valid(struct hmm_range *range)
-{
-	return range->valid;
-}
-
 /*
  * hmm_device_entry_to_page() - return struct page pointed to by a device entry
  * @range: range use to decode device entry value
@@ -267,111 +217,6 @@ static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
 		range->flags[HMM_PFN_VALID];
 }
 
-/*
- * Mirroring: how to synchronize device page table with CPU page table.
- *
- * A device driver that is participating in HMM mirroring must always
- * synchronize with CPU page table updates. For this, device drivers can either
- * directly use mmu_notifier APIs or they can use the hmm_mirror API. Device
- * drivers can decide to register one mirror per device per process, or just
- * one mirror per process for a group of devices. The pattern is:
- *
- *      int device_bind_address_space(..., struct mm_struct *mm, ...)
- *      {
- *          struct device_address_space *das;
- *
- *          // Device driver specific initialization, and allocation of das
- *          // which contains an hmm_mirror struct as one of its fields.
- *          ...
- *
- *          ret = hmm_mirror_register(&das->mirror, mm, &device_mirror_ops);
- *          if (ret) {
- *              // Cleanup on error
- *              return ret;
- *          }
- *
- *          // Other device driver specific initialization
- *          ...
- *      }
- *
- * Once an hmm_mirror is registered for an address space, the device driver
- * will get callbacks through sync_cpu_device_pagetables() operation (see
- * hmm_mirror_ops struct).
- *
- * Device driver must not free the struct containing the hmm_mirror struct
- * before calling hmm_mirror_unregister(). The expected usage is to do that when
- * the device driver is unbinding from an address space.
- *
- *
- *      void device_unbind_address_space(struct device_address_space *das)
- *      {
- *          // Device driver specific cleanup
- *          ...
- *
- *          hmm_mirror_unregister(&das->mirror);
- *
- *          // Other device driver specific cleanup, and now das can be freed
- *          ...
- *      }
- */
-
-struct hmm_mirror;
-
-/*
- * struct hmm_mirror_ops - HMM mirror device operations callback
- *
- * @update: callback to update range on a device
- */
-struct hmm_mirror_ops {
-	/* release() - release hmm_mirror
-	 *
-	 * @mirror: pointer to struct hmm_mirror
-	 *
-	 * This is called when the mm_struct is being released.  The callback
-	 * must ensure that all access to any pages obtained from this mirror
-	 * is halted before the callback returns. All future access should
-	 * fault.
-	 */
-	void (*release)(struct hmm_mirror *mirror);
-
-	/* sync_cpu_device_pagetables() - synchronize page tables
-	 *
-	 * @mirror: pointer to struct hmm_mirror
-	 * @update: update information (see struct mmu_notifier_range)
-	 * Return: -EAGAIN if mmu_notifier_range_blockable(update) is false
-	 * and callback needs to block, 0 otherwise.
-	 *
-	 * This callback ultimately originates from mmu_notifiers when the CPU
-	 * page table is updated. The device driver must update its page table
-	 * in response to this callback. The update argument tells what action
-	 * to perform.
-	 *
-	 * The device driver must not return from this callback until the device
-	 * page tables are completely updated (TLBs flushed, etc); this is a
-	 * synchronous call.
-	 */
-	int (*sync_cpu_device_pagetables)(
-		struct hmm_mirror *mirror,
-		const struct mmu_notifier_range *update);
-};
-
-/*
- * struct hmm_mirror - mirror struct for a device driver
- *
- * @hmm: pointer to struct hmm (which is unique per mm_struct)
- * @ops: device driver callback for HMM mirror operations
- * @list: for list of mirrors of a given mm
- *
- * Each address space (mm_struct) being mirrored by a device must register one
- * instance of an hmm_mirror struct with HMM. HMM will track the list of all
- * mirrors for each mm_struct.
- */
-struct hmm_mirror {
-	struct hmm			*hmm;
-	const struct hmm_mirror_ops	*ops;
-	struct list_head		list;
-};
-
 /*
  * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that case.
  */
@@ -381,15 +226,9 @@ struct hmm_mirror {
 #define HMM_FAULT_SNAPSHOT		(1 << 1)
 
 #ifdef CONFIG_HMM_MIRROR
-int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
-void hmm_mirror_unregister(struct hmm_mirror *mirror);
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror);
-void hmm_range_unregister(struct hmm_range *range);
-
 long hmm_range_fault(struct hmm_range *range, unsigned int flags);
 
 long hmm_range_dma_map(struct hmm_range *range,
@@ -401,24 +240,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			 dma_addr_t *daddrs,
 			 bool dirty);
 #else
-int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
-{
-	return -EOPNOTSUPP;
-}
-
-void hmm_mirror_unregister(struct hmm_mirror *mirror)
-{
-}
-
-int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror)
-{
-	return -EOPNOTSUPP;
-}
-
-void hmm_range_unregister(struct hmm_range *range)
-{
-}
-
 static inline long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
 	return -EOPNOTSUPP;
diff --git a/mm/Kconfig b/mm/Kconfig
index d0b5046d9aeffd..e38ff1d5968dbf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -675,7 +675,6 @@ config DEV_PAGEMAP_OPS
 config HMM_MIRROR
 	bool
 	depends on MMU
-	depends on MMU_NOTIFIER
 
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
diff --git a/mm/hmm.c b/mm/hmm.c
index 22ac3595771feb..75d15a820e182e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -26,193 +26,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-static struct mmu_notifier *hmm_alloc_notifier(struct mm_struct *mm)
-{
-	struct hmm *hmm;
-
-	hmm = kzalloc(sizeof(*hmm), GFP_KERNEL);
-	if (!hmm)
-		return ERR_PTR(-ENOMEM);
-
-	init_waitqueue_head(&hmm->wq);
-	INIT_LIST_HEAD(&hmm->mirrors);
-	init_rwsem(&hmm->mirrors_sem);
-	INIT_LIST_HEAD(&hmm->ranges);
-	spin_lock_init(&hmm->ranges_lock);
-	hmm->notifiers = 0;
-	return &hmm->mmu_notifier;
-}
-
-static void hmm_free_notifier(struct mmu_notifier *mn)
-{
-	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-
-	WARN_ON(!list_empty(&hmm->ranges));
-	WARN_ON(!list_empty(&hmm->mirrors));
-	kfree(hmm);
-}
-
-static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
-{
-	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-	struct hmm_mirror *mirror;
-
-	/*
-	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
-	 * prevented as long as a range exists.
-	 */
-	WARN_ON(!list_empty_careful(&hmm->ranges));
-
-	down_read(&hmm->mirrors_sem);
-	list_for_each_entry(mirror, &hmm->mirrors, list) {
-		/*
-		 * Note: The driver is not allowed to trigger
-		 * hmm_mirror_unregister() from this thread.
-		 */
-		if (mirror->ops->release)
-			mirror->ops->release(mirror);
-	}
-	up_read(&hmm->mirrors_sem);
-}
-
-static void notifiers_decrement(struct hmm *hmm)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&hmm->ranges_lock, flags);
-	hmm->notifiers--;
-	if (!hmm->notifiers) {
-		struct hmm_range *range;
-
-		list_for_each_entry(range, &hmm->ranges, list) {
-			if (range->valid)
-				continue;
-			range->valid = true;
-		}
-		wake_up_all(&hmm->wq);
-	}
-	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
-}
-
-static int hmm_invalidate_range_start(struct mmu_notifier *mn,
-			const struct mmu_notifier_range *nrange)
-{
-	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-	struct hmm_mirror *mirror;
-	struct hmm_range *range;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&hmm->ranges_lock, flags);
-	hmm->notifiers++;
-	list_for_each_entry(range, &hmm->ranges, list) {
-		if (nrange->end < range->start || nrange->start >= range->end)
-			continue;
-
-		range->valid = false;
-	}
-	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
-
-	if (mmu_notifier_range_blockable(nrange))
-		down_read(&hmm->mirrors_sem);
-	else if (!down_read_trylock(&hmm->mirrors_sem)) {
-		ret = -EAGAIN;
-		goto out;
-	}
-
-	list_for_each_entry(mirror, &hmm->mirrors, list) {
-		int rc;
-
-		rc = mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
-		if (rc) {
-			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
-			    rc != -EAGAIN))
-				continue;
-			ret = -EAGAIN;
-			break;
-		}
-	}
-	up_read(&hmm->mirrors_sem);
-
-out:
-	if (ret)
-		notifiers_decrement(hmm);
-	return ret;
-}
-
-static void hmm_invalidate_range_end(struct mmu_notifier *mn,
-			const struct mmu_notifier_range *nrange)
-{
-	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-
-	notifiers_decrement(hmm);
-}
-
-static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
-	.release		= hmm_release,
-	.invalidate_range_start	= hmm_invalidate_range_start,
-	.invalidate_range_end	= hmm_invalidate_range_end,
-	.alloc_notifier		= hmm_alloc_notifier,
-	.free_notifier		= hmm_free_notifier,
-};
-
-/*
- * hmm_mirror_register() - register a mirror against an mm
- *
- * @mirror: new mirror struct to register
- * @mm: mm to register against
- * Return: 0 on success, -ENOMEM if no memory, -EINVAL if invalid arguments
- *
- * To start mirroring a process address space, the device driver must register
- * an HMM mirror struct.
- *
- * The caller cannot unregister the hmm_mirror while any ranges are
- * registered.
- *
- * Callers using this function must put a call to mmu_notifier_synchronize()
- * in their module exit functions.
- */
-int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
-{
-	struct mmu_notifier *mn;
-
-	lockdep_assert_held_write(&mm->mmap_sem);
-
-	/* Sanity check */
-	if (!mm || !mirror || !mirror->ops)
-		return -EINVAL;
-
-	mn = mmu_notifier_get_locked(&hmm_mmu_notifier_ops, mm);
-	if (IS_ERR(mn))
-		return PTR_ERR(mn);
-	mirror->hmm = container_of(mn, struct hmm, mmu_notifier);
-
-	down_write(&mirror->hmm->mirrors_sem);
-	list_add(&mirror->list, &mirror->hmm->mirrors);
-	up_write(&mirror->hmm->mirrors_sem);
-
-	return 0;
-}
-EXPORT_SYMBOL(hmm_mirror_register);
-
-/*
- * hmm_mirror_unregister() - unregister a mirror
- *
- * @mirror: mirror struct to unregister
- *
- * Stop mirroring a process address space, and cleanup.
- */
-void hmm_mirror_unregister(struct hmm_mirror *mirror)
-{
-	struct hmm *hmm = mirror->hmm;
-
-	down_write(&hmm->mirrors_sem);
-	list_del(&mirror->list);
-	up_write(&hmm->mirrors_sem);
-	mmu_notifier_put(&hmm->mmu_notifier);
-}
-EXPORT_SYMBOL(hmm_mirror_unregister);
-
 struct hmm_vma_walk {
 	struct hmm_range	*range;
 	struct dev_pagemap	*pgmap;
@@ -779,87 +592,6 @@ static void hmm_pfns_clear(struct hmm_range *range,
 		*pfns = range->values[HMM_PFN_NONE];
 }
 
-/*
- * hmm_range_register() - start tracking change to CPU page table over a range
- * @range: range
- * @mm: the mm struct for the range of virtual address
- *
- * Return: 0 on success, -EFAULT if the address space is no longer valid
- *
- * Track updates to the CPU page table see include/linux/hmm.h
- */
-int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror)
-{
-	struct hmm *hmm = mirror->hmm;
-	unsigned long flags;
-
-	range->valid = false;
-	range->hmm = NULL;
-
-	if ((range->start & (PAGE_SIZE - 1)) || (range->end & (PAGE_SIZE - 1)))
-		return -EINVAL;
-	if (range->start >= range->end)
-		return -EINVAL;
-
-	/* Prevent hmm_release() from running while the range is valid */
-	if (!mmget_not_zero(hmm->mmu_notifier.mm))
-		return -EFAULT;
-
-	/* Initialize range to track CPU page table updates. */
-	spin_lock_irqsave(&hmm->ranges_lock, flags);
-
-	range->hmm = hmm;
-	list_add(&range->list, &hmm->ranges);
-
-	/*
-	 * If there are any concurrent notifiers we have to wait for them for
-	 * the range to be valid (see hmm_range_wait_until_valid()).
-	 */
-	if (!hmm->notifiers)
-		range->valid = true;
-	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(hmm_range_register);
-
-/*
- * hmm_range_unregister() - stop tracking change to CPU page table over a range
- * @range: range
- *
- * Range struct is used to track updates to the CPU page table after a call to
- * hmm_range_register(). See include/linux/hmm.h for how to use it.
- */
-void hmm_range_unregister(struct hmm_range *range)
-{
-	struct hmm *hmm = range->hmm;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hmm->ranges_lock, flags);
-	list_del_init(&range->list);
-	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
-
-	/* Drop reference taken by hmm_range_register() */
-	mmput(hmm->mmu_notifier.mm);
-
-	/*
-	 * The range is now invalid and the ref on the hmm is dropped, so
-	 * poison the pointer.  Leave other fields in place, for the caller's
-	 * use.
-	 */
-	range->valid = false;
-	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
-}
-EXPORT_SYMBOL(hmm_range_unregister);
-
-static bool needs_retry(struct hmm_range *range)
-{
-	if (range->notifier)
-		return mmu_range_check_retry(range->notifier,
-					     range->notifier_seq);
-	return !range->valid;
-}
-
 static const struct mm_walk_ops hmm_walk_ops = {
 	.pud_entry	= hmm_vma_walk_pud,
 	.pmd_entry	= hmm_vma_walk_pmd,
@@ -900,20 +632,15 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start = range->start, end;
 	struct hmm_vma_walk hmm_vma_walk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = range->notifier->mm;
 	struct vm_area_struct *vma;
 	int ret;
 
-	if (range->notifier)
-		mm = range->notifier->mm;
-	else
-		mm = range->hmm->mmu_notifier.mm;
-
 	lockdep_assert_held(&mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (needs_retry(range))
+		if (mmu_range_check_retry(range->notifier, range->notifier_seq))
 			return -EBUSY;
 
 		vma = find_vma(mm, start);
@@ -946,7 +673,9 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			start = hmm_vma_walk.last;
 
 			/* Keep trying while the range is valid. */
-		} while (ret == -EBUSY && !needs_retry(range));
+		} while (ret == -EBUSY &&
+			 !mmu_range_check_retry(range->notifier,
+						range->notifier_seq));
 
 		if (ret) {
 			unsigned long i;
@@ -1004,7 +733,8 @@ long hmm_range_dma_map(struct hmm_range *range, struct device *device,
 			continue;
 
 		/* Check if range is being invalidated */
-		if (needs_retry(range)) {
+		if (mmu_range_check_retry(range->notifier,
+					  range->notifier_seq)) {
 			ret = -EBUSY;
 			goto unmap;
 		}
-- 
2.23.0

