Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F638703F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhERDgQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 May 2021 23:36:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4725 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbhERDgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 23:36:14 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkhP80ZKfzmhX2;
        Tue, 18 May 2021 11:31:24 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 11:34:30 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 11:34:30 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 18 May 2021 11:34:29 +0800
From:   liweihang <liweihang@huawei.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Topic: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Index: AQHXSGaCBgr5LwNpvECpXt268+zsNg==
Date:   Tue, 18 May 2021 03:34:29 +0000
Message-ID: <6328764d6be74e3f804ed13f70cf76df@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <1620958299-4869-2-git-send-email-liweihang@huawei.com>
 <c90bd7a612c64f26bc5caa95179e7de7@intel.com>
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

On 2021/5/18 7:03, Saleem, Shiraz wrote:
>> Subject: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of atomic_t for
>> reference counting
>>
>> The refcount_t API will WARN on underflow and overflow of a reference counter,
>> and avoid use-after-free risks. Increase refcount_t from 0 to 1 is regarded as there
>> is a risk about use-after-free. So it should be set to 1 directly during initialization.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/iwcm.c        |  9 ++++-----
>>  drivers/infiniband/core/iwcm.h        |  2 +-
>>  drivers/infiniband/core/iwpm_util.c   | 12 ++++++++----
>>  drivers/infiniband/core/iwpm_util.h   |  2 +-
>>  drivers/infiniband/core/mad_priv.h    |  2 +-
>>  drivers/infiniband/core/multicast.c   | 30 +++++++++++++++---------------
>>  drivers/infiniband/core/uverbs.h      |  2 +-
>>  drivers/infiniband/core/uverbs_main.c | 12 ++++++------
>>  8 files changed, 37 insertions(+), 34 deletions(-)
>>
> 
> [...]
> 
>> @@ -589,9 +589,9 @@ static struct mcast_group *acquire_group(struct
>> mcast_port *port,
>>  		kfree(group);
>>  		group = cur_group;
>>  	} else
>> -		atomic_inc(&port->refcount);
>> +		refcount_inc(&port->refcount);
>>  found:
>> -	atomic_inc(&group->refcount);
>> +	refcount_inc(&group->refcount);
> 
> Seems like there is refcount_inc with refcount = 0 when the group is first created?

Yes, one of "refcount_inc(&group->refcount)" led to the issue that Leon had
reported. I will fix it, thank you.

Weihang

> 
>>  	spin_unlock_irqrestore(&port->lock, flags);
>>  	return group;
>>  }
> 
> 

