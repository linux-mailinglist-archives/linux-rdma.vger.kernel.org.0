Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7240381561
	for <lists+linux-rdma@lfdr.de>; Sat, 15 May 2021 05:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEODJN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 14 May 2021 23:09:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3760 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEODJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 May 2021 23:09:12 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhqxZ0DwLzmgRW;
        Sat, 15 May 2021 11:04:34 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 15 May 2021 11:07:59 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 15 May 2021 11:07:58 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Sat, 15 May 2021 11:07:58 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Topic: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Index: AQHXSGaCBgr5LwNpvECpXt268+zsNg==
Date:   Sat, 15 May 2021 03:07:58 +0000
Message-ID: <693f3fc2bcb04615b22a829ac50eb679@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <1620958299-4869-2-git-send-email-liweihang@huawei.com>
 <20210514123445.GY1002214@nvidia.com>
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

On 2021/5/14 20:34, Jason Gunthorpe wrote:
> On Fri, May 14, 2021 at 10:11:34AM +0800, Weihang Li wrote:
>> The refcount_t API will WARN on underflow and overflow of a reference
>> counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
>> regarded as there is a risk about use-after-free. So it should be set to 1
>> directly during initialization.
> 
> What does this comment about 0 to 1 mean?
> 

Hi Jason,

I first thought refcount_inc() and atomic_inc() are exactly the same, but I got
a warning about refcount_t on iwpm_init() after the replacement:

[   16.882939] refcount_t: addition on 0; use-after-free.
[   16.888065] WARNING: CPU: 2 PID: 1 at lib/refcount.c:25
refcount_warn_saturate+0xa0/0x144
..
[   17.014698] Call trace:
[   17.017135]  refcount_warn_saturate+0xa0/0x144
[   17.021559]  iwpm_init+0x104/0x12c
[   17.024948]  iw_cm_init+0x24/0xd0
[   17.028248]  do_one_initcall+0x54/0x2d0
[   17.032068]  kernel_init_freeable+0x224/0x294
[   17.036407]  kernel_init+0x20/0x12c
[   17.039880]  ret_from_fork+0x10/0x18

Then I noticed that the comment of refcount_inc() says:

 * Will WARN if the refcount is 0, as this represents a possible use-after-free
 * condition.

so I made changes:

@@ -77,8 +77,12 @@ int iwpm_init(u8 nl_client)
                        ret = -ENOMEM;
                        goto init_exit;
                }
+
+               refcount_set(&iwpm_admin.refcount, 1);
+       } else {
+               refcount_inc(&iwpm_admin.refcount);
        }
-       refcount_inc(&iwpm_admin.refcount);
+

I wrote the comments because I thought someone might be confused by the above
changes :)

> This all seems like a good idea but I wish you had done one patch per
> variable changed
> 
> Jason
> 

Sure, thanks.

Weihang

