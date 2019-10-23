Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD33E2490
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfJWU1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 16:27:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37856 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729666AbfJWU1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 16:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA1KK0GA68TMyJuLjavNfk0zNyfM5GonFu0btvCFN7k=;
        b=ftn4bF3YXhLlqEtPkH6ViDyrg5OBbyL+9/8QBEkX5YXvNuPLebBvPASD5HBRs8wCci5Syw
        PtLeXtW6btELpfJ/J4TTKe1gINJJSKkU4gNgdDzXaotLW0ALulPjM3M7W0yYrlKnr2mmIb
        lpZaKTlrfJZ6jhI6w2wx4EXYDZJmio4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-IH5k8UgDOLW9tgjZyOyBTw-1; Wed, 23 Oct 2019 16:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8145EE;
        Wed, 23 Oct 2019 20:27:28 +0000 (UTC)
Received: from redhat.com (ovpn-123-188.rdu2.redhat.com [10.10.123.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B24EA600CC;
        Wed, 23 Oct 2019 20:27:27 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:27:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191023202725.GB3200@redhat.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-3-rcampbell@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191023195515.13168-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IH5k8UgDOLW9tgjZyOyBTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 12:55:14PM -0700, Ralph Campbell wrote:
> If a device driver like nouveau tries to use hmm_range_fault() to access
> the special shared zero page in system memory, hmm_range_fault() will
> return -EFAULT and kill the process.
> Allow hmm_range_fault() to return success (0) when the CPU pagetable
> entry points to the special shared zero page.
> page_to_pfn() and pfn_to_page() are defined on the zero page so just
> handle it like any other page.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>

Reviewed-by: "J=E9r=F4me Glisse" <jglisse@redhat.com>

> Cc: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  mm/hmm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index acf7a664b38c..8c96c9ddcae5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -529,8 +529,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>  =09=09if (unlikely(!hmm_vma_walk->pgmap))
>  =09=09=09return -EBUSY;
>  =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte=
)) {
> -=09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> -=09=09return -EFAULT;
> +=09=09if (!is_zero_pfn(pte_pfn(pte))) {
> +=09=09=09*pfn =3D range->values[HMM_PFN_SPECIAL];
> +=09=09=09return -EFAULT;
> +=09=09}
> +=09=09/*
> +=09=09 * Since each architecture defines a struct page for the zero
> +=09=09 * page, just fall through and treat it like a normal page.
> +=09=09 */
>  =09}
> =20
>  =09*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
> --=20
> 2.20.1
>=20

