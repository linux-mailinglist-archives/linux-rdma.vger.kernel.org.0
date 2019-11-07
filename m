Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38217F234F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfKGAX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 19:23:29 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15704 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAX3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 19:23:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc363c20005>; Wed, 06 Nov 2019 16:22:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Nov 2019 16:23:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 Nov 2019 16:23:23 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Nov
 2019 00:23:21 +0000
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <nouveau@lists.freedesktop.org>, <xen-devel@lists.xenproject.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
Date:   Wed, 6 Nov 2019 16:23:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-3-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573086147; bh=wcGT9xMQYHuXfFscUQsjE5NTf0ZA6XJfn+TCAYtZiBE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KiQQ4LDyxKXYIitiaRH6a8gsJ4dGhAyOwYM7DFJdAyGJJBY3oq01CkMaJ9YchQ48q
         S8p0H+M/dgsvISqRDU5deHEqFujQiLM0nmjKtDoHgycaWrEdOq/u72/QWCG3GbqPzt
         DwaP7KV1LZDeFUTiiuyaLyiDSDtdJrpAIjhBmR3DZbzX2ylQyNbRl4t1hyWAb9gKNW
         6MSsYSuHvzmEbihgwRd3FUAb81gqORq9QD9eTo+r61EpuB2TYaHUJWpVNalIVlzBaV
         XPVEiITQ6xu6lP175Mfr/LRZjaj3XWM5EbZ8Z3JfPKLHjUlDKu0PNeaVfd/ppHUsju
         uXdrdN8657ruQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/19 1:10 PM, Jason Gunthorpe wrote:
...
>  include/linux/mmu_notifier.h |  98 +++++++
>  mm/Kconfig                   |   1 +
>  mm/mmu_notifier.c            | 533 +++++++++++++++++++++++++++++++++--
>  3 files changed, 607 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 12bd603d318ce7..51b92ba013ddce 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -6,10 +6,12 @@
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
>  #include <linux/srcu.h>
> +#include <linux/interval_tree.h>
>  
>  struct mmu_notifier_mm;
>  struct mmu_notifier;
>  struct mmu_notifier_range;
> +struct mmu_range_notifier;

Hi Jason,

Nice design, I love the seq foundation! So far, I'm not able to spot anything
actually wrong with the implementation, sorry about that. 

Generally my reaction is: given that the design is complex, try to mitigate 
that with documentation and naming. So the comments are in these areas:

1. There is a rather severe naming overlap (not technically a naming conflict,
but still) with existing mmn work, which already has, for example:

    struct mmu_notifier_range

...and you're adding:

    struct mmu_range_notifier

...so I'll try to help sort that out.

2. I'm also seeing a couple of things that are really hard for the reader
verify are correct (abuse and battery of the low bit in .invalidate_seq, 
for example, haha), so I have some recommendations there.

