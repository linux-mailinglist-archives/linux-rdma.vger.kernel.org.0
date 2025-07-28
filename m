Return-Path: <linux-rdma+bounces-12498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE01B135D7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95AF3A1BFF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF61D130E;
	Mon, 28 Jul 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CS0cnDt7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96A1ACEDD
	for <linux-rdma@vger.kernel.org>; Mon, 28 Jul 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688884; cv=none; b=O4ssdWZjd8ikyJkOJVCTQt5mgv4JlIisg6jpQ74SMOIhIq6F5Z7929pNGALkNpyWHCxNp7Siu/ZhO8H5hVvV+bzAP9CqXHcP7bPgsUpR+zSm2hWMGRtLBVQdg1WuZtMiJlueuI44ayLCzJ437IW0OVpoQmBTJexSzzXXaGXd694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688884; c=relaxed/simple;
	bh=ykMte9mAOOLXT1yOi12CRgkeV6QBOCWh3K9TUO2bjAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyydraXVKe1EbyHq5sibJv/jodWvnu2MvLspzk7tBVBHtQG/lcJ2JTnJpq4cqENP8qBy45h5v3wIvEmGi/svTCS/XCOvgMW3xjtFq2VGf/IGeQxbERH6wDZ30mZfkTmrirSP7QcKi/Tv3rB4k8dlaEMXYiWhUqkdXqiSpfxOYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CS0cnDt7; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753688878; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Dy8uIOKOmltRFVqSIzWx74/ll1eKyhVgCyUDZYRceH0=;
	b=CS0cnDt79hJIJ8nkKUhR6VwhNmJMVTqyC9IbRWCQEP3GvAYNNZsB+DNerwsflBpeUNYUqHvbjZZloFsaYCgoguHkJ1KnxJAg0AY9uaGN2oW1uMwyobuzCpDG3SgmFeDRoejZ/y3GTSQSZbCSXma3Ity92ltKZZiBb2Z5FO/5l5g=
Received: from 30.221.115.250(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WkFpmuS_1753688877 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 15:47:58 +0800
Message-ID: <d243319c-c57b-ee30-a54f-aeaee6b1b663@linux.alibaba.com>
Date: Mon, 28 Jul 2025 15:47:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter
 MTT buffer
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-2-boshiyu@linux.alibaba.com>
 <20250727112757.GZ402218@unreal>
 <5cd4c86c-fc28-4ff5-a135-4d468bff7f36@linux.alibaba.com>
 <20250728070841.GB402218@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20250728070841.GB402218@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/28/25 3:08 PM, Leon Romanovsky wrote:
> On Mon, Jul 28, 2025 at 11:08:46AM +0800, Boshi Yu wrote:
>>
>>
>> On 2025/7/27 19:27, Leon Romanovsky wrote:
>>> On Fri, Jul 25, 2025 at 01:53:54PM +0800, Boshi Yu wrote:
>>>> Each high-level indirect MTT entry is assumed to point to exactly one page
>>>> of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
>>>> pages when mapping. To avoid extra overhead from splitting merged regions,
>>>> use dma_map_page to map the scatter MTT buffer page by page.
>>>>
>>>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>>>> ---
>>>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
>>>>   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
>>>>   2 files changed, 71 insertions(+), 43 deletions(-)
>>>
>>> <...>
>>>
>>>> +	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
>>>> +	if (!pg_dma)
>>>> +		return 0;
>>>> -	sg_init_table(sglist, npages);
>>>> +	addr = buf;
>>>>   	for (i = 0; i < npages; i++) {
>>>> -		pg = vmalloc_to_page(buf);
>>>> +		pg = vmalloc_to_page(addr);
>>>
>>> <...>
>>>> +
>>>> +		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
>>>> +					 DMA_TO_DEVICE);
>>>
>>> Does it work?
>>
>> Hi Leon,
>>
>> I would like to confirm which part you think is not working properly. I
>> guess that you might be concerned that if the buffer is not page-aligned, it
>> could cause problems with dma_map_page.
>>
>> In fact, when allocating the MTT buffer, we ensure that it is always
>> page-aligned and that its length is a multiple of PAGE_SIZE. We have also
>> tested the new code in our production environment, and it works well.
>>
>> Look forward to your further reply if I have misunderstood your concerns.
> 
> DMA API expects Kmalloc addresses and not Vmalloc ones.
> 

Hi Leon,

Thanks for your reply. Could you provide some references for this point?
We cannot find the constraint in the Kernel Documentation.

To our best knowledge, vzalloc allocates enough pages from the page level
allocator, and vmalloc_to_page converts the buffer to 'struct page *', then
dma_map_page can accept 'struct page *' as an input parameter to generate
the DMA address.

We can find many similar uses in the kernel. 

For example, pds_vfio_dirty_seq_ack in drivers/vfio/pci/pds/dirty.c:
<...>
	for (unsigned long long i = 0; i < npages; i++) {
		struct page *page = vmalloc_to_page(bmp);

		if (!page) {
			err = -EFAULT;
			goto out_free_pages;
		}

		pages[i] = page;
		bmp += PAGE_SIZE;
	}

	err = sg_alloc_table_from_pages(&sg_table, pages, npages, page_offset,
					bmp_bytes, GFP_KERNEL);
	if (err)
		goto out_free_pages;

	err = dma_map_sgtable(pdsc_dev, &sg_table, dma_dir, 0);
	if (err)
		goto out_free_sg_table;
<...>

Another example, irdma_map_vm_page_list in drivers/infiniband/hw/irdma/utils.c:
<...>
	for (i = 0; i < pg_cnt; i++) {
		vm_page = vmalloc_to_page(addr);
		if (!vm_page)
			goto err;

		pg_dma[i] = dma_map_page(hw->device, vm_page, 0, PAGE_SIZE,
					 DMA_BIDIRECTIONAL);
		if (dma_mapping_error(hw->device, pg_dma[i]))
			goto err;

		addr += PAGE_SIZE;
	}

<...>

If we have misunderstood something, please point it out and we would appreciate it.

Thanks,
Cheng Xu

> Thanks

