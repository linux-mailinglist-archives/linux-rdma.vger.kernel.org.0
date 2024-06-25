Return-Path: <linux-rdma+bounces-3485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E83917264
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 22:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ABF1C20E4C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FED17D36B;
	Tue, 25 Jun 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKKksC/S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3D17CA1F
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346770; cv=none; b=SAGae1WCs+///kA1cg2qrjW+Cq2DgTu3eEKr59nQRJErPLY038zPlC6dZxIFefsduqsn8zASTnhT0iplObxKmmTs82vBQoXF6cTLz7yu/NGFy1sYb/FMCHA6lHFhMHXajJPoIGQAwKUYEhSrHlGkmxSdWR1c68EcfqH6OxqBbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346770; c=relaxed/simple;
	bh=QC2Z8G3j7vYAjRX4XrKVmySKYNzxS6dlRkiwjub9CuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx1BvSLixXPIEDHMPpvhGvZlYxZ0cAJeuxBmkBqKe6NKtrz8ygaphDqGKzJZzUH+FRWGh98KSTEaN+8X5qZJHroTC73ZyHb9418J1V+7DyKYnwI8lu/3ZKXHjgFrXjDeha5XBzirPhH1Pu5GmUDg1+xF3b22Qzqxihr6ie9+FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKKksC/S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: anand.a.khoje@oracle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719346765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9678CUjzhgPN1J6RvQvl+rS35cxTG5Xyob/LOGdofF8=;
	b=mKKksC/SKoPfTtrUS+NkypA5Rjjlki2NRD1vyrLmErMvGk3EM0m8aj5pjmr+9KPCfi1CZc
	vDvxfZRJwgwmwZS0t5EAyksQ/e6oiEi8PVmKPbSIbsfP70J+ysyKfC4aECxd0I9Klx8lRF
	p1LMlfAQlLPgbNTq2ekfRRy7Qw6H5E0=
X-Envelope-To: jesse.brandeburg@intel.com
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: saeedm@mellanox.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: tariqt@nvidia.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: davem@davemloft.net
Message-ID: <c5a8b1b0-ce6e-4c35-aa00-2a4a1469b3ce@linux.dev>
Date: Wed, 26 Jun 2024 04:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
To: Anand Khoje <anand.a.khoje@oracle.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
 <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
 <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/25 13:00, Anand Khoje 写道:
> 
> On 6/25/24 02:11, Jesse Brandeburg wrote:
>> On 6/24/2024 8:33 AM, Anand Khoje wrote:
>>
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>> @@ -608,6 +608,7 @@ enum {
>>>       RELEASE_ALL_PAGES_MASK = 0x4000,
>>>   };
>>> +#define MAX_RECLAIM_NPAGES -50000
>> Can you please explain why this is negative? There doesn't seem to be
>> any reason mentioned in the commit message or code.
>>
>> At the very least it's super confusing to have a MAX be negative, and at
>> worst it's a bug. I don't have any other context on this code besides
>> this patch, so an explanation would be helpful.
>>
>>
>>
> Hi Jesse,
> 
> The way Mellanox ConnectX5 driver handles 'release of allocated pages 
> from HCA' or 'allocation of pages to HCA', is by sending an event to the 
> host. This event will have number of pages in it. If the number is 
> positive, that indicates HCA is requesting that number of pages to be 
> allocated. And if that number is negative, it is the HCA indicating that 
> that number of pages can be reclaimed by the host.
> 
> In this patch we are restricting the maximum number of pages that can be 
> reclaimed to be 50000 (effectively this would be -50000 as it is 
> reclaim). This limit is based on the capability of the firmware as it 
> cannot release more than 50000 back to the host in one go.
> 
> I hope that explains.

To be honest, I am also obvious why this MACRO is defined as a negative 
number. From the above, I can understand why. I think, perhaps many 
people also wonder why it is defined as a negative. IMO, it is better 
that you put the above explanations into the source code as comments.
When users check the source code, from the comments, users will know why 
it is defined as a negative number.

Thanks a lot.
Zhu Yanjun

> 
> Thanks,
> 
> Anand
> 


