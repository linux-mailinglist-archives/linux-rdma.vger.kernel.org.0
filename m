Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD97DFC01
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfJVCp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 22:45:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfJVCp6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 22:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdtkIFyiHAOI13mkQxpBz9LE01qOPeMsARcYeNx52wY=;
        b=IOiuglO4gwdNcqMP38KXEVqBDlWiF1DD+pki/jnwzNhHzYYHw+VzDHNRoRqEYh646m8npQ
        0IHRtSlTrlvnNOAMf2qnmyvfA4et7hRasIGF17pg2RI2eqGE76N1csB9o+QOq2on+WHCOJ
        mfjWih5P/5ZTw3OD52dlE19dJM7Bl/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-bD-UMq-nO-m9-vaopSnFJg-1; Mon, 21 Oct 2019 22:45:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBB580183E;
        Tue, 22 Oct 2019 02:45:52 +0000 (UTC)
Received: from redhat.com (ovpn-120-88.rdu2.redhat.com [10.10.120.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3578D60A35;
        Tue, 22 Oct 2019 02:45:51 +0000 (UTC)
Date:   Mon, 21 Oct 2019 22:45:49 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191022024549.GA4347@redhat.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bD-UMq-nO-m9-vaopSnFJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 01:54:15PM -0700, Ralph Campbell wrote:
>=20
> On 10/21/19 11:49 AM, Jerome Glisse wrote:
> > On Tue, Oct 15, 2019 at 01:48:13PM -0700, Ralph Campbell wrote:
> > > Allow hmm_range_fault() to return success (0) when the CPU pagetable
> > > entry points to the special shared zero page.
> > > The caller can then handle the zero page by possibly clearing device
> > > private memory instead of DMAing a zero page.
> >=20
> > I do not understand why you are talking about DMA. GPU can work
> > on main memory and migrating to GPU memory is optional and should
> > not involve this function at all.
>=20
> Good point. This is the device accessing the zero page over PCIe
> or another bus, not migrating a zero page to device private memory.
> I'll update the wording.
>=20
> > >=20
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > NAK please keep semantic or change it fully. See the alternative
> > below.
> >=20
> > > ---
> > >   mm/hmm.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/mm/hmm.c b/mm/hmm.c
> > > index 5df0dbf77e89..f62b119722a3 100644
> > > --- a/mm/hmm.c
> > > +++ b/mm/hmm.c
> > > @@ -530,7 +530,9 @@ static int hmm_vma_handle_pte(struct mm_walk *wal=
k, unsigned long addr,
> > >   =09=09=09return -EBUSY;
> > >   =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_specia=
l(pte)) {
> > >   =09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> > > -=09=09return -EFAULT;
> > > +=09=09if (!is_zero_pfn(pte_pfn(pte)))
> > > +=09=09=09return -EFAULT;
> > > +=09=09return 0;
> >=20
> > An acceptable change would be to turn the branch into:
> > =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pt=
e)) {
> > =09=09if (!is_zero_pfn(pte_pfn(pte))) {
> > =09=09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> > =09=09=09return -EFAULT;
> > =09=09}
> > =09=09/* Fall-through for zero pfn (if write was needed the above
> > =09=09 * hmm_pte_need_faul() would had catched it).
> > =09=09 */
> > =09}
> >=20
>=20
> Except this will return the zero pfn with no indication that it is specia=
l
> (i.e., doesn't have a struct page).

That is fine, the device driver should not do anything with it ie
if the device driver wanted to write then the write fault test
would return true and it would fault.

Note that driver should not dereference the struct page.

Cheers,
J=E9r=F4me

