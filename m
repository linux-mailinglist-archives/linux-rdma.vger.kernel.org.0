Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0FDF51E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfJUSbH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:31:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbfJUSbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571682665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWzhTBYpGYPdSV91muDnmc/gB8n5LQ/uQ1I3j7xBs/s=;
        b=CS9L4JD/2HVI5THPLBsAr2QNwojiEtDDSILF1FEmLpfoOp1otJHwnT8XW1hb69tkhZ02s2
        /opMF4u9/F8zXreD6EvY0f+Hm+2GiHeQ8ll+5Nw4erZj1YKb65NCCujG1qMSs7eeq6obtf
        1LZ8sezoY9u7D9Iu9GIA8muQgyiBjB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-XIrI2mA2OKecqcAoSJUmGQ-1; Mon, 21 Oct 2019 14:31:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A2980183E;
        Mon, 21 Oct 2019 18:30:59 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 532FA194BE;
        Mon, 21 Oct 2019 18:30:58 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:30:56 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191021183056.GA3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-3-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XIrI2mA2OKecqcAoSJUmGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:29PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Of the 13 users of mmu_notifiers, 8 of them use only
> invalidate_range_start/end() and immediately intersect the
> mmu_notifier_range with some kind of internal list of VAs.  4 use an
> interval tree (i915_gem, radeon_mn, umem_odp, hfi1). 4 use a linked list
> of some kind (scif_dma, vhost, gntdev, hmm)
>=20
> And the remaining 5 either don't use invalidate_range_start() or do some
> special thing with it.
>=20
> It turns out that building a correct scheme with an interval tree is
> pretty complicated, particularly if the use case is synchronizing against
> another thread doing get_user_pages().  Many of these implementations hav=
e
> various subtle and difficult to fix races.
>=20
> This approach puts the interval tree as common code at the top of the mmu
> notifier call tree and implements a shareable locking scheme.
>=20
> It includes:
>  - An interval tree tracking VA ranges, with per-range callbacks
>  - A read/write locking scheme for the interval tree that avoids
>    sleeping in the notifier path (for OOM killer)
>  - A sequence counter based collision-retry locking scheme to tell
>    device page fault that a VA range is being concurrently invalidated.
>=20
> This is based on various ideas:
> - hmm accumulates invalidated VA ranges and releases them when all
>   invalidates are done, via active_invalidate_ranges count.
>   This approach avoids having to intersect the interval tree twice (as
>   umem_odp does) at the potential cost of a longer device page fault.
>=20
> - kvm/umem_odp use a sequence counter to drive the collision retry,
>   via invalidate_seq
>=20
> - a deferred work todo list on unlock scheme like RTNL, via deferred_list=
.
>   This makes adding/removing interval tree members more deterministic
>=20
> - seqlock, except this version makes the seqlock idea multi-holder on the
>   write side by protecting it with active_invalidate_ranges and a spinloc=
k
>=20
> To minimize MM overhead when only the interval tree is being used, the
> entire SRCU and hlist overheads are dropped using some simple
> branches. Similarly the interval tree overhead is dropped when in hlist
> mode.
>=20
> The overhead from the mandatory spinlock is broadly the same as most of
> existing users which already had a lock (or two) of some sort on the
> invalidation path.
>=20
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/linux/mmu_notifier.h |  78 ++++++
>  mm/Kconfig                   |   1 +
>  mm/mmu_notifier.c            | 529 +++++++++++++++++++++++++++++++++--
>  3 files changed, 583 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 12bd603d318ce7..bc2b12483de127 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -6,10 +6,12 @@
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
>  #include <linux/srcu.h>
> +#include <linux/interval_tree.h>
> =20
>  struct mmu_notifier_mm;
>  struct mmu_notifier;
>  struct mmu_notifier_range;
> +struct mmu_range_notifier;
> =20
>  /**
>   * enum mmu_notifier_event - reason for the mmu notifier callback
> @@ -32,6 +34,9 @@ struct mmu_notifier_range;
>   * access flags). User should soft dirty the page in the end callback to=
 make
>   * sure that anyone relying on soft dirtyness catch pages that might be =
written
>   * through non CPU mappings.
> + *
> + * @MMU_NOTIFY_RELEASE: used during mmu_range_notifier invalidate to sig=
nal that
> + * the mm refcount is zero and the range is no longer accessible.
>   */
>  enum mmu_notifier_event {
>  =09MMU_NOTIFY_UNMAP =3D 0,
> @@ -39,6 +44,7 @@ enum mmu_notifier_event {
>  =09MMU_NOTIFY_PROTECTION_VMA,
>  =09MMU_NOTIFY_PROTECTION_PAGE,
>  =09MMU_NOTIFY_SOFT_DIRTY,
> +=09MMU_NOTIFY_RELEASE,
>  };
> =20
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> @@ -222,6 +228,25 @@ struct mmu_notifier {
>  =09unsigned int users;
>  };
> =20
> +/**
> + * struct mmu_range_notifier_ops
> + * @invalidate: Upon return the caller must stop using any SPTEs within =
this
> + *              range, this function can sleep. Return false if blocking=
 was
> + *              required but range is non-blocking
> + */
> +struct mmu_range_notifier_ops {
> +=09bool (*invalidate)(struct mmu_range_notifier *mrn,
> +=09=09=09   const struct mmu_notifier_range *range);
> +};
> +
> +struct mmu_range_notifier {
> +=09struct interval_tree_node interval_tree;
> +=09const struct mmu_range_notifier_ops *ops;
> +=09struct hlist_node deferred_item;
> +=09unsigned long invalidate_seq;
> +=09struct mm_struct *mm;
> +};
> +
>  #ifdef CONFIG_MMU_NOTIFIER
> =20
>  #ifdef CONFIG_LOCKDEP
> @@ -263,6 +288,59 @@ extern int __mmu_notifier_register(struct mmu_notifi=
er *mn,
>  =09=09=09=09   struct mm_struct *mm);
>  extern void mmu_notifier_unregister(struct mmu_notifier *mn,
>  =09=09=09=09    struct mm_struct *mm);
> +
> +unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn);
> +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +=09=09=09      unsigned long start, unsigned long length,
> +=09=09=09      struct mm_struct *mm);
> +int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
> +=09=09=09=09     unsigned long start, unsigned long length,
> +=09=09=09=09     struct mm_struct *mm);
> +void mmu_range_notifier_remove(struct mmu_range_notifier *mrn);
> +
> +/**
> + * mmu_range_read_retry - End a read side critical section against a VA =
range
> + * mrn: The range under lock
> + * seq: The return of the paired mmu_range_read_begin()
> + *
> + * This MUST be called under a user provided lock that is also held
> + * unconditionally by op->invalidate(). That lock provides the required =
SMP
> + * barrier for handling invalidate_seq.
> + *
> + * Each call should be paired with a single mmu_range_read_begin() and
> + * should be used to conclude the read side.
> + *
> + * Returns true if an invalidation collided with this critical section, =
and
> + * the caller should retry.
> + */
> +static inline bool mmu_range_read_retry(struct mmu_range_notifier *mrn,
> +=09=09=09=09=09unsigned long seq)
> +{
> +=09return READ_ONCE(mrn->invalidate_seq) !=3D seq;
> +}

