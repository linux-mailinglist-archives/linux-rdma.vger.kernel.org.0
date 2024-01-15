Return-Path: <linux-rdma+bounces-633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5082DD84
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF71F22857
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5117BA5;
	Mon, 15 Jan 2024 16:23:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com [103.126.92.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29F17BA4;
	Mon, 15 Jan 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.69.7] (unknown [121.32.254.147])
	by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 8B7656802F0;
	Mon, 15 Jan 2024 11:27:08 +0800 (CST)
Message-ID: <520ac28c-80c6-4c5e-ae88-4c5a8387f3c0@sangfor.com.cn>
Date: Mon, 15 Jan 2024 11:27:07 +0800
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
 <62db1a02-41b8-44b0-960b-6d6f5bec5d19@sangfor.com.cn>
 <20240105141944.GF50608@ziepe.ca>
From: Shifeng Li <lishifeng@sangfor.com.cn>
In-Reply-To: <20240105141944.GF50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxlDVh0YQktLTR8ZSU4YSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8d0b28a2752eb5kusn8b7656802f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6Hjo4DzwoCBpDKT8cSCEz
	NhgaChFVSlVKTEtOSUNCSUlCTk9PVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpJSlVISVVJTk9VSk9MWVdZCAFZQU9JQkw3Bg++

On 2024/1/5 22:19, Jason Gunthorpe wrote:
> On Fri, Jan 05, 2024 at 04:15:18PM +0800, Shifeng Li wrote:
>> On 2024/1/4 20:37, Jason Gunthorpe wrote:
>>> On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
>>>
>>>> The root cause is that mad_client and cm_client may init concurrently
>>>> when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
>>>
>>> That can't be true, the module loader infrastructue ensures those two
>>> things are sequential.
>>>
>>
>> I'm a bit confused how the module loader infrastructue ensures that mad_client.add() and
>> cm_client.add() are sequential. Could you explain in more detail
>> please?
> 
> ib_cm has a symbol dependency on ib_mad, so the module loader will not
> allow ib_cm to start running until all its symbol dependencies have
> completed loading.

I have found a method to reproduce the issue as follow:

1. modprobe -r ib_cm; modprobe -r ib_core; modprobe -r mlx5_ib;
2. Compile and replace ib_core with following patch;
3. modprobe ib_cm;
4. modprobe mlx5_ib;

diff -Narup ./drivers/infiniband/core/device.c ./drivers/infiniband/core/device.c.reproduce
--- ./drivers/infiniband/core/device.c  2024-01-15 11:14:08.063094430 +0800
+++ ./drivers/infiniband/core/device.c.reproduce        2024-01-15 11:16:22.577096953 +0800
@@ -64,6 +64,8 @@ struct workqueue_struct *ib_wq;
  EXPORT_SYMBOL_GPL(ib_wq);
  static struct workqueue_struct *ib_unreg_wq;
  
+int ib_cm_run_flag = 0;
+
  /*
   * Each of the three rwsem locks (devices, clients, client_data) protects the
   * xarray of the same name. Specifically it allows the caller to assert that
@@ -1371,6 +1373,9 @@ static int enable_device_and_get(struct
          */
         downgrade_write(&devices_rwsem);
  
+       ib_cm_run_flag = 1;
+       msleep(30000);
+
         if (device->ops.enable_driver) {
                 ret = device->ops.enable_driver(device);
                 if (ret)
@@ -1843,6 +1848,12 @@ int ib_register_client(struct ib_client
         if (ret)
                 return ret;
  
+       if (strncmp(client->name, "cm", strlen("cm")) == 0) {
+               while (!ib_cm_run_flag) {
+                       cond_resched();
+               }
+       }
+
         down_read(&devices_rwsem);
         xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
                 ret = add_client_context(device, client);

> 
>> We know that the ib_cm driver and mlx5_ib driver can load concurrently.
> 
> Yes, this is possible
> 
> Jason
> 


