Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C12E2D49
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438520AbfJXJ2I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 05:28:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732786AbfJXJ2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 05:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571909286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9dNaWZFvEiSUa55212d7slKnI+HVQ3BVmxEOBRsr1U=;
        b=VXUlETGLLd9SjxcW49Do6W/KQJnuHKIzphfhQxNWsPWkJ9zw1f2PK4JgER8PvY17OxvpRQ
        CvVLBQu6ke0LahtfsvM3Kf6AnfDEshgaJ33oX+DWzLiG2z7iIVpulTkt51/8H/oDVqt1Kj
        cY1YMMuDm3vQgo3jvAgPJclq31FIZQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-nEUoEaZKMTa4qHT9O5AAOA-1; Thu, 24 Oct 2019 05:28:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEC6180183D;
        Thu, 24 Oct 2019 09:28:01 +0000 (UTC)
Received: from [10.36.117.225] (ovpn-117-225.ams2.redhat.com [10.36.117.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59D865C1B5;
        Thu, 24 Oct 2019 09:28:00 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] mm/hmm: allow snapshot of the special zero page
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-3-rcampbell@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8e051e7f-fb41-4026-cc55-45eee85f8829@redhat.com>
Date:   Thu, 24 Oct 2019 11:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023195515.13168-3-rcampbell@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nEUoEaZKMTa4qHT9O5AAOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 23.10.19 21:55, Ralph Campbell wrote:
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
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> ---
>   mm/hmm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index acf7a664b38c..8c96c9ddcae5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -529,8 +529,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>   =09=09if (unlikely(!hmm_vma_walk->pgmap))
>   =09=09=09return -EBUSY;
>   =09} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pt=
e)) {
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
>   =09}
>  =20
>   =09*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
>=20

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

