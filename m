Return-Path: <linux-rdma+bounces-15174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A514CD826B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C77F301A1C8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2162F1FD5;
	Tue, 23 Dec 2025 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngD0R9kc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0832E54D3
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467638; cv=none; b=PSrxCEG7jdlGr/Z4A2sAcvxp41G/M/u2MJhCPhJGsHo0Yy/WRfiR1G5XlxX4xgm9MaDsj2IMETIyCUHtYD93sJV5JSqiU/ZEhNQkOyPrL5w0/LccpbYTwDxflmIh35gdXRXwduOS8ttOFmNQsuWFOsGTDmL714/S6WmoFXzgxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467638; c=relaxed/simple;
	bh=/VVRNNo4GO44GKPYIsUWoYEHEu3NaY+LFzz32SIndF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGwAZUBfJzZ/XV6lrq4AMEgXEcQBkh4PXjs/zMlsc65yYIHsj7/AZpU99AxDUysoM1DX82ERdnwzeHUs/5pZzpuWSY0j4VXhBxSnGWTiVwTEtvTdWKtCLZaL9/3Ztb79uJxNlqtgsUYBZMfZ8B3H4kABC4Kn9XNStLQ5pFeKGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngD0R9kc; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7de9609c-afa2-4536-a65c-67e623885870@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766467624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOgEYlzPOmLC1vmU7RFAfKMjUUs3jqYRzoevYnslq0Y=;
	b=ngD0R9kcdEItqQ0xMrVN8iy3WXnXe6SndzVGbxQP5mZyyXhjubwysXY657oq7unEkkmb+O
	UVP3Br46cPTd+XzTWCbk6gyhdvGP8txncsZI6bmx/z3tOfy4cxo3VE9eIwIwIJKcye6E9J
	xJ35+ENv2ZLWIJ27fssLqOg816F6odQ=
Date: Mon, 22 Dec 2025 21:26:54 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
 <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/22 21:18, Gustavo A. R. Silva 写道:
>
>
> On 12/23/25 14:10, Zhu Yanjun wrote:
>>
>> 在 2025/12/22 21:03, Gustavo A. R. Silva 写道:
>>>
>>>
>>> On 12/23/25 13:41, Zhu Yanjun wrote:
>>>> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>>>>
>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>>> getting ready to enable it, globally.
>>>>
>>>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>>>
>>>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure 
>>>> containing a flexible array member is not at the end of another 
>>>> structure [-Wflex-array- member-not-at-end]
>>>>
>>>> This helper creates a union between a flexible-array member (FAM) 
>>>> and a
>>>> set of MEMBERS that would otherwise follow it.
>>>>
>>>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>>>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>>>> start of MEMBER aligned.
>>>>
>>>> The static_assert() ensures this alignment remains, and it's
>>>> intentionally placed inmediately after the related structure --no
>>>> blank line in between.
>>>>
>>>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>>>> to the end of the corresponding structure.
>>>>
>>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>
>>> What are you doing?
>>
>> Because struct rxe_sge differs from struct ib_sge, I aligned it to 
>> use the same structure.
>
> Listen, this is not how things are done upstream. Read what I 
> previously commented:
>
>>> You're making a mess of this whole thing. Please, don't make changes
>>> to my patches on your own.
>
> and please, learn how to properly submit patch series.
>
> Lastly, do the changes that you want/need to implement in your code, 
> and don't
> submit my patch as part of those changes again.

You can correct this patch by yourself.

Yanjun.Zhu

>
> -Gustavo

-- 
Best Regards,
Yanjun.Zhu


