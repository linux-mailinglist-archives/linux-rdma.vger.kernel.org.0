Return-Path: <linux-rdma+bounces-15236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD1CE74DE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F57301FF55
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C532ED40;
	Mon, 29 Dec 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dedRxZPj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6232E6BE;
	Mon, 29 Dec 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024695; cv=none; b=O648SZ5vDYHeSNdZ27cBHyNS3m9dlVx/qQg8wbIQV1HPZPRLu8eEhE88iAzsCLNbWwBSZoamgP6xCOX3oNXS4ZJQiqubn3lsMFd1UU4ifUkSWGYu/d04+wWCX7M+6dJm13d9kA4+AltmnnRmppuldzBE7mN1rB2GypJjVDhdUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024695; c=relaxed/simple;
	bh=GVtodO4OXEn00EzaxlcWcyOl9zRNhOJmoI1kHaKs/gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HH3ZpWWxhmGbAGi5PV1efsUA/m/XjUdzG9cgaZyDk4UlzxRr2C4YUn/zrFUHvvJbPkQsR10+sWaXfalvx7n/wYvBFyLFFbR+ENkxz2MF1vByOl41eHJWq8AEgBpDMPOdHip4oO+mQS5u9/M1z3H5wBWyVbRAI75Y8Tx+iq7fulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dedRxZPj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6478cb24-ce3b-43c7-b33d-b27de7436d89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767024686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uJdFgjg/HfSnhbOxich0piWyZ/hVi/UqqPSIjXp6Fw=;
	b=dedRxZPjRx/TvJjk8lincVHb6L2V5zVVg6YY7eGc6w0PZkeIZaWTGP2BADhmN+xdrdIa4E
	fIf2LcfYHEC67eGlCelDBJWQiEQ7/FAW36EUk4EnTUdyUEUB54OgKmg8N0vkz3mtfWohGL
	2nU7hfG/+fcjAUyFpq1mcdb27V22IUg=
Date: Mon, 29 Dec 2025 08:11:18 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused page_offset member
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
References: <20251226094159.3042935-1-lizhijian@fujitsu.com>
 <20a9c8d2-1151-4318-8e77-3cced4040128@linux.dev>
 <706b7917-28b4-4f54-8c5a-7d67729a62aa@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <706b7917-28b4-4f54-8c5a-7d67729a62aa@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/28 21:49, Zhijian Li (Fujitsu) 写道:
> 
> 
> On 27/12/2025 13:30, Zhu Yanjun wrote:
>> 在 2025/12/26 1:41, Li Zhijian 写道:
>>> The `page_offset` member of the `rxe_mr` struct was initialized based on
>>> `ibmr.iova`, which at the initialization point hadn't been properly set.
>>>
>>> Consequently, the value assigned to `page_offset` was incorrect. However,
>>
>> Hi, Zhijian
>>
>> Why page_offset was incorrect? Can you explain it and add the explainations into commit log?
> 
> 
>>> The `page_offset` member of the `rxe_mr` struct was initialized based on
>>> `ibmr.iova`, which at the initialization point hadn't been properly set.
> 
> The reason is stated in the line above.
> 
> Are you suggesting that I should add more details about when/where
> `ibmr.iova` is correctly initialized? If so, I can clarify that it
> is assigned its value in the ib_sg_to_pages() function.

Yes, that’s exactly what I meant.

It would be helpful to explicitly document when and where ibmr.iova is 
initialized, since it’s not obvious to the reader that it is always 
valid at the point of use. Clarifying that ibmr.iova is assigned in 
ib_sg_to_pages() should address the concern and make the data flow 
easier to follow.

Thanks for adding that clarification.

Zhu Yanjun

> 
> 
> Thanks
> Zhijian
> 
> 
>>
>> But removing page_offset seems correct.
>>
>> Thanks,
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Zhu Yanjun
>>
>>> since `page_offset` was never utilized throughout the code, it can be safely
>>> removed to clean up the codebase and avoid future confusion.
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>>>    drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>>>    3 files changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index bcb97b3ea58a..b28b56db725a 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -237,7 +237,6 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>>>        mr->nbuf = 0;
>>>        mr->page_shift = ilog2(page_size);
>>>        mr->page_mask = ~((u64)page_size - 1);
>>> -    mr->page_offset = mr->ibmr.iova & (page_size - 1);
>>>        return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
>>>    }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> index f58e3ec6252f..8b6a8b064d3c 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -110,7 +110,6 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>>>        mr->access = access_flags;
>>>        mr->ibmr.length = length;
>>>        mr->ibmr.iova = iova;
>>> -    mr->page_offset = ib_umem_offset(&umem_odp->umem);
>>>        err = rxe_odp_init_pages(mr);
>>>        if (err) {
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index fd48075810dd..f94ce85eb807 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -347,7 +347,6 @@ struct rxe_mr {
>>>        int            access;
>>>        atomic_t        num_mw;
>>> -    unsigned int        page_offset;
>>>        unsigned int        page_shift;
>>>        u64            page_mask;
>>


