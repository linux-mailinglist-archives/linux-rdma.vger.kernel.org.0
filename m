Return-Path: <linux-rdma+bounces-11325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EBAADA224
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jun 2025 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEACB3A92E2
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jun 2025 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9032A189F56;
	Sun, 15 Jun 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg7SUhYe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD05176ADE;
	Sun, 15 Jun 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749998708; cv=none; b=RIhucHwvpe4hphaCE5+YchQqKI9Qn8N/ES70jjzhJa1uVW7tKgsViL5kJSAGdVLbtu4l1A08ol4wrlB9EI/ffFOElbceJitUllIg+alHKr1OtpPCMFFAx6HUMWRfnntRuSLRkLtc/lXIRVfh3MPf211uMxJEFD7m1Eftr4DxRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749998708; c=relaxed/simple;
	bh=yns/HdK/KDP3W8qk7tnplSuGwOShe1QOJEKByBbubuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDLqNoxocuqRsBmSSBM2GG5VxY+bnWoWgfI+pFfQUZFHvOfrKnxEuhv9SAS70UT7JpmSEhBSnnuvDRA4wM5XBRdwyU+fNY+ZK7oHNJY4JtZ6dymAc90naxEfUXQlxRGQJ47JKBQtcB9XaqH8CAo0ftWtoh8zoZgSYgwYkRqocUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg7SUhYe; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb6c6cc5-aa19-4f10-baf7-e20f021553ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749998691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxUQCc0gvo7bthO+iU82/CFSIOIRFWx8jjfAItn3Hks=;
	b=hg7SUhYe2InS7a+5i/3VIomSWd88ohx/jPKsoHh8kbPN00wFHfzO/IIHS8dzy3Xb21oHUR
	x8fCC3Ykzok8WPbunz8lx3+7a2iQI3peMohvw+PrhAXl8ofsyV6BXAWLqDCHYsiFFeqbpp
	i8pY2nqp6Jc2Wj1BC52fMcyB5FQpyks=
Date: Sun, 15 Jun 2025 07:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/9] net/mlx5: Ensure fw pages are always allocated on
 same NUMA
To: Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250610151514.1094735-1-mbloch@nvidia.com>
 <20250610151514.1094735-2-mbloch@nvidia.com>
 <1688e772-3067-4277-ad45-6564b4fbbddf@linux.dev>
 <524cf976-a734-4d30-915b-2480a6139e27@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <524cf976-a734-4d30-915b-2480a6139e27@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/6/14 22:55, Moshe Shemesh 写道:
>
>
> On 6/13/2025 7:22 PM, Zhu Yanjun wrote:
>> 在 2025/6/10 8:15, Mark Bloch 写道:
>>> From: Moshe Shemesh <moshe@nvidia.com>
>>>
>>> When firmware asks the driver to allocate more pages, using event of
>>> give_pages, the driver should always allocate it from same NUMA, the
>>> original device NUMA. Current code uses dev_to_node() which can result
>>> in different NUMA as it is changed by other driver flows, such as
>>> mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
>>> allocating firmware pages.
>>
>> I'm not sure whether NUMA balancing is currently being considered or 
>> not.
>>
>> If I understand correctly, after this commit is applied, all pages will
>> be allocated from the same NUMA node — specifically, the original
>> device's NUMA node. This seems like it could lead to NUMA imbalance.
>
> The change is applied only on pages allocated for FW use. Pages which 
> are allocated for driver use as SQ/RQ/CQ/EQ etc, are not affected by 
> this change.
>
> As for FW pages (allocated for FW use), we did mean to use only the 
> device close NUMA, we are not looking for balance here. Even before 
> the change, in most cases, FW pages are allocated from device close 
> NUMA, the fix only ensures it.

Thanks a lot. I’m fine with your explanations.

In the past, I encountered a NUMA-balancing issue where memory 
allocations were dependent on the mlx5 device. Specifically, memory was 
allocated only from the NUMA node closest to the mlx5 device. As a 
result, during the lifetime of the process, more than 100GB of memory 
was allocated from that single NUMA node, while other NUMA nodes saw no 
significant allocations. This led to a NUMA imbalance problem.

According to your commit, SQ/RQ/CQ/EQ are not affected—only the firmware 
(FW) pages are. These FW pages include Memory Region (MR) and On-Demand 
Paging (ODP) pages. ODP pages are freed after use, and the amount of MR 
pages remains fixed throughout the process lifecycle. Therefore, in 
theory, this commit should not cause any NUMA imbalance. However, since 
production environments can be complex, I’ll monitor for any NUMA 
balancing issues after this commit is deployed in production.

In short, I’m fine with both this commit and your explanations.

Thanks,

Yanjun.Zhu

>
>>
>> By using dev_to_node, it appears that pages could be allocated from
>> other NUMA nodes, which might help maintain better NUMA balance.
>>
>> In the past, I encountered a NUMA balancing issue caused by the mlx5
>> NIC, so using dev_to_node might be beneficial in addressing similar
>> problems.
>>
>> Thanks,
>> Zhu Yanjun
>>
>>>
>>> Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on 
>>> reader NUMA node")
>>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/ 
>>> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>> index 972e8e9df585..9bc9bd83c232 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>> @@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, 
>>> u64 addr, u32 function)
>>>   static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>>>   {
>>>       struct device *device = mlx5_core_dma_dev(dev);
>>> -     int nid = dev_to_node(device);
>>> +     int nid = dev->priv.numa_node;
>>>       struct page *page;
>>>       u64 zero_addr = 1;
>>>       u64 addr;
>>
>
-- 
Best Regards,
Yanjun.Zhu


