Return-Path: <linux-rdma+bounces-763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9383D272
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 03:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892021F22088
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707938BE3;
	Fri, 26 Jan 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V84AZO/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21B7475
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jan 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235490; cv=none; b=dHgynAVd3GF7io+ORo+G8/B7LrFBiR4TKvfJrtwiBX9eCJnP15KlZg2RpBqCNXBlocJq0sw1A5bJYQZkJp/99c7bCa60eHNhI18rn5D7qit8U4smHWZolbbzqSaPT5qLaOX8iV3GIlfI6FI9LcTjqTWc6BdP0EK1HKb9pe2YaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235490; c=relaxed/simple;
	bh=U+0Rv7mAdg2CfouEvvdx3FErzjgvdLl/Y3M/r0HHZMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWtom3PSHOM1XOJRJYFeA+/MeQesf81JwqiT+WDxRNB5dFVqqRntqvFoSI+rl51T0E1YBMTaaSc6G7MAxvcECXQ+W6nxRIAIS4ZsRfOfCxQSNlPYXbMcOhwgeCYxNDs27CYZyT7nXjzwg5Pcwew/jlj2+M46dt6PuBTOMc2sEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V84AZO/Y; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e550d100-9545-425e-b548-d6a588968b31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706235484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtosFhdK9WYdAwSe6uRtjgNfTz4hNvwY/HhFzzEUKHA=;
	b=V84AZO/Y7faFUPXFTT7YC90Me/4PWmIbJTMa5fIBcnJwKjLtusNmNwUU9FMwuy7d+CndrI
	um/zG7nn3C6eyVY+s1/vshnTSsFd39dV2Mz/P4LJZqQMAIZmGBX9mV8GMd7EPmRj0wbmhU
	YwP08QNs/qx0Axrw1h+5Z5D+9FiK8js=
Date: Fri, 26 Jan 2024 10:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user
 mkeys
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
 Mark Zhang <markzhang@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
 Tamar Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <cover.1706185318.git.leon@kernel.org>
 <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
 <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
 <20240125133824.GM1455070@nvidia.com> <20240125200230.GD9841@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240125200230.GD9841@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/26 4:02, Leon Romanovsky 写道:
> On Thu, Jan 25, 2024 at 09:38:24AM -0400, Jason Gunthorpe wrote:
>> On Thu, Jan 25, 2024 at 08:52:57PM +0800, Junxian Huang wrote:
>>>
>>>
>>> On 2024/1/25 20:30, Leon Romanovsky wrote:
>>>> From: Or Har-Toov <ohartoov@nvidia.com>
>>>>
>>>> In the dereg flow, UMEM is not a good enough indication whether an MR
>>>> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
>>>> when a new MR is created and the UMEM of the old MR is set to NULL.
>>>> Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
>>>> but cache_ent can be different than NULL. So, the mkey will not be
>>>> destroyed.
>>>> Therefore checking if mkey is from user application and cacheable
>>>> should be done by checking if rb_key or cache_ent exist and all other kind of
>>>> mkeys should be destroyed.
>>>>
>>>> Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
>>>> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>>> ---
>>>>   drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
>>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
>>>> index 12bca6ca4760..3c241898e064 100644
>>>> --- a/drivers/infiniband/hw/mlx5/mr.c
>>>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>>>> @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
>>>>   	return ret;
>>>>   }
>>>>   
>>>> +static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)
>>>
>>> I think it's better using a pointer as the parameter instead of the struct itself.
>>
>> Indeed, that looks like a typo
> 
> It is suboptimal to pass struct by value, because whole struct will be copied,

Agree. With a pointer, an address is passed. With the struct, the whole 
struct is copied and passed. The overhead of calling function is less 
with a pointer.

Zhu Yanjun

> but it is not a mistake too.
> 
> Thanks
> 
>>
>> Thanks,
>> Jason
>>


