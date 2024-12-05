Return-Path: <linux-rdma+bounces-6257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6F9E4C6D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 03:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C07169EE7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 02:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AD15DBB3;
	Thu,  5 Dec 2024 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rMFOKo78"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51779DC
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366814; cv=none; b=q9AXa1e+aG0Jmn3HknaPBFQsPonDlmJ9x3t4TKIVgpVBDTR8Nw/jG+AAanetv17BWR+lGphN9NuoQBjd2Ws7cJzNpTqg42RIqvQAWTxxmjQPMP5wZe+wEEMpTSiOssFywptj5TlcSXtJIkudZD6wLoMjXlzzhvLdYZpSZiNSfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366814; c=relaxed/simple;
	bh=4jKk/gXYCjE02f6JFf14c89Z7E9LkuJCfcUV/P+fy1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz6UvsFgf3IXBm7z5ShyH6LuANKZR7LNdbOe59y/0aL35Mcgf0uN806Tm92UglbhNYPbhoqnwwox7KdGhaW/9CmNeuu+iGZwiTD0Wlw8OgP6qjArUGkrfBG8Usqks54oc2zLE3je4MgKv78UNRDwoU2GWwx9DAWaQwjKcwovzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rMFOKo78; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733366802; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2R9aPQDLerjdjPUCye9hQsRAAgePTKGvGGZltUlQAQU=;
	b=rMFOKo78A8F6vVjZpf8zwlVWYfIDnJHO1Ac5mS0noz7+BDRbV6aQO5fj9SVcBPUV44EwQz2reWlPT/KvR98uXenwhGDQN4O5g8c5fL2vVWzreaSzZcctE5YXEXqU8uvxAaEYU59j2Zb2WMidjO272bhhcrS0y+lA/UnMO9pCcC4=
Received: from 30.221.116.17(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKrWW7y_1733366801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 10:46:42 +0800
Message-ID: <3559c2d4-41f7-4787-b4fe-46f0a4cd6ff9@linux.alibaba.com>
Date: Thu, 5 Dec 2024 10:46:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
 chengyou@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-2-boshiyu@linux.alibaba.com>
 <20241204140307.GO1245331@unreal>
From: Boshi Yu <boshiyu@linux.alibaba.com>
In-Reply-To: <20241204140307.GO1245331@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/4 22:03, Leon Romanovsky 写道:
> On Tue, Nov 26, 2024 at 02:59:07PM +0800, Boshi Yu wrote:
>> Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
>> The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
>> the protocol used by the erdma device. Since each protocol requires
>> different ib_device_ops, we introduce the erdma_device_ops_iwarp and
>> erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.
>>
>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/Kconfig       |  2 +-
>>   drivers/infiniband/hw/erdma/erdma.h       |  3 +-
>>   drivers/infiniband/hw/erdma/erdma_hw.h    |  7 ++++
>>   drivers/infiniband/hw/erdma/erdma_main.c  | 47 ++++++++++++++++++-----
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 16 +++++++-
>>   drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++++
>>   6 files changed, 75 insertions(+), 12 deletions(-)
> 
> <...>
> 
>> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
>> @@ -172,6 +172,12 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
>>   {
>>   	int ret;
>>   
>> +	dev->proto = erdma_reg_read32(dev, ERDMA_REGS_DEV_PROTO_REG);
>> +	if (!erdma_device_iwarp(dev) && !erdma_device_rocev2(dev)) {
> 
> Why do you need this check? Your old driver which supports only iwarp
> doesn't have this check, so why did you suddenly need it for roce?
> 

Hi, Leon,

We initially try to avoid reading an invalid value from the hardware.
Thank you for your question; I found that the check is unnecessary since
the value of ERDMA_REGS_DEV_PROTO_REG can only be 0 or 1. We will remove
this check in patch v2.

Thanks,

Boshi Yu

>> +		dev_err(&pdev->dev, "Unsupported protocol: %d\n", dev->proto);
>> +		return -ENODEV;
>> +	}
>> +
> 
> Thanks


