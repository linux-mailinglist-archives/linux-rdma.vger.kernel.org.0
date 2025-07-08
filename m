Return-Path: <linux-rdma+bounces-11969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFBDAFD7FF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ADD3B3621
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12BE23D29D;
	Tue,  8 Jul 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="o6Kf06x1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091223D289
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005637; cv=none; b=jTCfg+KFd/MeJuHQsLA2nzcLIWAj3LravjcVu00yD+IKNgFxIWOxh8P7iqf/8eMuBHAqGOCf7uEA642IfWIvVYjWapWd505jG9OZlj6c1TP0UvuK49RPUItWuz5RCQkLCPrCVNc/WyCDDoKKTpnFbSvAFg9krZcA55jOs0Lth7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005637; c=relaxed/simple;
	bh=FS7/00H+JgztLqCXVndl0uuyRc4hXD4K3LZn69j+1r4=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rcfXINzCXYDOutAzWsGsJ1dPXP6wgzj3kZFNU3GtbkG/Rzb/Lm2qHpLqiw9bjdLEm9qyJRUkhMC6dzbD2oxcNkXsPjejg1qwDB/cvdYgLmYMCK+oFVlCLsyJDOoWJ5IsC0pLhXIH4tt+XUwNwmafT5f+YGCCBrAFClBsJT53i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=o6Kf06x1; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752005635; x=1783541635;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=vFKsn0sB0QNVgUGjGhOkTzUU53lTh1EIrS1cQDyhDYk=;
  b=o6Kf06x1CHAfrrKdD36i8yfT2+O9ZzrmSOiuYsi+sfg4xrPNxJ17DF1F
   ljPCMHoVn51EEEacvnNm8y5JQcE+dbQJAZfCaILR/j0NJWQDLFvS9Gtjj
   phiIbwnE3sLKYT9C+l8VGL2hnfg2OO3JqTJDR9iJhNa6lFaODCLpgvp5d
   tIpmHTdvraiqQ2vIaK91aLU6s2Auh9WOd+Z/CgWBRJnBTase//47NDbyK
   xs+TRhmS4LzBtAUCAQAPjqltFjqm6MgaDjNW6dy5o/XoLiIzLohkaoIrl
   HWsf33qDGR7jlN9MF80rfcCUE3QsY3tBc7GseRZPRp2w/7jFDy7tEkxn3
   g==;
X-IronPort-AV: E=Sophos;i="6.16,298,1744070400"; 
   d="scan'208";a="508808916"
Subject: Re: [PATCH for-next 1/2] RDMA/uverbs: Add a common way to create CQ with umem
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:13:51 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:40132]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.212:2525] with esmtp (Farcaster)
 id e1cbcb28-6119-428e-a37f-07408ba743b5; Tue, 8 Jul 2025 20:13:50 +0000 (UTC)
X-Farcaster-Flow-ID: e1cbcb28-6119-428e-a37f-07408ba743b5
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:13:50 +0000
Received: from [192.168.122.16] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:13:47 +0000
Message-ID: <b8f6588c-1bb6-41a2-8f09-121f7cc6ac1a@amazon.com>
Date: Tue, 8 Jul 2025 23:13:42 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>
References: <20250701231545.14282-1-mrgolin@amazon.com>
 <20250701231545.14282-2-mrgolin@amazon.com>
 <20250704181443.GQ1410929@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250704181443.GQ1410929@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/4/2025 9:14 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Jul 01, 2025 at 11:15:44PM +0000, Michael Margolin wrote:
>> Add ioctl command attributes and a common handling for the option to
>> create CQs with memory buffers passed from userspace. When required
>> attributes are supplied, create umem for driver use and store it in CQ
>> context.
>> The extension enables creation of CQs on top of preallocated CPU
>> virtual or device memory buffers, by supplying VA or dmabuf fd, in a
>> common way. At first stage the command fails for any driver that didn't
>> explicitly state its support by setting a flag in the ops struct.
>>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>   drivers/infiniband/core/device.c              |  3 +
>>   drivers/infiniband/core/uverbs_std_types_cq.c | 82 ++++++++++++++++++-
>>   include/rdma/ib_verbs.h                       |  6 ++
>>   include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
>>   4 files changed, 91 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 468ed6bd4722..8b0ce0ec15dd 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2667,6 +2667,9 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>>        dev_ops->uverbs_no_driver_id_binding |=
>>                ops->uverbs_no_driver_id_binding;
>>
>> +     dev_ops->uverbs_support_cq_with_umem |=
>> +             ops->uverbs_support_cq_with_umem;
> This seems to have turned out quite nice!
>
> I might just suggest a tweak to streamline this flow
>
> Add:
>
> +       int (*create_cq_umem)(struct ib_cq *cq,
> +                             const struct ib_cq_init_attr *attr,
> +                             struct ib_umem *umem,
> +                             struct uverbs_attr_bundle *attrs);
>
>
> Instead of the uverbs_support_cq_with_umem
>
> Then the core code would check the two ops and if only umem is present
> it will insist on the new attributes, if it is not present it will
> refuse them otherwise it will call the correct op.
>
> In the driver the create_cq would obtain the umem from the private
> attrs and then call create_cq_umem() in the same way
>
> So it becomes quite easy to just reorganize the drivers to support
> this.
>
> Jason

Generally I would say that adding a new op for an additional optional 
param isn't scalable but I implemented your suggestion and I do think it 
makes things more structured for drivers as well as clarifying umem 
ownership.

Sending v2 series.

Michael


