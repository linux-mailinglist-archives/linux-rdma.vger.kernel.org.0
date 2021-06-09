Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804C03A0AD3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhFIDrP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 23:47:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8102 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhFIDrP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 23:47:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0Cbp4q8bzYrkB;
        Wed,  9 Jun 2021 11:42:30 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:45:20 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:45:20 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Wed, 9 Jun 2021 11:45:19 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 06/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of mcast_group
Thread-Topic: [PATCH v4 for-next 06/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of mcast_group
Thread-Index: AQHXU6UjabGanqgQOkeH2uLjSRjukQ==
Date:   Wed, 9 Jun 2021 03:45:19 +0000
Message-ID: <4cd2bfc3eba6410896835744be88bd13@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
 <1622194663-2383-7-git-send-email-liweihang@huawei.com>
 <20210608175533.GA964838@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/9 1:55, Jason Gunthorpe wrote:
> On Fri, May 28, 2021 at 05:37:37PM +0800, Weihang Li wrote:
>> @@ -565,8 +565,11 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
>>  	if (!is_mgid0) {
>>  		spin_lock_irqsave(&port->lock, flags);
>>  		group = mcast_find(port, mgid);
>> -		if (group)
>> +		if (group) {
>> +			refcount_inc(&group->refcount);
>>  			goto found;
>> +		}
>> +
>>  		spin_unlock_irqrestore(&port->lock, flags);
>>  	}
>>  
>> @@ -590,8 +593,10 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
>>  		group = cur_group;
>>  	} else
>>  		refcount_inc(&port->refcount);
>> +
>> +	refcount_set(&group->refcount, 1);
>> +
> 
> This isn't right, when mcast_insert() returns an existing group we
> need to incr not set the refcount. Change it like this:
> 

Thanks, I will modify it.

Weihang

> diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
> index 17abc212b87d05..cf99e17b81ce79 100644
> --- a/drivers/infiniband/core/multicast.c
> +++ b/drivers/infiniband/core/multicast.c
> @@ -585,17 +585,17 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
>  	INIT_LIST_HEAD(&group->active_list);
>  	INIT_WORK(&group->work, mcast_work_handler);
>  	spin_lock_init(&group->lock);
> +	refcount_set(&group->refcount, 1);
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	cur_group = mcast_insert(port, group, is_mgid0);
>  	if (cur_group) {
>  		kfree(group);
>  		group = cur_group;
> +		refcount_inc(&group->refcount);
>  	} else
>  		refcount_inc(&port->refcount);
>  
> -	refcount_set(&group->refcount, 1);
> -
>  found:
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	return group;
> 

