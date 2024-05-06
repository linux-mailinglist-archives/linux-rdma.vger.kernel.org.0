Return-Path: <linux-rdma+bounces-2296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36688BCDFD
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CC7287BBC
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31511B672;
	Mon,  6 May 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ChgUekeV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918C748F
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998715; cv=none; b=mzJ4jFAaHQluu+JMZap2xPEH7H7PcU8d5Bku0x1eWiKUfFZljAMIoz6CpyyXHnwkTF/1nS834B+NUEwse/05j5Vx1YKPvGBAawdMv+0jsROapFYIXEo2qaSwuXrOVkalA1ZloL2NjIS9JfGU1Dr/lF0cBLDFEas0P/Lw63HbLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998715; c=relaxed/simple;
	bh=mxg4Z4oafHVulw/uIwjZkOQ7GUAchshEfrvj0YsSY5U=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aPO5drHpCYBUhqvtNaaEHxvNHXhsj46Crlw5m9Ioall+9uXDjWw0xxeQB89vOLyiZzXaCKLWyqdWCuzNce9lB9gGooNwcF7bLzEFUuiQhnJn2o6hCjtkUS4i+6DpM1kEDRwVWarkETIfYxBD9OxvpGpSaBvtI1tyLSTvX4Hg4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ChgUekeV; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714998714; x=1746534714;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=rmdGGDmyq3ebaclz8W+GYzRccLWZy3YDoiM216unRCI=;
  b=ChgUekeVeR4azkLldPTY7p68fpdfi67r1rZ03BZP5VT6SN7a1dSZ5Z1c
   ZECUNgND2lMW5GkXs0VdKe4RSsAncKIrPkg82VyCqGQuT1mX9oEG7+q0o
   N3q7QVGODshgS2ZE+LGdq3KV0BvhWhHPV9p1IYj4d3whccn6wSJ+dfVKW
   o=;
X-IronPort-AV: E=Sophos;i="6.07,258,1708387200"; 
   d="scan'208";a="293181423"
Subject: Re: [PATCH for-next] RDMA/efa: Support QP with unsolicited write w/ imm.
 receive
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 12:31:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:14636]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.154:2525] with esmtp (Farcaster)
 id bc6a7ca8-a1f7-4f56-9ea5-2010d477c0bd; Mon, 6 May 2024 12:31:48 +0000 (UTC)
X-Farcaster-Flow-ID: bc6a7ca8-a1f7-4f56-9ea5-2010d477c0bd
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 12:31:48 +0000
Received: from [192.168.151.66] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 12:31:44 +0000
Message-ID: <e8e1d66f-b3cc-40e3-8920-284e2eba15b6@amazon.com>
Date: Mon, 6 May 2024 15:31:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Daniel Kranzdorf
	<dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20240506104859.9225-1-mrgolin@amazon.com>
 <50a20417-596e-4183-93c6-63fdef526a18@linux.dev>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <50a20417-596e-4183-93c6-63fdef526a18@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Hey Gal,

Thanks I'll fix that.


Michael

On 5/6/2024 2:19 PM, Gal Pressman wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> Hi Michael,
>
> On 06/05/2024 13:48, Michael Margolin wrote:
>> @@ -663,7 +666,9 @@ struct efa_admin_feature_device_attr_desc {
>>         *    polling is supported
>>         * 3 : rdma_write - If set, RDMA Write is supported
>>         *    on TX queues
>> -      * 31:4 : reserved - MBZ
>> +      * 4 : unsolicited_write_recv - If set, unsolicited
>> +      *    write with imm. receive is supported
>> +      * 32:5 : reserved - MBZ
> Nit: 31:5.
>
>>         */
>>        u32 device_caps;
>>
>>   struct efa_ibv_create_qp {
>>        __u32 comp_mask;
>>        __u32 rq_ring_size; /* bytes */
>>        __u32 sq_ring_size; /* bytes */
>>        __u32 driver_qp_type;
>> +     __u16 flags;
>> +     __u8 reserved_90[6];
> Don't you need to verify this reserved is cleared somewhere?
>
>>   };

