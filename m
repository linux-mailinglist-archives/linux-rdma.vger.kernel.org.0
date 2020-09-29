Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102527D827
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgI2Ua3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 16:30:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1738 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgI2Ua2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 16:30:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7399580000>; Tue, 29 Sep 2020 13:30:16 -0700
Received: from [172.27.0.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:30:26 +0000
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Yishai Hadas" <yishaih@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
 <20200929201303.GG9475@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <ec93e0f2-22c5-ac93-3a3a-8874ab7d8aa6@nvidia.com>
Date:   Tue, 29 Sep 2020 23:30:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929201303.GG9475@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601411416; bh=x8XqmZ5SmGylaQvczf8e5zmDh506y16dUfXlR2XUohg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=XYlFEMiOSx2KxslpT5x06A4O7k1iZFWg/BV9rENQX0wqgMDt+1e2bAXu45SVq9JlH
         cBieG8GOYrXbPnrW35jxUWWbnawqGn3iwJcFvtmcx4biFVsi1mlUvYhJD4+o//7eFZ
         PXV1F3S3FuUPneRfxjacLrc/3ahx59BTVtqQkZLdPIa6+F7DSqZFdP9JLsZRi4i91L
         q1adZuqBZOIf8bocB9Bla9qPqFChNLJwIIR1xsntcX5D8JNRKccF4VczOfQdJ3c/3L
         DW8uMw3rCqIgt0SlR/m46CiY9MFVCdlEgRrZyB0jMgHIGsOJr5VV6kIuKHeRb0mUUn
         Cn94pnkTfdyGg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/29/2020 11:13 PM, Jason Gunthorpe wrote:
> On Tue, Sep 29, 2020 at 11:09:43PM +0300, Yishai Hadas wrote:
>> On 9/29/2020 10:27 PM, Jason Gunthorpe wrote:
>>> On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:
>>>
>>>> +	if (!*dma_addr) {
>>>> +		*dma_addr = ib_dma_map_page(dev, page, 0,
>>>> +				1 << umem_odp->page_shift,
>>>> +				DMA_BIDIRECTIONAL);
>>>> +		if (ib_dma_mapping_error(dev, *dma_addr)) {
>>>> +			*dma_addr = 0;
>>>> +			return -EFAULT;
>>>> +		}
>>>> +		umem_odp->npages++;
>>>> +	}
>>>> +
>>>> +	*dma_addr |= access_mask;
>>> This does need some masking, the purpose of this is to update the
>>> access flags in the case we hit a fault on a dma mapped thing. Looks
>>> like this can happen on a read-only page becoming writable again
>>> (wp_page_reuse() doesn't trigger notifiers)
>>>
>>> It should also have a comment to that effect.
>>>
>>> something like:
>>>
>>> if (*dma_addr) {
>>>       /*
>>>        * If the page is already dma mapped it means it went through a
>>>        * non-invalidating trasition, like read-only to writable. Resync the
>>>        * flags.
>>>        */
>>>       *dma_addr = (*dma_addr & (~ODP_DMA_ADDR_MASK)) | access_mask;
>> Did you mean
>>
>> *dma_addr = (*dma_addr & (ODP_DMA_ADDR_MASK)) | access_mask;
> Probably
>
>> flags. (see ODP_DMA_ADDR_MASK).  Also, if we went through a
>> read->write access without invalidation why do we need to mask at
>> all ? the new access_mask should have the write access.
> Feels like a good idea to be safe here
It followed your note from V1 that the extra mask was really redundant, 
the original code also didn't have it, but up-to-you.
>   
>>>> +		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
>>>> +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
>>>> +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
>>>> +		/* If a hugepage was detected and ODP wasn't set for, the umem
>>>> +		 * page_shift will be used, the opposite case is an error.
>>>> +		 */
>>>> +		if (hmm_order + PAGE_SHIFT < page_shift) {
>>>> +			ret = -EINVAL;
>>>> +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
>>>> +				 __func__, hmm_order, page_shift);
>>>>    			break;
>>>>    		}
>>> I think this break should be a continue here. There is no reason not
>>> to go to the next aligned PFN and try to sync as much as possible.
>> This might happen if the application didn't honor the contract to use
>> hugepages for the full range despite that it sets IB_ACCESS_HUGETLB, right ?
> Yes
>
>> Do we still need to sync as much as possible in that case ? I
>> believe that we may consider return an error in this case to let
>> application be aware of as was before this series.
> We might be prefetching or something weird where it could make sense.

Not sure about the exact scenario rather than an application issue, this 
follows the original code in this area, maybe better sets an error in 
the clear application error.

>
>>> This should also
>>>
>>>     WARN_ON(umem_odp->dma_list[dma_index]);
Can you add it locally if you prefer the above approach ?
>>>
>>> And all the pr_debugs around this code being touched should become
>>> mlx5_ib_dbg
>> We are in IB core, why mlx5_ib_debug ?
> oops, dev_dbg
Can it can done locally ?
> Jason


