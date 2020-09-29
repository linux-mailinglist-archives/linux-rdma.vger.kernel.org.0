Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3696627D7EA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgI2UUL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 16:20:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19173 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2UUK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 16:20:10 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7396ee0000>; Tue, 29 Sep 2020 13:19:58 -0700
Received: from [172.27.0.53] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:20:08 +0000
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
 <20200929175946.GA767138@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <42087438-c5fb-a4a5-014f-0c274a000912@nvidia.com>
Date:   Tue, 29 Sep 2020 23:20:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929175946.GA767138@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601410798; bh=y8R0x1IZaD8xscsGZVej0O2f/jac3MJNwTUcIP6pnNM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=fnJ7NRKzD/CF/60VWZRtbQzJNlLvm2AqFuQN38BLEbk916z2Xr5Qrk06lHXvxwg2w
         3Psmb2MNficmU+zqESrhjZFA9vJDJppKzTZwNf0dn048QWbvAAphYuEj6VLz1F3GNL
         568WGxEikYeI3s+MgiY4xkSPYLTddaxBzkruoklyS2Jbj1z6LtcvszY7csnGnHrUCJ
         LwMLdqTAxDtFXe3uxfF/Pku8LCKY8ogVPYCVBUWnTY6wfKPMR3hyUMJ94uTRTtHtBO
         4aeO2AtASdAXnJHj531kGAaqRb/AZFqWPpNg10KzL512FaIL1xIPBieVz/299PU41Q
         yXuf0Uir04syA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/29/2020 8:59 PM, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 11:21:01AM +0300, Leon Romanovsky wrote:
>> @@ -287,87 +289,48 @@ EXPORT_SYMBOL(ib_umem_odp_release);
>>    * Map for DMA and insert a single page into the on-demand paging page tables.
>>    *
>>    * @umem: the umem to insert the page to.
>> - * @page_index: index in the umem to add the page to.
>> + * @dma_index: index in the umem to add the dma to.
>>    * @page: the page struct to map and add.
>>    * @access_mask: access permissions needed for this page.
>>    * @current_seq: sequence number for synchronization with invalidations.
>>    *               the sequence number is taken from
>>    *               umem_odp->notifiers_seq.
>>    *
>> - * The function returns -EFAULT if the DMA mapping operation fails. It returns
>> - * -EAGAIN if a concurrent invalidation prevents us from updating the page.
>> + * The function returns -EFAULT if the DMA mapping operation fails.
>>    *
>> - * The page is released via put_page even if the operation failed. For on-demand
>> - * pinning, the page is released whenever it isn't stored in the umem.
>>    */
>>   static int ib_umem_odp_map_dma_single_page(
>>   		struct ib_umem_odp *umem_odp,
>> -		unsigned int page_index,
>> +		unsigned int dma_index,
>>   		struct page *page,
>> -		u64 access_mask,
>> -		unsigned long current_seq)
>> +		u64 access_mask)
>>   {
>>   	struct ib_device *dev = umem_odp->umem.ibdev;
>> -	dma_addr_t dma_addr;
>> -	int ret = 0;
>> -
>> -	if (mmu_interval_check_retry(&umem_odp->notifier, current_seq)) {
>> -		ret = -EAGAIN;
>> -		goto out;
>> -	}
>> -	if (!(umem_odp->dma_list[page_index])) {
>> -		dma_addr =
>> -			ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
>> -					DMA_BIDIRECTIONAL);
>> -		if (ib_dma_mapping_error(dev, dma_addr)) {
>> -			ret = -EFAULT;
>> -			goto out;
>> -		}
>> -		umem_odp->dma_list[page_index] = dma_addr | access_mask;
>> -		umem_odp->page_list[page_index] = page;
>> +	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];
>> +
>> +	if (!*dma_addr) {
>> +		*dma_addr = ib_dma_map_page(dev, page, 0,
>> +				1 << umem_odp->page_shift,
>> +				DMA_BIDIRECTIONAL);
>> +		if (ib_dma_mapping_error(dev, *dma_addr))
>> +			return -EFAULT;
> This leaves *dma_addr set to ib_dma_mapping_error, which means the
> next try to map it will fail the if (!dma_addr) and produce a
> corrupted dma address.
>
> *dma_addr should be set to 0 here
>
> Jason

This makes sense, do we need V3 for this or that you can add locally ? 
the other notes in the other mail are quite straight forward as well or 
can be some nice to have I believe.

Yishai

