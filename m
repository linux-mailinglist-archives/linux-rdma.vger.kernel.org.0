Return-Path: <linux-rdma+bounces-15097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F6CCE6F9
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 05:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FA9302CBBE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 04:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A47221F26;
	Fri, 19 Dec 2025 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HK/7bXbX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BD26D4CD
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118609; cv=none; b=crTbGmRmJJ/2Xn6cGje/CoAPF8rxaI0Pn11jhsZDGpPRnCXGmbyuhhcev6cHsC1WvKI8JRnIwumlV1ohBSAaOSwgUuoLAdIP5iLkZWRS2Z8KvP1r1IPJV3C1XMcg5/o89SXTnrneDc2s2G8A6qh34hi29hxd7J1QS+KZNXwVa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118609; c=relaxed/simple;
	bh=baan+3WwgAGCeasU8GtCXNpE1tP/Q+IXqT3mtx6bGI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3+0w2o3+w+1cBEKbBS1AMRGHIB8W6AqjoE0EZCIB2iffJJRQhW8b7gXbcnx79rfspyJYtLYPUf9YOcrCFmY4OYdybMKt9MSzrLZ7Ov7JjAeGW2YgilkPP0ID4BOSWTKHnpD0Hpvm7S6a0FI5xdBAO30khXlxtOEKC8+I5MB1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HK/7bXbX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766118601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCYKT1pgbGMqqmfqm84IAiOY70gUOuR0JnC8XC7s9DE=;
	b=HK/7bXbXgxTy92GrNABpLaUHmcq6uM7fnMr3WayY/W3p0LPN4lhJu4ub+IbUU5DfgQnqPG
	nmIe5hTU0luI2mtteRslJJ9Um5rKF29/ww4Opx6ZCVeopMgu6DW0MJ1hJICL8NbrFpL2tj
	HFzHhU0SJ2hyNDTzMf/Rgu/ao7pqaww=
Date: Thu, 18 Dec 2025 20:29:55 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/18 18:51, Gustavo A. R. Silva 写道:
>
>
> On 12/19/25 04:22, Yanjun.Zhu wrote:
>>
>> On 12/18/25 7:56 AM, Leon Romanovsky wrote:
>>> On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
>>>>
>>>> 在 2025/12/5 20:41, Zhu Yanjun 写道:
>>>>>
>>>>> 在 2025/12/4 9:48, yanjun.zhu 写道:
>>>>>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>>>>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>>>>>         unsigned int res_head;
>>>>>>>>>         unsigned int        res_tail;
>>>>>>>>>         struct resp_res        *res;
>>>>>>>>> +
>>>>>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
>>>>>>>> rxe_recv_wqe has
>>>>>>>> no member named wqe
>>>>>>>>     289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>>>>>         |                                         ^
>>>>>>> I didn't try to fix all the typos, you will need to do that.
>>>>>> Exactly. I will fix this problem. This weekend, I will send out an
>>>>>> official commit.
>>>>> Hi, Jason
>>>>>
>>>>> The followings are based on your commits and Leon's commits. And 
>>>>> it can
>>>>> pass the rdma-core tests.
>>>>>
>>>>> I am not sure if this commit is good or not.
>>>> Hi, Jason && Leon
>>>>
>>>> Any update? If this looks good to you, I will send out an official 
>>>> commit
>>>> based on the following commit.
>>> You are RXE maintainer, send the official patch.
>>
>> Will do. I will send it out very soon.
>
> I don't see how this addresses the flex-array in the middle issue that
> originated this discussion.

Could you please explain this in more detail?
Also, if you have a better approach, would you mind sending a new commit 
for discussion?

Thanks a lot.

Yanjun.Zhu

>
> -Gustavo

-- 
Best Regards,
Yanjun.Zhu


