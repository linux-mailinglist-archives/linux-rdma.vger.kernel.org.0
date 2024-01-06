Return-Path: <linux-rdma+bounces-548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3428825DD8
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jan 2024 03:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEE11C218CC
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jan 2024 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E015A8;
	Sat,  6 Jan 2024 02:20:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m25491.xmail.ntesmail.com (mail-m25491.xmail.ntesmail.com [103.129.254.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BC1381;
	Sat,  6 Jan 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [0.0.0.0] (unknown [IPV6:240e:3b7:3270:7fa0:85a6:e42d:4e25:cac7])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 0C4152C03C5;
	Sat,  6 Jan 2024 10:12:19 +0800 (CST)
Message-ID: <e029db0a-c515-e61c-d34e-f7f054d51e88@sangfor.com.cn>
Date: Sat, 6 Jan 2024 10:12:17 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shifeng Li <lishifeng1992@126.com>, Shifeng Li <lishifeng@sangfor.com.cn>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20240104123728.GC50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE0fVkMeSU5CQhgeTBkfQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlMQUhJTEtBTB0aS0FDThpNQR5PSR9BTx5JTkEYGhhMWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg++
X-HM-Tid: 0a8cdc8ae567b249kuuu0c4152c03c5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6FSo4QzweFD5NTQIDDiFI
	TklPCQxVSlVKTEtPTktMSkhCQ0NMVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxLQUwdGktBQ04aTUEeT0kfQU8eSU5BGBoYTFlXWQgBWUFNSkpLNwY+

On 2024/1/4 20:37, Jason Gunthorpe wrote:
> On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
> 
>> The root cause is that mad_client and cm_client may init concurrently
>> when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
> 
> That can't be true, the module loader infrastructue ensures those two
> things are sequential.
> 

Please consider the sequence again and notice that:

1. We agree that dependencies ensure mad_client be registered before cm_client.
2. But the mad_client.add() is not invoked in ib_register_client(), since
    there is no DEVICE_REGISTERED device at that time.
    Instead, it will be delayed until the device driver init (e.g. mlx5_core)
    in enable_device_and_get().
3. The ib_cm and mlx5_core can be loaded concurrently, after setting DEVICE_REGISTERED
    and downgrade_write(&devices_rwsem) in enable_device_and_get(), there is a chance
    that cm_client.add() can be invoked before mad_client.add().


         T1(ib_core init)      |      T2(device driver init)        |        T3(ib_cm init)
---------------------------------------------------------------------------------------------------
ib_register_client mad_client
   assign_client_id
     add clients CLIENT_REGISTERED
     (with clients_rwsem write)
   down_read(&devices_rwsem);
   xa_for_each_marked (&devices, DEVICE_REGISTERED)
     nop # no devices
   up_read(&devices_rwsem);

                               ib_register_device
                                 enable_device_and_get
                                   down_write(&devices_rwsem);
                                   set DEVICE_REGISTERED
                                   downgrade_write(&devices_rwsem);
                                                                     ib_register_client cm_client
                                                                       assign_client_id
                                                                         add clients CLIENT_REGISTERED
                                                                         (with clients_rwsem write)
                                                                       down_read(&devices_rwsem);
                                                                       xa_for_each_marked (&devices, DEVICE_REGISTERED)
                                                                         add_client_context
                                                                           down_write(&device->client_data_rwsem);
                                                                           get CLIENT_DATA_REGISTERED
                                                                           downgrade_write(&device->client_data_rwsem);
                                                                           cm_client.add
                                                                             cm_add_one
                                                                               ib_register_mad_agent
                                                                                 ib_get_mad_port
                                                                                   __ib_get_mad_port return NULL!
                                                                           set CLIENT_DATA_REGISTERED
                                                                           up_read(&device->client_data_rwsem);
                                                                       up_read(&devices_rwsem);
                                 down_read(&clients_rwsem);
                                 xa_for_each_marked (&clients, CLIENT_REGISTERED)
                                   add_client_context [mad]
                                     mad_client.add
                                   add_client_context [cm]
                                     nop # already CLIENT_DATA_REGISTERED
                                 up_read(&clients_rwsem);
                                 up_read(&devices_rwsem);

> You are trying to say that the post-client fixup stuff will still see
> the DEVICE_REGISTERED before it reaches the clients_rwsem lock?
> 
> That probably just says the clients_rwsem should be obtained before
> changing the DEVICE_STATE too :\
> 


-- 
Thanks,
- Ding Hui


