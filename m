Return-Path: <linux-rdma+bounces-765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957EF83D9C2
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBBB2D3F0
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571917732;
	Fri, 26 Jan 2024 11:54:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m255222.qiye.163.com (mail-m255222.qiye.163.com [103.129.255.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A317BC9;
	Fri, 26 Jan 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.255.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270081; cv=none; b=cHbgyw+xMuNVH5j07eq7ZhZDdkCCqK8iINglfzorQrF0e+5gtfrMAqB6IN5+zr5syrsBbJnXFMXWsuwxeib59QhG6fIaGM2s6zlMaPVJVcmDtmjcvjpVQXbKzFfiOBM6lGK7J890/mDwMJYOpfG2rKquuRGU41n+xwkNuC+CR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270081; c=relaxed/simple;
	bh=Bds8OgSb+ANDgZeXtZphHAaeceMSfeyWRHKOgIMh9TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JY6CEmejn7h5F3q9PVKJUqRp3M/Ayn/r+7xoFznRiuuXQHZR2qQNPv3orqdqe0WOlymun1O3RKT6btr+CU9jToUoS4W9SGl0BTeY9TDss2VMpAZFTymm8rhLSgzPBVRyQKPdBC4hZyMVHPHyn19641Spk6mP6JZsTpqU7WXGYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=103.129.255.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.69.7] (unknown [121.32.254.147])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 20CE74601A9;
	Fri, 26 Jan 2024 10:25:02 +0800 (CST)
Message-ID: <5bc6ed6d-31e9-4b44-aa91-5f9d0f3d92c8@sangfor.com.cn>
Date: Fri, 26 Jan 2024 10:25:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
To: Ding Hui <dinghui@sangfor.com.cn>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shifeng Li <lishifeng1992@126.com>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
 <20240104123728.GC50608@ziepe.ca>
 <e029db0a-c515-e61c-d34e-f7f054d51e88@sangfor.com.cn>
 <20240115134707.GZ50608@ziepe.ca>
 <354e2bf7-a8b4-629d-3d2d-35951a52e8bd@sangfor.com.cn>
From: Shifeng Li <lishifeng@sangfor.com.cn>
In-Reply-To: <354e2bf7-a8b4-629d-3d2d-35951a52e8bd@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRlCVhkeGR1DHhpMGUlDGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8d4395bb0903aekunm20ce74601a9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46MSo5FDMPMg8*URccCS80
	KUwaCytVSlVKTEtNSUhOQktISE5DVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpJSlVISVVJTk9VSk9MWVdZCAFZQUNMTE03Bg++

On 2024/1/16 10:12, Ding Hui wrote:
> On 2024/1/15 21:47, Jason Gunthorpe wrote:
>> On Sat, Jan 06, 2024 at 10:12:17AM +0800, Ding Hui wrote:
>>> On 2024/1/4 20:37, Jason Gunthorpe wrote:
>>>> On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:
>>>>
>>>>> The root cause is that mad_client and cm_client may init concurrently
>>>>> when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:
>>>>
>>>> That can't be true, the module loader infrastructue ensures those two
>>>> things are sequential.
>>>>
>>>
>>> Please consider the sequence again and notice that:
>>>
>>> 1. We agree that dependencies ensure mad_client be registered before cm_client.
>>> 2. But the mad_client.add() is not invoked in ib_register_client(), since
>>>     there is no DEVICE_REGISTERED device at that time.
>>>     Instead, it will be delayed until the device driver init (e.g. mlx5_core)
>>>     in enable_device_and_get().
>>> 3. The ib_cm and mlx5_core can be loaded concurrently, after setting DEVICE_REGISTERED
>>>     and downgrade_write(&devices_rwsem) in enable_device_and_get(), there is a chance
>>>     that cm_client.add() can be invoked before mad_client.add().
>>>
>>>
>>>          T1(ib_core init)      |      T2(device driver init)        |        T3(ib_cm init)
>>> ---------------------------------------------------------------------------------------------------
>>> ib_register_client mad_client
>>>    assign_client_id
>>>      add clients CLIENT_REGISTERED
>>>      (with clients_rwsem write)
>>>    down_read(&devices_rwsem);
>>>    xa_for_each_marked (&devices, DEVICE_REGISTERED)
>>>      nop # no devices
>>>    up_read(&devices_rwsem);
>>>
>>>                                ib_register_device
>>>                                  enable_device_and_get
>>>                                    down_write(&devices_rwsem);
>>>                                    set DEVICE_REGISTERED
>>>                                    downgrade_write(&devices_rwsem);
>>>                                                                      ib_register_client cm_client
>>>                                                                        assign_client_id
>>>                                                                          add clients CLIENT_REGISTERED
>>>                                                                          (with clients_rwsem write)
>>>                                                                        down_read(&devices_rwsem);
>>>                                                                        xa_for_each_marked (&devices, DEVICE_REGISTERED)
>>>                                                                          add_client_context
>>>                                                                            down_write(&device->client_data_rwsem);
>>>                                                                            get CLIENT_DATA_REGISTERED
>>>                                                                            downgrade_write(&device->client_data_rwsem);
>>>                                                                            cm_client.add
>>>                                                                              cm_add_one
>>>                                                                                ib_register_mad_agent
>>>                                                                                  ib_get_mad_port
>>>                                                                                    __ib_get_mad_port return NULL!
>>>                                                                            set CLIENT_DATA_REGISTERED
>>>                                                                            up_read(&device->client_data_rwsem);
>>>                                                                        up_read(&devices_rwsem);
>>>                                  down_read(&clients_rwsem);
>>>                                  xa_for_each_marked (&clients, CLIENT_REGISTERED)
>>>                                    add_client_context [mad]
>>>                                      mad_client.add
>>>                                    add_client_context [cm]
>>>                                      nop # already CLIENT_DATA_REGISTERED
>>>                                  up_read(&clients_rwsem);
>>>                                  up_read(&devices_rwsem);
>>
>> Take the draft I sent previously and use down_write(&devices_rwsem) in
>> ib_register_client()
>>
> 
> I believe this modification is effective, rather than expanding the clients_rwsem range,
> the key point is down_write(&devices_rwsem), which prevents ib_register_client() from
> being executed in the gap of ib_register_device().
> 
> However, this may cause a little confusion, as ib_register_client() does not modify
> anything related to devices, but it is protected by a write lock.
> 

Hi Jason，

Do you have any differing opinions about above?



