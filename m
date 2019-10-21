Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E2DF72D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJUUyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:54:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13486 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfJUUyR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 16:54:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dae1b030000>; Mon, 21 Oct 2019 13:54:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 21 Oct 2019 13:54:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 21 Oct 2019 13:54:17 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 20:54:16 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 21 Oct 2019 20:54:15 +0000
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
To:     Jerome Glisse <jglisse@redhat.com>
CC:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
Date:   Mon, 21 Oct 2019 13:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021184927.GG3177@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571691267; bh=N8CJfrBWXeelg3CYFYytdZrSkYKGVF3Nf4ocWcNbLdM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HePaq9WzypRM7B2petuLt4qiPLZCLRNb/n5j1JQzPt5ugY+W0vlC/NA0qG1Sr4ld/
         hlrmFm06izi6WeWC98l3kxbIUWR6YOJr/WJf/UunELirAo0NyAaleeRb4JHCcbyIGD
         Y371rfRttqxdSShpe32lF2GGOfu4Iocs7r1FU/NaOdk0LBLqZ7sQh/vwZ32CqyllcT
         uVILKsl3to8db8Xytx7B3fnNRJsaw2ckiYSSYewM7oAGxqbGJHV6j4F7NDbd0Kc0KK
         SkzKVKHPKJXg/WWcZ4/Q2kWxuNtM+TmcGIr7g8Lgx14JwE5Gqok4bJrid9LjSfs56m
         d4dBdfXOi32iA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/21/19 11:49 AM, Jerome Glisse wrote:
> On Tue, Oct 15, 2019 at 01:48:13PM -0700, Ralph Campbell wrote:
>> Allow hmm_range_fault() to return success (0) when the CPU pagetable
>> entry points to the special shared zero page.
>> The caller can then handle the zero page by possibly clearing device
>> private memory instead of DMAing a zero page.
>=20
> I do not understand why you are talking about DMA. GPU can work
> on main memory and migrating to GPU memory is optional and should
> not involve this function at all.

Good point. This is the device accessing the zero page over PCIe
or another bus, not migrating a zero page to device private memory.
I'll update the wording.

>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>=20
> NAK please keep semantic or change it fully. See the alternative
> below.
>=20
>> ---
>>   mm/hmm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 5df0dbf77e89..f62b119722a3 100644
>> --- a/mm/hmm.c
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
> An acceptable change would be to turn the branch into:
> 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) =
{
> 		if (!is_zero_pfn(pte_pfn(pte))) {
> 			*pfn =3D range->values[HMM_PFN_SPECIAL];
> 			return -EFAULT;
> 		}
> 		/* Fall-through for zero pfn (if write was needed the above
> 		 * hmm_pte_need_faul() would had catched it).
> 		 */
> 	}
>=20

Except this will return the zero pfn with no indication that it is special
(i.e., doesn't have a struct page).
