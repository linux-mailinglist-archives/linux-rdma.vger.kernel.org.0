Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC83ADF55E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJUStg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:49:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbfJUStg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571683774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP1P9UhUXceFYbStwykFgcLAqeDXxnCtLtdnWFR9K0w=;
        b=bJGF1YutkbS/9mKUy9/yNoBJD5772g65A+XBTc/7d44qRE49gfoCCsRAr5qyDKhpNNZijO
        d8S0dohuq/eN4QGgt2QQYye4fbb6p7t4BTXc9RAySlwTq0EzEAeNlABQQRAEVMDMttnRM/
        +lAEZUrMTejNaO6FOYy2eRH4BeuttHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-utNYNCAeOAO3iAhlIrJ7QA-1; Mon, 21 Oct 2019 14:49:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 227695E4;
        Mon, 21 Oct 2019 18:49:30 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F67619C58;
        Mon, 21 Oct 2019 18:49:29 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:49:27 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191021184927.GG3177@redhat.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191015204814.30099-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: utNYNCAeOAO3iAhlIrJ7QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 01:48:13PM -0700, Ralph Campbell wrote:
> Allow hmm_range_fault() to return success (0) when the CPU pagetable
> entry points to the special shared zero page.
> The caller can then handle the zero page by possibly clearing device
> private memory instead of DMAing a zero page.

I do not understand why you are talking about DMA. GPU can work
on main memory and migrating to GPU memory is optional and should
not involve this function at all.

>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>

NAK please keep semantic or change it fully. See the alternative
below.

> ---
>  mm/hmm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 5df0dbf77e89..f62b119722a3 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -530,7 +530,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, u=
nsigned long addr,
>  =09=09=09return -EBUSY;
>  =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte=
)) {
>  =09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> -=09=09return -EFAULT;
> +=09=09if (!is_zero_pfn(pte_pfn(pte)))
> +=09=09=09return -EFAULT;
> +=09=09return 0;

An acceptable change would be to turn the branch into:
=09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) =
{
=09=09if (!is_zero_pfn(pte_pfn(pte))) {
=09=09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
=09=09=09return -EFAULT;
=09=09}
=09=09/* Fall-through for zero pfn (if write was needed the above
=09=09 * hmm_pte_need_faul() would had catched it).
=09=09 */
=09}

