Return-Path: <linux-rdma+bounces-6137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A269DB155
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 03:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876C51675B2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A3481B7;
	Thu, 28 Nov 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xkJK+gN1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A335C0
	for <linux-rdma@vger.kernel.org>; Thu, 28 Nov 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759676; cv=none; b=rii+ZCPqvNtKHHVAIVPJOAFy9qoiW1OqzK0LzLrQryBI2Dw3lhMq9gHOUwmUlc9nt0cagqzYGuQ9CBGj9iLqSNHNGkjtOMCd3a/CwVmKdByThCBiaOryPcMdfg9c37UGn76OmcWM0vRapj+yFQjUMry0MBnlevrQMurV3N7n53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759676; c=relaxed/simple;
	bh=foRZmNvQ2q0vsvqkXVVo+YQszAjU6L7xRMqvVK9LtMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipikq7bAlGPxfUflFrojO/rVWeJ0TprQPo9k/aUrBLGy8wkSLK+bJ9F6mBfNlE+GSn7DykhkU073hsN+WsVpH7528eUyGkGHbXT2oDN4nbN0XX4PVDcZ4RYIsw6uVFlhY5Vhl7Mh6GphSYWliuc2pXrN8RSee/vLyOc5BsCDDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xkJK+gN1; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732759665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vSn1OGlDEEXAMw+bVXV6z0jhwh9ETUy8UjhSDkeIHp8=;
	b=xkJK+gN175wodtrdWOKTapah+GNUBpKwr14aq/Ua7uB1zSi0aDcxmBU+66lgzMzasPjqrPYjxQFUQ3anY+ExDaoU5+/On6trh6BthQ0A240lKv2NQa5nAzR4pHblMYYPhRa9+MRAMYmufSA0lsWywyzRcH+MrzGuQS1xSS13nHc=
Received: from 30.221.116.205(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WKNtRp2_1732759663 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 10:07:44 +0800
Message-ID: <765311dd-16d5-28f3-cdda-93578e5f40eb@linux.alibaba.com>
Date: Thu, 28 Nov 2024 10:07:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Boshi Yu <boshiyu@linux.alibaba.com>,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-2-boshiyu@linux.alibaba.com>
 <e03c5cf0-f4dc-41c2-af48-a95463592eed@linux.dev>
Content-Language: en-US
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <e03c5cf0-f4dc-41c2-af48-a95463592eed@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/26/24 11:36 PM, Zhu Yanjun wrote:
> 在 2024/11/26 7:59, Boshi Yu 写道:
>> Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
>> The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
>> the protocol used by the erdma device. Since each protocol requires
>> different ib_device_ops, we introduce the erdma_device_ops_iwarp and
>> erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.
>>
> Hi, Boshi
> 
> From alomost all of the RDMA users, it seems that RoCEv2 protocol is required while very few users request iWARP protocol in their production hosts. But in the erdma HW/FW, this iWARP protocol is supported. Is this iWARP protocol for some special use cases in the Ali-Cloud environment?
> 

Hi, Yanjun,

iWarp & TCP have some good features, such as Tail Loss Probe(TLP), selective ACK and
out-of-order DDP, so that can get better performance in large-scale lossy network. The
current usage scenarios include HPC industrial simulation, redis, PolarDB and big data
in public cloud environment.

Thanks,
Cheng Xu

> I am just curious about this, not to be against this patch series. If this is related with the Ali-Cloud security, you can ignore this.
> 
> Thanks,
> Zhu Yanjun
> 


