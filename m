Return-Path: <linux-rdma+bounces-4804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8796F80F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190BC287486
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9A61D27AF;
	Fri,  6 Sep 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dPkdDbn/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE71D2F67
	for <linux-rdma@vger.kernel.org>; Fri,  6 Sep 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635848; cv=none; b=vE8gvEFTAySzYJlIQprnmlqaZcN6ce2XhgKCQUKAJOC+aChg7kND8VCRNB0s2V7S8L6mACdfl4wuki7kukmduavjQ9sO95ZdYPHxffHxypuapQNaTYYC6t1piq6Ojv15n9C0zennb/EgkVYUS8CIgja1Ve8Z58Vci/q6AjhFhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635848; c=relaxed/simple;
	bh=7LuZa4LYrpVKytnvHXL3CdQWeRjsk4m/vKw64BPJTyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slcwz7DBopQf0PsKm+UdYuLMJUPxdhfFN6ci8VmJf6VxtyLMZTel3VX4YzPLwaPIajTzFkzrh6tNZzKxzo+qXkaCu5u6rySdIsdulrLiqpUU4jKz8FnNe+k8rbrhKXr0nH2tfd+X7L+V/49OqYZycMG1XA8rNz7S2UepGV+o064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dPkdDbn/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <144bf42b-8b9e-48b6-81f7-07af79cb0a94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725635844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UDOBpw3dQ6gmpXcKrFxnKRHK22I6owm67kjSgoRLT4=;
	b=dPkdDbn/7ja3iLcRFSpYxr5gkAQDF7XI7LjwyMM/NEZl1HmAOQBZp5dMRgLxVNkXpmj6V2
	p0GtwUCHuDAM9P5/03oPC7g/4xeCwwK51SKvUmgAVBY5kZQ1O3JoX8D4sgE0FRSVGio7u6
	9D5B7hPm+UY+VyeRhImTm5bUU2ELefQ=
Date: Fri, 6 Sep 2024 23:17:13 +0800
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
 <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
 <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
 <99b11f32-387c-4501-bd60-efa37618c53d@linux.dev>
 <a50bd6bd-5cae-49d9-8bd8-172f88035d18@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <a50bd6bd-5cae-49d9-8bd8-172f88035d18@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/9/6 20:17, Edward Srouji 写道:
