Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B827D7B2
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgI2UJs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 16:09:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10041 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgI2UJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 16:09:48 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7394590000>; Tue, 29 Sep 2020 13:08:57 -0700
Received: from [172.27.0.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:09:46 +0000
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
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
Date:   Tue, 29 Sep 2020 23:09:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929192730.GB767138@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601410137; bh=PE5c5saOkxcpl4ATOnQr0kGO1744C9fmVLaNHjUlJRk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=cbHNvVcKlTQfd1jHKt0Owf0TVF1J+uVPYcOQUrdZvuTfIWvO3po4sw0dC12F1gF/4
         EydDVnJyb4UZoQqFzHvPTR+O4297ch5ZcrqvQKUsJyZWCLfTgRF4DmUewnR6w2OSR3
         rq/TD/jeQxa8Ku4quQfVqZLl1M1pFQgBuo6cwP/k623OjulbMxzlEYuZ9BQ7SPf8O2
         f9H9AGA1V2HR8bfcFW6+2NS/auQtzOWek6HpJR2fw4Gu7LQvAck730RWjDI8/tViuR
         gKcqDPB6LPzYsCuC28ovIFsCcZID4/vsMTPIys7RGAOJ1qLwcXWJPQw3NdQ5+7kGXG
         zqp9Z8jKAT0/A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/29/2020 10:27 PM, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:
>
>> +	if (!*dma_addr) {
>> +		*dma_addr = ib_dma_map_page(dev, page, 0,
>> +				1 << umem_odp->page_shift,
>> +				DMA_BIDIRECTIONAL);
>> +		if (ib_dma_mapping_error(dev, *dma_addr)) {
>> +			*dma_addr = 0;
>> +			return -EFAULT;
>> +		}
>> +		umem_odp->npages++;
>> +	}
>> +
>> +	*dma_addr |= access_mask;
> This does need some masking, the purpose of this is to update the
> access flags in the case we hit a fault on a dma mapped thing. Looks
> like this can happen on a read-only page becoming writable again
> (wp_page_reuse() doesn't trigger notifiers)
>
> It should also have a comment to that effect.
>
> something like:
>
> if (*dma_addr) {
>      /*
>       * If the page is already dma mapped it means it went through a
>       * non-invalidating trasition, like read-only to writable. Resync the
>       * flags.
>       */
>      *dma_addr = (*dma_addr & (~ODP_DMA_ADDR_MASK)) | access_mask;
Did you mean

*dma_addr = (*dma_addr & (ODP_DMA_ADDR_MASK)) | access_mask;

Otherwise we may lose the dma_addr itself and just have the access flags. (see ODP_DMA_ADDR_MASK).
Also, if we went through a read->write access without invalidation why do we need to mask at all ? the new access_mask should have the write access.

>      return;
> }
>
> new_dma_addr = ib_dma_map_page()
> [..]
> *dma_addr = new_dma_addr | access_mask
>
>> +		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
>> +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
>> +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
>> +		/* If a hugepage was detected and ODP wasn't set for, the umem
>> +		 * page_shift will be used, the opposite case is an error.
>> +		 */
>> +		if (hmm_order + PAGE_SHIFT < page_shift) {
>> +			ret = -EINVAL;
>> +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
>> +				 __func__, hmm_order, page_shift);
>>   			break;
>>   		}
> I think this break should be a continue here. There is no reason not
> to go to the next aligned PFN and try to sync as much as possible.

This might happen if the application didn't honor the contract to use 
hugepages for the full range despite that it sets IB_ACCESS_HUGETLB, right ?

Do we still need to sync as much as possible in that case ? I believe 
that we may consider return an error in this case to let application be 
aware of as was before this series.

> This should also
>
>    WARN_ON(umem_odp->dma_list[dma_index]);
>
> And all the pr_debugs around this code being touched should become
> mlx5_ib_dbg
We are in IB core, why mlx5_ib_debug ?
>
> Jason


