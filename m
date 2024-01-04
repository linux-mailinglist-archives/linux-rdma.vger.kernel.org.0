Return-Path: <linux-rdma+bounces-535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26895823E93
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4E1C239B5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6020323;
	Thu,  4 Jan 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MA9077I5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD222030F
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jan 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704360350; x=1735896350;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=fI6osL9MqyWxhmBc9J30ATQ7hX0xzG9orbgdrNecUeM=;
  b=MA9077I5FyQGxmzBwhL6TGsCb9SYYVK8Y+4xLO8Tn8DvZnLrPjeZEWT5
   MN/ARnhvw6azy8tT9ZqSBOtmJFBEE/t6f7htkuBsFUDWSfvM4I9GnbGQO
   0ZPoqg8H3K6l/UPvhWm6BdgdehW10wd9FCm7gOSZwO7OLMTLCDxH8NIH+
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="372424595"
Subject: Re: [PATCH for-next] RDMA/efa: Limit EQs to available MSI-X vectors
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:25:47 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 8BB0380495;
	Thu,  4 Jan 2024 09:25:45 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:43924]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.235:2525] with esmtp (Farcaster)
 id 151e3fd5-2e37-4da9-a905-647b2d22bf7a; Thu, 4 Jan 2024 09:25:44 +0000 (UTC)
X-Farcaster-Flow-ID: 151e3fd5-2e37-4da9-a905-647b2d22bf7a
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:25:42 +0000
Received: from [192.168.136.188] (10.85.143.176) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:25:39 +0000
Message-ID: <2edc6365-42a6-4d94-88cb-6ff8cbd9bf52@amazon.com>
Date: Thu, 4 Jan 2024 11:25:33 +0200
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
CC: <sleybo@amazon.com>, <matua@amazon.com>, Michael Margolin
	<mrgolin@amazon.com>, Yonatan Goldhirsh <ygold@amazon.com>
References: <20240103142134.2191-1-ynachum@amazon.com>
 <3845b1b5-6e1d-445c-b937-c8bf7af42a77@linux.dev>
From: "Nachum, Yonatan" <ynachum@amazon.com>
In-Reply-To: <3845b1b5-6e1d-445c-b937-c8bf7af42a77@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)

>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
>> index 15ee92081118..1aade398c723 100644
>> --- a/drivers/infiniband/hw/efa/efa_main.c
>> +++ b/drivers/infiniband/hw/efa/efa_main.c
>> @@ -319,7 +319,9 @@ static int efa_create_eqs(struct efa_dev *dev)
>>       int err;
>>       int i;
>>
>> -     neqs = min_t(unsigned int, neqs, num_online_cpus());
>> +     neqs = min_t(unsigned int, neqs,
>> +                  dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
>> +
> If the device supports one msix (which is reserved for commands) you'll
> end up with zero neqs, and allocate a zero-sized dev->eqs array.
>
> Won't that break when efa_create_cq() is called and try to access this
> array?
> Especially since efa_ib_device_add() sets num_comp_vectors to 1 in such
> case..
>
>>       dev->neqs = neqs;
>>       dev->eqs = kcalloc(neqs, sizeof(*dev->eqs), GFP_KERNEL);
>>       if (!dev->eqs)

When the number of EQs is 0 we don't report EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS
to the upper layer (rdma-core for example) so it won't be able to request the driver for
CQs with interrupts enabled. So in terms of behavior we keep the same behavior as older driver
versions.

I will need create a separate patch for num_comp_vectors to represent the number of EQs even if its 0 and add driver protection for out of bounds reach to the EQ array. Thanks.

