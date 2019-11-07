Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED4F3A06
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 22:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKGVEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 16:04:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27738 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfKGVEY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 16:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573160663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/OUHbhjqmo/2b88pcHR1Lly3F7Wmo3w1j9CIvENsK0=;
        b=NDeEeK3qbUyoAUkRsr3UXwzZV5PS5ToJzW06SWyKnMFjiacGhE9K+j2OldUN0lnFI+t/pn
        Do4hh5UQ+2NCgavjXOZkVM7bMp0SB787fiVF6dEmkNGpr+9Jx061HIyc5kPc2D8geB846j
        zDNlIya1I86FWfqYL8qiz9AUG1ORDN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-5mTC5mxRONi9JJNT1c4IYQ-1; Thu, 07 Nov 2019 16:04:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08CED1005500;
        Thu,  7 Nov 2019 21:04:14 +0000 (UTC)
Received: from redhat.com (ovpn-122-19.rdu2.redhat.com [10.10.122.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E81285C548;
        Thu,  7 Nov 2019 21:04:10 +0000 (UTC)
Date:   Thu, 7 Nov 2019 16:04:08 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191107210408.GA4716@redhat.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com>
 <20191107201102.GC21728@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191107201102.GC21728@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5mTC5mxRONi9JJNT1c4IYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 08:11:06PM +0000, Jason Gunthorpe wrote:
> On Wed, Nov 06, 2019 at 09:08:07PM -0500, Jerome Glisse wrote:
>=20
> > >=20
> > > Extra credit: IMHO, this clearly deserves to all be in a new mmu_rang=
e_notifier.h
> > > header file, but I know that's extra work. Maybe later as a follow-up=
 patch,
> > > if anyone has the time.
> >=20
> > The range notifier should get the event too, it would be a waste, i thi=
nk it is
> > an oversight here. The release event is fine so NAK to you separate eve=
nt. Event
> > is really an helper for notifier i had a set of patch for nouveau to le=
verage
> > this i need to resucite them. So no need to split thing, i would just f=
orward
> > the event ie add event to mmu_range_notifier_ops.invalidate() i failed =
to catch
> > that in v1 sorry.
>=20
> I think what you mean is already done?
>=20
> struct mmu_range_notifier_ops {
> =09bool (*invalidate)(struct mmu_range_notifier *mrn,
> =09=09=09   const struct mmu_notifier_range *range,
> =09=09=09   unsigned long cur_seq);

Yes it is sorry, i got confuse with mmu_range_notifier and mmu_notifier_ran=
ge :)
It is almost a palyndrome structure ;)

>=20
> > No it is always odd, you must call mmu_range_set_seq() only from the
> > op->invalidate_range() callback at which point the seq is odd. As well
> > when mrn is added and its seq first set it is set to an odd value
> > always. Maybe the comment, should read:
> >=20
> >  * mrn->invalidate_seq is always, yes always, set to an odd value. This=
 ensures
> >=20
> > To stress that it is not an error.
>=20
> I went with this:
>=20
> =09/*
> =09 * mrn->invalidate_seq must always be set to an odd value via
> =09 * mmu_range_set_seq() using the provided cur_seq from
> =09 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
> =09 * will always clear the below sleep in some reasonable time as
> =09 * mmn_mm->invalidate_seq is even in the idle state.
> =09 */

Yes fine with me.

[...]

> > > > +=09might_lock(&mm->mmap_sem);
> > > > +
> > > > +=09mmn_mm =3D smp_load_acquire(&mm->mmu_notifier_mm);
> > >=20
> > > What does the above pair with? Should have a comment that specifies t=
hat.
> >=20
> > It was discussed in v1 but maybe a comment of what was said back then w=
ould
> > be helpful. Something like:
> >=20
> > /*
> >  * We need to insure that all writes to mm->mmu_notifier_mm are visible=
 before
> >  * any checks we do on mmn_mm below as otherwise CPU might re-order wri=
te done
> >  * by another CPU core to mm->mmu_notifier_mm structure fields after th=
e read
> >  * belows.
> >  */
>=20
> This comment made it, just at the store side:
>=20
> =09/*
> =09 * Serialize the update against mmu_notifier_unregister. A
> =09 * side note: mmu_notifier_release can't run concurrently with
> =09 * us because we hold the mm_users pin (either implicitly as
> =09 * current->mm or explicitly with get_task_mm() or similar).
> =09 * We can't race against any other mmu notifier method either
> =09 * thanks to mm_take_all_locks().
> =09 *
> =09 * release semantics on the initialization of the mmu_notifier_mm's
>          * contents are provided for unlocked readers.  acquire can only =
be
>          * used while holding the mmgrab or mmget, and is safe because on=
ce
>          * created the mmu_notififer_mm is not freed until the mm is
>          * destroyed.  As above, users holding the mmap_sem or one of the
>          * mm_take_all_locks() do not need to use acquire semantics.
> =09 */
> =09if (mmu_notifier_mm)
> =09=09smp_store_release(&mm->mmu_notifier_mm, mmu_notifier_mm);
>=20
> Which I think is really overly belaboring the typical smp
> store/release pattern, but people do seem unfamiliar with them...

Perfect with me. I think also sometimes you forgot what memory model is
and thus store/release pattern do, i know i do and i need to refresh my
mind.

Cheers,
J=E9r=F4me

