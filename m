Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607E616558B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 04:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBTDTh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 22:19:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbgBTDTh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 22:19:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69FD77A8F6DABE932F4E;
        Thu, 20 Feb 2020 11:19:35 +0800 (CST)
Received: from [127.0.0.1] (10.40.203.251) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 11:19:25 +0800
Subject: Re: [PATCH RFC v2 for-next 1/7] RDMA/core: add inactive attribute of
 ib_port_cache
To:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-2-liweihang@huawei.com>
 <20200219210130.GY31668@ziepe.ca>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <cf62eeae-5e5e-a228-7a9e-8eccfc90c5fc@huawei.com>
Date:   Thu, 20 Feb 2020 11:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219210130.GY31668@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/20 5:01, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 04:24:02PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Add attribute inactive to mark bonding backup port.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>   drivers/infiniband/core/cache.c | 16 +++++++++++++++-
>>   include/rdma/ib_cache.h         | 10 ++++++++++
>>   include/rdma/ib_verbs.h         |  2 ++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index d535995..7a7ef0e 100644
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -1175,6 +1175,19 @@ int ib_get_cached_port_state(struct ib_device   *device,
>>   }
>>   EXPORT_SYMBOL(ib_get_cached_port_state);
>>   
>> +u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num)
>> +{
>> +	unsigned long flags;
>> +	u8 inactive;
>> +
>> +	read_lock_irqsave(&device->cache.lock, flags);
>> +	inactive = device->port_data[port_num].cache.inactive;
>> +	read_unlock_irqrestore(&device->cache.lock, flags);
>> +
>> +	return inactive;
>> +}
>> +EXPORT_SYMBOL(ib_get_cached_port_inactive_status);
>> +
>>   /**
>>    * rdma_get_gid_attr - Returns GID attributes for a port of a device
>>    * at a requested gid_index, if a valid GID entry exists.
>> @@ -1393,7 +1406,7 @@ static void ib_cache_update(struct ib_device *device,
>>   	if (!rdma_is_port_valid(device, port))
>>   		return;
>>   
>> -	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
>> +	tprops = kzalloc(sizeof *tprops, GFP_KERNEL);
>>   	if (!tprops)
>>   		return;
>>   
>> @@ -1435,6 +1448,7 @@ static void ib_cache_update(struct ib_device *device,
>>   	device->port_data[port].cache.pkey = pkey_cache;
>>   	device->port_data[port].cache.lmc = tprops->lmc;
>>   	device->port_data[port].cache.port_state = tprops->state;
>> +	device->port_data[port].cache.inactive = tprops->inactive;
>>   
>>   	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>>   	write_unlock_irq(&device->cache.lock);
>> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
>> index 870b5e6..63b2dd6 100644
>> +++ b/include/rdma/ib_cache.h
>> @@ -131,6 +131,16 @@ int ib_get_cached_port_state(struct ib_device *device,
>>   			      u8                port_num,
>>   			      enum ib_port_state *port_active);
>>   
>> +/**
>> + * ib_get_cached_port_inactive_status - Returns a cached port inactive status
>> + * @device: The device to query.
>> + * @port_num: The port number of the device to query.
>> + *
>> + * ib_get_cached_port_inactive_status() fetches the specified event inactive
>> + * status stored in the local software cache.
>> + */
>> +u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num);
>> +
> 
> kdocs belong with the implementation, not in the header file

All of ib_get_cached_XXX() should remove rdma_is_port_valid() and move 
kdocs from ib_cache.h to cache.c.
I can send this first, independently.

> 
>>   bool rdma_is_zero_gid(const union ib_gid *gid);
>>   const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
>>   					    u8 port_num, int index);
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 5608e14..e17d846 100644
>> +++ b/include/rdma/ib_verbs.h
>> @@ -665,6 +665,7 @@ struct ib_port_attr {
>>   	u8			active_speed;
>>   	u8                      phys_state;
>>   	u16			port_cap_flags2;
>> +	u8 			inactive;
>>   };
> 
> Why is a major structure being changed for this?
> 
> If LAG is to be brought up to the core code then the core should know
> what leg is active or not, not the driver.

"LAG is to be brought up to the core", is this under planning?
The link event report could be after this . Then, there may be a better 
way to ignore inactive port.

> 
>>   enum ib_device_modify_flags {
>> @@ -2145,6 +2146,7 @@ struct ib_port_cache {
>>   	struct ib_gid_table   *gid;
>>   	u8                     lmc;
>>   	enum ib_port_state     port_state;
>> +	u8                     inactive;
>>   };
> 
> Please think carefully about structure patcking here, both placements
> of u8 seem poor
> 
> Jason
> 
> .
> 

