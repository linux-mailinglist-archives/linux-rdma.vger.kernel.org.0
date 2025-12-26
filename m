Return-Path: <linux-rdma+bounces-15223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8724CDE5E4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 07:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFDF63006469
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF529ACF6;
	Fri, 26 Dec 2025 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a/kpibou"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291328314A
	for <linux-rdma@vger.kernel.org>; Fri, 26 Dec 2025 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729658; cv=none; b=hue0UUmEWrF1RRLwnaCB7lwEuz/B/S99wi8AOrEcESmRhZC0UG6dTePvgthg9ALCZtPDb+eWSG+/S36asqIKmD6XFJ5jpb/FbgSZg75l4NrMpT3JkpE9ly+mGE4FyzGEe6+P8/JcZ7uZCYbfFi/0upJXCu02ki2gjZZ2AtilqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729658; c=relaxed/simple;
	bh=535xoqcKcYrPQXsntCWwNVnjVyQ4BpkcbelfQpPn0bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6EPn7/aZZT7iF4axbnuLbrveUoN/fsJ9T3LKZDufhBRUHktA3+AMJ8WSfN5p0s3BhaDLVcw8FLSy96zud64qGH0X4Xk/y7WQ7z0x2qGG+XOL9ibXjwtXbKqg8q+hUVvOrEzrt7LFTA11I9QN9jsOovSTfSvILGt1jvdftnIXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a/kpibou; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa979d2f-150d-4e9b-80dc-b6a34191da08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766729644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfYE72kf/YHok1dgp72c9MA+z2NRqHpakm9XDgwtvRw=;
	b=a/kpibouIisaP/WAgPGwZdHT+JJBsAdBmJF6HIXUZ8pe/8WeB0MCxfXLQK6JiGJmGa0zC1
	38ImyqTCgjZV+oaSwC3txF2BZJ7rx3guXdqtcpf87ZIwJuU6e+xCG1j3AF3yloVo1cTiVg
	wMtUPKhVLFt2uR7M0rSP8azmHzZHXXI=
Date: Thu, 25 Dec 2025 22:13:56 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
 <20251219142600.GC254720@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251219142600.GC254720@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/19 6:26, Jason Gunthorpe 写道:
> On Fri, Dec 19, 2025 at 11:51:54AM +0900, Gustavo A. R. Silva wrote:
> 
>>>>> Any update? If this looks good to you, I will send out an official commit
>>>>> based on the following commit.
>>>> You are RXE maintainer, send the official patch.
>>>
>>> Will do. I will send it out very soon.
>>
>> I don't see how this addresses the flex-array in the middle issue that
>> originated this discussion.
> 
> ??
> 
> It moved it to the end of every struct it is part of?

Any update?

Yanjun.Zhu

> 
> Jason


