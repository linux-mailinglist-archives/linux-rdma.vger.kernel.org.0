Return-Path: <linux-rdma+bounces-1953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA928A6263
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 06:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7759B28351B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E22E403;
	Tue, 16 Apr 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D2i5KAqD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9320B0E
	for <linux-rdma@vger.kernel.org>; Tue, 16 Apr 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241632; cv=none; b=ZaP/Q/4XMtQytBtJ6S6lmPnBl6+TVc4juudRyRPe8jkjozctFG8bWuLbizxkhhGrsl9jcejyFxLbKPmbhbDLglzGOLUvUH/cda03rqfjLWbp6eKKX72/B5uYxGMHpVqjWAA23G1BvgciU1s7NnDxVsghEDXRHJfaiuMr0v5P0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241632; c=relaxed/simple;
	bh=0xecUiT5IqPzvTJOIQC5hqXruSFac8zxlq/vQvqSXgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcQT2dF18RzlfK7hXBNA00gwMqRBh1rGSI9L3M/OFETRphBd61t4MYPzYPhhJ0nuwE/NQlOu8JigiICO6F6qW5jXwC2JrM/HZ9x64p1CgyN7ZuiE+NN0VmBM6PPVpU+JS/aq32QT46aBAhvuNoALLgp5YhDpDm81+iXYP18uuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D2i5KAqD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713241628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtudUHObd5FAkvIMzOg0MTxFzzCYwBlwkkCYwlAcIHs=;
	b=D2i5KAqDKs8klSfndz0c2S1gYNEJbLXTY+VzV7COIzkHA1uL+rCg9e9Q4G3y+kNAbDbXRT
	eVd6uS6SXRNA5bvuftrLsOmHwavWXM4GUcFIeKETdUPT2R6W6ADCqvbOni2GhHgBli2KBJ
	ka/Pxqb6H0cImaD/fyvxs+Dsej9rAP4=
Date: Tue, 16 Apr 2024 06:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>,
 Leon Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Shradha Gupta <shradhagupta@microsoft.com>, Yury Norov
 <yury.norov@gmail.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240415161305.GO223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/15 18:13, Jason Gunthorpe 写道:
> On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
>> Add new device attributes to view multiport, msix, and adapter MTU
>> setting for MANA device.
>>
>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> ---
>>   .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
>>   include/net/mana/gdma.h                       |  9 +++
>>   2 files changed, 83 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> index 1332db9a08eb..6674a02cff06 100644
>> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
>>   	return dev_id == MANA_PF_DEVICE_ID;
>>   }
>>   
>> +static ssize_t mana_attr_show(struct device *dev,
>> +			      struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct gdma_context *gc = pci_get_drvdata(pdev);
>> +	struct mana_context *ac = gc->mana.driver_data;
>> +
>> +	if (strcmp(attr->attr.name, "mport") == 0)
>> +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
>> +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
>> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
>> +	else if (strcmp(attr->attr.name, "msix") == 0)
>> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
>> +	else
>> +		return -EINVAL;
>> +
> 
> That is not how sysfs should be implemented at all, please find a
> good example to copy from. Every attribute should use its own function
> with the macros to link it into an attributes group and sysfs_emit
> should be used for printing

Not sure if this file drivers/infiniband/hw/usnic/usnic_ib_sysfs.c is a 
good example or not.

Zhu Yanjun

> 
> Jason


