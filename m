Return-Path: <linux-rdma+bounces-11912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A6FAFA688
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402463B91C4
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2D2135A1;
	Sun,  6 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lVxDP2u6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78C165F1A
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751819541; cv=none; b=cl+thym/OrkrmIVuMqH/EoFUK8RDGL4Wd3+p4w8XxO6fCp22rjg6rVHkX/RefE8TDGikTUHHu07lEbdTSeJMOTZ1aEkp66LDWVwqewQRkneqMg+pe7T1G9EUf1U/sDPfycgAWlgTmMR9+SysijLetzuOM2ixZDBwXEtyt0c+i3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751819541; c=relaxed/simple;
	bh=Gt6sRkwR0Wv1MgbSwCOR1mW9Y53CuG4Mb23b3G1k040=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U9tl1ZsfE4RQCaadPbCNAOpmK2xzF9CyVpMjmV+wBBUit2ghjOO3IsjHGGjJQ9/KVcOfNgwVyrO7aAHWUnxk94kUqmtK7pp3p65KiferVL369DBKeAEcHf2mlD48cHEYuInjLjTUpnDKfsZIizF8e9mDAbgL9HLYigMzuOohfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lVxDP2u6; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751819540; x=1783355540;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=3CyNgxI8NdCmCTlLCNwh8Iq1kiEuawJSUZWWklZ/So8=;
  b=lVxDP2u68OVh56gpniDYksSH+zbhUQnNVy239wSEwJ5cxysU4A887O7s
   uYW/NXuDRvc69kksznvSy3Av0X6km+YHSTBITfkaZZ2nvjTqXZjis2phM
   4oemQhAvkkLVDdPn9iKBWcKZuHr571mALgJfsg3Yuqo/MumV5EXgduG7L
   M8Dy0ar6j2NDjj3HwbwBL5Mx8xIgx1rY9IBMK9iPk5I5vtChKaZ5ipEH5
   2pQ9os7AdYAulMGwagxceTywzq5cv1Xb/X2TAPIF+kpZo0Qq/bNChiDlW
   uKspupGd0YtBh+FpKp8aCcel4QwPXVvWBkh3+rwsge5iH709UFM98UlNb
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,292,1744070400"; 
   d="scan'208";a="508102949"
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 16:32:15 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:51887]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.165:2525] with esmtp (Farcaster)
 id 13332953-e127-4fd1-8bc4-f2db57219cbf; Sun, 6 Jul 2025 16:32:13 +0000 (UTC)
X-Farcaster-Flow-ID: 13332953-e127-4fd1-8bc4-f2db57219cbf
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Jul 2025 16:32:13 +0000
Received: from [192.168.121.59] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Jul 2025 16:32:10 +0000
Message-ID: <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>
Date: Sun, 6 Jul 2025 19:32:05 +0300
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
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250706072523.GQ6278@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
>>        reinit_completion(&comp_ctx->wait_event);
>>
>> @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
>>                if (comp_ctx->status == EFA_CMD_COMPLETED)
>>                        ibdev_err_ratelimited(
>>                                aq->efa_dev,
>> -                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>> +                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>                                efa_com_cmd_str(comp_ctx->cmd_opcode),
>>                                comp_ctx->cmd_opcode, comp_ctx->status,
>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>> +                             aq->cq.cc);
>>                else
>>                        ibdev_err_ratelimited(
>>                                aq->efa_dev,
>> -                             "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>> +                             "The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
>>                                efa_com_cmd_str(comp_ctx->cmd_opcode),
>>                                comp_ctx->cmd_opcode, comp_ctx->status,
>> -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
>> +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
>> +                             aq->cq.cc);
> I have very strong feeling that you don't really use these prints in real life.
>
> For example, comp_ctx->cmd_id is printed with %d, while code and comment
> around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.
>
> It has a lot of information separated to LSB and MSB bits which are not readable
> while printing with %d.
>
> You are also printing comp_ctx->status, which is clear from if/else section.
>
> So no, I don't buy this claim for "additional debug information", while
> existing is not used.

What do you mean by that?!?

These errors are extremely rare and are not manually reproducible, 
that's why we want to collect as much information as we can when it happens.

I'm less bothered by the format as long as we have the info we need.


Michael

>
> Thanks
>

