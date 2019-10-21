Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B749DDF5BC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfJUTMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:12:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32685 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbfJUTMH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 15:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571685125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkpSHvtoZdBJ93HK32BxiBlNAsoJFLpFKE8eiNsK3LE=;
        b=XoviMv8Ki8LkN/Jhz6UXYkxfSQthg4DBnTDSYrWmY6FPFQY/ttcubKjIPT2rkWtMhFjvgs
        Fyh+qdoYYxecryolwJcEf0xjaB/xlO/2uTW/fwAOBuULArgeY4oMUorcjIGsDTJ6V4qBnQ
        8D7k5WaGBmxLQ2hPu+z6OL7fO1+ms+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-UXHEnR14P7SpLJiLYXvamA-1; Mon, 21 Oct 2019 15:12:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 606B047B;
        Mon, 21 Oct 2019 19:12:00 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 153B060856;
        Mon, 21 Oct 2019 19:11:59 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:11:57 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191021191157.GA5208@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
 <20191021183056.GA3177@redhat.com>
 <20191021185421.GG6285@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191021185421.GG6285@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UXHEnR14P7SpLJiLYXvamA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 06:54:25PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 02:30:56PM -0400, Jerome Glisse wrote:
>=20
> > > +/**
> > > + * mmu_range_read_retry - End a read side critical section against a=
 VA range
> > > + * mrn: The range under lock
> > > + * seq: The return of the paired mmu_range_read_begin()
> > > + *
> > > + * This MUST be called under a user provided lock that is also held
> > > + * unconditionally by op->invalidate(). That lock provides the requi=
red SMP
> > > + * barrier for handling invalidate_seq.
> > > + *
> > > + * Each call should be paired with a single mmu_range_read_begin() a=
nd
> > > + * should be used to conclude the read side.
> > > + *
> > > + * Returns true if an invalidation collided with this critical secti=
on, and
> > > + * the caller should retry.
> > > + */
> > > +static inline bool mmu_range_read_retry(struct mmu_range_notifier *m=
rn,
> > > +=09=09=09=09=09unsigned long seq)
> > > +{
> > > +=09return READ_ONCE(mrn->invalidate_seq) !=3D seq;
> > > +}
> >=20
> > What about calling this mmu_range_read_end() instead ? To match
> > with the mmu_range_read_begin().
>=20
> _end make some sense too, but I picked _retry for symmetry with the
> seqcount_* family of functions which used retry.
>=20
> I think retry makes it clearer that it is expected to fail and retry
> is required.

Fair enough.