3. Documentation improvements, which easy to apply, with perhaps one exception.
(Here, because this a complicated area, documentation does make a difference,
so it's worth a little extra fuss.)

4. Other nits that don't matter too much, but just help polish things up
as usual.

>  
>  /**
>   * enum mmu_notifier_event - reason for the mmu notifier callback
> @@ -32,6 +34,9 @@ struct mmu_notifier_range;
>   * access flags). User should soft dirty the page in the end callback to make
>   * sure that anyone relying on soft dirtyness catch pages that might be written
>   * through non CPU mappings.
> + *
> + * @MMU_NOTIFY_RELEASE: used during mmu_range_notifier invalidate to signal that
> + * the mm refcount is zero and the range is no longer accessible.
>   */
>  enum mmu_notifier_event {
>  	MMU_NOTIFY_UNMAP = 0,
> @@ -39,6 +44,7 @@ enum mmu_notifier_event {
>  	MMU_NOTIFY_PROTECTION_VMA,
>  	MMU_NOTIFY_PROTECTION_PAGE,
>  	MMU_NOTIFY_SOFT_DIRTY,
> +	MMU_NOTIFY_RELEASE,
>  };


OK, let the naming debates begin! ha. Anyway, after careful study of the overall
patch, and some browsing of the larger patchset, it's clear that:

* The new "MMU range notifier" that you've created is, approximately, a new
object. It uses classic mmu notifiers inside, as an implementation detail, and
it does *similar* things (notifications) as mmn's. But it's certainly not the same
as mmn's, as shown later when you say the need to an entirely new ops struct, and 
data struct too.

Therefore, you need a separate events enum as well. This is important. MMN's
won't be issuing MMN_NOTIFY_RELEASE events, nor will MNR's be issuing the first
four prexisting MMU_NOTIFY_* items. So it would be a design mistake to glom them
together, unless you ultimately decided to merge these MMN and MNR objects (which
I don't really see any intention of, and that's fine).

So this should read:

enum mmu_range_notifier_event {
	MMU_NOTIFY_RELEASE,
};

...assuming that we stay with "mmu_range_notifier" as a core name for this 
whole thing.

Also, it is best moved down to be next to the new MNR structs, so that all the
MNR stuff is in one group.

Extra credit: IMHO, this clearly deserves to all be in a new mmu_range_notifier.h
header file, but I know that's extra work. Maybe later as a follow-up patch,
if anyone has the time.

>  
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> @@ -222,6 +228,26 @@ struct mmu_notifier {
>  	unsigned int users;
>  };
>  

That should also be moved down, next to the new structs.



A little bit above these next items, just above "struct mmu_notifier" (not shown here, 
it's outside the diff area), there is some documentation about classic MMNs. It would 
be nice if it were clearer that that documentation is not relevant to MNRs. Actually, 
this is another reason that a separate header file would be nice.

> +/**
> + * struct mmu_range_notifier_ops
> + * @invalidate: Upon return the caller must stop using any SPTEs within this
> + *              range, this function can sleep. Return false if blocking was
> + *              required but range is non-blocking
> + */

How about this (I'm not sure I fully understand the return value, though):

/**
 * struct mmu_range_notifier_ops
 * @invalidate: Upon return the caller must stop using any SPTEs within this
 * 		range.
 *
 * 		This function is permitted to sleep.
 *
 *      	@Return: false if blocking was required, but @range is
 *			non-blocking.
 *
 */


> +struct mmu_range_notifier_ops {
> +	bool (*invalidate)(struct mmu_range_notifier *mrn,
> +			   const struct mmu_notifier_range *range,
> +			   unsigned long cur_seq);
> +};
> +
> +struct mmu_range_notifier {
> +	struct interval_tree_node interval_tree;
> +	const struct mmu_range_notifier_ops *ops;
> +	struct hlist_node deferred_item;
> +	unsigned long invalidate_seq;
> +	struct mm_struct *mm;
> +};
> +

Again, now we have the new struct mmu_range_notifier, and the old 
struct mmu_notifier_range, and it's not good.

Ideas:

a) Live with it.

b) (Discarded, too many callers): rename old one. Nope.

c) Rename new one. Ideas:

    struct mmu_interval_notifier
    struct mmu_range_intersection
    ...other ideas?


>  #ifdef CONFIG_MMU_NOTIFIER
>  
>  #ifdef CONFIG_LOCKDEP
> @@ -263,6 +289,78 @@ extern int __mmu_notifier_register(struct mmu_notifier *mn,
>  				   struct mm_struct *mm);
>  extern void mmu_notifier_unregister(struct mmu_notifier *mn,
>  				    struct mm_struct *mm);
> +
> +unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn);
> +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +			      unsigned long start, unsigned long length,
> +			      struct mm_struct *mm);
> +int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
> +				     unsigned long start, unsigned long length,
> +				     struct mm_struct *mm);
> +void mmu_range_notifier_remove(struct mmu_range_notifier *mrn);
> +
> +/**
> + * mmu_range_set_seq - Save the invalidation sequence

How about:

 * mmu_range_set_seq - Set the .invalidate_seq to a new value.


> + * @mrn - The mrn passed to invalidate
> + * @cur_seq - The cur_seq passed to invalidate
> + *
> + * This must be called unconditionally from the invalidate callback of a
> + * struct mmu_range_notifier_ops under the same lock that is used to call
> + * mmu_range_read_retry(). It updates the sequence number for later use by
> + * mmu_range_read_retry().
> + *
> + * If the user does not call mmu_range_read_begin() or mmu_range_read_retry()

nit: "caller" is better than "user", when referring to...well, callers. "user" 
most often refers to user space, whereas a call stack and function calling is 
clearly what you're referring to here (and in other places, especially "user lock").

> + * then this call is not required.
> + */
> +static inline void mmu_range_set_seq(struct mmu_range_notifier *mrn,
> +				     unsigned long cur_seq)
> +{
> +	WRITE_ONCE(mrn->invalidate_seq, cur_seq);
> +}
> +
> +/**
> + * mmu_range_read_retry - End a read side critical section against a VA range
> + * mrn: The range under lock
> + * seq: The return of the paired mmu_range_read_begin()
> + *
> + * This MUST be called under a user provided lock that is also held
> + * unconditionally by op->invalidate() when it calls mmu_range_set_seq().
> + *
> + * Each call should be paired with a single mmu_range_read_begin() and
> + * should be used to conclude the read side.
> + *
> + * Returns true if an invalidation collided with this critical section, and
> + * the caller should retry.
> + */
> +static inline bool mmu_range_read_retry(struct mmu_range_notifier *mrn,
> +					unsigned long seq)
> +{
> +	return mrn->invalidate_seq != seq;
> +}
> +
> +/**
> + * mmu_range_check_retry - Test if a collision has occurred
> + * mrn: The range under lock
> + * seq: The return of the matching mmu_range_read_begin()
> + *
> + * This can be used in the critical section between mmu_range_read_begin() and
> + * mmu_range_read_retry().  A return of true indicates an invalidation has
> + * collided with this lock and a future mmu_range_read_retry() will return
> + * true.
> + *
> + * False is not reliable and only suggests a collision has not happened. It

let's say "suggests that a collision *may* not have occurred."  

...
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 367670cfd02b7b..d02d3c8c223eb7 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -12,6 +12,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/err.h>
> +#include <linux/interval_tree.h>
>  #include <linux/srcu.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> @@ -36,10 +37,243 @@ struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
>  struct mmu_notifier_mm {
>  	/* all mmu notifiers registered in this mm are queued in this list */
>  	struct hlist_head list;
> +	bool has_interval;
>  	/* to serialize the list modifications and hlist_unhashed */
>  	spinlock_t lock;
> +	unsigned long invalidate_seq;
> +	unsigned long active_invalidate_ranges;
> +	struct rb_root_cached itree;
> +	wait_queue_head_t wq;
> +	struct hlist_head deferred_list;
>  };
>  
> +/*
> + * This is a collision-retry read-side/write-side 'lock', a lot like a
> + * seqcount, however this allows multiple write-sides to hold it at
> + * once. Conceptually the write side is protecting the values of the PTEs in
> + * this mm, such that PTES cannot be read into SPTEs while any writer exists.

Just to be kind, can we say "SPTEs (shadow PTEs)", just this once? :)

> + *
> + * Note that the core mm creates nested invalidate_range_start()/end() regions
> + * within the same thread, and runs invalidate_range_start()/end() in parallel
> + * on multiple CPUs. This is designed to not reduce concurrency or block
> + * progress on the mm side.
> + *
> + * As a secondary function, holding the full write side also serves to prevent
> + * writers for the itree, this is an optimization to avoid extra locking
> + * during invalidate_range_start/end notifiers.
> + *
> + * The write side has two states, fully excluded:
> + *  - mm->active_invalidate_ranges != 0
> + *  - mnn->invalidate_seq & 1 == True
> + *  - some range on the mm_struct is being invalidated
> + *  - the itree is not allowed to change
> + *
> + * And partially excluded:
> + *  - mm->active_invalidate_ranges != 0

I assume this implies mnn->invalidate_seq & 1 == False in this case? If so,
let's say so. I'm probably getting that wrong, too.

> + *  - some range on the mm_struct is being invalidated
> + *  - the itree is allowed to change
> + *
> + * The later state avoids some expensive work on inv_end in the common case of
> + * no mrn monitoring the VA.
> + */
> +static bool mn_itree_is_invalidating(struct mmu_notifier_mm *mmn_mm)
> +{
> +	lockdep_assert_held(&mmn_mm->lock);
> +	return mmn_mm->invalidate_seq & 1;
> +}
> +
> +static struct mmu_range_notifier *
> +mn_itree_inv_start_range(struct mmu_notifier_mm *mmn_mm,
> +			 const struct mmu_notifier_range *range,
> +			 unsigned long *seq)
> +{
> +	struct interval_tree_node *node;
> +	struct mmu_range_notifier *res = NULL;
> +
> +	spin_lock(&mmn_mm->lock);
> +	mmn_mm->active_invalidate_ranges++;
> +	node = interval_tree_iter_first(&mmn_mm->itree, range->start,
> +					range->end - 1);
> +	if (node) {
> +		mmn_mm->invalidate_seq |= 1;


OK, this either needs more documentation and assertions, or a different
approach. Because I see addition, subtraction, AND, OR and booleans
all being applied to this field, and it's darn near hopeless to figure
out whether or not it really is even or odd at the right times.

Different approach: why not just add a mmn_mm->is_invalidating 
member variable? It's not like you're short of space in that struct.


> +		res = container_of(node, struct mmu_range_notifier,
> +				   interval_tree);
> +	}
> +
> +	*seq = mmn_mm->invalidate_seq;
> +	spin_unlock(&mmn_mm->lock);
> +	return res;
> +}
> +
> +static struct mmu_range_notifier *
> +mn_itree_inv_next(struct mmu_range_notifier *mrn,
> +		  const struct mmu_notifier_range *range)
> +{
> +	struct interval_tree_node *node;
> +
> +	node = interval_tree_iter_next(&mrn->interval_tree, range->start,
> +				       range->end - 1);
> +	if (!node)
> +		return NULL;
> +	return container_of(node, struct mmu_range_notifier, interval_tree);
> +}
> +
> +static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
> +{
> +	struct mmu_range_notifier *mrn;
> +	struct hlist_node *next;
> +	bool need_wake = false;
> +
> +	spin_lock(&mmn_mm->lock);
> +	if (--mmn_mm->active_invalidate_ranges ||
> +	    !mn_itree_is_invalidating(mmn_mm)) {
> +		spin_unlock(&mmn_mm->lock);
> +		return;
> +	}
> +
> +	mmn_mm->invalidate_seq++;

Is this the right place for an assertion that this is now an even value?

> +	need_wake = true;
> +
> +	/*
> +	 * The inv_end incorporates a deferred mechanism like
> +	 * rtnl_lock(). Adds and removes are queued until the final inv_end

Let me point out that rtnl_lock() itself is a one-liner that calls mutex_lock().
But I suppose if one studies that file closely there is more. :)

...

> +unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn)
> +{
> +	struct mmu_notifier_mm *mmn_mm = mrn->mm->mmu_notifier_mm;
> +	unsigned long seq;
> +	bool is_invalidating;
> +
> +	/*
> +	 * If the mrn has a different seq value under the user_lock than we
> +	 * started with then it has collided.
> +	 *
> +	 * If the mrn currently has the same seq value as the mmn_mm seq, then
> +	 * it is currently between invalidate_start/end and is colliding.
> +	 *
> +	 * The locking looks broadly like this:
> +	 *   mn_tree_invalidate_start():          mmu_range_read_begin():
> +	 *                                         spin_lock
> +	 *                                          seq = READ_ONCE(mrn->invalidate_seq);
> +	 *                                          seq == mmn_mm->invalidate_seq
> +	 *                                         spin_unlock
> +	 *    spin_lock
> +	 *     seq = ++mmn_mm->invalidate_seq
> +	 *    spin_unlock
> +	 *     op->invalidate_range():
> +	 *       user_lock
> +	 *        mmu_range_set_seq()
> +	 *         mrn->invalidate_seq = seq
> +	 *       user_unlock
> +	 *
> +	 *                          [Required: mmu_range_read_retry() == true]
> +	 *
> +	 *   mn_itree_inv_end():
> +	 *    spin_lock
> +	 *     seq = ++mmn_mm->invalidate_seq
> +	 *    spin_unlock
> +	 *
> +	 *                                        user_lock
> +	 *                                         mmu_range_read_retry():
> +	 *                                          mrn->invalidate_seq != seq
> +	 *                                        user_unlock
> +	 *
> +	 * Barriers are not needed here as any races here are closed by an
> +	 * eventual mmu_range_read_retry(), which provides a barrier via the
> +	 * user_lock.
> +	 */
> +	spin_lock(&mmn_mm->lock);
> +	/* Pairs with the WRITE_ONCE in mmu_range_set_seq() */
> +	seq = READ_ONCE(mrn->invalidate_seq);
> +	is_invalidating = seq == mmn_mm->invalidate_seq;
> +	spin_unlock(&mmn_mm->lock);
> +
> +	/*
> +	 * mrn->invalidate_seq is always set to an odd value. This ensures

This claim just looks wrong the first N times one reads the code, given that
there is mmu_range_set_seq() to set it to an arbitrary value!  Maybe you mean

"is always set to an odd value when invalidating"??

> +	 * that if seq does wrap we will always clear the below sleep in some
> +	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> +	 * state.
> +	 */

Let's move that comment higher up. The code that follows it has nothing to
do with it, so it's confusing here.

...
> @@ -529,6 +852,166 @@ void mmu_notifier_put(struct mmu_notifier *mn)
>  }
>  EXPORT_SYMBOL_GPL(mmu_notifier_put);
>  
> +static int __mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +				       unsigned long start,
> +				       unsigned long length,
> +				       struct mmu_notifier_mm *mmn_mm,
> +				       struct mm_struct *mm)
> +{
> +	mrn->mm = mm;
> +	RB_CLEAR_NODE(&mrn->interval_tree.rb);
> +	mrn->interval_tree.start = start;
> +	/*
> +	 * Note that the representation of the intervals in the interval tree
> +	 * considers the ending point as contained in the interval.

Thanks for that comment!

> +	 */
> +	if (length == 0 ||
> +	    check_add_overflow(start, length - 1, &mrn->interval_tree.last))
> +		return -EOVERFLOW;
> +
> +	/* pairs with mmdrop in mmu_range_notifier_remove() */
> +	mmgrab(mm);
> +
> +	/*
> +	 * If some invalidate_range_start/end region is going on in parallel
> +	 * we don't know what VA ranges are affected, so we must assume this
> +	 * new range is included.
> +	 *
> +	 * If the itree is invalidating then we are not allowed to change
> +	 * it. Retrying until invalidation is done is tricky due to the
> +	 * possibility for live lock, instead defer the add to the unlock so
> +	 * this algorithm is deterministic.
> +	 *
> +	 * In all cases the value for the mrn->mr_invalidate_seq should be
> +	 * odd, see mmu_range_read_begin()
> +	 */
> +	spin_lock(&mmn_mm->lock);
> +	if (mmn_mm->active_invalidate_ranges) {
> +		if (mn_itree_is_invalidating(mmn_mm))
> +			hlist_add_head(&mrn->deferred_item,
> +				       &mmn_mm->deferred_list);
> +		else {
> +			mmn_mm->invalidate_seq |= 1;
> +			interval_tree_insert(&mrn->interval_tree,
> +					     &mmn_mm->itree);
> +		}
> +		mrn->invalidate_seq = mmn_mm->invalidate_seq;
> +	} else {
> +		WARN_ON(mn_itree_is_invalidating(mmn_mm));
> +		mrn->invalidate_seq = mmn_mm->invalidate_seq - 1;

Ohhh, checkmate. I lose. Why is *subtracting* the right thing to do
for seq numbers here?  I'm acutely unhappy trying to figure this out.
I suspect it's another unfortunate side effect of trying to use the
lower bit of the seq number (even/odd) for something else.

> +		interval_tree_insert(&mrn->interval_tree, &mmn_mm->itree);
> +	}
> +	spin_unlock(&mmn_mm->lock);
> +	return 0;
> +}
> +
> +/**
> + * mmu_range_notifier_insert - Insert a range notifier
> + * @mrn: Range notifier to register
> + * @start: Starting virtual address to monitor
> + * @length: Length of the range to monitor
> + * @mm : mm_struct to attach to
> + *
> + * This function subscribes the range notifier for notifications from the mm.
> + * Upon return the ops related to mmu_range_notifier will be called whenever
> + * an event that intersects with the given range occurs.
> + *
> + * Upon return the range_notifier may not be present in the interval tree yet.
> + * The caller must use the normal range notifier locking flow via
> + * mmu_range_read_begin() to establish SPTEs for this range.
> + */
> +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +			      unsigned long start, unsigned long length,
> +			      struct mm_struct *mm)
> +{
> +	struct mmu_notifier_mm *mmn_mm;
> +	int ret;

Hmmm, I think a later patch improperly changes the above to "int ret = 0;".
I'll check on that. It's correct here, though.

> +
> +	might_lock(&mm->mmap_sem);
> +
> +	mmn_mm = smp_load_acquire(&mm->mmu_notifier_mm);

What does the above pair with? Should have a comment that specifies that.

 
thanks,

John Hubbard
NVIDIA
