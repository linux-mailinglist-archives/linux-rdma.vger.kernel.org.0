Return-Path: <linux-rdma+bounces-15189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FDCD9E8B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCC830194EC
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5D2D6E53;
	Tue, 23 Dec 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhaj1Z75"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF372D0C63
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506441; cv=none; b=vBPnhudXs2l1p6P1/7ZipseUimPd5o2ioEuNz9qG+AB37o+GoG61YatGpkk6ALohdJD9wOAlYfYzqx2fkCmC7H6l1yuc5MtKhQ1wJHF0Rd53kr1iheAULhCDjzoBJX3tqHff8PhjUBJbJ6UEIQk8ap1EA/ejXXJKNV6ph/mAFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506441; c=relaxed/simple;
	bh=f4AWNzs8FniP9xvHu54yv8fcxsAALCnxN3mj5budGHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rERh5/6RySwPa65aK6iqByuLv6rNOuzyEA3RZCmz3DEQxDY5VLPlpF8ca3osduCvErWi9XtNtcDx9wdAOGw8xhpLl4aFJlkov3b/lZDHd4W7EM1nlNoOfQ4Ljy8Hieu8rmDxInUewSk1VD3axXbDDsyXWJykWV5Qcx4xcZ0YTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhaj1Z75; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba0fb412-455b-4348-a81c-013e7f40377f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766506437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YA4ueY+hnzmoZPAxp82QzMFokgtNSll8hzsXPYqcv4=;
	b=fhaj1Z75OsmM3rGlUtwtMXepczoCUVCHfJToYMcntqzFM3i76cNy629KZJ9PokzEBJkkf8
	K/lJCqOUz8tvZhipCMFmRnZv8RJ+RMY8XpxUmyuLBLEcJSQHm0UvEeCBWJgiBaxYFOUQsA
	KXNvhY4peoxwPoOL9vHvC7XXOqJaEbs=
Date: Tue, 23 Dec 2025 08:13:49 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
 <20251223142055.GC11869@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251223142055.GC11869@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/23 6:20, Leon Romanovsky 写道:
> On Mon, Dec 22, 2025 at 09:10:11PM -0800, Zhu Yanjun wrote:
>> 在 2025/12/22 21:03, Gustavo A. R. Silva 写道:
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
>>>> structure [-Wflex-array-member-not-at-end]
>>>>
>>>> This helper creates a union between a flexible-array member (FAM) and a
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
>>> What are you doing?
>> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the
>> same structure.
> Zhu,
>
> Please submit your rxe_sge to ib_sge change as standalone patch and
> Gustavo will resubmit his patch later if he wants so.


OK. I will do soon.

Yanjun.Zhu


>
> Thanks

-- 
Best Regards,
Yanjun.Zhu


