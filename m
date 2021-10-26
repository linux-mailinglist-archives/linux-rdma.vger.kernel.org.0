Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC443AAA3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhJZDQa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 23:16:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26121 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhJZDQ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 23:16:29 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HdcLc1H5Xz1DHrc;
        Tue, 26 Oct 2021 11:12:08 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 26 Oct 2021 11:14:01 +0800
Subject: Re: [PATCH rdma-rc] IB/core: fix a UAF for netdev in netdevice_event
 process
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>, <mbloch@nvidia.com>,
        <jinpu.wang@ionos.com>, <lee.jones@linaro.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211025034258.2426872-1-william.xuanziyang@huawei.com>
 <YXZdsyifJVY+jOaH@unreal> <00f99243-919a-d697-646a-0e200c0aef81@huawei.com>
 <YXaPm6oTI/lk5GoT@unreal>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <07239ae2-8994-20a6-1cba-c3018c9b0117@huawei.com>
Date:   Tue, 26 Oct 2021 11:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YXaPm6oTI/lk5GoT@unreal>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>>>> diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
>>>> index 68197e576433..063dbe72b7c2 100644
>>>> --- a/drivers/infiniband/core/roce_gid_mgmt.c
>>>> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
>>>> @@ -621,6 +621,7 @@ static void netdevice_event_work_handler(struct work_struct *_work)
>>>>  {
>>>>  	struct netdev_event_work *work =
>>>>  		container_of(_work, struct netdev_event_work, work);
>>>> +	struct net_device *real_dev;
>>>>  	unsigned int i;
>>>>  
>>>>  	for (i = 0; i < ARRAY_SIZE(work->cmds) && work->cmds[i].cb; i++) {
>>>> @@ -628,6 +629,12 @@ static void netdevice_event_work_handler(struct work_struct *_work)
>>>>  					 work->cmds[i].filter_ndev,
>>>>  					 work->cmds[i].cb,
>>>>  					 work->cmds[i].ndev);
>>>> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].ndev);
>>>> +		if (real_dev)
>>>> +			dev_put(real_dev);
>>>> +		real_dev = rdma_vlan_dev_real_dev(work->cmds[i].filter_ndev);
>>>> +		if (real_dev)
>>>> +			dev_put(real_dev);
>>>>  		dev_put(work->cmds[i].ndev);
>>>>  		dev_put(work->cmds[i].filter_ndev);
>>>>  	}
>>>> @@ -638,9 +645,10 @@ static void netdevice_event_work_handler(struct work_struct *_work)
>>>>  static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
>>>>  				struct net_device *ndev)
>>>>  {
>>>> -	unsigned int i;
>>>>  	struct netdev_event_work *ndev_work =
>>>>  		kmalloc(sizeof(*ndev_work), GFP_KERNEL);
>>>> +	struct net_device *real_dev;
>>>> +	unsigned int i;
>>>>  
>>>>  	if (!ndev_work)
>>>>  		return NOTIFY_DONE;
>>>> @@ -653,6 +661,12 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
>>>>  			ndev_work->cmds[i].filter_ndev = ndev;
>>>>  		dev_hold(ndev_work->cmds[i].ndev);
>>>>  		dev_hold(ndev_work->cmds[i].filter_ndev);
>>>> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
>>>> +		if (real_dev)
>>>> +			dev_hold(real_dev);
>>>> +		real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].filter_ndev);
>>>> +		if (real_dev)
>>>> +			dev_hold(real_dev);
>>>>  	}
>>>>  	INIT_WORK(&ndev_work->work, netdevice_event_work_handler);
>>>
>>> Probably, this is the right change, but I don't know well enough that
>>> part of code. What prevents from "real_dev" to disappear right after
>>> your call to rdma_vlan_dev_real_dev()?
>>>
>>
>> It is known that free the net_device until its dev_refcnt is one. The
>> detail realization see netdev_run_todo().The real_dev's dev_refcnt of
>> a vlan net_device will reach one after unregister_netdevice(&real_dev)
>> and unregister_vlan_dev(&vlan_ndev, ...) but the dev_refcnt of the vlan
>> net_device is bigger than one because netdevice_queue_work() will hold
>> the vlan net_device. So my solution is hold the real_dev too in
>> netdevice_queue_work().
> 
>               dev_hold(ndev_work->cmds[i].filter_ndev);
>  +            real_dev = rdma_vlan_dev_real_dev(ndev_work->cmds[i].ndev);
>  +            if (real_dev)
>                   <------------ real_dev is released here.
>  +                    dev_hold(real_dev);

At first, I thought the real_dev's dev_refcnt is bigger than one before
NETDEV_UNREGISTER notifier event of the vlan net_device because it calls
dev_put(real_dev) after calling unregister_netdevice_queue(dev, head).
I thought unregister_netdevice_queue() would issue NETDEV_UNREGISTER
notifier event of the vlan net_device, I can hold the real_dev in
NETDEV_UNREGISTER notifier event handler netdevice_queue_work().

But I read unregister_vlan_dev() again, found unregister_netdevice_queue()
in unregister_vlan_dev() just move the vlan net_device to a list to unregister
later. So it is possible the real_dev has been freed when we access in
netdevice_queue_work() although the probability is very small.

So the modification need to improve. For example set vlan->real_dev = NULL
after dev_put(real_dev) in unregister_vlan_dev() proposed by Jason Gunthorpe.

Do you have any other good ideas?

Thank you!
