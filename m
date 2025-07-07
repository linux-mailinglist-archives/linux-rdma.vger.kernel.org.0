Return-Path: <linux-rdma+bounces-11928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3EAAFB225
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F7817025B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E9295517;
	Mon,  7 Jul 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bQ+daE+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF21A238F
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887124; cv=none; b=ItpZGjJyQ9AqGXyhdfe9nb+b4Qngo6eRhPm68w67eGSCKUmjI/bunSDFQk+ZH3SJVdROrh6hpyqwYcNSiAE13cy1W2a3ZZKQwr0jEeK8QGnabJ28Z26crlUDMx3+YeasTaC8JRABoLZ0giYy3gSLPFGUZN6rvfPl6Wo5SCMiQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887124; c=relaxed/simple;
	bh=ymjkoaRwdJS89YFHAW60/H/DbsNPUWoe/bfwnbxZU4E=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L+UPZlh4kDgdlftv9LisDMOLC+VULv6IoOD24WqCZusVCjtakvut/sJ+3m6VZOJO53JhThUcF4fD1DATC86cbHsXl0zjRq6MNFDRnLi7qboD2kKoWqS4fA5jsKwMxT2AfmzBdvQMs8TVW8mUV27ypQwrlKmWSUD9Dj1EzCChKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bQ+daE+P; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751887122; x=1783423122;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=S1gcuNtc6LY7Ma0pqQ0dqbYsTnGbiXIsptXDTs2dQMA=;
  b=bQ+daE+Pi73eJmYF2voLWbNszc/40jDw/7gJK4RAFgMg4QldQeaEvuSL
   kQEr1v+clxE3SP71BrBOurWVhmsCtQ6XOfDj+JGxYOxplUZSsRRY+r8mN
   RzYm7zJ0DUuUjmvVONs9N+Ktag34nHaepyvhKwnCv86YuFBvEfncHEsAb
   U+pEVNhthM+vN6wGxPL5mERyEpfEumVK2sJ4P1xYhUUK62HCy+AGhErNM
   tslsGNz//g2wbtdbnVohdFWqGMsLaRUoOVyduz/Z2JDU3Fqcb/AfjGOVY
   cfyocfnLHt5ICODjfcU3S+59cavr9GrGi4brJru3Ox4TsdG3ixcEhcFCA
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,294,1744070400"; 
   d="scan'208";a="508258862"
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:18:39 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:6056]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.90:2525] with esmtp (Farcaster)
 id 160123e6-af65-4c41-b78a-bedcbbb3f8db; Mon, 7 Jul 2025 11:18:39 +0000 (UTC)
X-Farcaster-Flow-ID: 160123e6-af65-4c41-b78a-bedcbbb3f8db
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 11:18:38 +0000
Received: from [192.168.139.156] (10.85.143.177) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 11:18:35 +0000
Message-ID: <dd59336e-6ab5-4814-a25a-9185d0737ecc@amazon.com>
Date: Mon, 7 Jul 2025 14:18:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20250703182314.16442-1-mrgolin@amazon.com>
 <20250706072523.GQ6278@unreal>
 <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>
 <20250707062808.GT6278@unreal>
 <f8fc9034-41b4-4b2f-8032-1bc9d2bcdb99@amazon.com>
 <20250707102830.GV6278@unreal>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250707102830.GV6278@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/7/2025 1:28 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Jul 07, 2025 at 12:51:40PM +0300, Margolin, Michael wrote:
>> On 7/7/2025 9:28 AM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Sun, Jul 06, 2025 at 07:32:05PM +0300, Margolin, Michael wrote:
>>>> On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
>>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>>>
>>>>>
>>>>>
>>>>> On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
>>>>>>          reinit_completion(&comp_ctx->wait_event);
>>>>>>
>>>>>> @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
>>>>>>                  if (comp_ctx->status == EFA_CMD_COMPLETED)
>>>>>>                          ibdev_err_ratelimited(
>>>>>>                                  aq->efa_dev,
>>>>>> -                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>> +                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>>                                  efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>>>                                  comp_ctx->cmd_opcode, comp_ctx->status,
>>>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>>>>>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>>>>>> +                             aq->cq.cc);
>>>>>>                  else
>>>>>>                          ibdev_err_ratelimited(
>>>>>>                                  aq->efa_dev,
>>>>>> -                             "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>> +                             "The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>>                                  efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>>>                                  comp_ctx->cmd_opcode, comp_ctx->status,
>>>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>>>>>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>>>>>> +                             aq->cq.cc);
>>>>> I have very strong feeling that you don't really use these prints in real life.
>>>>>
>>>>> For example, comp_ctx->cmd_id is printed with %d, while code and comment
>>>>> around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.
>>>>>
>>>>> It has a lot of information separated to LSB and MSB bits which are not readable
>>>>> while printing with %d.
>>>>>
>>>>> You are also printing comp_ctx->status, which is clear from if/else section.
>>>>>
>>>>> So no, I don't buy this claim for "additional debug information", while
>>>>> existing is not used.
>>>> What do you mean by that?!?
>>> If you take a close look on the prints, you will see the reasons.
>>> For example, you print comp_ctx->status which can be only 0 or 1,
>>> while it is already clear what its value from the print itself.
>>>
>>>> These errors are extremely rare and are not manually reproducible, that's
>>>> why we want to collect as much information as we can when it happens.
>>> Do it out-of-tree, there is no need in upstream code for internal debug
>>> sessions.
>> It's not for internal debug, it is used in production. Why would I upstream
>> internal debug prints?
> It is used in internal cloud for the NICs not available to the rest of
> the world. So yes, it is your internal debug print.
>>>> I'm less bothered by the format as long as we have the info we need.
>>> Like I said, it is clear that you never actually relied on this information.
>>> Better if you completely delete these prints and keep them out-of-tree.
>> Not sure that I follow, can you please elaborate on what "relying" means
>> from your POV?
> "relied" == "used"
>
The NIC might be available only in AWS but customers decide what Linux 
versions they use. Many of our customers choose to use upstream versions 
and avoid taking debug or modified versions.

You are right saying the appearance for this print is rare, that's why 
as you pointed out, it isn't perfectly formatted. But this is since the 
issue rarely reproduce, what is exactly the reason we need the print 
in-place when it does.

I can definitely improve the styling if it makes things better.

Michael