What about calling this mmu_range_read_end() instead ? To match
with the mmu_range_read_begin().


> +
> +/**
> + * mmu_range_check_retry - Test if a collision has occurred
> + * mrn: The range under lock
> + * seq: The return of the matching mmu_range_read_begin()
> + *
> + * This can be used in the critical section between mmu_range_read_begin=
() and
> + * mmu_range_read_retry().  A return of true indicates an invalidation h=
as
> + * collided with this lock and a future mmu_range_read_retry() will retu=
rn
> + * true.
> + *
> + * False is not reliable and only suggests a collision has not happened.=
 It
> + * can be called many times and does not have to hold the user provided =
lock.
> + *
> + * This call can be used as part of loops and other expensive operations=
 to
> + * expedite a retry.
> + */
> +static inline bool mmu_range_check_retry(struct mmu_range_notifier *mrn,
> +=09=09=09=09=09 unsigned long seq)
> +{
> +=09return READ_ONCE(mrn->invalidate_seq) !=3D seq;
> +}
> +
>  extern void __mmu_notifier_mm_destroy(struct mm_struct *mm);
>  extern void __mmu_notifier_release(struct mm_struct *mm);
>  extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb510a..d0b5046d9aeffd 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -284,6 +284,7 @@ config VIRT_TO_BUS
>  config MMU_NOTIFIER
>  =09bool
>  =09select SRCU
> +=09select INTERVAL_TREE
> =20
>  config KSM
>  =09bool "Enable KSM for page merging"
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 367670cfd02b7b..5e5e75ebcde4af 100644
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
> @@ -36,10 +37,243 @@ struct lockdep_map __mmu_notifier_invalidate_range_s=
tart_map =3D {
>  struct mmu_notifier_mm {
>  =09/* all mmu notifiers registered in this mm are queued in this list */
>  =09struct hlist_head list;
> +=09bool has_interval;
>  =09/* to serialize the list modifications and hlist_unhashed */
>  =09spinlock_t lock;
> +=09unsigned long invalidate_seq;
> +=09unsigned long active_invalidate_ranges;
> +=09struct rb_root_cached itree;
> +=09wait_queue_head_t wq;
> +=09struct hlist_head deferred_list;
>  };
> =20
> +/*
> + * This is a collision-retry read-side/write-side 'lock', a lot like a
> + * seqcount, however this allows multiple write-sides to hold it at
> + * once. Conceptually the write side is protecting the values of the PTE=
s in
> + * this mm, such that PTES cannot be read into SPTEs while any writer ex=
ists.
> + *
> + * Note that the core mm creates nested invalidate_range_start()/end() r=
egions
> + * within the same thread, and runs invalidate_range_start()/end() in pa=
rallel
> + * on multiple CPUs. This is designed to not reduce concurrency or block
> + * progress on the mm side.
> + *
> + * As a secondary function, holding the full write side also serves to p=
revent
> + * writers for the itree, this is an optimization to avoid extra locking
> + * during invalidate_range_start/end notifiers.
> + *
> + * The write side has two states, fully excluded:
> + *  - mm->active_invalidate_ranges !=3D 0
> + *  - mnn->invalidate_seq & 1 =3D=3D True
> + *  - some range on the mm_struct is being invalidated
> + *  - the itree is not allowed to change
> + *
> + * And partially excluded:
> + *  - mm->active_invalidate_ranges !=3D 0
> + *  - some range on the mm_struct is being invalidated
> + *  - the itree is allowed to change
> + *
> + * The later state avoids some expensive work on inv_end in the common c=
ase of
> + * no mrn monitoring the VA.
> + */
> +static bool mn_itree_is_invalidating(struct mmu_notifier_mm *mmn_mm)
> +{
> +=09lockdep_assert_held(&mmn_mm->lock);
> +=09return mmn_mm->invalidate_seq & 1;
> +}
> +
> +static struct mmu_range_notifier *
> +mn_itree_inv_start_range(struct mmu_notifier_mm *mmn_mm,
> +=09=09=09 const struct mmu_notifier_range *range,
> +=09=09=09 unsigned long *seq)
> +{
> +=09struct interval_tree_node *node;
> +=09struct mmu_range_notifier *res =3D NULL;
> +
> +=09spin_lock(&mmn_mm->lock);
> +=09mmn_mm->active_invalidate_ranges++;
> +=09node =3D interval_tree_iter_first(&mmn_mm->itree, range->start,
> +=09=09=09=09=09range->end - 1);
> +=09if (node) {
> +=09=09mmn_mm->invalidate_seq |=3D 1;
> +=09=09res =3D container_of(node, struct mmu_range_notifier,
> +=09=09=09=09   interval_tree);
> +=09}
> +
> +=09*seq =3D mmn_mm->invalidate_seq;
> +=09spin_unlock(&mmn_mm->lock);
> +=09return res;
> +}
> +
> +static struct mmu_range_notifier *
> +mn_itree_inv_next(struct mmu_range_notifier *mrn,
> +=09=09  const struct mmu_notifier_range *range)
> +{
> +=09struct interval_tree_node *node;
> +
> +=09node =3D interval_tree_iter_next(&mrn->interval_tree, range->start,
> +=09=09=09=09       range->end - 1);
> +=09if (!node)
> +=09=09return NULL;
> +=09return container_of(node, struct mmu_range_notifier, interval_tree);
> +}
> +
> +static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
> +{
> +=09struct mmu_range_notifier *mrn;
> +=09struct hlist_node *next;
> +=09bool need_wake =3D false;
> +
> +=09spin_lock(&mmn_mm->lock);
> +=09if (--mmn_mm->active_invalidate_ranges ||
> +=09    !mn_itree_is_invalidating(mmn_mm)) {
> +=09=09spin_unlock(&mmn_mm->lock);
> +=09=09return;
> +=09}
> +
> +=09mmn_mm->invalidate_seq++;
> +=09need_wake =3D true;
> +
> +=09/*
> +=09 * The inv_end incorporates a deferred mechanism like rtnl. Adds and

The rtnl reference is lost on people unfamiliar with the network :)
code maybe like rtnl_lock()/rtnl_unlock() so people have a chance to
grep the right function. Assuming i am myself getting the right
reference :)

> +=09 * removes are queued until the final inv_end happens then they are
> +=09 * progressed. This arrangement for tree updates is used to avoid
> +=09 * using a blocking lock during invalidate_range_start.
> +=09 */
> +=09hlist_for_each_entry_safe(mrn, next, &mmn_mm->deferred_list,
> +=09=09=09=09  deferred_item) {
> +=09=09if (RB_EMPTY_NODE(&mrn->interval_tree.rb))
> +=09=09=09interval_tree_insert(&mrn->interval_tree,
> +=09=09=09=09=09     &mmn_mm->itree);
> +=09=09else
> +=09=09=09interval_tree_remove(&mrn->interval_tree,
> +=09=09=09=09=09     &mmn_mm->itree);
> +=09=09hlist_del(&mrn->deferred_item);
> +=09}
> +=09spin_unlock(&mmn_mm->lock);
> +
> +=09/*
> +=09 * TODO: Since we already have a spinlock above, this would be faster
> +=09 * as wake_up_q
> +=09 */
> +=09if (need_wake)
> +=09=09wake_up_all(&mmn_mm->wq);
> +}
> +
> +/**
> + * mmu_range_read_begin - Begin a read side critical section against a V=
A range
> + * mrn: The range to lock
> + *
> + * mmu_range_read_begin()/mmu_range_read_retry() implement a collision-r=
etry
> + * locking scheme similar to seqcount for the VA range under mrn. If the=
 mm
> + * invokes invalidation during the critical section then
> + * mmu_range_read_retry() will return true.
> + *
> + * This is useful to obtain shadow PTEs where teardown or setup of the S=
PTEs
> + * require a blocking context.  The critical region formed by this lock =
can
> + * sleep, and the required 'user_lock' can also be a sleeping lock.
> + *
> + * The caller is required to provide a 'user_lock' to serialize both tea=
rdown
> + * and setup.
> + *
> + * The return value should be passed to mmu_range_read_retry().
> + */
> +unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn)
> +{
> +=09struct mmu_notifier_mm *mmn_mm =3D mrn->mm->mmu_notifier_mm;
> +=09unsigned long seq;
> +=09bool is_invalidating;
> +
> +=09/*
> +=09 * If the mrn has a different seq value under the user_lock than we
> +=09 * started with then it has collided.
> +=09 *
> +=09 * If the mrn currently has the same seq value as the mmn_mm seq, the=
n
> +=09 * it is currently between invalidate_start/end and is colliding.
> +=09 *
> +=09 * The locking looks broadly like this:
> +=09 *   mn_tree_invalidate_start():          mmu_range_read_begin():
> +=09 *                                         spin_lock
> +=09 *                                          seq =3D READ_ONCE(mrn->in=
validate_seq);
> +=09 *                                          seq =3D=3D mmn_mm->invali=
date_seq
> +=09 *                                         spin_unlock
> +=09 *    spin_lock
> +=09 *     seq =3D ++mmn_mm->invalidate_seq
> +=09 *    spin_unlock
> +=09 *    mrn->invalidate_seq =3D seq
> +=09 *     op->invalidate_range():
> +=09 *       user_lock
> +=09 *       user_unlock
> +=09 *
> +=09 *                          [Required: mmu_range_read_retry() =3D=3D =
true]
> +=09 *
> +=09 *   mn_itree_inv_end():
> +=09 *    spin_lock
> +=09 *     seq =3D ++mmn_mm->invalidate_seq
> +=09 *    spin_unlock
> +=09 *
> +=09 *                                        user_lock
> +=09 *                                         mmu_range_read_retry():
> +=09 *                                          READ_ONCE(mrn->invalidate=
_seq) !=3D seq
> +=09 *                                        user_unlock
> +=09 *
> +=09 * Logically mrn->invalidate_seq is locked under the user provided
> +=09 * lock, however the write is placed before that lock due to the way
> +=09 * the API is layered.
> +=09 *
> +=09 * Barriers are not needed as any races here are closed by an eventua=
l
> +=09 * mmu_range_read_retry(), which provides a barrier via the user_lock=
.
> +=09 */
> +=09spin_lock(&mmn_mm->lock);
> +=09seq =3D READ_ONCE(mrn->invalidate_seq);
> +=09is_invalidating =3D seq =3D=3D mmn_mm->invalidate_seq;
> +=09spin_unlock(&mmn_mm->lock);
> +
> +=09/*
> +=09 * mrn->invalidate_seq is always set to an odd value. This ensures
> +=09 * that if seq does wrap we will always clear the below sleep in some
> +=09 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> +=09 * state.

I think this comment should be with the struct mmu_range_notifier
definition and you should just point to it from here as the same
comment would be useful down below.

> +=09 */
> +=09lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +=09lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +=09if (is_invalidating)
> +=09=09wait_event(mmn_mm->wq,
> +=09=09=09   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
> +
> +=09/*
> +=09 * Notice that mmu_range_read_retry() can already be true at this
> +=09 * point, avoiding loops here allows the user of this lock to provide
> +=09 * a global time bound.
> +=09 */
> +
> +=09return seq;
> +}
> +EXPORT_SYMBOL_GPL(mmu_range_read_begin);
> +
> +static void mn_itree_release(struct mmu_notifier_mm *mmn_mm,
> +=09=09=09     struct mm_struct *mm)
> +{
> +=09struct mmu_notifier_range range =3D {
> +=09=09.flags =3D MMU_NOTIFIER_RANGE_BLOCKABLE,
> +=09=09.event =3D MMU_NOTIFY_RELEASE,
> +=09=09.mm =3D mm,
> +=09=09.start =3D 0,
> +=09=09.end =3D ULONG_MAX,
> +=09};
> +=09struct mmu_range_notifier *mrn;
> +=09unsigned long cur_seq;
> +=09bool ret;
> +
> +=09for (mrn =3D mn_itree_inv_start_range(mmn_mm, &range, &cur_seq); mrn;
> +=09     mrn =3D mn_itree_inv_next(mrn, &range)) {
> +=09=09ret =3D mrn->ops->invalidate(mrn, &range);
> +=09=09WARN_ON(ret);
> +=09}
> +
> +=09mn_itree_inv_end(mmn_mm);
> +}
> +
>  /*
>   * This function can't run concurrently against mmu_notifier_register
>   * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
> @@ -52,17 +286,24 @@ struct mmu_notifier_mm {
>   * can't go away from under us as exit_mmap holds an mm_count pin
>   * itself.
>   */
> -void __mmu_notifier_release(struct mm_struct *mm)
> +static void mn_hlist_release(struct mmu_notifier_mm *mmn_mm,
> +=09=09=09     struct mm_struct *mm)
>  {
>  =09struct mmu_notifier *mn;
>  =09int id;
> =20
> +=09if (mmn_mm->has_interval)
> +=09=09mn_itree_release(mmn_mm, mm);
> +
> +=09if (hlist_empty(&mmn_mm->list))
> +=09=09return;
> +
>  =09/*
>  =09 * SRCU here will block mmu_notifier_unregister until
>  =09 * ->release returns.
>  =09 */
>  =09id =3D srcu_read_lock(&srcu);
> -=09hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist)
> +=09hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist)
>  =09=09/*
>  =09=09 * If ->release runs before mmu_notifier_unregister it must be
>  =09=09 * handled, as it's the only way for the driver to flush all
> @@ -72,9 +313,9 @@ void __mmu_notifier_release(struct mm_struct *mm)
>  =09=09if (mn->ops->release)
>  =09=09=09mn->ops->release(mn, mm);
> =20
> -=09spin_lock(&mm->mmu_notifier_mm->lock);
> -=09while (unlikely(!hlist_empty(&mm->mmu_notifier_mm->list))) {
> -=09=09mn =3D hlist_entry(mm->mmu_notifier_mm->list.first,
> +=09spin_lock(&mmn_mm->lock);
> +=09while (unlikely(!hlist_empty(&mmn_mm->list))) {
> +=09=09mn =3D hlist_entry(mmn_mm->list.first,
>  =09=09=09=09 struct mmu_notifier,
>  =09=09=09=09 hlist);
>  =09=09/*
> @@ -85,7 +326,7 @@ void __mmu_notifier_release(struct mm_struct *mm)
>  =09=09 */
>  =09=09hlist_del_init_rcu(&mn->hlist);
>  =09}
> -=09spin_unlock(&mm->mmu_notifier_mm->lock);
> +=09spin_unlock(&mmn_mm->lock);
>  =09srcu_read_unlock(&srcu, id);
> =20
>  =09/*
> @@ -100,6 +341,17 @@ void __mmu_notifier_release(struct mm_struct *mm)
>  =09synchronize_srcu(&srcu);
>  }
> =20
> +void __mmu_notifier_release(struct mm_struct *mm)
> +{
> +=09struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
> +
> +=09if (mmn_mm->has_interval)
> +=09=09mn_itree_release(mmn_mm, mm);
> +
> +=09if (!hlist_empty(&mmn_mm->list))
> +=09=09mn_hlist_release(mmn_mm, mm);
> +}
> +
>  /*
>   * If no young bitflag is supported by the hardware, ->clear_flush_young=
 can
>   * unmap the address and return 1 or 0 depending if the mapping previous=
ly
> @@ -172,14 +424,41 @@ void __mmu_notifier_change_pte(struct mm_struct *mm=
, unsigned long address,
>  =09srcu_read_unlock(&srcu, id);
>  }
> =20
> -int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *ran=
ge)
> +static int mn_itree_invalidate(struct mmu_notifier_mm *mmn_mm,
> +=09=09=09=09     const struct mmu_notifier_range *range)
> +{
> +=09struct mmu_range_notifier *mrn;
> +=09unsigned long cur_seq;
> +
> +=09for (mrn =3D mn_itree_inv_start_range(mmn_mm, range, &cur_seq); mrn;
> +=09     mrn =3D mn_itree_inv_next(mrn, range)) {
> +=09=09bool ret;
> +
> +=09=09WRITE_ONCE(mrn->invalidate_seq, cur_seq);
> +=09=09ret =3D mrn->ops->invalidate(mrn, range);
> +=09=09if (!ret && !WARN_ON(mmu_notifier_range_blockable(range)))

Isn't the logic wrong here ? We want to warn if the range
was mark as blockable and invalidate returned false. Also
we went to backoff no matter what if the invalidate return
false ie:
    if (!ret) {
        WARN_ON(mmu_notifier_range_blockable(range)))
        goto out_would_block;
    }


> +=09=09=09goto out_would_block;
> +=09}
> +=09return 0;
> +
> +out_would_block:
> +=09/*
> +=09 * On -EAGAIN the non-blocking caller is not allowed to call
> +=09 * invalidate_range_end()
> +=09 */
> +=09mn_itree_inv_end(mmn_mm);
> +=09return -EAGAIN;
> +}
> +
> +static int mn_hlist_invalidate_range_start(struct mmu_notifier_mm *mmn_m=
m,
> +=09=09=09=09=09   struct mmu_notifier_range *range)
>  {
>  =09struct mmu_notifier *mn;
>  =09int ret =3D 0;
>  =09int id;
> =20
>  =09id =3D srcu_read_lock(&srcu);
> -=09hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist=
) {
> +=09hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist) {
>  =09=09if (mn->ops->invalidate_range_start) {
>  =09=09=09int _ret;
> =20
> @@ -203,15 +482,30 @@ int __mmu_notifier_invalidate_range_start(struct mm=
u_notifier_range *range)
>  =09return ret;
>  }
> =20
> -void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *rang=
e,
> -=09=09=09=09=09 bool only_end)
> +int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *ran=
ge)
> +{
> +=09struct mmu_notifier_mm *mmn_mm =3D range->mm->mmu_notifier_mm;
> +=09int ret =3D 0;
> +
> +=09if (mmn_mm->has_interval) {
> +=09=09ret =3D mn_itree_invalidate(mmn_mm, range);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +=09if (!hlist_empty(&mmn_mm->list))
> +=09=09return mn_hlist_invalidate_range_start(mmn_mm, range);
> +=09return 0;
> +}
> +
> +static void mn_hlist_invalidate_end(struct mmu_notifier_mm *mmn_mm,
> +=09=09=09=09    struct mmu_notifier_range *range,
> +=09=09=09=09    bool only_end)
>  {
>  =09struct mmu_notifier *mn;
>  =09int id;
> =20
> -=09lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>  =09id =3D srcu_read_lock(&srcu);
> -=09hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist=
) {
> +=09hlist_for_each_entry_rcu(mn, &mmn_mm->list, hlist) {
>  =09=09/*
>  =09=09 * Call invalidate_range here too to avoid the need for the
>  =09=09 * subsystem of having to register an invalidate_range_end
> @@ -238,6 +532,19 @@ void __mmu_notifier_invalidate_range_end(struct mmu_=
notifier_range *range,
>  =09=09}
>  =09}
>  =09srcu_read_unlock(&srcu, id);
> +}
> +
> +void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *rang=
e,
> +=09=09=09=09=09 bool only_end)
> +{
> +=09struct mmu_notifier_mm *mmn_mm =3D range->mm->mmu_notifier_mm;
> +
> +=09lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +=09if (mmn_mm->has_interval)
> +=09=09mn_itree_inv_end(mmn_mm);
> +
> +=09if (!hlist_empty(&mmn_mm->list))
> +=09=09mn_hlist_invalidate_end(mmn_mm, range, only_end);
>  =09lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  }
> =20
> @@ -256,8 +563,9 @@ void __mmu_notifier_invalidate_range(struct mm_struct=
 *mm,
>  }
> =20
>  /*
> - * Same as mmu_notifier_register but here the caller must hold the
> - * mmap_sem in write mode.
> + * Same as mmu_notifier_register but here the caller must hold the mmap_=
sem in
> + * write mode. A NULL mn signals the notifier is being registered for it=
ree
> + * mode.
>   */
>  int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *m=
m)
>  {
> @@ -274,9 +582,6 @@ int __mmu_notifier_register(struct mmu_notifier *mn, =
struct mm_struct *mm)
>  =09=09fs_reclaim_release(GFP_KERNEL);
>  =09}
> =20
> -=09mn->mm =3D mm;
> -=09mn->users =3D 1;
> -
>  =09if (!mm->mmu_notifier_mm) {
>  =09=09/*
>  =09=09 * kmalloc cannot be called under mm_take_all_locks(), but we
> @@ -284,21 +589,22 @@ int __mmu_notifier_register(struct mmu_notifier *mn=
, struct mm_struct *mm)
>  =09=09 * the write side of the mmap_sem.
>  =09=09 */
>  =09=09mmu_notifier_mm =3D
> -=09=09=09kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
> +=09=09=09kzalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
>  =09=09if (!mmu_notifier_mm)
>  =09=09=09return -ENOMEM;
> =20
>  =09=09INIT_HLIST_HEAD(&mmu_notifier_mm->list);
>  =09=09spin_lock_init(&mmu_notifier_mm->lock);
> +=09=09mmu_notifier_mm->invalidate_seq =3D 2;

Why starting at 2 ?

> +=09=09mmu_notifier_mm->itree =3D RB_ROOT_CACHED;
> +=09=09init_waitqueue_head(&mmu_notifier_mm->wq);
> +=09=09INIT_HLIST_HEAD(&mmu_notifier_mm->deferred_list);
>  =09}
> =20
>  =09ret =3D mm_take_all_locks(mm);
>  =09if (unlikely(ret))
>  =09=09goto out_clean;
> =20
> -=09/* Pairs with the mmdrop in mmu_notifier_unregister_* */
> -=09mmgrab(mm);
> -
>  =09/*
>  =09 * Serialize the update against mmu_notifier_unregister. A
>  =09 * side note: mmu_notifier_release can't run concurrently with
> @@ -306,13 +612,26 @@ int __mmu_notifier_register(struct mmu_notifier *mn=
, struct mm_struct *mm)
>  =09 * current->mm or explicitly with get_task_mm() or similar).
>  =09 * We can't race against any other mmu notifier method either
>  =09 * thanks to mm_take_all_locks().
> +=09 *
> +=09 * release semantics are provided for users not inside a lock covered
> +=09 * by mm_take_all_locks(). acquire can only be used while holding the
> +=09 * mmgrab or mmget, and is safe because once created the
> +=09 * mmu_notififer_mm is not freed until the mm is destroyed.
>  =09 */
>  =09if (mmu_notifier_mm)
> -=09=09mm->mmu_notifier_mm =3D mmu_notifier_mm;
> +=09=09smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);

I do not understand why you need the release semantics here, we
are under the mmap_sem in write mode when we release it the lock
barrier will make sure anyone else sees the new mmu_notifier_mm

I fail to see the benefit or need for release/acquire semantics
here.

> =20
> -=09spin_lock(&mm->mmu_notifier_mm->lock);
> -=09hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
> -=09spin_unlock(&mm->mmu_notifier_mm->lock);
> +=09if (mn) {
> +=09=09/* Pairs with the mmdrop in mmu_notifier_unregister_* */
> +=09=09mmgrab(mm);
> +=09=09mn->mm =3D mm;
> +=09=09mn->users =3D 1;
> +
> +=09=09spin_lock(&mm->mmu_notifier_mm->lock);
> +=09=09hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
> +=09=09spin_unlock(&mm->mmu_notifier_mm->lock);
> +=09} else
> +=09=09mm->mmu_notifier_mm->has_interval =3D true;
> =20
>  =09mm_drop_all_locks(mm);
>  =09BUG_ON(atomic_read(&mm->mm_users) <=3D 0);
> @@ -529,6 +848,166 @@ void mmu_notifier_put(struct mmu_notifier *mn)
>  }
>  EXPORT_SYMBOL_GPL(mmu_notifier_put);
> =20
> +static int __mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +=09=09=09=09       unsigned long start,
> +=09=09=09=09       unsigned long length,
> +=09=09=09=09       struct mmu_notifier_mm *mmn_mm,
> +=09=09=09=09       struct mm_struct *mm)
> +{
> +=09mrn->mm =3D mm;
> +=09RB_CLEAR_NODE(&mrn->interval_tree.rb);
> +=09mrn->interval_tree.start =3D start;
> +=09/*
> +=09 * Note that the representation of the intervals in the interval tree
> +=09 * considers the ending point as contained in the interval.
> +=09 */
> +=09if (length =3D=3D 0 ||
> +=09    check_add_overflow(start, length - 1, &mrn->interval_tree.last))
> +=09=09return -EOVERFLOW;
> +
> +=09/* pairs with mmdrop in mmu_range_notifier_remove() */
> +=09mmgrab(mm);
> +
> +=09/*
> +=09 * If some invalidate_range_start/end region is going on in parallel
> +=09 * we don't know what VA ranges are affected, so we must assume this
> +=09 * new range is included.
> +=09 *
> +=09 * If the itree is invalidating then we are not allowed to change
> +=09 * it. Retrying until invalidation is done is tricky due to the
> +=09 * possibility for live lock, instead defer the add to the unlock so
> +=09 * this algorithm is deterministic.
> +=09 *
> +=09 * In all cases the value for the mrn->mr_invalidate_seq should be
> +=09 * odd, see mmu_range_read_begin()
> +=09 */
> +=09spin_lock(&mmn_mm->lock);
> +=09if (mmn_mm->active_invalidate_ranges) {
> +=09=09if (mn_itree_is_invalidating(mmn_mm))
> +=09=09=09hlist_add_head(&mrn->deferred_item,
> +=09=09=09=09       &mmn_mm->deferred_list);
> +=09=09else {
> +=09=09=09mmn_mm->invalidate_seq |=3D 1;
> +=09=09=09interval_tree_insert(&mrn->interval_tree,
> +=09=09=09=09=09     &mmn_mm->itree);
> +=09=09}
> +=09=09mrn->invalidate_seq =3D mmn_mm->invalidate_seq;
> +=09} else {
> +=09=09WARN_ON(mn_itree_is_invalidating(mmn_mm));
> +=09=09mrn->invalidate_seq =3D mmn_mm->invalidate_seq - 1;
> +=09=09interval_tree_insert(&mrn->interval_tree, &mmn_mm->itree);
> +=09}
> +=09spin_unlock(&mmn_mm->lock);
> +=09return 0;
> +}
> +
> +/**
> + * mmu_range_notifier_insert - Insert a range notifier
> + * @mrn: Range notifier to register
> + * @start: Starting virtual address to monitor
> + * @length: Length of the range to monitor
> + * @mm : mm_struct to attach to
> + *
> + * This function subscribes the range notifier for notifications from th=
e mm.
> + * Upon return the ops related to mmu_range_notifier will be called when=
ever
> + * an event that intersects with the given range occurs.
> + *
> + * Upon return the range_notifier may not be present in the interval tre=
e yet.
> + * The caller must use the normal range notifier locking flow via
> + * mmu_range_read_begin() to establish SPTEs for this range.
> + */
> +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> +=09=09=09      unsigned long start, unsigned long length,
> +=09=09=09      struct mm_struct *mm)
> +{
> +=09struct mmu_notifier_mm *mmn_mm;
> +=09int ret;
> +
> +=09might_lock(&mm->mmap_sem);
> +
> +=09mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);
> +=09if (!mmn_mm || !mmn_mm->has_interval) {
> +=09=09ret =3D mmu_notifier_register(NULL, mm);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09mmn_mm =3D mm->mmu_notifier_mm;
> +=09}
> +=09return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm);
> +}
> +EXPORT_SYMBOL_GPL(mmu_range_notifier_insert);
> +
> +int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
> +=09=09=09=09     unsigned long start, unsigned long length,
> +=09=09=09=09     struct mm_struct *mm)
> +{
> +=09struct mmu_notifier_mm *mmn_mm;
> +=09int ret;
> +
> +=09lockdep_assert_held_write(&mm->mmap_sem);
> +
> +=09mmn_mm =3D mm->mmu_notifier_mm;

Shouldn't you be using smp_load_acquire() ?

> +=09if (!mmn_mm || !mmn_mm->has_interval) {
> +=09=09ret =3D __mmu_notifier_register(NULL, mm);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09mmn_mm =3D mm->mmu_notifier_mm;
> +=09}
> +=09return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm);
> +}
> +EXPORT_SYMBOL_GPL(mmu_range_notifier_insert_locked);
> +
> +/**
> + * mmu_range_notifier_remove - Remove a range notifier
> + * @mrn: Range notifier to unregister
> + *
> + * This function must be paired with mmu_range_notifier_insert(). It can=
not be
> + * called from any ops callback.
> + *
> + * Once this returns ops callbacks are no longer running on other CPUs a=
nd
> + * will not be called in future.
> + */
> +void mmu_range_notifier_remove(struct mmu_range_notifier *mrn)
> +{
> +=09struct mm_struct *mm =3D mrn->mm;
> +=09struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
> +=09unsigned long seq =3D 0;
> +
> +=09might_sleep();
> +
> +=09spin_lock(&mmn_mm->lock);
> +=09if (mn_itree_is_invalidating(mmn_mm)) {
> +=09=09/*
> +=09=09 * remove is being called after insert put this on the
> +=09=09 * deferred list, but before the deferred list was processed.
> +=09=09 */
> +=09=09if (RB_EMPTY_NODE(&mrn->interval_tree.rb)) {
> +=09=09=09hlist_del(&mrn->deferred_item);
> +=09=09} else {
> +=09=09=09hlist_add_head(&mrn->deferred_item,
> +=09=09=09=09       &mmn_mm->deferred_list);
> +=09=09=09seq =3D mmn_mm->invalidate_seq;
> +=09=09}
> +=09} else {
> +=09=09WARN_ON(RB_EMPTY_NODE(&mrn->interval_tree.rb));
> +=09=09interval_tree_remove(&mrn->interval_tree, &mmn_mm->itree);
> +=09}
> +=09spin_unlock(&mmn_mm->lock);
> +
> +=09/*
> +=09 * The possible sleep on progress in the invalidation requires the
> +=09 * caller not hold any locks held by invalidation callbacks.
> +=09 */
> +=09lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +=09lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +=09if (seq)
> +=09=09wait_event(mmn_mm->wq,
> +=09=09=09   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
> +
> +=09/* pairs with mmgrab in mmu_range_notifier_insert() */
> +=09mmdrop(mm);
> +}
> +EXPORT_SYMBOL_GPL(mmu_range_notifier_remove);
> +
>  /**
>   * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
>   *
> --=20
> 2.23.0
>=20

