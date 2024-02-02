Return-Path: <linux-rdma+bounces-866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4977847032
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 13:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A81F2B37D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940311420CD;
	Fri,  2 Feb 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORyyp0S9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465C78B60
	for <linux-rdma@vger.kernel.org>; Fri,  2 Feb 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876657; cv=none; b=UN5AxMjh4JDzyr0YPan0iy1kUuvOsKHBSW6eHtkzNh5+0reL/9ABzEvzC9/2XYYFaikYHXZatUzdu+f+8gxdcY9LBYXuI2vslEUZ2vk+c8BqaczoqRLgyrK3rmol/LgY8YETR/Vtc8lLJrSXY6Abf6rHvSt2H1+ctadF6UQmE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876657; c=relaxed/simple;
	bh=4dB3qCA7PO0PMoBv9ms+FnjdJrFFOAiqKJE4cZj6rVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmAMtr5q+Zwbw9cVl3QNQxS3VUHo1CphSt4HP0kBDts/0XSWH1IxaVYcNh2Box0tjW1gV1lRuuOk12OGgy95wkscoZ+nD8/awD2hzhxTnobDx+hJhXEjYbDRIJCGcydy1gG8Wm7NdfZtIbinNdHFKcKc3zqjJSsHcHs7YoXFPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORyyp0S9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <faf30d17-dfc7-5a52-8c7c-b55bd9035116@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706876652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gC69q16JkyF4ZZW5gGYc1ONS1EeQwj/uJ0ojoQJDrGA=;
	b=ORyyp0S9PdR7qQv6K0W0Ea5R4utS/BLnBF76U3r/8qEjl0kuOXTbF9PyS5SS92ffaqMAgV
	zR+eytJrmJGQ7jRzmdH8IYHl+ZDle9tibVzwDCQp4ZYQmx4UV0VGERm1j46pUXdFlIrbtY
	b9gjxj6ymk7IoXlbMyv4xFhV0hbTtBY=
Date: Fri, 2 Feb 2024 20:24:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused 'iova' parameter from
 rxe_mr_init_user
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20240201125745.21525-1-guoqing.jiang@linux.dev>
 <CAD=hENdNnzqBP1jJj-NHRg_BjsQYh-u2CdCQNn6HF8R87JOgzg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAD=hENdNnzqBP1jJj-NHRg_BjsQYh-u2CdCQNn6HF8R87JOgzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/2/24 19:49, Zhu Yanjun wrote:
> On Thu, Feb 1, 2024 at 8:58 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
>> Use members of generic struct in rxe_mr").
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_loc.h | 2 +-
>>   drivers/infiniband/sw/rxe/rxe_mr.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index 4d2a8ef52c85..746110898a0e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>>   /* rxe_mr.c */
>>   u8 rxe_get_next_key(u32 last_key);
>>   void rxe_mr_init_dma(int access, struct rxe_mr *mr);
>> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>>                       int access, struct rxe_mr *mr);
>>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>>   int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index bc81fde696ee..da3dee520876 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
>>          return xas_error(&xas);
>>   }
>>
>> -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>> +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>>                       int access, struct rxe_mr *mr)
>>   {
>>          struct ib_umem *umem;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 48f86839d36a..04427238fcab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1278,7 +1278,7 @@ static struct ib_mr *rxe_reg_user_mr(struct
> ib_pd *ibpd, u64 start,
>          mr->ibmr.pd = ibpd;
>          mr->ibmr.device = ibpd->device;
>
> -       err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
> +       err = rxe_mr_init_user(rxe, start, length, access, mr);
>          if (err) {
>                  rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
>                  goto err_cleanup;

Oops, my mistake, will add above in v2.

Thanks,
Guoqing

