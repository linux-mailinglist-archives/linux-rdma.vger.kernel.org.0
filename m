Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8FF0BF1
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 03:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfKFCQ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 21:16:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730231AbfKFCQ6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 21:16:58 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DEBCEB07C63B6EE71115;
        Wed,  6 Nov 2019 10:16:56 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 6 Nov 2019
 10:16:48 +0800
Subject: Re: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
To:     Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
 <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191105144103.GF6763@unreal>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <bbad9230-b218-3054-ff10-650ceaa0f7c3@huawei.com>
Date:   Wed, 6 Nov 2019 10:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191105144103.GF6763@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/5 22:41, Leon Romanovsky wrote:
> On Tue, Nov 05, 2019 at 04:09:12AM +0000, Parav Pandit wrote:
>> Hi Yixian Liu,
>>
>>> -----Original Message-----
>>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>>> owner@vger.kernel.org> On Behalf Of Yixian Liu
>>> Sent: Monday, November 4, 2019 9:48 PM
>>> To: dledford@redhat.com; jgg@ziepe.ca
>>> Cc: Parav Pandit <parav@mellanox.com>; leon@kernel.org; linux-
>>> rdma@vger.kernel.org; linuxarm@huawei.com
>>> Subject: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
>>>
>>> This warning can be triggered easily when adding a large number of VLANs
>>> while the capacity of GID table is small.
>>>
>>> Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
>>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
>>> ---
>>>  drivers/infiniband/core/cache.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>> Thanks for the patch. However, vlan netdevice addition is an administrative operation allowed to process which has CAP_NET_ADMIN privilege.
>> So large number of VLAN addition by a user for a RoCE device whose GID capacity is small is constrained operation.
>> Therefore, we shouldn't be rate limiting it.
>> By rate limiting we miss the information about any bugs in GID cache management.
>> At best we can convert it to dev_dbg() so that we still get the necessary debug information when needed.
>> I wanted to convert them trace functions which will allow us to more debug level prints such as netdev name, vlan etc.
>> I think I remember comment from Leon too while working on it, but it was long haul that time.
> 
> I wanted to work on it, but it never happened.

I see, thanks.

> 
> Thanks
> 
> .
> 

