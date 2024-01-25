Return-Path: <linux-rdma+bounces-756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775083C3AA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 14:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C511C227FB
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC450258;
	Thu, 25 Jan 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a7aE4O5q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA551035
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189452; cv=none; b=R5LO4WFzrXAOojJ8vrGET/iUexnWMx7bEDcV++oDQ0KCMZ6Sq86qFuttT9Lg2hha57cwnlcdAje4dUnh5cT5Z1K4zSBhAc3M60u9ChHgibsMjuZppec/usmNwl2vLqXafqdn3sz6CTGXgu6hn1acTTL4oI1zHnEtQd1jsM7NkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189452; c=relaxed/simple;
	bh=FiuNJhR49ZU2HC3GgJwsBO2uGB75RGlODArSfMWAyxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw47cskHsfuPSCdLbdWkXALJqLI8JSBB+/dY9hy/on8i3T89eT3jsXY/ObA8BwiKap39Brsrkjg0sFZK7oX4lBBFajRFn95Uq0cqgoEQ4nGYzKKNxrqNTZEu1LrZFq8h/iXuLSW2T85hF4XRePRc8AU1Z8/7KwOvCbh3UB+hTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a7aE4O5q; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3ae1ecb-bf03-4a28-b2fa-058540f70180@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706189447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/rQciKaO+LURa83MzLtmINUWrylV7h/ZUUM0sgabrU=;
	b=a7aE4O5qo04ISRJwP3BJ4nHVMCF8LY3Rzl9aI8r8IM7ctWipgvDmZ1nsxR1Rr3WaizONxe
	gFN2slJw2otHVl8rzLsPRjVnbT03qbdF2n3n78pXQ+CJJdvuixtAAwPnAgcyVFO1ApG7bX
	z9JM2UMFH+G2WX2jdp4Llanvl3sIkmg=
Date: Thu, 25 Jan 2024 21:30:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user
 mkeys
To: Junxian Huang <huangjunxian6@hisilicon.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
 Mark Zhang <markzhang@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
 Tamar Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <cover.1706185318.git.leon@kernel.org>
 <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
 <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/25 20:52, Junxian Huang 写道:
> 
> 
> On 2024/1/25 20:30, Leon Romanovsky wrote:
>> From: Or Har-Toov <ohartoov@nvidia.com>
>>
>> In the dereg flow, UMEM is not a good enough indication whether an MR
>> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
>> when a new MR is created and the UMEM of the old MR is set to NULL.
>> Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
>> but cache_ent can be different than NULL. So, the mkey will not be
>> destroyed.
>> Therefore checking if mkey is from user application and cacheable
>> should be done by checking if rb_key or cache_ent exist and all other kind of
>> mkeys should be destroyed.
>>
>> Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
>> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>   drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
>> index 12bca6ca4760..3c241898e064 100644
>> --- a/drivers/infiniband/hw/mlx5/mr.c
>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>> @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
>>   	return ret;
>>   }
>>   
>> +static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)
> 
> I think it's better using a pointer as the parameter instead of the struct itself.

Why do you think that a pointer is better that the struct itself? In 
kernel doc, is there any rule about this?

Thanks.

Zhu Yanjun

> 
> Junxian
> 
>> +{
>> +	return mkey.cache_ent || mkey.rb_key.ndescs;
>> +}
>> +
>>   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>   {
>>   	struct mlx5_ib_mr *mr = to_mmr(ibmr);
>> @@ -1901,12 +1906,6 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>   		mr->sig = NULL;
>>   	}
>>   
>> -	/* Stop DMA */
>> -	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
>> -		if (mlx5r_umr_revoke_mr(mr) ||
>> -		    cache_ent_find_and_store(dev, mr))
>> -			mr->mmkey.cache_ent = NULL;
>> -
>>   	if (mr->umem && mr->umem->is_peer) {
>>   		rc = mlx5r_umr_revoke_mr(mr);
>>   		if (rc)
>> @@ -1914,7 +1913,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>   		ib_umem_stop_invalidation_notifier(mr->umem);
>>   	}
>>   
>> -	if (!mr->mmkey.cache_ent) {
>> +	/* Stop DMA */
>> +	if (!is_cacheable_mkey(mr->mmkey) || mlx5r_umr_revoke_mr(mr) ||
>> +	    cache_ent_find_and_store(dev, mr)) {
>>   		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
>>   		if (rc)
>>   			return rc;


