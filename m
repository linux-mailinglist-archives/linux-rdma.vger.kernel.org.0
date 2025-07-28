Return-Path: <linux-rdma+bounces-12493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C6B1335A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 05:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02FC1896499
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193620010C;
	Mon, 28 Jul 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nzQzwX/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0A20468C
	for <linux-rdma@vger.kernel.org>; Mon, 28 Jul 2025 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672139; cv=none; b=fDyCJHa1cdmBYIg/XdklGRJkyghu9pQtpr36fNwkN0zqbspWv0dVQt2wvMo5fxOmgtNXg/xGgsQIwjs4w+BBEnRLuUeMAzwKvXKpoQPbSj+NNxjnzAXOORt42K6QTqv/A/yYZ+8Kp6mj3BeHpzBiZt/mjZQylIXhKwyOYEQOOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672139; c=relaxed/simple;
	bh=O7dP/hUGjPpfvYLKaWyxH9t3iK7nnRJNp4tiGWfaJd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrD8T8hpzJI7k1uTnpVapmJtrM0lzZmeZ4Ijj5WLWQF+gfb8K6yFl05/FepggSjTejt87pWb1FXSRAGw772rHuOtWMI7zY+isZNJc+YBJsZzUJHcUPibNxfst9YiPMVxQCSz/6gf9dbWwFH3R5WJIv6ZuwhRgHQM0LgLnQrxjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nzQzwX/1; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753672127; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BZqAIs1gK4tQZVBfldy3qZSNAh18Pm/Mr8YsL6doKGE=;
	b=nzQzwX/1hzBIZa277GjFyCTqR78katztEQw/30wwbXpPbIvibxvJwu09JKRPW7x/mpi2mvlnJrnCEzhxi5BmiXkV8dKpdOfwVir9FFOOvwS4nfox8MnteCvZVrEXN/nyJO5XNQKRCArfkrMB31PR4tAIiH4iFpWadwiEIgRQoU8=
Received: from 30.221.115.19(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WkBfL77_1753672126 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 11:08:47 +0800
Message-ID: <5cd4c86c-fc28-4ff5-a135-4d468bff7f36@linux.alibaba.com>
Date: Mon, 28 Jul 2025 11:08:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter
 MTT buffer
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
 kaishen@linux.alibaba.com
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-2-boshiyu@linux.alibaba.com>
 <20250727112757.GZ402218@unreal>
From: Boshi Yu <boshiyu@linux.alibaba.com>
In-Reply-To: <20250727112757.GZ402218@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/27 19:27, Leon Romanovsky wrote:
> On Fri, Jul 25, 2025 at 01:53:54PM +0800, Boshi Yu wrote:
>> Each high-level indirect MTT entry is assumed to point to exactly one page
>> of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
>> pages when mapping. To avoid extra overhead from splitting merged regions,
>> use dma_map_page to map the scatter MTT buffer page by page.
>>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
>>   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
>>   2 files changed, 71 insertions(+), 43 deletions(-)
> 
> <...>
> 
>> +	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
>> +	if (!pg_dma)
>> +		return 0;
>>   
>> -	sg_init_table(sglist, npages);
>> +	addr = buf;
>>   	for (i = 0; i < npages; i++) {
>> -		pg = vmalloc_to_page(buf);
>> +		pg = vmalloc_to_page(addr);
> 
> <...>
>> +
>> +		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
>> +					 DMA_TO_DEVICE);
> 
> Does it work?

Hi Leon,

I would like to confirm which part you think is not working properly. I 
guess that you might be concerned that if the buffer is not 
page-aligned, it could cause problems with dma_map_page.

In fact, when allocating the MTT buffer, we ensure that it is always 
page-aligned and that its length is a multiple of PAGE_SIZE. We have 
also tested the new code in our production environment, and it works well.

Look forward to your further reply if I have misunderstood your concerns.

Thanks,
Boshi Yu

> 
> Thanks


