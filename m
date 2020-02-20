Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30F9165998
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 09:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBTItB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 03:49:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgBTItB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 03:49:01 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B508ED0AF6ECCDDDC6F3;
        Thu, 20 Feb 2020 16:48:54 +0800 (CST)
Received: from [127.0.0.1] (10.40.203.251) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 16:48:45 +0800
Subject: Re: [PATCH RFC v2 for-next 6/7] RDMA/core: support send port event
To:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-7-liweihang@huawei.com>
 <20200219210732.GB31668@ziepe.ca>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <272c082a-7b92-03ce-43e2-09a282ec878d@huawei.com>
Date:   Thu, 20 Feb 2020 16:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219210732.GB31668@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/20 5:07, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 04:24:07PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> For the process of handling the link event of the net device, the driver
>> of each provider is similar, so it can be integrated into the ib_core for
>> unified processing.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>   drivers/infiniband/core/device.c        |  1 +
>>   drivers/infiniband/core/roce_gid_mgmt.c | 45 +++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 84dd74f..0427a4d 100644
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2225,6 +2225,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>>   
>>   	return res;
>>   }
>> +EXPORT_SYMBOL(ib_device_get_netdev);
>>   
>>   /**
>>    * ib_device_get_by_netdev - Find an IB device associated with a netdev
>> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
>> index 2860def..4170ba3 100644
>> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
>> @@ -751,6 +751,12 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
>>   	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
>>   	struct netdev_event_work_cmd cmds[ROCE_NETDEV_CALLBACK_SZ] = { {NULL} };
>>   
>> +	enum ib_port_state last_state;
>> +	enum ib_port_state curr_state;
>> +	struct ib_device *device;
>> +	struct ib_event ibev;
>> +	unsigned int port;
>> +
>>   	if (ndev->type != ARPHRD_ETHER)
>>   		return NOTIFY_DONE;
>>   
>> @@ -762,6 +768,45 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
>>   		cmds[2] = add_cmd;
>>   		break;
>>   
>> +	case NETDEV_CHANGE:
>> +	case NETDEV_DOWN:
>> +		device = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
>> +		if (!device)
>> +			break;
>> +
>> +		rdma_for_each_port (device, port) {
>> +			if (ib_device_get_netdev(device, port) != ndev)
>> +				continue;
> 
> This feels strange, maybe we need to fix ib_device_get_by_netdev to
> return the port too?

Seems ib_device_get_by_netdev is used infrequently, so the port 
information may only benefit siw and here.

> 
>> +
>> +			if (ib_get_cached_port_inactive_status(device, port))
>> +				break;
>> +
>> +			ib_get_cached_port_state(device, port, &last_state);
>> +			curr_state =
>> +				netif_running(ndev) && netif_carrier_ok(ndev) ?
>> +					IB_PORT_ACTIVE :
>> +					IB_PORT_DOWN;
>> +
>> +			if (last_state == curr_state)
>> +				break;
>> +
>> +			if (curr_state == IB_PORT_DOWN)
>> +				ibev.event = IB_EVENT_PORT_ERR;
>> +			else if (curr_state == IB_PORT_ACTIVE)
>> +				ibev.event = IB_EVENT_PORT_ACTIVE;
>> +			else
>> +				break;
> 
> Other states are ignored?

I think the "curr_state" has only two port states,
maybe the "last_state" has the 3rd state(0) to represent INIT.

> 
>> +
>> +			ibev.device = device;
>> +			ibev.element.port_num = port;
>> +			ib_dispatch_event(&ibev);
>> +			ibdev_dbg(ibev.device, "core send %s\n",
>> +				  ib_event_msg(ibev.event));
>> +		}
>> +
>> +		ib_device_put(device);
>> +		break;
> 
> Ah the series is backwards.
> 
> You need to organize your series so that every patch works
> properly. This has to be before any drivers are removed, and you'll
> need some temporary capability to disable it for drivers that have not
> been migrated yet.

Yes.I will add "some temporary capability" in next to make every patch 
works properly.

Thanks.

> 
> Jason
> 
> .
> 

