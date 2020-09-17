Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8FE26D839
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIQJ7f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 05:59:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15495 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIQJ7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Sep 2020 05:59:32 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:59:32 EDT
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6332480000>; Thu, 17 Sep 2020 02:54:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 02:54:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Sep 2020 02:54:29 -0700
Received: from [172.27.13.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 09:54:27 +0000
Subject: Re: [PATCH rdma-next 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Christoph Hellwig <hch@infradead.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-2-leon@kernel.org>
 <20200916164516.GA11582@infradead.org>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <55a2e301-6a15-ad27-682e-1ea7f9543b0a@nvidia.com>
Date:   Thu, 17 Sep 2020 12:54:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916164516.GA11582@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600336456; bh=T72oez/y1ZIshKlmUVb6A+AOi0vXLv8kGVNQ1aM707o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=FMz3/BsQZwMra9YQKITCjZasNrm/C5PbwvXNW8VDxal3PhzNMo3EYElREG+5om7qC
         dRezOM9ewQDTIeLAF1mAW//P2a4xkLYa6Ckn47hlxtRENkAtupjpxmijMU3Dbehl//
         8/Z5yU8Fzu5XRGSb0nMx2dwFXKUGTHKHrG+8WOsXCerHGLsYdVy7w2ahbz5ubbhK9O
         DLEDlUO68zdabui4QYtM9Nz3Tw/69Z8R1Pr4AI3905caYN08YE06mTSX+DBoKQeGJH
         T9j/w9/w3dnSu2WjG0VOFbltt0A2pqzq9OdoWru6BiYKig5nM9zoaKmr8/r3MBzPSQ
         YPvfhwT1GD6Pg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/2020 7:45 PM, Christoph Hellwig wrote:
>> In addition,
>> Moving to use the HMM enables to reduce page faults in the system as it
>> exposes the snapshot mode, this will be introduced in next patches from
>> this series.
>>
>> As part of this cleanup some flows and use the required data structures
>> to work with HMM.
> Just saying HMM here seems weird.  The function is hmm_range_fault.
> And it really needs to grow a better name eventually..

Sure, will rephrase.

>>   		unsigned long start;
>>   		unsigned long end;
>> -		size_t pages;
>> +		size_t ndmas, npfns;
>>   
>>   		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
>>   		if (check_add_overflow(umem_odp->umem.address,
>> @@ -71,20 +72,21 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>>   		if (unlikely(end < page_size))
>>   			return -EOVERFLOW;
>>   
>> -		pages = (end - start) >> umem_odp->page_shift;
>> -		if (!pages)
>> +		ndmas = (end - start) >> umem_odp->page_shift;
>> +		if (!ndmas)
>>   			return -EINVAL;
>>   
>> -		umem_odp->page_list = kvcalloc(
>> -			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
>> -		if (!umem_odp->page_list)
>> +		npfns = (end - start) >> PAGE_SHIFT;
>> +		umem_odp->pfn_list = kvcalloc(
>> +			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
>> +		if (!umem_odp->pfn_list)
>>   			return -ENOMEM;
>>   
>>   		umem_odp->dma_list = kvcalloc(
>> -			pages, sizeof(*umem_odp->dma_list), GFP_KERNEL);
>> +			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
>>   		if (!umem_odp->dma_list) {
>>   			ret = -ENOMEM;
>> -			goto out_page_list;
>> +			goto out_pfn_list;
> Why do you rename these variables?  We're still mapping pages.

The pfn_list is allocated in a size to match the system page size as 
used by hmm_range_fault() by contrast to the dma_list that its size 
depends on umem page size.
As of that I have separated to 2 variables and renamed to clarify their 
usage (i.e no struct page ** is allocated but unsigned long *)

>>   static int ib_umem_odp_map_dma_single_page(
>>   		struct ib_umem_odp *umem_odp,
>> +		unsigned int dma_index,
>>   		struct page *page,
>> +		u64 access_mask)
>>   {
>>   	struct ib_device *dev = umem_odp->umem.ibdev;
>>   	dma_addr_t dma_addr;
>>   
>> +	if (umem_odp->dma_list[dma_index]) {
> Note that 0 is a valid DMA address.  I think due the access bit this
> works, but it is a little subtle..

I have added a note to clarify the usage as you have suggested in the 
next email will be part of V1, the flags will do the work.

By the way see below [1], existing code assumes that NULL is not valid 
but new code won't rely on any more.

[1] 
https://elixir.bootlin.com/linux/v5.3-rc7/source/drivers/infiniband/core/umem_odp.c#L727

>> +		umem_odp->dma_list[dma_index] &= ODP_DMA_ADDR_MASK;
>> +		umem_odp->dma_list[dma_index] |= access_mask;
> This looks a little weird.  Instead of &= ODP_DMA_ADDR_MASK I'd do a
> &= ~ACCESS_MASK as that makes the code a lot more logical.
>
> But more importantly except for (dma_addr_t)-1 (DMA_MAPPING_ERROR)
> all dma_addr_t values are valid, so taking more than a single bit
> from a dma_addr_t is not strictly speaking correct.
>
>> +		return 0;
>>   	}
>>   
>> +	dma_addr =
>> +		ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
>> +				DMA_BIDIRECTIONAL);
> The use of the BIT macro which is already obsfucating in its intended
> place is really out of place here.
>
>> +	if (ib_dma_mapping_error(dev, dma_addr))
>> +		return -EFAULT;
>> +
>> +	umem_odp->dma_list[dma_index] = dma_addr | access_mask;
>> +	umem_odp->npages++;
>> +	return 0;
> I'd change the calling conventions and write the whole thing as:
>
> static int ib_umem_odp_map_dma_single_page(struct ib_umem_odp *umem_odp
> 		unsigned int dma_index, struct page *page, u64 access_mask)
> {
>   	struct ib_device *dev = umem_odp->umem.ibdev;
> 	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];
>
> 	if (!dma_addr) {

You referred to if (!*dma_addr), right ? no problem will use your 
suggestion below.

> 		*dma_addr = ib_dma_map_page(dev, page, 0,
> 				1 << umem_odp->page_shift,
> 				DMA_BIDIRECTIONAL);
> 		if (ib_dma_mapping_error(dev, *dma_addr))
> 			return -EFAULT;
> 		umem_odp->npages++;
> 	}
> 	*dma_addr &= ~ODP_ACCESS_MASK;
There isn't such a mask, I found it clear to use ODP_DMA_ADDR_MASK.
> 	*dma_addr |= access_mask;
> 	return 0;
> }
>
>> +	/*
>> +	 * No need to check whether the MTTs really belong to
>> +	 * this MR, since ib_umem_odp_map_dma_and_lock already
>> +	 * checks this.
>> +	 */
> You could easily squeeze the three lines into two while still staying
> under 80 characters for each line.

No problem, will change.

Yishai

