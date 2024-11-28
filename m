Return-Path: <linux-rdma+bounces-6150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516389DB845
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 14:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AA2281866
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCA11A08B6;
	Thu, 28 Nov 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D7cLfmyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902719D086
	for <linux-rdma@vger.kernel.org>; Thu, 28 Nov 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799293; cv=none; b=VpQAMB9/0rUDu1ThrweFowfFBRYvoAZ9jGhYTthAv5MIIm9jESHVklms77OReF4ZtKKHA4qhYRisWAXiJDnnnvKUC3rM5ZbHgsbV4eYnbofWltzZydqz6i7LLRkJayylI9QXwxnWJXOo79vAyJoKut9C1ze4FISijxNGG/6XFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799293; c=relaxed/simple;
	bh=1yiKS+/c/COdiBScKfDeuNzzQAHj3y3KuJkh+DIeZfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJzWSebJWER2h0K42jpM6At5Wv/vbunsn1uLmR5Fx2o3tlXIPPsBpjZB2yNbPpGmeeVzsEPeHUQ1SL3H7faRNRD4ygOUiJx16ma/cIEjTmkaeedoeGfXZ88+r7p/8YfyifKcGwikE6tQ3CKiQco8d+ZfDdQIE2qdLy7HzwjlNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D7cLfmyu; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d1458ea-b831-47bd-8242-5e1797a8ea34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732799283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/50c4njo4pWIFGmIVUL3V0ScpGBOa5xKqqL+kt2s004=;
	b=D7cLfmyuhMbIwxpsJKbXP+rexpvCZ5ZInoFS9msv0IDu3Fay8glMArIcfdCdjnkU1MWkhr
	muqE+8kSCcXOUCQtq43sz+ZgPbt3/XqjKU/bvAZPlJmNykM+4iKdURMgyzlBSNuJYnhib9
	8fV+YO9fF6oBc7XA1I8v//F36kF8+C0=
Date: Thu, 28 Nov 2024 14:07:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
To: Cheng Xu <chengyou@linux.alibaba.com>,
 Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-2-boshiyu@linux.alibaba.com>
 <e03c5cf0-f4dc-41c2-af48-a95463592eed@linux.dev>
 <765311dd-16d5-28f3-cdda-93578e5f40eb@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <765311dd-16d5-28f3-cdda-93578e5f40eb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/11/28 3:07, Cheng Xu 写道:
> 
> 
> On 11/26/24 11:36 PM, Zhu Yanjun wrote:
>> 在 2024/11/26 7:59, Boshi Yu 写道:
>>> Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
>>> The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
>>> the protocol used by the erdma device. Since each protocol requires
>>> different ib_device_ops, we introduce the erdma_device_ops_iwarp and
>>> erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.
>>>
>> Hi, Boshi
>>
>>  From alomost all of the RDMA users, it seems that RoCEv2 protocol is required while very few users request iWARP protocol in their production hosts. But in the erdma HW/FW, this iWARP protocol is supported. Is this iWARP protocol for some special use cases in the Ali-Cloud environment?
>>
> 
> Hi, Yanjun,
> 
> iWarp & TCP have some good features, such as Tail Loss Probe(TLP), selective ACK and
> out-of-order DDP, so that can get better performance in large-scale lossy network. The

Thanks for your reply. The design purpose of RDMA is for big bandwidth 
and low latency network, that is, a loss-less network. And most users 
work in this loss-less network. I can not image why rdma should work in 
this kind of large-scale lossy network.

Anyway
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> current usage scenarios include HPC industrial simulation, redis, PolarDB and big data
> in public cloud environment.
> 
> Thanks,
> Cheng Xu
> 
>> I am just curious about this, not to be against this patch series. If this is related with the Ali-Cloud security, you can ignore this.
>>
>> Thanks,
>> Zhu Yanjun
>>
> 


