Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B109DE2107
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfJWQwc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 12:52:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbfJWQwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 12:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571849551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GanjAE8HfQ8qzFKCa/r64Dq3fD+/mSUc5zOx+PGr8eg=;
        b=CFbPw7ge1cEfd6zfruWiTMMy1isjVe5aniMuB2kfrzSzWWSiM1kr1RJglVlo13tsECdgZh
        EKhvt4LjbYskVdW2l7zOLJZzbDfU+YUn53o6VsV55X+eR2eoyXvd2oGmomU2SxYCs7jF/l
        UBY1iGuNiC8Mp5RzMD3i8zQ06GTYJ54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-kiwu8J-9MZWZX-y3vAa-XQ-1; Wed, 23 Oct 2019 12:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D64580183E;
        Wed, 23 Oct 2019 16:52:26 +0000 (UTC)
Received: from redhat.com (ovpn-124-105.rdu2.redhat.com [10.10.124.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 258D660126;
        Wed, 23 Oct 2019 16:52:25 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:52:23 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     christian.koenig@amd.com
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191023165223.GA4163@redhat.com>
References: <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
 <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
MIME-Version: 1.0
In-Reply-To: <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kiwu8J-9MZWZX-y3vAa-XQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 11:32:16AM +0200, Christian K=F6nig wrote:
> Am 23.10.19 um 11:08 schrieb Daniel Vetter:
> > On Tue, Oct 22, 2019 at 03:01:13PM +0000, Jason Gunthorpe wrote:
> > > On Tue, Oct 22, 2019 at 09:57:35AM +0200, Daniel Vetter wrote:
> > >=20
> > > > > The unusual bit in all of this is using a lock's critical region =
to
> > > > > 'protect' data for read, but updating that same data before the l=
ock's
> > > > > critical secion. ie relying on the unlock barrier to 'release' pr=
ogram
> > > > > ordered stores done before the lock's own critical region, and th=
e
> > > > > lock side barrier to 'acquire' those stores.
> > > > I think this unusual use of locks as barriers for other unlocked ac=
cesses
> > > > deserves comments even more than just normal barriers. Can you pls =
add
> > > > them? I think the design seeems sound ...
> > > >=20
> > > > Also the comment on the driver's lock hopefully prevents driver
> > > > maintainers from moving the driver_lock around in a way that would =
very
> > > > subtle break the scheme, so I think having the acquire barrier comm=
ented
> > > > in each place would be really good.
> > > There is already a lot of documentation, I think it would be helpful
> > > if you could suggest some specific places where you think an addition
> > > would help? I think the perspective of someone less familiar with thi=
s
> > > design would really improve the documentation
> > Hm I just meant the usual recommendation that "barriers must have comme=
nts
> > explaining what they order, and where the other side of the barrier is"=
.
> > Using unlock/lock as a barrier imo just makes that an even better idea.
> > Usually what I do is something like "we need to order $this against $th=
at
> > below, and the other side of this barrier is in function()." With maybe=
 a
> > bit more if it's not obvious how things go wrong if the orderin is brok=
en.
> >=20
> > Ofc seqlock.h itself skimps on that rule and doesn't bother explaining =
its
> > barriers :-/
> >=20
> > > I've been tempted to force the driver to store the seq number directl=
y
> > > under the driver lock - this makes the scheme much clearer, ie
> > > something like this:
> > >=20
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/=
nouveau/nouveau_svm.c
> > > index 712c99918551bc..738fa670dcfb19 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > > @@ -488,7 +488,8 @@ struct svm_notifier {
> > >   };
> > >   static bool nouveau_svm_range_invalidate(struct mmu_range_notifier =
*mrn,
> > > -                                        const struct mmu_notifier_ra=
nge *range)
> > > +                                        const struct mmu_notifier_ra=
nge *range,
> > > +                                        unsigned long seq)
> > >   {
> > >          struct svm_notifier *sn =3D
> > >                  container_of(mrn, struct svm_notifier, notifier);
> > > @@ -504,6 +505,7 @@ static bool nouveau_svm_range_invalidate(struct m=
mu_range_notifier *mrn,
> > >                  mutex_lock(&sn->svmm->mutex);
> > >          else if (!mutex_trylock(&sn->svmm->mutex))
> > >                  return false;
> > > +       mmu_range_notifier_update_seq(mrn, seq);
> > >          mutex_unlock(&sn->svmm->mutex);
> > >          return true;
> > >   }
> > >=20
> > >=20
> > > At the cost of making the driver a bit more complex, what do you
> > > think?
> > Hm, spinning this further ... could we initialize the mmu range notifie=
r
> > with a pointer to the driver lock, so that we could put a
> > lockdep_assert_held into mmu_range_notifier_update_seq? I think that wo=
uld
> > make this scheme substantially more driver-hacker proof :-)
>=20
> Going another step further.... what hinders us to put the lock into the m=
mu
> range notifier itself and have _lock()/_unlock() helpers?
>=20
> I mean having the lock in the driver only makes sense when the driver wou=
ld
> be using the same lock for multiple things, e.g. multiple MMU range
> notifiers under the same lock. But I really don't see that use case here.

I actualy do, nouveau use one lock to protect the page table and that's the
lock that matter. You can have multiple range for a single page table, idea
being only a sub-set of the process address space is ever accessed by the
GPU and those it is better to focus on this sub-set and track invalidation =
in
a finer grain.

Cheers,
J=E9r=F4me

