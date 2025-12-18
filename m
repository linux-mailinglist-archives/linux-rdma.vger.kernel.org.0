Return-Path: <linux-rdma+bounces-15093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD8CCD5ED
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 20:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66649301FFAA
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF593320CB1;
	Thu, 18 Dec 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UZUzzVNL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB258302742
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766085770; cv=none; b=a+2ZKqq4WziI+QdUxiEPxTk+/iqbnhuXherkLpfzxqCKRNvRRCmQmoPmdAcKw0q2N3l/a96PfIVSxSFZnp55mKbzXD5nmXF6pLRfhexUh7wOsQdYw61DTC7IzM5sg4qSYkM5fI8hIrSDQnQDZnNr7hjHqsKZcGqVBHjakW/0BGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766085770; c=relaxed/simple;
	bh=ijYF4JbQvPFODetWEBKlK7bAqKSwXrgg2kzAPhDHmUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1cjlJ8HySqxn4gpqvFVp6vOhwtzm2pVD/KwNT92cC+G3ymsr8wCzIhubxa8ScqmuyRO7ULnIrmPvGY3tKWugTmecBJq5/vMh/oyuN4ZjVtEbGfkh6ykZUJCyUPobmIu1Yi2+XqT6CeWA+2mM9VxbP6m/jqB1Rt7RFSQ1RxLxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UZUzzVNL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766085756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrdWvcwlB/Kp5cwo07JH6P/TBZtebj35FcbjnD7K5Zs=;
	b=UZUzzVNLbrlIJxVZVt3Ye50JFi1f6fWQmIIZx0nIbwGX6z7vxa44kt/D1fScP9oBaEsAHo
	bEv3imp7VAPvEmw6aJv74lfu0QB+vpyZi4Siau8juvMS1c8le7prNl47XNQ8tnQ3UKOwzF
	sUK1QgS4jHrgTBZEd6H1V8kYZDnkzB0=
Date: Thu, 18 Dec 2025 11:22:30 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251218155623.GC400630@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/18/25 7:56 AM, Leon Romanovsky wrote:
> On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
>>
>> 在 2025/12/5 20:41, Zhu Yanjun 写道:
>>>
>>> 在 2025/12/4 9:48, yanjun.zhu 写道:
>>>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>>>         unsigned int        res_head;
>>>>>>>         unsigned int        res_tail;
>>>>>>>         struct resp_res        *res;
>>>>>>> +
>>>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
>>>>>> rxe_recv_wqe has
>>>>>> no member named wqe
>>>>>>     289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>>>         |                                         ^
>>>>> I didn't try to fix all the typos, you will need to do that.
>>>> Exactly. I will fix this problem. This weekend, I will send out an
>>>> official commit.
>>> Hi, Jason
>>>
>>> The followings are based on your commits and Leon's commits. And it can
>>> pass the rdma-core tests.
>>>
>>> I am not sure if this commit is good or not.
>> Hi, Jason && Leon
>>
>> Any update? If this looks good to you, I will send out an official commit
>> based on the following commit.
> You are RXE maintainer, send the official patch.

Will do. I will send it out very soon.

Yanjun.Zhu

>
> Thanks

