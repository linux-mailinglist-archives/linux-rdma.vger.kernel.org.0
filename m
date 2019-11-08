Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC66DF3DCC
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 03:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKHCAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 21:00:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58323 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbfKHCAy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 21:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573178452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmaB2CyqCtOYzlfv/kbgamUkAPvC2mHzu/cckynz8S8=;
        b=G4poe+r/wEa/NSI3+U0S5UlSzP+df7vM9qlOZYeRK0WOxB7kKfwnGpTCFfLPQJgl+kUchP
        tCjadp06C5KGcRAMFN5gC1np4W2oKJTguDVVwEpBkwOt2ul482h7OD2u2kNJf+8U65/Z24
        U8zFsJxJFR7YC3Qk9oH4+Z1n3JvCIbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-qWlwQnQQOJmU_alVVJU2pA-1; Thu, 07 Nov 2019 21:00:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2891800D7B;
        Fri,  8 Nov 2019 02:00:40 +0000 (UTC)
Received: from redhat.com (ovpn-122-19.rdu2.redhat.com [10.10.122.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5B6B600D3;
        Fri,  8 Nov 2019 02:00:36 +0000 (UTC)
Date:   Thu, 7 Nov 2019 21:00:34 -0500
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
Message-ID: <20191108020034.GA470884@redhat.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com>
 <20191107201102.GC21728@mellanox.com>
 <20191107210408.GA4716@redhat.com>
 <20191108003219.GD21728@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191108003219.GD21728@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qWlwQnQQOJmU_alVVJU2pA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 08, 2019 at 12:32:25AM +0000, Jason Gunthorpe wrote:
> On Thu, Nov 07, 2019 at 04:04:08PM -0500, Jerome Glisse wrote:
> > On Thu, Nov 07, 2019 at 08:11:06PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Nov 06, 2019 at 09:08:07PM -0500, Jerome Glisse wrote:
> > >=20
> > > > >=20
> > > > > Extra credit: IMHO, this clearly deserves to all be in a new mmu_=
range_notifier.h
> > > > > header file, but I know that's extra work. Maybe later as a follo=
w-up patch,
> > > > > if anyone has the time.
> > > >=20
> > > > The range notifier should get the event too, it would be a waste, i=
 think it is
> > > > an oversight here. The release event is fine so NAK to you separate=
 event. Event
> > > > is really an helper for notifier i had a set of patch for nouveau t=
o leverage
> > > > this i need to resucite them. So no need to split thing, i would ju=
st forward
> > > > the event ie add event to mmu_range_notifier_ops.invalidate() i fai=
led to catch
> > > > that in v1 sorry.
> > >=20
> > > I think what you mean is already done?
> > >=20
> > > struct mmu_range_notifier_ops {
> > > =09bool (*invalidate)(struct mmu_range_notifier *mrn,
> > > =09=09=09   const struct mmu_notifier_range *range,
> > > =09=09=09   unsigned long cur_seq);
> >=20
> > Yes it is sorry, i got confuse with mmu_range_notifier and mmu_notifier=
_range :)
> > It is almost a palyndrome structure ;)
>=20
> Lets change the name then, this is clearly not working. I'll reflow
> everything tomorrow

Semantic patch to do that run from your linux kernel directory with your pa=
tch
applied (you can run it one patch after the other and the git commit -a --f=
ixup HEAD)

spatch --sp-file name-of-the-file-below --dir . --all-includes --in-place

%< ------------------------------------------------------------------
@@
@@
struct
-mmu_range_notifier
+mmu_interval_notifier

@@
@@
struct
-mmu_range_notifier
+mmu_interval_notifier
{...};

// Change mrn name to mmu_in
@@
struct mmu_interval_notifier *mrn;
@@
-mrn
+mmu_in

@@
identifier fn;
@@
fn(...,=20
-struct mmu_interval_notifier *mrn,
+struct mmu_interval_notifier *mmu_in,
...) {...}
------------------------------------------------------------------ >%

You need coccinelle (which provides spatch). It is untested but it should w=
ork
also i could not come up with a nice name to update mrn as min is way too
confusing. If you have better name feel free to use it.

Oh and coccinelle is pretty clever about code formating so it should do a g=
ood
jobs at keeping things nicely formated and align.

Cheers,
J=E9r=F4me

