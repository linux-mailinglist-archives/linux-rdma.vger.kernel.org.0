Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84B1DF52A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfJUSd6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:33:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUSd6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 14:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571682836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heW2STh0qsJgZQvznrhVwfeqG1lZ93qzWcMlIpNclqY=;
        b=NMIrdim2wSElkPN7ugALfUU3qGT4OlL3msnNxLZmTtZD2JB0W+NvdMF3i8x5SoRLvvOntL
        ef0lbRAdIA3/IfM16JxhfKWivUGM6ANomxZ502QWBxC/+ePwb3noQvcyzx4gGTeiDohRt0
        k6Ol3nj7Li+vwOMJ8VBGsq8LYHNOgiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-_AN48j-3OTqbMRy9HXQccA-1; Mon, 21 Oct 2019 14:33:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261C280183E;
        Mon, 21 Oct 2019 18:33:54 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AECD60161;
        Mon, 21 Oct 2019 18:33:53 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:33:51 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 03/15] mm/hmm: allow hmm_range to be used with a
 mmu_range_notifier or hmm_mirror
Message-ID: <20191021183351.GD3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-4-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-4-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _AN48j-3OTqbMRy9HXQccA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:30PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> hmm_mirror's handling of ranges does not use a sequence count which
> results in this bug:
>=20
>          CPU0                                   CPU1
>                                      hmm_range_wait_until_valid(range)
>                                          valid =3D=3D true
>                                      hmm_range_fault(range)
> hmm_invalidate_range_start()
>    range->valid =3D false
> hmm_invalidate_range_end()
>    range->valid =3D true
>                                      hmm_range_valid(range)
>                                           valid =3D=3D true
>=20
> Where the hmm_range_valid should not have succeeded.
>=20
> Adding the required sequence count would make it nearly identical to the
> new mmu_range_notifier. Instead replace the hmm_mirror stuff with
> mmu_range_notifier.
>=20
> Co-existence of the two APIs is the first step.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

> ---
>  include/linux/hmm.h |  5 +++++
>  mm/hmm.c            | 25 +++++++++++++++++++------
>  2 files changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 3fec513b9c00f1..8ac1fd6a81af8f 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -145,6 +145,9 @@ enum hmm_pfn_value_e {
>  /*
>   * struct hmm_range - track invalidation lock on virtual address range
>   *
> + * @notifier: an optional mmu_range_notifier
> + * @notifier_seq: when notifier is used this is the result of
> + *                mmu_range_read_begin()
>   * @hmm: the core HMM structure this range is active against
>   * @vma: the vm area struct for the range
>   * @list: all range lock are on a list
> @@ -159,6 +162,8 @@ enum hmm_pfn_value_e {
>   * @valid: pfns array did not change since it has been fill by an HMM fu=
nction
>   */
>  struct hmm_range {
> +=09struct mmu_range_notifier *notifier;
> +=09unsigned long=09=09notifier_seq;
>  =09struct hmm=09=09*hmm;
>  =09struct list_head=09list;
>  =09unsigned long=09=09start;
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 902f5fa6bf93ad..22ac3595771feb 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -852,6 +852,14 @@ void hmm_range_unregister(struct hmm_range *range)
>  }
>  EXPORT_SYMBOL(hmm_range_unregister);
> =20
> +static bool needs_retry(struct hmm_range *range)
> +{
> +=09if (range->notifier)
> +=09=09return mmu_range_check_retry(range->notifier,
> +=09=09=09=09=09     range->notifier_seq);
> +=09return !range->valid;
> +}
> +
>  static const struct mm_walk_ops hmm_walk_ops =3D {
>  =09.pud_entry=09=3D hmm_vma_walk_pud,
>  =09.pmd_entry=09=3D hmm_vma_walk_pmd,
> @@ -892,18 +900,23 @@ long hmm_range_fault(struct hmm_range *range, unsig=
ned int flags)
>  =09const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>  =09unsigned long start =3D range->start, end;
>  =09struct hmm_vma_walk hmm_vma_walk;
> -=09struct hmm *hmm =3D range->hmm;
> +=09struct mm_struct *mm;
>  =09struct vm_area_struct *vma;
>  =09int ret;
> =20
> -=09lockdep_assert_held(&hmm->mmu_notifier.mm->mmap_sem);
> +=09if (range->notifier)
> +=09=09mm =3D range->notifier->mm;
> +=09else
> +=09=09mm =3D range->hmm->mmu_notifier.mm;
> +
> +=09lockdep_assert_held(&mm->mmap_sem);
> =20
>  =09do {
>  =09=09/* If range is no longer valid force retry. */
> -=09=09if (!range->valid)
> +=09=09if (needs_retry(range))
>  =09=09=09return -EBUSY;
> =20
> -=09=09vma =3D find_vma(hmm->mmu_notifier.mm, start);
> +=09=09vma =3D find_vma(mm, start);
>  =09=09if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
>  =09=09=09return -EFAULT;
> =20
> @@ -933,7 +946,7 @@ long hmm_range_fault(struct hmm_range *range, unsigne=
d int flags)
>  =09=09=09start =3D hmm_vma_walk.last;
> =20
>  =09=09=09/* Keep trying while the range is valid. */
> -=09=09} while (ret =3D=3D -EBUSY && range->valid);
> +=09=09} while (ret =3D=3D -EBUSY && !needs_retry(range));
> =20
>  =09=09if (ret) {
>  =09=09=09unsigned long i;
> @@ -991,7 +1004,7 @@ long hmm_range_dma_map(struct hmm_range *range, stru=
ct device *device,
>  =09=09=09continue;
> =20
>  =09=09/* Check if range is being invalidated */
> -=09=09if (!range->valid) {
> +=09=09if (needs_retry(range)) {
>  =09=09=09ret =3D -EBUSY;
>  =09=09=09goto unmap;
>  =09=09}
> --=20
> 2.23.0
>=20

