Return-Path: <linux-rdma+bounces-12807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC262B29B61
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A1218A54A9
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADC2BD5A4;
	Mon, 18 Aug 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oJ62Ad6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0859277CAC
	for <linux-rdma@vger.kernel.org>; Mon, 18 Aug 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503751; cv=none; b=d35LOTsl+WSEJmy7rby0knRlqaUTYIuliutzjdk/5HY7dc99F/SF+V70uUZ0UCz/zgLfppxQIvFgGzkfLrwEKWoD6YDjOCUMvlurI56ExGF18R5xANudVVIS5ftweNZYClbscAX6S5x9RooY6srS+vP3UMpylnCyE90O7O5+2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503751; c=relaxed/simple;
	bh=IjqD8qsolFp+3egy9l/GmbgTnoX2xldlJ1bM9bKd3qk=;
	h=Subject:Message-ID:Date:MIME-Version:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rnlqXYocywqh/Ml42bnzNg8BN17kT/DRptSW+9h7OkZuEIc+jzO13gGCvI/EYh/eXZ8RQXoGqXCyVm7e491Vgy7c45zZ9Q6pkU5XFJ509Ev69PLNRIv9A0JWzlchwoVogkVchzf29QR9Pnwol0Dc4Yd1gTH22MPUeGoUow1w64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oJ62Ad6X; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755503749; x=1787039749;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=sfzYe3CBhOdVmE3JWr3mo2VDvsgKp2+5ayKcnSzrEtQ=;
  b=oJ62Ad6XKOT7njqSRXDrZDKs6SOVrqYMT2KMIjQQQx8/gMcVZFJu2aYU
   HjZi1V2JwTvp7wPv2RRo8+6ULF0NJBhanAXZgw5C6TAyaU8eNSEeF49dZ
   8oMmGMzSljrDXkO0Z2+WX2SH2j0M1w1P+2pIzoyEcP8GHoav6kvD3EnK5
   s/srL1Wushrqjacz3zbBz9uC+zwfdTlNBQIz7U5Mq+RiDj/8P3/0J3aV2
   /r7M9isEcg9VysV7GMVYXBRjCPJ1XqA/uyJBMsHWjbvcfZllmaTaMvhRT
   MmE3tHAHLkcOvAti2xpFou47LCBOJC//GQehLAFkfvQ0iyjilEsSY5sIu
   g==;
X-CSE-ConnectionGUID: PSsvjyfRSWuUpSwtwmI+2A==
X-CSE-MsgGUID: TfLwJBQ6RG6YNpf7RczhLA==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="868738"
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-west-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 07:55:38 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:45113]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.225:2525] with esmtp (Farcaster)
 id a3dd292d-563c-498a-b82b-0fc7624b153a; Mon, 18 Aug 2025 07:55:37 +0000 (UTC)
X-Farcaster-Flow-ID: a3dd292d-563c-498a-b82b-0fc7624b153a
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 07:55:37 +0000
Received: from [192.168.141.233] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 07:55:32 +0000
Message-ID: <4d595390-a37d-40ea-8a3c-7962ece8e33c@amazon.com>
Date: Mon, 18 Aug 2025 10:55:25 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Margolin, Michael" <mrgolin@amazon.com>
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
 <dd59336e-6ab5-4814-a25a-9185d0737ecc@amazon.com>
