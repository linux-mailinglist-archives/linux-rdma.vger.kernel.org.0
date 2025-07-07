Return-Path: <linux-rdma+bounces-11920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55CAFB056
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E3F7B29A7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCC291C11;
	Mon,  7 Jul 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PWR1NalF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6B292B22
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881914; cv=none; b=YwmY663zzKGDzc7NgljRunxDfY38BM08+STcPeTVjytSAHHNnJQRAUfCvCbVo/nthS4Ge8Y5jqV4had+bPbKqj6vwwxUltiY2lp4J1AdGvw95kGN4bINEVy8bNEeHrwI36LpCkDPMx54iVRh0sIQjGHOSjGcDgGdX83p++jxUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881914; c=relaxed/simple;
	bh=oalSbbzEqx2u1nMxgthXPsD2ee/sRoiNBELza1nJmCA=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJHYi4X+aWl8pbce3fRuVYv41miVfXLx+Lqv9kXb7+73QtRdfepMfUnzH9JVQOxEsjQzDhoBBbGMDNgmyYZTThmjMwvZA0yz08ZOSdfABhNUPWLcUs+2H9lnR+DhgVkKJDB1mzUE/F8WCu3O6Ste33XK4CXkXzODJVFhP5WcnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PWR1NalF; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751881912; x=1783417912;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=rCOm/0EEbetDH0WKWQFsm6epSmRBBbp8gKXtY3v4L8I=;
  b=PWR1NalF8QwoTXZAWJC+1+uQlvDBAbJqgf9cD9mgwFfsttgaMJPeb+Yu
   AAgmXhLR0HOCNDddYcSgLDQy1+6hgMgL0qZYpOdphQl1KEDijsAVb5XWO
   2rU0BoapblSHwLdV9vPQOm/lRvrCsnrFcL4GZL+Q9t7Wpr4fLVqs/NMis
   gK/X0/YO7nhXVjC67tpic10pTTIfNJ/o0g4Era52q0VzZYCYxN4cuaUGs
   Jmd3CKJnKqMvg85/Jj7pMAjRN8qvCkAW9YX4FAOauUiXUhl5YeKw72nbJ
   z+hedjFCjaj5qBBgsqv8t0fZUzeTDangppmbAm0WKfReiKJ/BMdHnPDDV
   A==;
X-IronPort-AV: E=Sophos;i="6.16,293,1744070400"; 
   d="scan'208";a="217040346"
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 09:51:50 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:11521]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.121:2525] with esmtp (Farcaster)
 id 91b3cdec-6809-4813-8d5c-d07eb3a9d3b8; Mon, 7 Jul 2025 09:51:49 +0000 (UTC)
X-Farcaster-Flow-ID: 91b3cdec-6809-4813-8d5c-d07eb3a9d3b8
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 09:51:48 +0000
Received: from [192.168.139.156] (10.85.143.177) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 09:51:45 +0000
Message-ID: <f8fc9034-41b4-4b2f-8032-1bc9d2bcdb99@amazon.com>
Date: Mon, 7 Jul 2025 12:51:40 +0300
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
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250707062808.GT6278@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/7/2025 9:28 AM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Sun, Jul 06, 2025 at 07:32:05PM +0300, Margolin, Michael wrote:
>> On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
>>>>         reinit_completion(&comp_ctx->wait_event);
>>>>
>>>> @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
>>>>                 if (comp_ctx->status == EFA_CMD_COMPLETED)
>>>>                         ibdev_err_ratelimited(
>>>>                                 aq->efa_dev,
>>>> -                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>> +                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>                                 efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>                                 comp_ctx->cmd_opcode, comp_ctx->status,
>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>>>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>>>> +                             aq->cq.cc);
>>>>                 else
>>>>                         ibdev_err_ratelimited(
>>>>                                 aq->efa_dev,
>>>> -                             "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>> +                             "The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>>>                                 efa_com_cmd_str(comp_ctx->cmd_opcode),
>>>>                                 comp_ctx->cmd_opcode, comp_ctx->status,
>>>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>>>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>>>> +                             aq->cq.cc);
>>> I have very strong feeling that you don't really use these prints in real life.
>>>
>>> For example, comp_ctx->cmd_id is printed with %d, while code and comment
>>> around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.
>>>
>>> It has a lot of information separated to LSB and MSB bits which are not readable
>>> while printing with %d.
>>>
>>> You are also printing comp_ctx->status, which is clear from if/else section.
>>>
>>> So no, I don't buy this claim for "additional debug information", while
>>> existing is not used.
>> What do you mean by that?!?
> If you take a close look on the prints, you will see the reasons.
> For example, you print comp_ctx->status which can be only 0 or 1,
> while it is already clear what its value from the print itself.
>
>> These errors are extremely rare and are not manually reproducible, that's
>> why we want to collect as much information as we can when it happens.
> Do it out-of-tree, there is no need in upstream code for internal debug
> sessions.

It's not for internal debug, it is used in production. Why would I 
upstream internal debug prints?

>> I'm less bothered by the format as long as we have the info we need.
> Like I said, it is clear that you never actually relied on this information.
> Better if you completely delete these prints and keep them out-of-tree.

Not sure that I follow, can you please elaborate on what "relying" means 
from your POV?

Michael


