Return-Path: <linux-rdma+bounces-6561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F089F434E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 07:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B09188F966
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA015624D;
	Tue, 17 Dec 2024 06:09:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AA18E20;
	Tue, 17 Dec 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415758; cv=none; b=NvQh766zLTCqCNX7Ch3kyL97vmpOZExUyQCWWFfKtjsQokqaWqRxj2Jyf4IFy1fgKtYVIDB0eBDkxGtzsAn3jWU9ooTTxvoUSxWohrCURB3XiEiq6CukeHjE8bveTfl1nJf3mah4PruX9O6nyQQSodF5MwITlduhrrpLKV3tXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415758; c=relaxed/simple;
	bh=ocI9FGvYylHELrxh6ft4J8TxAQ1rprBKmDRcD6uQjws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N3sfRrvVqyMGejrPGBu6b9KsLyo8jsDkg2TGGQlslR0VQhgetwE96gfPSvSOHCARFCU3RXFkEWaLHrOXmYcYO9o7UFnhiQcMFux6DFzaPCGi1Tzp7irsIXDlCpqFRrwIjAP0bwP4aR4DaJvEOZmOMX4OQI3Ef+hh7x0Yv/G64BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YC5tx1lctz21nWh;
	Tue, 17 Dec 2024 14:07:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EDB51A016C;
	Tue, 17 Dec 2024 14:09:12 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Dec 2024 14:09:11 +0800
Message-ID: <39f42a84-57d9-51bb-401d-b7ecf685bd78@hisilicon.com>
Date: Tue, 17 Dec 2024 14:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
 <20241209190125.GA2367762@nvidia.com>
 <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
 <20241210134827.GG2347147@nvidia.com>
 <92d90a3b-40e5-b47a-e570-ca63e4e58126@hisilicon.com>
 <Z1wtPniGY+OVQhqz@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <Z1wtPniGY+OVQhqz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/12/13 20:49, Jason Gunthorpe wrote:
> On Fri, Dec 13, 2024 at 05:37:58PM +0800, Junxian Huang wrote:
>>> But your reset flow partially disassociates the device, when the
>>> userspace goes back to sleep, or rearms the CQ, it should get a hard
>>> fail and do a full cleanup without relying on flushing. 
>>
>> Not sure if I got your point, when you said "the userspace goes back to sleep",
>> did you mean the ibv_get_async_event() api? Are you suggesting that userspace
>> should call ibv_get_async_event() to monitor async events, and when it gets a
>> fatal event, it should stop polling CQs and clean up everything instead of
>> still waiting for the remaining CQEs?
> 
> Yes, it should do that as well. This is wha the devce fatal event is
> for.
> 
> I'm also saying that any kernel systems calls, like sleeping for CQ
> events should start failing too.
> 
> Jason

Thanks. I took a cursory look at some open-source userspace projects,
UCX and SPDK handle the device fatal event properly by doing cleanup.
But Ceph doesn't seem to have any special handling except for logs..

Junxian

