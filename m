Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B2114456
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 17:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfLEQDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 11:03:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfLEQDe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 11:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575561813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHd+4w0V9iVfUn6tAMIGauQiWjLxMUn18cIdw9bXNzA=;
        b=NflRHuan3Ju5klAhlrEXMl70Z+Nt6vNMBsLB/ZlTnZy7JceiILsAOhCviPFhdXSSqDnFY+
        znBjHD49pobspjTV2Gvy9hls09bod4y5Lpdaf+9soOLkbbzCvVeg3tJd0lrnOLIF14d1eq
        A8b7o2Yj78jH44rp19PDzURgGwzS3iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-MoRTtIA4PDWwtQt6J_dX7Q-1; Thu, 05 Dec 2019 11:03:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E4D312A7E49;
        Thu,  5 Dec 2019 16:03:28 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC4D600D1;
        Thu,  5 Dec 2019 16:03:26 +0000 (UTC)
Date:   Thu, 5 Dec 2019 11:03:24 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull hmm changes
Message-ID: <20191205160324.GB5819@redhat.com>
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191203024206.GC5795@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MoRTtIA4PDWwtQt6J_dX7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 03, 2019 at 02:42:12AM +0000, Jason Gunthorpe wrote:
> On Sat, Nov 30, 2019 at 10:23:31AM -0800, Linus Torvalds wrote:
> > On Sat, Nov 30, 2019 at 10:03 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I'll try to figure the code out, but my initial reaction was "yeah,
> > > not in my VM".
> >=20
> > Why is it ok to sometimes do
> >=20
> >     WRITE_ONCE(mni->invalidate_seq, cur_seq);
> >=20
> > (to pair with the unlocked READ_ONCE), and sometimes then do
> >=20
> >     mni->invalidate_seq =3D mmn_mm->invalidate_seq;
> >=20
> > My initial guess was that latter is only done at initialization time,
> > but at least in one case it's done *after* the mni has been added to
> > the mmn_mm (oh, how I despise those names - I can only repeat: WTF?).
>=20
> Yes, the only occurrences are in the notifier_insert, under the
> spinlock. The one case where it is out of the natural order was to
> make the manipulation of seq a bit saner, but in all cases since the
> spinlock is held there is no way for another thread to get the pointer
> to the 'mmu_interval_notifier *' to do the unlocked read.
>=20
> Regarding the ugly names.. Naming has been really hard here because
> currently everything is a 'mmu notifier' and the natural abberviations
> from there are crummy. Here is the basic summary:
>=20
> struct mmu_notifier_mm (ie the mm->mmu_notifier_mm)
>    -> mmn_mm
> struct mm_struct=20
>    -> mm
> struct mmu_notifier (ie the user subscription to the mm_struct)
>    -> mn
> struct mmu_interval_notifier (the other kind of user subscription)
>    -> mni

What about "interval" the context should already tell people
it is related to mmu notifier and thus a notifier. I would
just remove the notifier suffix, this would match the below
range.

> struct mmu_notifier_range (ie the args to invalidate_range)
>    -> range

Yeah range as context should tell you it is related to mmu
notifier.

>=20
> I can send a patch to switch mmn_mm to mmu_notifier_mm, which is the
> only pre-existing name for this value. But IIRC, it is a somewhat ugly
> with long line wrapping. 'mni' is a pain, I have to reflect on that.
> (honesly, I dislike mmu_notififer_mm quite a lot too)
>=20
> I think it would be overall nicer with better names for the original
> structs. Perhaps:
>=20
>  mmn_* - MMU notifier prefix
>  mmn_state <- struct mmu_notifier_mm
>  mmn_subscription (mmn_sub) <- struct mmu_notifier
>  mmn_range_subscription (mmn_range_sub) <- struct mmu_interval_notifier
>  mmn_invalidate_desc <- struct mmu_notifier_range

This looks good.

>=20
> At least this is how I describe them in my mind..  This is a lot of
> churn, and spreads through many drivers. This is why I kept the names
> as-is and we ended up with the also quite bad 'mmu_interval_notifier'
>=20
> Maybe just switch mmu_notifier_mm for mmn_state and leave the drivers
> alone?
>=20
> Anyone on the CC list have advice?

Maybe we can do a semantic patch to do convertion and then Linus
can easily apply the patch by just re-running the coccinelle.

Cheers,
J=E9r=F4me

