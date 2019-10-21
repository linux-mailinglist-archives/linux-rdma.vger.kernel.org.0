Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF65DF67F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfJUUIV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:08:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8414 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUIV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 16:08:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dae10390003>; Mon, 21 Oct 2019 13:08:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 21 Oct 2019 13:08:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 21 Oct 2019 13:08:20 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 20:08:20 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 20:08:17 +0000
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021180836.GE6285@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <03961f82-bd03-796f-9cb6-aec38fbd958f@nvidia.com>
Date:   Mon, 21 Oct 2019 13:08:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021180836.GE6285@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571688505; bh=2ra+kt8z/5wxbafu2VhB01aluircmbMKWVVuX5PGlmU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iUI1dx780VmDYvtjTBFOpvQlvVfemhaGyZQ/I1OB2KeEzpkS8UBn73dKJNAmN8azl
         8erxjDAoMjivlarXss7KcPBkhXn6Kru+JRxt/LAPGr3A6sgeBDEjijtt16rTUqpB4C
         FNpfkYbdwbYKerTRCKJkgUOtpswS0RYguJR6EUiL2v4m5sEnUM1iWGouEeZ150Pb8T
         tAJ7Knwuw2REvtYG9V8jr9Ag5Q5winkJRj87vpEklBV53puFYR4vMTVlp+0grc0i4w
         eZnEhr8tz2sHqCykjD7DIlGcmIldGhO8rHn1Jf6TvYLtswcqs7dQIdvGaX4x3Kz9Dk
         SkAZkhyjmL44A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/21/19 11:08 AM, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2019 at 01:48:13PM -0700, Ralph Campbell wrote:
>> Allow hmm_range_fault() to return success (0) when the CPU pagetable
>> entry points to the special shared zero page.
>> The caller can then handle the zero page by possibly clearing device
>> private memory instead of DMAing a zero page.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>>   mm/hmm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 5df0dbf77e89..f62b119722a3 100644
>> +++ b/mm/hmm.c
>> @@ -530,7 +530,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>>   			return -EBUSY;
>>   	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte=
)) {
>>   		*pfn =3D range->values[HMM_PFN_SPECIAL];
>> -		return -EFAULT;
>> +		if (!is_zero_pfn(pte_pfn(pte)))
>> +			return -EFAULT;
>> +		return 0;
>=20
> Does it make sense to return HMM_PFN_SPECIAL in this case? Does the
> zero pfn have a struct page? Does it need mandatory special treatment?

The zero pfn does not have a struct page so it needs special treatment:
see nouveau_dmem_convert_pfn() where it calls hmm_device_entry_to_page().

If HMM ever ends up supporting VM_PFNMAP
there would need to be a way to distinguish pfns with and without a
backing struct page too.

> ie the base behavior without any driver code should be to dma from the
> zero memory. A fancy driver should be able to detect the zero and do
> something else.

Correct.

> I'm not clear what the two existing users do with PFN_SPECIAL? Nouveau
> looks like it is the same value as error, can't guess what amdgpu does
> with its magic constant
>=20
> Jason

I doubt the zero pfn case is being handled correctly in amd/nouveau.
I made the change above when explicitly testing for it in the patch
adding HMM tests.
