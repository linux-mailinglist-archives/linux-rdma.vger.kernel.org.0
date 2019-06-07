Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785193990A
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGWjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:39:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9316 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfFGWjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 18:39:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfae78d0001>; Fri, 07 Jun 2019 15:39:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 15:39:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 15:39:09 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 22:39:07 +0000
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an argument
 for hmm_range_register
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <4a391bd4-287c-5f13-3bca-c6a46ff8d08c@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e460ddf5-9ed3-7f3b-98ce-526c12fdb8b1@nvidia.com>
Date:   Fri, 7 Jun 2019 15:39:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <4a391bd4-287c-5f13-3bca-c6a46ff8d08c@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559947149; bh=eTTUWJi61h5qqJA3yxmX9O8Uva/UfogeyAnkiaxrKMg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JpoOI2cBmdaAZidTMJPSl0KSbBKE2o4ZRJdWcugT6orV5WnAe0KdsGUXOGpuQQ0LW
         m7osQ9wOTTxkmKPKnK09Qt6i7dn5T367HVSBBLDJRoRQ7Kv6a6+9l3TYvyZkc1q+gh
         4iqORp/qQZBmwO9Sei+lW8GghFirA8MA1f3bJCPvu7DgLJKRDaPmRAYgVijn5AoCWW
         eWmt1e0vAgP9gCIK2Fla2A3qItjGNnCi2Nm61BH0eUNToknBTqap9RPaibIW3jMXVv
         6xmNjJCmplZWRUsIbaXUsE5WEblrvAbyzB1lMSir10Ioo7ikCAQ90cZ2QC7TFVg1Su
         wkEP7XsQ0osAA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/19 11:24 AM, Ralph Campbell wrote:
>=20
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
>> From: Jason Gunthorpe <jgg@mellanox.com>
>>
>> Ralph observes that hmm_range_register() can only be called by a driver
>> while a mirror is registered. Make this clear in the API by passing in=20
>> the
>> mirror structure as a parameter.
>>
>> This also simplifies understanding the lifetime model for struct hmm, as
>> the hmm pointer must be valid as part of a registered mirror so all we
>> need in hmm_register_range() is a simple kref_get.
>>
>> Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> You might CC Ben for the nouveau part.
> CC: Ben Skeggs <bskeggs@redhat.com>
>=20
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
>=20
>=20
>> ---
>> v2
>> - Include the oneline patch to nouveau_svm.c
>> ---
>> =C2=A0 drivers/gpu/drm/nouveau/nouveau_svm.c |=C2=A0 2 +-
>> =C2=A0 include/linux/hmm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +=
+++---
>> =C2=A0 mm/hmm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++---------
>> =C2=A0 3 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c=20
>> b/drivers/gpu/drm/nouveau/nouveau_svm.c
>> index 93ed43c413f0bb..8c92374afcf227 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
>> @@ -649,7 +649,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range.values =3D =
nouveau_svm_pfn_values;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range.pfn_shift =
=3D NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>> =C2=A0 again:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hmm_vma_fault(&range=
, true);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hmm_vma_fault(&svmm-=
>mirror, &range, true);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mutex_lock(&svmm->mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!hmm_vma_range_done(&range)) {
>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>> index 688c5ca7068795..2d519797cb134a 100644
>> --- a/include/linux/hmm.h
>> +++ b/include/linux/hmm.h
>> @@ -505,7 +505,7 @@ static inline bool hmm_mirror_mm_is_alive(struct=20
>> hmm_mirror *mirror)
>> =C2=A0=C2=A0 * Please see Documentation/vm/hmm.rst for how to use the ra=
nge API.
>> =C2=A0=C2=A0 */
>> =C2=A0 int hmm_range_register(struct hmm_range *range,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct hmm_mirror *mirror,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long end,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned page_shift);
>> @@ -541,7 +541,8 @@ static inline bool hmm_vma_range_done(struct=20
>> hmm_range *range)
>> =C2=A0 }
>> =C2=A0 /* This is a temporary helper to avoid merge conflict between tre=
es. */
>> -static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>> +static inline int hmm_vma_fault(struct hmm_mirror *mirror,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct hmm_range *range, bool block)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long ret;
>> @@ -554,7 +555,7 @@ static inline int hmm_vma_fault(struct hmm_range=20
>> *range, bool block)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->default_flags =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->pfn_flags_mask =3D -1UL;
>> -=C2=A0=C2=A0=C2=A0 ret =3D hmm_range_register(range, range->vma->vm_mm,
>> +=C2=A0=C2=A0=C2=A0 ret =3D hmm_range_register(range, mirror,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->start, range->end,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 547002f56a163d..8796447299023c 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -925,13 +925,13 @@ static void hmm_pfns_clear(struct hmm_range *range=
,
>> =C2=A0=C2=A0 * Track updates to the CPU page table see include/linux/hmm=
.h
>> =C2=A0=C2=A0 */
>> =C2=A0 int hmm_range_register(struct hmm_range *range,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct mm_struct *mm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct hmm_mirror *mirror,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long end,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned page_shift)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mask =3D ((1UL << page_shif=
t) - 1UL);
>> -=C2=A0=C2=A0=C2=A0 struct hmm *hmm;
>> +=C2=A0=C2=A0=C2=A0 struct hmm *hmm =3D mirror->hmm;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->valid =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->hmm =3D NULL;
>> @@ -945,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->start =3D start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range->end =3D end;
>> -=C2=A0=C2=A0=C2=A0 hmm =3D hmm_get_or_create(mm);
>> -=C2=A0=C2=A0=C2=A0 if (!hmm)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if hmm_mm_destroy() was call. */
>> -=C2=A0=C2=A0=C2=A0 if (hmm->mm =3D=3D NULL || hmm->dead) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hmm_put(hmm);
>> +=C2=A0=C2=A0=C2=A0 if (hmm->mm =3D=3D NULL || hmm->dead)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> -=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 range->hmm =3D hmm;
>> +=C2=A0=C2=A0=C2=A0 kref_get(&hmm->kref);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Initialize range to track CPU page tab=
le updates. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&hmm->lock);
>>

I forgot to add that I think you can delete the duplicate
     "range->hmm =3D hmm;"
here between the mutex_lock/unlock.
