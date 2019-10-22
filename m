Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616A8E0A0D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfJVRGn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:06:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732316AbfJVRGn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 13:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571764001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pziuiR3USf+QYOjB5TUqNYl6I5zkv1vS1NLbzCx5qr0=;
        b=Jkx5ej7pToZQm/GGB/iNh8lj0TUA8vNikRWNf6TwiE0DetZQ+cN35mqkT+eLVuQHtI9PCf
        XPHBDcZ2rLwjdMUl2CHrHZnddUEPwCP3DQW7TxGBm5vK5xMj/VwLFfWJ4LPX8mAVw2hHov
        g79byH7Y7PTGWeSU5Z6GCWGyDsCOYwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ltazWoUfNh2VJ_Uoq4ToMQ-1; Tue, 22 Oct 2019 13:06:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F26E61005509;
        Tue, 22 Oct 2019 17:06:33 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5A05D6A9;
        Tue, 22 Oct 2019 17:06:33 +0000 (UTC)
Date:   Tue, 22 Oct 2019 13:06:31 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191022170631.GA4805@redhat.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com>
 <20191022150514.GH22766@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191022150514.GH22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ltazWoUfNh2VJ_Uoq4ToMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 03:05:18PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 10:45:49PM -0400, Jerome Glisse wrote:
> > On Mon, Oct 21, 2019 at 01:54:15PM -0700, Ralph Campbell wrote:
> > >=20
> > > On 10/21/19 11:49 AM, Jerome Glisse wrote:
> > > > On Tue, Oct 15, 2019 at 01:48:13PM -0700, Ralph Campbell wrote:
> > > > > Allow hmm_range_fault() to return success (0) when the CPU pageta=
ble
> > > > > entry points to the special shared zero page.
> > > > > The caller can then handle the zero page by possibly clearing dev=
ice
> > > > > private memory instead of DMAing a zero page.
> > > >=20
> > > > I do not understand why you are talking about DMA. GPU can work
> > > > on main memory and migrating to GPU memory is optional and should
> > > > not involve this function at all.
> > >=20
> > > Good point. This is the device accessing the zero page over PCIe
> > > or another bus, not migrating a zero page to device private memory.
> > > I'll update the wording.
> > >=20
> > > > >=20
> > > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
> > > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > >=20
> > > > NAK please keep semantic or change it fully. See the alternative
> > > > below.
> > > >=20
> > > > >   mm/hmm.c | 4 +++-
> > > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/mm/hmm.c b/mm/hmm.c
> > > > > index 5df0dbf77e89..f62b119722a3 100644
> > > > > +++ b/mm/hmm.c
> > > > > @@ -530,7 +530,9 @@ static int hmm_vma_handle_pte(struct mm_walk =
*walk, unsigned long addr,
> > > > >   =09=09=09return -EBUSY;
> > > > >   =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_sp=
ecial(pte)) {
> > > > >   =09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> > > > > -=09=09return -EFAULT;
> > > > > +=09=09if (!is_zero_pfn(pte_pfn(pte)))
> > > > > +=09=09=09return -EFAULT;
> > > > > +=09=09return 0;
> > > >=20
> > > > An acceptable change would be to turn the branch into:
> > > > =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_specia=
l(pte)) {
> > > > =09=09if (!is_zero_pfn(pte_pfn(pte))) {
> > > > =09=09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> > > > =09=09=09return -EFAULT;
> > > > =09=09}
> > > > =09=09/* Fall-through for zero pfn (if write was needed the above
> > > > =09=09 * hmm_pte_need_faul() would had catched it).
> > > > =09=09 */
> > > > =09}
> > > >=20
> > >=20
> > > Except this will return the zero pfn with no indication that it is sp=
ecial
> > > (i.e., doesn't have a struct page).
> >=20
> > That is fine, the device driver should not do anything with it ie
> > if the device driver wanted to write then the write fault test
> > would return true and it would fault.
> >=20
> > Note that driver should not dereference the struct page.
>=20
> Can this thing be dma mapped for read?
>=20

Yes it can, the zero page is just a regular page (AFAIK on all
architecture). So device can dma map it for read only, there is
no reason to treat it any differently.

The HMM_PTE_SPECIAL is only (as documented in the header) for
pte insert with insert_pfn or insert_page ie pte inserted in
vma with MIXED or PFNMAP flag. While HMM catch those vma early
on and backof it can still race with some driver setting the vma
flag and installing special pte afterward hence why special pte
goes through this special path.

The zero page being a special pte is just an exception ie it
is the only special pte allowed in vma that do not have MIXED or
PFNMAP flag set.

Cheers,
J=E9r=F4me

