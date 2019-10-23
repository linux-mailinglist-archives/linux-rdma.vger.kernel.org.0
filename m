Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11372E248B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJWU0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:26:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfJWU0X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 16:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571862381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1XeLbQwzCck5Lma54SyUL7NHxZOnECT3DsLOWtBh4k=;
        b=flLdISb/pLQJ0TRAqBSa1m3RAYv04lBBYV4NjaKYxYdXmPi1gpyKN+bEe/XAR8Bu1Oppyu
        mesM6VI4bkJcoUCAc6kDo9rBvBANy5tMwiBNlfzYYVdBo/5Q04KNz3AZnL2zNMAQPb9DXs
        9I8NYjuvwyGPwFE79GWfyY0+9b6gPLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Mi54ZwgNMmyd4SWvphQ_uA-1; Wed, 23 Oct 2019 16:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D3C800D5A;
        Wed, 23 Oct 2019 20:26:17 +0000 (UTC)
Received: from redhat.com (ovpn-123-188.rdu2.redhat.com [10.10.123.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A79610027A4;
        Wed, 23 Oct 2019 20:26:15 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:26:13 -0400
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
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191023202539.GA3200@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191021184041.GF3177@redhat.com>
 <20191021190556.GI6285@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191021190556.GI6285@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Mi54ZwgNMmyd4SWvphQ_uA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 07:06:00PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 02:40:41PM -0400, Jerome Glisse wrote:
> > On Tue, Oct 15, 2019 at 03:12:27PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >=20
> > > 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, h=
fi1,
> > > scif_dma, vhost, gntdev, hmm) drivers are using a common pattern wher=
e
> > > they only use invalidate_range_start/end and immediately check the
> > > invalidating range against some driver data structure to tell if the
> > > driver is interested. Half of them use an interval_tree, the others a=
re
> > > simple linear search lists.
> > >=20
> > > Of the ones I checked they largely seem to have various kinds of race=
s,
> > > bugs and poor implementation. This is a result of the complexity in h=
ow
> > > the notifier interacts with get_user_pages(). It is extremely difficu=
lt to
> > > use it correctly.
> > >=20
> > > Consolidate all of this code together into the core mmu_notifier and
> > > provide a locking scheme similar to hmm_mirror that allows the user t=
o
> > > safely use get_user_pages() and reliably know if the page list still
> > > matches the mm.
> > >=20
> > > This new arrangment plays nicely with the !blockable mode for
> > > OOM. Scanning the interval tree is done such that the intersection te=
st
> > > will always succeed, and since there is no invalidate_range_end expos=
ed to
> > > drivers the scheme safely allows multiple drivers to be subscribed.
> > >=20
> > > Four places are converted as an example of how the new API is used.
> > > Four are left for future patches:
> > >  - i915_gem has complex locking around destruction of a registration,
> > >    needs more study
> > >  - hfi1 (2nd user) needs access to the rbtree
> > >  - scif_dma has a complicated logic flow
> > >  - vhost's mmu notifiers are already being rewritten
> > >=20
> > > This is still being tested, but I figured to send it to start getting=
 help
> > > from the xen, amd and hfi drivers which I cannot test here.
> >=20
> > It might be a good oportunity to also switch those users to
> > hmm_range_fault() instead of GUP as GUP is pointless for those
> > users. In fact the GUP is an impediment to normal mm operations.
>=20
> I think vhost can use hmm_range_fault
>=20
> hfi1 does actually need to have the page pin, it doesn't fence DMA
> during invalidate.
>=20
> i915_gem feels alot like amdgpu, so probably it would benefit
>=20
> No idea about scif_dma
>=20
> > I will test on nouveau.
>=20
> Thanks, hopefully it still works, I think Ralph was able to do some
> basic checks. But it is a pretty complicated series, I probably made
> some mistakes.

So it seems to work ok with nouveau, will let tests run in loop thought
there are not very advance test.

>=20
> FWIW, I know that nouveau gets a lockdep splat now from Daniel
> Vetter's recent changes, it tries to do GFP_KERENEL allocations under
> a lock also held by the invalidate_range_start path.

I have not seen any splat so far, is it throught some new kernel config ?

Cheers,
J=E9r=F4me

