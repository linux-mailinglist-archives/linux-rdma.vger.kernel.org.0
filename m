Return-Path: <linux-rdma+bounces-1902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A018A124E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E592628183D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3F146A74;
	Thu, 11 Apr 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ow7qyZP2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D021442FE
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832925; cv=none; b=QYOy1QeTxD5V/Hdmzqnq+hdlSSne4R32rtVbRQOf1NbKOGBOL2pZ3BUXMz3nAU6NaTQJLqNICq9mKgWbNOC927vLCoAOwM4JfZfY0AvfoqNbHVJGbsDZjVgqgOfOWulF7IKhV/8DPRTyDX0XS3C6Knnw3Uz1eCZagSTt//pixow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832925; c=relaxed/simple;
	bh=FnvaYVjgjga/QLbf/+N8vt3LnLcgNucJPAvIYwlPBBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GE21ahbDQ6ON9l9GvmF5I8dw8t8W4ljnQ5BixfMCkECeNDiaAeMsHs8a7VQhysnzX0YkwCgvwgf+JBjXS39/0hgah7GulcBqorHEdL0b8vr0kGjk3pjuYHHhvC/7YVGBD2yg1p8+V5wgGGhh9vyF2y7WZ1lTh/DZJHf40f1Ua5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ow7qyZP2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5cb275ac-0405-4097-bd63-a64fe58bfc92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712832920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4izHLAj8TuqwFZDvbDSfI8ObD2uhyizaX/o7YekfsA=;
	b=Ow7qyZP2Kc7v3lEQNTFRi413yMlqOQMkieflUOHyXF1ymiQHraR5gV1hC213Q7C1OFMXxL
	+OgwZqoxf0+hMRtY4JSY7k1BvpBu9Kb6EYL/KaHQ4CSlSbgy8RRx9x/Cx5PUTWQ0fvq2fS
	ZsN65W2AJWiHq7w9pDVNsDOWCXi7cgw=
Date: Thu, 11 Apr 2024 12:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Return the correct errno
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20240408142142.792413-1-yanjun.zhu@linux.dev>
 <402329bf-b959-4210-a3a0-7a3847dd8811@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <402329bf-b959-4210-a3a0-7a3847dd8811@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/4/11 11:11, Zhijian Li (Fujitsu) 写道:
>
> On 08/04/2024 22:21, Zhu Yanjun wrote:
>> In the function __rxe_add_to_pool, the function xa_alloc_cyclic is
>> called. The return value of the function xa_alloc_cyclic is as below:
>> "
>>    Return: 0 if the allocation succeeded without wrapping.  1 if the
>>    allocation succeeded after wrapping, -ENOMEM if memory could not be
>>    allocated or -EBUSY if there are no free entries in @limit.
>> "
>> But now the function __rxe_add_to_pool only returns -EINVAL. All the
>> returned error value should be returned to the caller.
>>
> make sense.
>
>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>    drivers/infiniband/sw/rxe/rxe_pool.c | 6 ++++--
>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 6215c6de3a84..43ba0277bd7b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -122,8 +122,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>    	int err;
> I'd like to assign 'err' a default error code: -EINVAL

Thanks a lot for your comments.

Before the local variable err is used, this variable err has already 
been set.

As such, it is not necessary to initialize this local variable when it 
is declared.

Best Regards,

Zhu Yanjun

>
>
> Thanks
> Zhijian
>
>
>
>>    	gfp_t gfp_flags;
>>    
>> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>> +	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) {
>> +		err = -EINVAL;
>>    		goto err_cnt;
>> +	}
>>    
>>    	elem->pool = pool;
>>    	elem->obj = (u8 *)elem - pool->elem_offset;
>> @@ -147,7 +149,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>    
>>    err_cnt:
>>    	atomic_dec(&pool->num_elem);
>> -	return -EINVAL;
>> +	return err;
>>    }
>>    
>>    void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)

