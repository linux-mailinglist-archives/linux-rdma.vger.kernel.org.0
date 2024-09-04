Return-Path: <linux-rdma+bounces-4741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0B96BB4D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364891F22128
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171451D3184;
	Wed,  4 Sep 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULANAis+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DC1D2225
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450804; cv=none; b=DhxqhNxBWJb/l0o30V2ti1N99lVOFN3RSc1mHtfQbwZg8jc9Yb0ToTcnvJ357wpFb6BsIlcg36zFdVB9Fj7QlrRWYQXYpSiwEa31U2S6KH6xUmW/EidJkbGzRcN/cgFPDAb/BXTHjpD+2khxUDAIA5vFvMan6jGIKbtuZJ6eT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450804; c=relaxed/simple;
	bh=23yD5+8tZ8DaU8E05WC/5m4SyJAaPulKcopDR2rc6aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z70+nBZzDPD5w8BUGj2eTMJMCRQA+01W6oW/uLU2bLPLAPkgN4YcxhsKhK+1Ba3smYYvreZBR2p1CRxtudcSzfqgr9wpxrVPvgcIXeIUTukY8aT9xxYLc01TyugdZUSwdiVc9S/wx3kZzMNyi8b/fCFvNjFZYuLqI0ehoRVetA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULANAis+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725450801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFiH4KOZRANCzSNai8Ri8tlxbgvrk+fsfchgGWYrvXw=;
	b=ULANAis+a2/1UYoZjNydgOOsdo6FYcZWnd9FBSfqr2BPHPtM8GHWNoVz7Ysg1W0zTSVumx
	FMjzpWVS8/gXuB2a4wnrWn3EJBWv/1kMdqi4y45tfNADcc999CN1zUodcFRTiP6w/dzJXg
	i92i6u/A5uR5IBsk0frQdivctUH7pL8=
Date: Wed, 4 Sep 2024 19:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
 <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/9/4 16:27, Edward Srouji 写道:
>
> On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Hi,
>>>
>>> This series from Edward introduces mlx5 data direct placement (DDP)
>>> feature.
>>>
>>> This feature allows WRs on the receiver side of the QP to be consumed
>>> out of order, permitting the sender side to transmit messages without
>>> guaranteeing arrival order on the receiver side.
>>>
>>> When enabled, the completion ordering of WRs remains in-order,
>>> regardless of the Receive WRs consumption order.
>>>
>>> RDMA Read and RDMA Atomic operations on the responder side continue to
>>> be executed in-order, while the ordering of data placement for RDMA
>>> Write and Send operations is not guaranteed.
>>
>> It is an interesting feature. If I got this feature correctly, this
>> feature permits the user consumes the data out of order when RDMA Write
>> and Send operations. But its completiong ordering is still in order.
>>
> Correct.
>> Any scenario that this feature can be applied and what benefits will be
>> got from this feature?
>>
>> I am just curious about this. Normally the users will consume the data
>> in order. In what scenario, the user will consume the data out of order?
>>
> One of the main benefits of this feature is achieving higher bandwidth 
> (BW) by allowing
> responders to receive packets out of order (OOO).
>
> For example, this can be utilized in devices that support multi-plane 
> functionality,
> as introduced in the "Multi-plane support for mlx5" series [1]. When 
> mlx5 multi-plane
> is supported, a single logical mlx5 port aggregates multiple physical 
> plane ports.
> In this scenario, the requester can "spray" packets across the 
> multiple physical
> plane ports without guaranteeing packet order, either on the wire or 
> on the receiver
> (responder) side.
>
> With this approach, no barriers or fences are required to ensure 
> in-order packet
> reception, which optimizes the data path for performance. This can 
> result in better
> BW, theoretically achieving line-rate performance equivalent to the 
> sum of
> the maximum BW of all physical plane ports, with only one QP.

Thanks a lot for your quick reply. Without ensuring in-order packet 
reception, this does optimize the data path for performance.

I agree with you.

But how does the receiver get the correct packets from the out-of-order 
packets efficiently?

The method is implemented in Software or Hardware?

I am just interested in this feature and want to know more about this.

Thanks,

Zhu Yanjun

>
> [1] https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
>> Thanks,
>> Zhu Yanjun
>>
>>>
>>> Thanks
>>>
>>> Edward Srouji (2):
>>>    net/mlx5: Introduce data placement ordering bits
>>>    RDMA/mlx5: Support OOO RX WQE consumption
>>>
>>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>>   drivers/infiniband/hw/mlx5/qp.c      | 51 
>>> +++++++++++++++++++++++++---
>>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>>
>>
-- 
Best Regards,
Yanjun.Zhu


