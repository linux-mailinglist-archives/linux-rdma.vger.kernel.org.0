Return-Path: <linux-rdma+bounces-15099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F8CCE87C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 06:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F2643021452
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD02C235E;
	Fri, 19 Dec 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="szfgO3oO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA17D531
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122075; cv=none; b=Rs7vq6JTiLF0QWs4HALFUTPMnSpeVCFOB4l/wPTLZCyq/zs6djU1gnRRTJAQCu6kZxRRPZp4yg6BzdVl5Gb3ICAu1k7jzgHG9sXNhqMZsEOwyFXq6h/WJpHwkQURtWc5B30/NgH+dNa7Q90OJpTQlzmQovuU3tNCGj1Gx0ekrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122075; c=relaxed/simple;
	bh=ZLPOsN93mhLBgc1DlgFNEARefAxozdoq2IoqoUCcGNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIG3W5XcrLWZrBaBt+t7WI5WAFy04uJpIS+wk0/ZseFx0R0iz2iBpSV/RmVkMFUVOFQBpW39JlTTuuD4h8k+e+xyNtFBe+7IClprPLLlE9vdPu0lJa1IzBjlqNofFOs5HoksdPgOidKDZ/EfB9g7htejOJ7yjJyw7W9jy8tbuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=szfgO3oO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01b419f6-264e-4faa-b4df-480fdf952d14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766122061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuAsbNg8IXs9RS2NAbeaLJ4hnHbfDFyeT7DH3dnGHR0=;
	b=szfgO3oOVzLCZiWDGJaoy/h6QDemWhZUqn+JYJOzQAIzVRlXlOW8kvEsQHZlkOzNf6eQSy
	gKbtTnSXhHAda/q6i73BVLnryj9Q241nndlMJ6wYI2670YvdpjMrhY75tK4lxAsig1Q1jz
	1AFHUzdsFBoNjKxQopG16lVjegIhV2Y=
Date: Thu, 18 Dec 2025 21:27:30 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
 <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
 <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/18 20:35, Gustavo A. R. Silva 写道:
> 
> 
> On 12/19/25 13:29, Zhu Yanjun wrote:
>>
>> 在 2025/12/18 18:51, Gustavo A. R. Silva 写道:
>>>
>>>
>>> On 12/19/25 04:22, Yanjun.Zhu wrote:
>>>>
>>>> On 12/18/25 7:56 AM, Leon Romanovsky wrote:
>>>>> On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
>>>>>>
>>>>>> 在 2025/12/5 20:41, Zhu Yanjun 写道:
>>>>>>>
>>>>>>> 在 2025/12/4 9:48, yanjun.zhu 写道:
>>>>>>>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>>>>>>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>>>>>>>         unsigned int res_head;
>>>>>>>>>>>         unsigned int        res_tail;
>>>>>>>>>>>         struct resp_res        *res;
>>>>>>>>>>> +
>>>>>>>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>>>>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
>>>>>>>>>> rxe_recv_wqe has
>>>>>>>>>> no member named wqe
>>>>>>>>>>     289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>>>>>>>         |                                         ^
>>>>>>>>> I didn't try to fix all the typos, you will need to do that.
>>>>>>>> Exactly. I will fix this problem. This weekend, I will send out an
>>>>>>>> official commit.
>>>>>>> Hi, Jason
>>>>>>>
>>>>>>> The followings are based on your commits and Leon's commits. And 
>>>>>>> it can
>>>>>>> pass the rdma-core tests.
>>>>>>>
>>>>>>> I am not sure if this commit is good or not.
>>>>>> Hi, Jason && Leon
>>>>>>
>>>>>> Any update? If this looks good to you, I will send out an official 
>>>>>> commit
>>>>>> based on the following commit.
>>>>> You are RXE maintainer, send the official patch.
>>>>
>>>> Will do. I will send it out very soon.
>>>
>>> I don't see how this addresses the flex-array in the middle issue that
>>> originated this discussion.
>>
>> Could you please explain this in more detail?
>> Also, if you have a better approach, would you mind sending a new 
>> commit for discussion?
> 
> This is exactly what my original patch is about. I've explained this a 
> couple of times
> in this thread already.

In your original patch, I have the following problem. I read all your 
replies.  But I can not find your answers to my problem.

My problem is as below:

1. The followings are the declaration of __TRAILING_OVERLAP

/**
  * __TRAILING_OVERLAP() - Overlap a flexible-array member with trailing
  *            members.
  *
  * Creates a union between a flexible-array member (FAM) in a struct 
and a set
  * of additional members that would otherwise follow it.
  *
  * @TYPE: Flexible structure type name, including "struct" keyword.
  * @NAME: Name for a variable to define.
  * @FAM: The flexible-array member within @TYPE          <----- Here
  * @ATTRS: Any struct attributes (usually empty)
  * @MEMBERS: Trailing overlapping members.
  */
#define __TRAILING_OVERLAP(TYPE, NAME, FAM, ATTRS, MEMBERS)         \
     union {                                 \
         TYPE NAME;                          \
         struct {                            \
             unsigned char __offset_to_FAM[offsetof(TYPE, FAM)]; \
             MEMBERS                         \
         } ATTRS;                            \
     }

2. I expanded the above MACRO __TRAILING_OVERLAP into the following 
following the definition in your commit.

union {

         struct rxe_recv_wqe wqe;

         struct {
             unsigned char __offset_to_FAM[offsetof(struct rxe_recv_wqe, 
dma.sge)]; \
             struct ib_sge sge[RXE_MAX_SGE];
         } ;

     }srq_wqe;

3. In your original commit, dma.sge should be the member of struct 
rxe_recv_wqe. The struct rxe_recv_wqe is as below.


"@FAM: The flexible-array member within @TYPE"


The struct rxe_recv_wqe is as below.

struct rxe_recv_wqe {
     __aligned_u64       wr_id;
     __u32           reserved;
     __u32           padding;
     struct rxe_dma_info dma;
};

But I can not find dma.sge in the above struct. Can you explain it?

To be honest, I read your original commit for several times, but I can 
not get it.  Can you explain the MACRO TRAILING_OVERLAP? And how can it 
replace the following struct?

struct {
       struct rxe_recv_wqe    wqe;
       struct ib_sge        sge[RXE_MAX_SGE];
} srq_wqe;

Thanks a lot.

Yanjun.Zhu

> 
> -Gustavo


