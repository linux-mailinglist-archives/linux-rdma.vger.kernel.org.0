Return-Path: <linux-rdma+bounces-10618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D99AC2274
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 14:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFFD1C03D30
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B321FF4F;
	Fri, 23 May 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1CAAfH6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08822331E
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002516; cv=none; b=VCmayUn7O9EBY4LmSmtG803yXRwunf0EZr4r5JAJIVIb5cg1toV1JAIhwTsPUvq2QoPsSOD9rjoiQHVQgTUTEfXh32llmOwk2veYlPZ/DliZdV9Vk0sVTQNy6lrOyNiaLinRaaQ/y4Gr5oMP8z/AwczpOQS1A816q+5ySmN5Hko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002516; c=relaxed/simple;
	bh=CsxiA0zdUbdYFwPZUYCegcm++xnkKkzx6+faSoO8Uso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb37D9W32x5EP3Y6fQjcC6TnaJB+93KQRfLT7YibKvnfrISooKAJpBYsB5azsmUSXGT7atMSx/0yYXTWXk1TFRyeDYPrMulTt8sGz3yEwFUiB66zSR0n3cVXYGJ/mtSWKV1nLWJo7ncTiAAkXxtrN8S1GjM6c/E9hbMfwfluFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1CAAfH6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3afc1cf8-0a8b-48b8-9707-3651136c227b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748002511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18DeuEE6TxKr4kLVBc9TL/Ppxrwoors/tW85ewmn48Y=;
	b=f1CAAfH6xzGry6xZApA/hL0QAK3TC3AEI9bIsBE3Ts6LpOOC5bhZbkWg9wUeJ+kRvGxVec
	zisWF+8QnH5IeRKCvp5aVsWbYvty9JKm9UGhXVjNFvuePv3PPtawOXzJBHSSzHtwC5OJd2
	tlTvB4YoMMVHjYWrP6K/njQVNE/E6ts=
Date: Fri, 23 May 2025 14:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
To: Daisuke Matsuda <dskmtsd@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <zyjzyj2000@gmail.com>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
 <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22.05.25 15:29, Daisuke Matsuda wrote:
> 
> On 2025/05/22 20:36, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> RO pages has "perm" equal to 0, that caused to the situation
>> where such pages were marked as needed to have fault and caused
>> to infinite loop.
>>
>> Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in 
>> PFN")
>> Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> Closes: 
>> https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Tested-by: Daisuke Matsuda <dskmtsd@gmail.com>

In the bug report mail, you mentioned
"
After these two patches are merged to the for-next tree, RXE ODP test 
always hangs:
   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
   RDMA/umem: Store ODP access mask information in PFN
"

After this commit is applied, which of the two previous commits is 
innocent, and which one causes the "stuck issue in uverbs_destroy_ufile_hw"?

Best Regards,
Yanjun.Zhu

> 
> Thank you!
> This change fixes one of the two issues I reported.
> The kernel module does not get stuck in rxe_ib_invalidate_range() anymore.
> 
> 
> The remaining one is the stuck issue in uverbs_destroy_ufile_hw().
> cf. 
> https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
> 
> The issue occurs with test_odp_async_prefetch_rc_traffic, which is not yet
> enabled in rxe. It might indicate that the root cause lies in ib_uverbs 
> layer.
> I will take a closer look anyway.
> 
> Thanks,
> Daisuke
> 
> 
>> ---
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c 
>> b/drivers/infiniband/sw/rxe/rxe_odp.c
>> index a1416626f61a5..0f67167ddddd1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>> @@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct 
>> ib_umem_odp *umem_odp,
>>       while (addr < iova + length) {
>>           idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
>> -        if (!(umem_odp->map.pfn_list[idx] & perm)) {
>> +        if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
>>               need_fault = true;
>>               break;
>>           }
> 


