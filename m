Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2D3AC4E7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFRH0C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Jun 2021 03:26:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7486 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRH0C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 03:26:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5r1f3NPnzZhXJ;
        Fri, 18 Jun 2021 15:20:54 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (7.185.36.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:23:50 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:23:50 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 18 Jun 2021 15:23:50 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        linyunsheng <linyunsheng@huawei.com>
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Topic: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Index: AQHXU6R/LojSLjaQ0EW84zhJi1oR7g==
Date:   Fri, 18 Jun 2021 07:23:50 +0000
Message-ID: <fae84e6e29f94f26849aa709285cb8cf@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
 <20210604145005.GA405010@nvidia.com>
 <efc5283d762542f6a4add9329744c4ee@huawei.com>
 <20210611113124.GO1002214@nvidia.com>
 <3fa07c87b91047a79402a9871e4e932a@huawei.com>
 <20210616191413.GO1002214@nvidia.com>
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

On 2021/6/17 3:14, Jason Gunthorpe wrote:
> On Wed, Jun 16, 2021 at 09:55:45AM +0000, liweihang wrote:
> 
>> If there is still any issues in this process, could you please tell us where to
>> add the barrier? Thank you :)
> 
> I don't know ARM perfectly well, but generally look at
> 
>  1) Do these special stores barrier with the spin unlock protecting
>     the post send? Allowing them to leak out will get things out of
>     order

I do not think we need to rely on the spin unlock to ensure correct ordering for
ST4 store.
ST4 store is similiar as DB store, the difference is that DB store writes 8
bytes to the device's MMIO space and ST4 store writes 64 bytes, the ST4 store
can be ordered by udma_to_device_barrier() too, which mean we can also use
udma_to_device_barrier() to ensure correct ordering between ST4 store and DB
store too.

> 
>  2) ARM MMIO stores are not ordered, so that DB store the ST4 store
>     are not guaranteed to execute in program order without a barrier.
>     The spinlock is not a MMIO barrier
> 

As there is udma_to_device_barrier() between each round of post send, we can
guarantee that the last DB store/ST4 store reaches the device before issuing the
the next DB store/ST4 store.

> You could ignore some of this when the DB rings were basically
> idempotent, but if you are xfering data it is more tricky. This is why
> we always see a barrier after a WC store to put all future MMIO
> strongly in order with the store.
> 
> Jason
> 

"st4 store" writes the doorbell and the content of WQE to the roce engine, and
the st4 store ensure doorbell and the content of WQE both reach the roce engine
at the same time. we tried to avoid WC store by using st4 store here, as WC
store might need a different barrier in order to flush the data to the device.

Thanks
Weihang
