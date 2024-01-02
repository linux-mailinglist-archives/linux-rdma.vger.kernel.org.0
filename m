Return-Path: <linux-rdma+bounces-516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81E821B3A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2583D283221
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC9EADC;
	Tue,  2 Jan 2024 11:53:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m118102.qiye.163.com (mail-m118102.qiye.163.com [115.236.118.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B6EAD7;
	Tue,  2 Jan 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.69.7] (unknown [121.32.254.147])
	by mail-m12750.qiye.163.com (Hmail) with ESMTPA id DE9D7F201DA;
	Tue,  2 Jan 2024 19:33:41 +0800 (CST)
Message-ID: <61e69337-c32e-4df7-a31c-faf112f36466@sangfor.com.cn>
Date: Tue, 2 Jan 2024 19:33:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, wenglianfa@huawei.com, gustavoars@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shifeng Li <lishifeng1992@126.com>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240102085814.GD6361@unreal>
From: Shifeng Li <lishifeng@sangfor.com.cn>
In-Reply-To: <20240102085814.GD6361@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0weVkweHRhDThlDT0IfGlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8cc9f36a96b21dkuuude9d7f201da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6CCo4UTw*P08jOBIfUUkt
	LSIaChVVSlVKTEtPSkJOSUlJTU1PVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpJSlVISVVJTk9VSk9MWVdZCAFZQUxISE83Bg++

On 2024/1/2 16:58, Leon Romanovsky wrote:
> On Mon, Jan 01, 2024 at 07:43:35PM -0800, Shifeng Li wrote:
>> The mad_client will be initialized in enable_device_and_get(), while the
>> devices_rwsem will be downgraded to a read semaphore. There is a window
>> that leads to the failed initialization for cm_client, since it can not
>> get matched mad port from ib_mad_port_list, and the matched mad port will
>> be added to the list after that.
>>
>>      mad_client    |                       cm_client
>> ------------------|--------------------------------------------------------
>> ib_register_device|
>> enable_device_and_get
>> down_write(&devices_rwsem)
>> xa_set_mark(&devices, DEVICE_REGISTERED)
>> downgrade_write(&devices_rwsem)
>>                    |
>>                    |ib_cm_init
>>                    |ib_register_client(&cm_client)
>>                    |down_read(&devices_rwsem)
>>                    |xa_for_each_marked (&devices, DEVICE_REGISTERED)
>>                    |add_client_context
>>                    |cm_add_one
>>                    |ib_register_mad_agent
>>                    |ib_get_mad_port
>>                    |__ib_get_mad_port
>>                    |list_for_each_entry(entry, &ib_mad_port_list, port_list)
>>                    |return NULL
>>                    |up_read(&devices_rwsem)
>>                    |
>> add_client_context|
>> ib_mad_init_device|
>> ib_mad_port_open  |
>> list_add_tail(&port_priv->port_list, &ib_mad_port_list)
>> up_read(&devices_rwsem)
>>                    |
> 
> How is this stack possible?
> 
> ib_register_device() is called by drivers and happens much later than ib_cm_init().
> 

I've caught the stack and err log as follows, ib_mad_init_device() called after
cm_add_one().

[   98.281786] CPU: 18 PID: 30079 Comm: modprobe Kdump: loaded
[   98.281787] Call Trace:
[   98.281790]  dump_stack+0x71/0xab
[   98.281805]  ib_register_mad_agent+0x1c6/0x27f0 [ib_core]
[   98.281840]  cm_add_one+0x4b0/0x9d0 [ib_cm]
[   98.281865]  add_client_context+0x2b9/0x380 [ib_core]
[   98.281890]  ib_register_client+0x22a/0x2a0 [ib_core]
[   98.281908]  __init_backport+0x12f/0x1000 [ib_cm]
[   98.281912]  do_one_initcall+0x87/0x2e2
[   98.281926]  do_init_module+0x1c3/0x5f7
[   98.281928]  load_module+0x4fe0/0x68d0
[   98.281945]  __do_sys_finit_module+0x14d/0x180
[   98.281952]  do_syscall_64+0xa0/0x370
[   98.281957]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[   98.281958] RIP: 0033:0x7f51d3a4373d
[   98.281961] RSP: 002b:00007ffceb925938 EFLAGS: 00000202 ORIG_RAX: 0000000000000139
[   98.281964] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f51d3a4373d
[   98.281965] RDX: 0000000000000000 RSI: 0000000001636b70 RDI: 0000000000000003
[   98.281966] RBP: 00007ffceb925950 R08: 0000000000000000 R09: 0000000001636b70
[   98.281967] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000402410
[   98.281968] R13: 00007ffceb926e60 R14: 0000000000000000 R15: 0000000000000000

[   98.281977] infiniband mlx5_1: ib_register_mad_agent: Invalid port 1

[   98.349040] CPU: 38 PID: 29896 Comm: modprobe Kdump: loaded
[   98.349043] Call Trace:
[   98.349053]  dump_stack+0x71/0xab
[   98.349076]  ib_register_mad_agent+0x1c6/0x27f0 [ib_core]
[   98.349149]  ib_agent_port_open+0xe2/0x2d0 [ib_core]
[   98.349164]  ib_mad_init_device+0x818/0x1d70 [ib_core]
[   98.349197]  add_client_context+0x2b9/0x380 [ib_core]
[   98.349221]  enable_device_and_get+0x1ab/0x340 [ib_core]
[   98.349292]  ib_register_device+0xcbf/0xfd0 [ib_core]
[   98.349355]  __mlx5_ib_add+0x44/0xf0 [mlx5_ib]
[   98.349404]  mlx5_add_device+0xc3/0x280 [mlx5_core]
[   98.349434]  mlx5_register_interface+0x109/0x190 [mlx5_core]
[   98.349442]  do_one_initcall+0x87/0x2e2
[   98.349460]  do_init_module+0x1c3/0x5f7
[   98.349462]  load_module+0x4fe0/0x68d0
[   98.349481]  __do_sys_init_module+0x1f9/0x220
[   98.349486]  do_syscall_64+0xa0/0x370
[   98.349492]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[   98.349494] RIP: 0033:0x7fbc327faa7a
[   98.349500] RSP: 002b:00007fff890df7f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000af
[   98.349502] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc327faa7a
[   98.349503] RDX: 00000000004250c0 RSI: 00000000001b0230 RDI: 00007fbc31919010
[   98.349505] RBP: 00007fff890df860 R08: 00000000025045b0 R09: 0000000000000000
[   98.349506] R10: 00000000001b0230 R11: 0000000000000202 R12: 0000000000402410
[   98.349507] R13: 00007fff890e0cf0 R14: 0000000000000000 R15: 0000000000000000

Thanks

> Thanks
> 
>>
>> Fix it by using the devices_rwsem write semaphore to protect the mad_client
>> init flow in enable_device_and_get().
>>
>> Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
>> Cc: Shifeng Li <lishifeng1992@126.com>
>> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
>> ---
>>   drivers/infiniband/core/device.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 67bcea7a153c..85782786993d 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1315,12 +1315,6 @@ static int enable_device_and_get(struct ib_device *device)
>>   	down_write(&devices_rwsem);
>>   	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
>>   
>> -	/*
>> -	 * By using downgrade_write() we ensure that no other thread can clear
>> -	 * DEVICE_REGISTERED while we are completing the client setup.
>> -	 */
>> -	downgrade_write(&devices_rwsem);
>> -
>>   	if (device->ops.enable_driver) {
>>   		ret = device->ops.enable_driver(device);
>>   		if (ret)
>> @@ -1337,7 +1331,7 @@ static int enable_device_and_get(struct ib_device *device)
>>   	if (!ret)
>>   		ret = add_compat_devs(device);
>>   out:
>> -	up_read(&devices_rwsem);
>> +	up_write(&devices_rwsem);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.25.1
>>
>>
> 