>
> On 9/6/2024 8:02 AM, Zhu Yanjun wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 在 2024/9/5 20:23, Edward Srouji 写道:
>>>
>>> On 9/4/2024 2:53 PM, Zhu Yanjun wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 在 2024/9/4 16:27, Edward Srouji 写道:
>>>>>
>>>>> On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>>>>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> This series from Edward introduces mlx5 data direct placement (DDP)
>>>>>>> feature.
>>>>>>>
>>>>>>> This feature allows WRs on the receiver side of the QP to be 
>>>>>>> consumed
>>>>>>> out of order, permitting the sender side to transmit messages 
>>>>>>> without
>>>>>>> guaranteeing arrival order on the receiver side.
>>>>>>>
>>>>>>> When enabled, the completion ordering of WRs remains in-order,
>>>>>>> regardless of the Receive WRs consumption order.
>>>>>>>
>>>>>>> RDMA Read and RDMA Atomic operations on the responder side 
>>>>>>> continue to
>>>>>>> be executed in-order, while the ordering of data placement for RDMA
>>>>>>> Write and Send operations is not guaranteed.
>>>>>>
>>>>>> It is an interesting feature. If I got this feature correctly, this
>>>>>> feature permits the user consumes the data out of order when RDMA 
>>>>>> Write
>>>>>> and Send operations. But its completiong ordering is still in order.
>>>>>>
>>>>> Correct.
>>>>>> Any scenario that this feature can be applied and what benefits 
>>>>>> will be
>>>>>> got from this feature?
>>>>>>
>>>>>> I am just curious about this. Normally the users will consume the 
>>>>>> data
>>>>>> in order. In what scenario, the user will consume the data out of
>>>>>> order?
>>>>>>
>>>>> One of the main benefits of this feature is achieving higher 
>>>>> bandwidth
>>>>> (BW) by allowing
>>>>> responders to receive packets out of order (OOO).
>>>>>
>>>>> For example, this can be utilized in devices that support multi-plane
>>>>> functionality,
>>>>> as introduced in the "Multi-plane support for mlx5" series [1]. When
>>>>> mlx5 multi-plane
>>>>> is supported, a single logical mlx5 port aggregates multiple physical
>>>>> plane ports.
>>>>> In this scenario, the requester can "spray" packets across the
>>>>> multiple physical
>>>>> plane ports without guaranteeing packet order, either on the wire or
>>>>> on the receiver
>>>>> (responder) side.
>>>>>
>>>>> With this approach, no barriers or fences are required to ensure
>>>>> in-order packet
>>>>> reception, which optimizes the data path for performance. This can
>>>>> result in better
>>>>> BW, theoretically achieving line-rate performance equivalent to the
>>>>> sum of
>>>>> the maximum BW of all physical plane ports, with only one QP.
>>>>
>>>> Thanks a lot for your quick reply. Without ensuring in-order packet
>>>> reception, this does optimize the data path for performance.
>>>>
>>>> I agree with you.
>>>>
>>>> But how does the receiver get the correct packets from the 
>>>> out-of-order
>>>> packets efficiently?
>>>>
>>>> The method is implemented in Software or Hardware?
>>>
>>>
>>> The packets have new field that is used by the HW to understand the
>>> correct message order (similar to PSN).
>>>
>>> Once the packets arrive OOO to the receiver side, the data is scattered
>>> directly (hence the DDP - "Direct Data Placement" name) by the HW.
>>>
>>> So the efficiency is achieved by the HW, as it also saves the required
>>> context and metadata so it can deliver the correct completion to the
>>> user (in-order) once we have some WQEs that can be considered an
>>> "in-order window" and be delivered to the user.
>>>
>>> The SW/Applications may receive OOO WR_IDs though (because the first 
>>> CQE
>>> may have consumed Recv WQE of any index on the receiver side), and it's
>>> their responsibility to handle it from this point, if it's required.
>>
>> Got it. It seems that all the functionalities are implemented in HW. The
>> SW only receives OOO WR_IDs. Thanks a lot. Perhaps it is helpful to RDMA
>> LAG devices. It should enhance the performance^_^
>>
>> BTW, do you have any performance data with this feature?
>
> Not yet. We tested it functionality wise for now.
>
> But we should be able to measure its performance soon :).

Thanks a lot. It is an interesting feature. If performance reports, 
please share them with us.

IMO, perhaps this feature can be used in random read/write devices, for 
example, hard disk?

Just my idea. Not sure if you have applied this feature with hard disk 
or not.

Best Regards,

Zhu Yanjun

>
>
>>
>> Best Regards,
>> Zhu Yanjun
>>
>>>
>>>>
>>>> I am just interested in this feature and want to know more about this.
>>>>
>>>> Thanks,
>>>>
>>>> Zhu Yanjun
>>>>
>>>>>
>>>>> [1] 
>>>>> https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
>>>>>> Thanks,
>>>>>> Zhu Yanjun
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Edward Srouji (2):
>>>>>>>    net/mlx5: Introduce data placement ordering bits
>>>>>>>    RDMA/mlx5: Support OOO RX WQE consumption
>>>>>>>
>>>>>>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>>>>>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>>>>>>   drivers/infiniband/hw/mlx5/qp.c      | 51
>>>>>>> +++++++++++++++++++++++++---
>>>>>>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>>>>>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>>>>>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>
>>>> -- 
>>>> Best Regards,
>>>> Yanjun.Zhu
>>>>
>>
-- 
Best Regards,
Yanjun.Zhu