Content-Language: en-US
In-Reply-To: <dd59336e-6ab5-4814-a25a-9185d0737ecc@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/7/2025 2:18 PM, Margolin, Michael wrote:
>
> On 7/7/2025 1:28 PM, Leon Romanovsky wrote:
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you can confirm the sender 
>> and know the content is safe.
>>
>>
>>
>> On Mon, Jul 07, 2025 at 12:51:40PM +0300, Margolin, Michael wrote:
>>> On 7/7/2025 9:28 AM, Leon Romanovsky wrote:
>>>> CAUTION: This email originated from outside of the organization. Do 
>>>> not click links or open attachments unless you can confirm the 
>>>> sender and know the content is safe.
>>>>
>>>>
>>>>
>>>> On Sun, Jul 06, 2025 at 07:32:05PM +0300, Margolin, Michael wrote:
>>>>> On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
>>>>>> CAUTION: This email originated from outside of the organization. 
>>>>>> Do not click links or open attachments unless you can confirm the 
>>>>>> sender and know the content is safe.
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
>>>>>>> reinit_completion(&comp_ctx->wait_event);
>>>>>>>
>>>>>>> @@ -557,17 +559,19 @@ static int 
>>>>>>> efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx 
>>>>>>> *com
>>>>>>>                  if (comp_ctx->status == EFA_CMD_COMPLETED)
>>>>>>>                          ibdev_err_ratelimited(
>>>>>>>                                  aq->efa_dev,
>>>>>>> -                             "The device sent a completion but 
>>>>>>> the driver didn't receive any MSI-X interrupt for admin cmd 
>>>>>>> %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, 
>>>>>>> cq consumer: %d)\n",
>>>>>>> +                             "The device sent a completion but 
>>>>>>> the driver didn't receive any MSI-X interrupt for admin cmd 
>>>>>>> %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq 
>>>>>>> consumer: %d)\n",
>>>>>>> efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>>>> comp_ctx->cmd_opcode, comp_ctx->status,
>>>>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, 
>>>>>>> aq->cq.cc);
>>>>>>> +                             comp_ctx->cmd_id, aq->sq.pc, 
>>>>>>> aq->sq.cc,
>>>>>>> +                             aq->cq.cc);
>>>>>>>                  else
>>>>>>>                          ibdev_err_ratelimited(
>>>>>>>                                  aq->efa_dev,
>>>>>>> -                             "The device didn't send any 
>>>>>>> completion for admin cmd %s(%d) status %d (ctx 0x%p, sq 
>>>>>>> producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>>> +                             "The device didn't send any 
>>>>>>> completion for admin cmd %s(%d) status %d (id: %d, sq producer: 
>>>>>>> %d, sq consumer: %d, cq consumer: %d)\n",
>>>>>>> efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>>>> comp_ctx->cmd_opcode, comp_ctx->status,
>>>>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, 
>>>>>>> aq->cq.cc);
>>>>>>> +                             comp_ctx->cmd_id, aq->sq.pc, 
>>>>>>> aq->sq.cc,
>>>>>>> +                             aq->cq.cc);
>>>>>> I have very strong feeling that you don't really use these prints 
>>>>>> in real life.
>>>>>>
>>>>>> For example, comp_ctx->cmd_id is printed with %d, while code and 
>>>>>> comment
>>>>>> around cmd_id in __efa_com_submit_admin_cmd() suggests that it 
>>>>>> needs to be 0x%X.
>>>>>>
>>>>>> It has a lot of information separated to LSB and MSB bits which 
>>>>>> are not readable
>>>>>> while printing with %d.
>>>>>>
>>>>>> You are also printing comp_ctx->status, which is clear from 
>>>>>> if/else section.
>>>>>>
>>>>>> So no, I don't buy this claim for "additional debug information", 
>>>>>> while
>>>>>> existing is not used.
>>>>> What do you mean by that?!?
>>>> If you take a close look on the prints, you will see the reasons.
>>>> For example, you print comp_ctx->status which can be only 0 or 1,
>>>> while it is already clear what its value from the print itself.
>>>>
>>>>> These errors are extremely rare and are not manually reproducible, 
>>>>> that's
>>>>> why we want to collect as much information as we can when it happens.
>>>> Do it out-of-tree, there is no need in upstream code for internal 
>>>> debug
>>>> sessions.
>>> It's not for internal debug, it is used in production. Why would I 
>>> upstream
>>> internal debug prints?
>> It is used in internal cloud for the NICs not available to the rest of
>> the world. So yes, it is your internal debug print.
>>>>> I'm less bothered by the format as long as we have the info we need.
>>>> Like I said, it is clear that you never actually relied on this 
>>>> information.
>>>> Better if you completely delete these prints and keep them 
>>>> out-of-tree.
>>> Not sure that I follow, can you please elaborate on what "relying" 
>>> means
>>> from your POV?
>> "relied" == "used"
>>
> The NIC might be available only in AWS but customers decide what Linux 
> versions they use. Many of our customers choose to use upstream 
> versions and avoid taking debug or modified versions.
>
> You are right saying the appearance for this print is rare, that's why 
> as you pointed out, it isn't perfectly formatted. But this is since 
> the issue rarely reproduce, what is exactly the reason we need the 
> print in-place when it does.
>
> I can definitely improve the styling if it makes things better.
>
> Michael
>
Leon, do you have any additional concerns regarding this patch? It's 
more than 6 weeks in the pipe now.

We are asking customers to use patched drivers and we shouldn't be there.


Michael


