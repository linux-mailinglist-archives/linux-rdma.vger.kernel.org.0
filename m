Return-Path: <linux-rdma+bounces-543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F2824FF3
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 09:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96293280993
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3D21358;
	Fri,  5 Jan 2024 08:25:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m127150.qiye.163.com (mail-m127150.qiye.163.com [115.236.127.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D042420E;
	Fri,  5 Jan 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.69.7] (unknown [121.32.254.147])
	by mail-m12750.qiye.163.com (Hmail) with ESMTPA id 594FEF20615;
	Fri,  5 Jan 2024 16:15:19 +0800 (CST)
Message-ID: <62db1a02-41b8-44b0-960b-6d6f5bec5d19@sangfor.com.cn>
Date: Fri, 5 Jan 2024 16:15:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shifeng Li <lishifeng1992@126.com>, "Ding, Hui" <dinghui@sangfor.com.cn>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
From: Shifeng Li <lishifeng@sangfor.com.cn>
In-Reply-To: <20240104123728.GC50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhhIVk8eQxhJHh5MTU8aS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8cd8b0e062b21dkuuu594fef20615
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6Nyo*TDwoIj80Kh8sECgc
	OiMwFC1VSlVKTEtPT09JTklLSU9JVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpJSlVISVVJTk9VSk9MWVdZCAFZQUlPT083Bg++

On 2024/1/4 20:37, Jason Gunthorpe wrote:
> On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
> 
>> The root cause is that mad_client and cm_client may init concurrently
>> when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
> 
> That can't be true, the module loader infrastructue ensures those two
> things are sequential.
> 

I'm a bit confused how the module loader infrastructue ensures that mad_client.add() and
cm_client.add() are sequential. Could you explain in more detail please?

We know that the ib_cm driver and mlx5_ib driver can load concurrently.

Thanks.

> You are trying to say that the post-client fixup stuff will still see
> the DEVICE_REGISTERED before it reaches the clients_rwsem lock?
> 
> That probably just says the clients_rwsem should be obtained before
> changing the DEVICE_STATE too :\
> 
> Jason
> 