>=20
> > > +=09/*
> > > +=09 * The inv_end incorporates a deferred mechanism like rtnl. Adds =
and
> >=20
> > The rtnl reference is lost on people unfamiliar with the network :)
> > code maybe like rtnl_lock()/rtnl_unlock() so people have a chance to
> > grep the right function. Assuming i am myself getting the right
> > reference :)
>=20
> Yep, you got it, I will update
>=20
> > > +=09/*
> > > +=09 * mrn->invalidate_seq is always set to an odd value. This ensure=
s
> > > +=09 * that if seq does wrap we will always clear the below sleep in =
some
> > > +=09 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> > > +=09 * state.
> >=20
> > I think this comment should be with the struct mmu_range_notifier
> > definition and you should just point to it from here as the same
> > comment would be useful down below.
>=20
> I had it here because it is critical to understanding the wait_event
> and why it doesn't just block indefinitely, but yes this property
> comes up below too which refers back here.
>=20
> Fundamentally this wait event is why this approach to keep an odd
> value in the mrn is used.

The comment is fine, it is just i read the patch out of order and
in insert function i was pondering on why it must be odd while the
explanation was here. It is more a taste thing, i prefer comments
about this to be part of the struct definition comments so that
multiple place can refer to the same struct definition it is more
resiliant to code change as struct definition is always easy to
find and thus reference to it can be sprinkle all over where it is
necessary.


>=20
> > > -int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range =
*range)
> > > +static int mn_itree_invalidate(struct mmu_notifier_mm *mmn_mm,
> > > +=09=09=09=09     const struct mmu_notifier_range *range)
> > > +{
> > > +=09struct mmu_range_notifier *mrn;
> > > +=09unsigned long cur_seq;
> > > +
> > > +=09for (mrn =3D mn_itree_inv_start_range(mmn_mm, range, &cur_seq); m=
rn;
> > > +=09     mrn =3D mn_itree_inv_next(mrn, range)) {
> > > +=09=09bool ret;
> > > +
> > > +=09=09WRITE_ONCE(mrn->invalidate_seq, cur_seq);
> > > +=09=09ret =3D mrn->ops->invalidate(mrn, range);
> > > +=09=09if (!ret && !WARN_ON(mmu_notifier_range_blockable(range)))
> >=20
> > Isn't the logic wrong here ? We want to warn if the range
> > was mark as blockable and invalidate returned false. Also
> > we went to backoff no matter what if the invalidate return
> > false ie:
>=20
> If invalidate returned false and the caller is blockable then we do
> not want to return, we must continue processing other ranges - to try
> to cope with the defective driver.
>=20
> Callers in blocking mode ignore the return value and go ahead to
> invalidate..
>=20
> Would it be clearer as=20
>=20
> if (!ret) {
>    if (WARN_ON(mmu_notifier_range_blockable(range)))
>        continue;
>    goto out_would_block;
> }
>=20
> ?

Yes look clearer to me at least.

>=20
> > > @@ -284,21 +589,22 @@ int __mmu_notifier_register(struct mmu_notifier=
 *mn, struct mm_struct *mm)
> > >  =09=09 * the write side of the mmap_sem.
> > >  =09=09 */
> > >  =09=09mmu_notifier_mm =3D
> > > -=09=09=09kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
> > > +=09=09=09kzalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
> > >  =09=09if (!mmu_notifier_mm)
> > >  =09=09=09return -ENOMEM;
> > > =20
> > >  =09=09INIT_HLIST_HEAD(&mmu_notifier_mm->list);
> > >  =09=09spin_lock_init(&mmu_notifier_mm->lock);
> > > +=09=09mmu_notifier_mm->invalidate_seq =3D 2;
> >=20
> > Why starting at 2 ?
>=20
> Good question. If everything is coded properly the starting value
> doesn't matter
>=20
> I left it like this because it makes debugging a tiny bit simpler, ie
> if you print the seq number then the first mmu_range_notififers will
> get 1 as their intial seq (see __mmu_range_notifier_insert) instead of
> ULONG_MAX

Yeah make sense.

>=20
> > > +=09=09mmu_notifier_mm->itree =3D RB_ROOT_CACHED;
> > > +=09=09init_waitqueue_head(&mmu_notifier_mm->wq);
> > > +=09=09INIT_HLIST_HEAD(&mmu_notifier_mm->deferred_list);
> > >  =09}
> > > =20
> > >  =09ret =3D mm_take_all_locks(mm);
> > >  =09if (unlikely(ret))
> > >  =09=09goto out_clean;
> > > =20
> > > -=09/* Pairs with the mmdrop in mmu_notifier_unregister_* */
> > > -=09mmgrab(mm);
> > > -
> > >  =09/*
> > >  =09 * Serialize the update against mmu_notifier_unregister. A
> > >  =09 * side note: mmu_notifier_release can't run concurrently with
> > > @@ -306,13 +612,26 @@ int __mmu_notifier_register(struct mmu_notifier=
 *mn, struct mm_struct *mm)
> > >  =09 * current->mm or explicitly with get_task_mm() or similar).
> > >  =09 * We can't race against any other mmu notifier method either
> > >  =09 * thanks to mm_take_all_locks().
> > > +=09 *
> > > +=09 * release semantics are provided for users not inside a lock cov=
ered
> > > +=09 * by mm_take_all_locks(). acquire can only be used while holding=
 the
> > > +=09 * mmgrab or mmget, and is safe because once created the
> > > +=09 * mmu_notififer_mm is not freed until the mm is destroyed.
> > >  =09 */
> > >  =09if (mmu_notifier_mm)
> > > -=09=09mm->mmu_notifier_mm =3D mmu_notifier_mm;
> > > +=09=09smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);
> >=20
> > I do not understand why you need the release semantics here, we
> > are under the mmap_sem in write mode when we release it the lock
> > barrier will make sure anyone else sees the new mmu_notifier_mm
>=20
> It pairs with the smp_load_acquire() in mmu_range_notifier_insert()
> which is not called with the mmap_sem held.=20
>=20
> Since that reader is not locked we need release semantics here to
> ensure the unlocked reader sees a fully initinalized mmu_notifier_mm
> structure when it observes the pointer.

