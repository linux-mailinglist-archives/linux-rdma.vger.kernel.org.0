Return-Path: <linux-rdma+bounces-8888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E191FA6B2CE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 03:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6524A405B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CD1DEFE4;
	Fri, 21 Mar 2025 02:02:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A322098;
	Fri, 21 Mar 2025 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522537; cv=none; b=ZlR+HLnFYgIJw54pzdYNqDNptwNX1n340lhW/6xE4DoHh5s6j8WftkUHdOetMaEMsalriqDn8vejyQbOXhx2PHbTvFsuF0K26wcRDLPZuAD3vd/+ZlseAhKP6jXo9hWUlPTMQfnuvdBMBxPKJfKS73Cda11ONCDVRPqGvdDgIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522537; c=relaxed/simple;
	bh=4zeM2xLM1XBpY6Nhy5IRB0WDsZ5EG44zdZssrHpnqwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cWRcpaF28HBRiEnLk/bnyMJl6L2WQaOMYb3576jMeLFzC4qMOkmK56bDGvCndeWV9O2qM8W5Rz2HmfVx4OMnj5ZPf9MeduQ74aZMZgkCIxIpdzOozU6O/O9WXezlt6XZyPUqfpbecnBKeWIcpZSGQsd0sGfPgWITn/ZxwswskxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZJlw86jj1zvWsL;
	Fri, 21 Mar 2025 09:58:16 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FFBC1800E4;
	Fri, 21 Mar 2025 10:02:11 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 10:02:10 +0800
Message-ID: <508c0841-8b39-4891-b373-3ff82b239ee2@huawei.com>
Date: Fri, 21 Mar 2025 10:02:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>, Sean Hefty <shefty@nvidia.com>
CC: Nikolay Aleksandrov <nikolay@enfabrica.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>, "rip.sohan@amd.com"
	<rip.sohan@amd.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"bmt@zurich.ibm.com" <bmt@zurich.ibm.com>, "roland@enfabrica.net"
	<roland@enfabrica.net>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	"davem@redhat.com" <davem@redhat.com>, "ian.ziemba@hpe.com"
	<ian.ziemba@hpe.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, huchunzhi
	<huchunzhi@huawei.com>, "jerry.lilijun@huawei.com"
	<jerry.lilijun@huawei.com>, "zhangkun09@huawei.com" <zhangkun09@huawei.com>,
	"wang.chihyung@huawei.com" <wang.chihyung@huawei.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
 <20250320143253.GV9311@nvidia.com>
 <DM6PR12MB43132490CF7D1CC16AF6D42CBDD82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250320201200.GL206770@nvidia.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250320201200.GL206770@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/21 4:12, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 08:05:05PM +0000, Sean Hefty wrote:
>>>> As the existing rdma subsystem doesn't seems to support the above use
>>>> case yet
>>>
>>> Why would you say that? If EFA needs SRD and RDM objects in RDMA they
>>> can create them, it is not a big issue. To my knowledge they haven't asked for
>>> them.
>>
>> When looking at how to integrate UET support into verbs, there were
>> changes relevant to this discussion that I found needed.
>>
>> 1. Allow an RDMA device to indicate that it supports multiple transports, separated per port.
>> 2. Specify the QP type separate from the protocol.
>> 3. Define a reliable, unconnected QP type.
>>
>> Lin might be referring to 2 (assuming 3 is resolved).

Yes, that was mainly my concern too. If supporting different protocol need
to use the driver specific QP type and do most of the handling in the driver
in the existing rdma subsystem, then it does not seem reasonable from new
protocol perspective if multi vendors implementing the same new protocol
might have duplicated code in their drivers.

> 
> That's at a verbs level though, at the kernel uAPI level we already have
> various ways to do all three..
> 
> What you say makes sense to me for verbs.

I suppose the verbs is corresponding to what is defined in IB spec, and
verbs is not easily updated without updating the IB spec?

> 
> Jason
> 

