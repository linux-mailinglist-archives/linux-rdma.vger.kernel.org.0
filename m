Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9951784B7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgCCVPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 16:15:24 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2192 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgCCVPX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 16:15:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5ec8c20000>; Tue, 03 Mar 2020 13:14:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 13:15:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Mar 2020 13:15:23 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 21:15:21 +0000
Subject: Re: [PATCH v2] nouveau/hmm: map pages after migration
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200303010023.2983-1-rcampbell@nvidia.com>
 <20200303124229.GH26318@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <1f27ac9e-7ddf-6e4f-25ea-063ef6c78761@nvidia.com>
Date:   Tue, 3 Mar 2020 13:15:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200303124229.GH26318@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583270082; bh=22wphWyEQ9kA/NT134DIsydKvoJeEto8s37Q83fcwtM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I3g3W9bniGHs2rCu0yfLWPfwG56cNXGXLhCicraDzGKkb8e8gDWo+Z8OzaNStF2hu
         y3pYgrOQBhye2JydvTdoCV80OZvDgk5j81+ak7Zq2hHmG07zCQUH2Df5BLAaJajL0C
         Xjb7yXcjyaBSRn+6ANiN9Cocmi4gH/WT0MKD7iDsS9f5EEQMqToUxA3wTmt8msDvmf
         7qHk5rrgkRKLNqpsboRa/an6DDqsJ7qWGmLT8mf5YdHQB93cIuMlydQHqkNU3rvTY6
         rhVXu0wQdLr/wATCoZe0XCmCGMZN2smS+n55V57w4wiyJiOnxXbX34fiMJ6MTiG68I
         ocqAAhJ0YEmjQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/3/20 4:42 AM, Jason Gunthorpe wrote:
> On Mon, Mar 02, 2020 at 05:00:23PM -0800, Ralph Campbell wrote:
>> When memory is migrated to the GPU, it is likely to be accessed by GPU
>> code soon afterwards. Instead of waiting for a GPU fault, map the
>> migrated memory into the GPU page tables with the same access permission=
s
>> as the source CPU page table entries. This preserves copy on write
>> semantics.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Ben Skeggs <bskeggs@redhat.com>
>> ---
>>
>> Originally this patch was targeted for Jason's rdma tree since other HMM
>> related changes were queued there. Now that those have been merged, this
>> patch just contains changes to nouveau so it could go through any tree.
>> I guess Ben Skeggs' tree would be appropriate.
>=20
> Yep
>=20
>> +static inline struct nouveau_pfnmap_args *
>> +nouveau_pfns_to_args(void *pfns)
>=20
> don't use static inline inside C files

OK.

>> +{
>> +	struct nvif_vmm_pfnmap_v0 *p =3D
>> +		container_of(pfns, struct nvif_vmm_pfnmap_v0, phys);
>> +
>> +	return container_of(p, struct nouveau_pfnmap_args, p);
>=20
> And this should just be
>=20
>     return container_of(pfns, struct nouveau_pfnmap_args, p.phys);

Much simpler, thanks.

>> +static struct nouveau_svmm *
>> +nouveau_find_svmm(struct nouveau_svm *svm, struct mm_struct *mm)
>> +{
>> +	struct nouveau_ivmm *ivmm;
>> +
>> +	list_for_each_entry(ivmm, &svm->inst, head) {
>> +		if (ivmm->svmm->notifier.mm =3D=3D mm)
>> +			return ivmm->svmm;
>> +	}
>> +	return NULL;
>> +}
>=20
> Is this re-implementing mmu_notifier_get() ?
>=20
> Jason

Not quite. This is being called from an ioctl() call on the GPU device
file which calls nouveau_svmm_bind() which locks mmap_sem for reading,
walks the vmas for the address range given in the ioctl() data, and migrate=
s
the pages to the GPU memory.
mmu_notifier_get() would try to lock mmap_sem for writing so that would dea=
dlock.
But it is similar in that the GPU specific process context (nouveau_svmm) n=
eeds
to be found for the given ioctl caller.
If find_get_mmu_notifier() was exported, I think that could work.
Now that I look at this again, there is an easier way to find the svmm and =
I see
some other bugs that need fixing. I'll post a v3 as soon as I get those wri=
tten
and tested.

Thanks for the review.