I thought the mm_take_all_locks() would have had a barrier and thus
that you could not see mmu_notifier struct partialy initialized. But
having the acquire/release as safety net does not hurt. Maybe add a
comment about the struct initialization needing to be visible before
pointer is set.

>=20
> > > +/**
> > > + * mmu_range_notifier_insert - Insert a range notifier
> > > + * @mrn: Range notifier to register
> > > + * @start: Starting virtual address to monitor
> > > + * @length: Length of the range to monitor
> > > + * @mm : mm_struct to attach to
> > > + *
> > > + * This function subscribes the range notifier for notifications fro=
m the mm.
> > > + * Upon return the ops related to mmu_range_notifier will be called =
whenever
> > > + * an event that intersects with the given range occurs.
> > > + *
> > > + * Upon return the range_notifier may not be present in the interval=
 tree yet.
> > > + * The caller must use the normal range notifier locking flow via
> > > + * mmu_range_read_begin() to establish SPTEs for this range.
> > > + */
> > > +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
> > > +=09=09=09      unsigned long start, unsigned long length,
> > > +=09=09=09      struct mm_struct *mm)
> > > +{
> > > +=09struct mmu_notifier_mm *mmn_mm;
> > > +=09int ret;
> > > +
> > > +=09might_lock(&mm->mmap_sem);
> > > +
> > > +=09mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);
>=20
> Right here we don't have the mmap_sem so this load is unlocked.
>=20
> If we observe !mmn_mm we must also observe all stores done to set it
> up. Ie we have to observe the spin_lock_init, RB_ROOT_CACHED/etc
>=20
> > > +=09if (!mmn_mm || !mmn_mm->has_interval) {
> > > +=09=09ret =3D mmu_notifier_register(NULL, mm);
> > > +=09=09if (ret)
> > > +=09=09=09return ret;
> > > +=09=09mmn_mm =3D mm->mmu_notifier_mm;
> > > +=09}
> > > +=09return __mmu_range_notifier_insert(mrn, start, length, mmn_mm, mm=
);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mmu_range_notifier_insert);
> > > +
> > > +int mmu_range_notifier_insert_locked(struct mmu_range_notifier *mrn,
> > > +=09=09=09=09     unsigned long start, unsigned long length,
> > > +=09=09=09=09     struct mm_struct *mm)
> > > +{
> > > +=09struct mmu_notifier_mm *mmn_mm;
> > > +=09int ret;
> > > +
> > > +=09lockdep_assert_held_write(&mm->mmap_sem);
> > > +
> > > +=09mmn_mm =3D mm->mmu_notifier_mm;
> >=20
> > Shouldn't you be using smp_load_acquire() ?
>=20
> This function is called while holding the mmap_sem. As you noted above
> all writers to mm->mmu_notifier_mm hold the write side of mmap_sem,
> thus here the read side is fully locked and doesn't need the acquire.
>=20
> Note the lockdep annotations marking the expected locking enviroment
> for the two functions.

Yes i thought you had the acquire/release for some other reason
than struct init. It is fine here to not use the load_acquire.

Cheers,
J=E9r=F4me

