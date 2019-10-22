Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26151E0AB3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfJVRac (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:30:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57982 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729871AbfJVRac (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571765431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hja+8CQpeSbgjIWMZTaNmrI9G8eDm+mI1+cLwA0u7HU=;
        b=gGpsnAgyZoNahi9DbdpsXxOPGhRiUyNFYvykG4qFz+UzOd3QT1bkqkRCxTsvD7hvi+hm2W
        z2xZMMN3BXStEixTKuzGfb3qdaXt80CtxsbMEx4IQpczhKPrgFHuA6eQFn/yaNZQE5VBqu
        FXTZJI0RzCofRuSwQhYWhCG/n0N+7gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-ZgP-4WlTNbK_iZxgtkRT9Q-1; Tue, 22 Oct 2019 13:30:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8580F80183D;
        Tue, 22 Oct 2019 17:30:28 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4F22608A5;
        Tue, 22 Oct 2019 17:30:27 +0000 (UTC)
Date:   Tue, 22 Oct 2019 13:30:26 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191022173026.GB5169@redhat.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com>
 <20191022150514.GH22766@mellanox.com>
 <20191022170631.GA4805@redhat.com>
 <20191022170916.GL22766@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191022170916.GL22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZgP-4WlTNbK_iZxgtkRT9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 05:09:19PM +0000, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2019 at 01:06:31PM -0400, Jerome Glisse wrote:
>=20
> > > > That is fine, the device driver should not do anything with it ie
> > > > if the device driver wanted to write then the write fault test
> > > > would return true and it would fault.
> > > >=20
> > > > Note that driver should not dereference the struct page.
> > >=20
> > > Can this thing be dma mapped for read?
> > >=20
> >=20
> > Yes it can, the zero page is just a regular page (AFAIK on all
> > architecture). So device can dma map it for read only, there is
> > no reason to treat it any differently.
> >=20
> > The HMM_PTE_SPECIAL is only (as documented in the header) for
> > pte insert with insert_pfn or insert_page ie pte inserted in
> > vma with MIXED or PFNMAP flag. While HMM catch those vma early
> > on and backof it can still race with some driver setting the vma
> > flag and installing special pte afterward hence why special pte
> > goes through this special path.
> >=20
> > The zero page being a special pte is just an exception ie it
> > is the only special pte allowed in vma that do not have MIXED or
> > PFNMAP flag set.
>=20
> Just to be clear then, the correct behavior is to return the zero page
> pfn as a HMM_PFN_VALID and the driver should treat it the same as any
> memory page and dma map it?

Yes correct.

>=20
> Smart drivers can test somehow for pfn =3D=3D zero_page and optimize?

There is nothing to optimize here, i do not know any hardware that
have a special page table entry that make all memory access return
zero.

What was confusing in Ralph commit message is that he was conflating
the memory migration, which is a totaly different code path, with
that code. When doing memory migration it is easy to program the DMA
engine to zero out destination memory (common feature found on various
devices) and that optimization is allowed by the migrate code.

So i can not think of any reason why distinguishing the zero page in
this code would help. Maybe i missed some new feature in the mmu of
some new hardware.

Cheers,
J=E9r=F4me

