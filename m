Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D5393C28
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 05:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhE1EAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 28 May 2021 00:00:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2509 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhE1EAT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 00:00:19 -0400
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrrSy4q8FzYqPV;
        Fri, 28 May 2021 11:56:02 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggeml756-chm.china.huawei.com (10.1.199.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 11:58:43 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 11:58:42 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 28 May 2021 11:58:42 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Topic: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Index: AQHXUTJz/ZoltCz67U2TkpxD2y6GdQ==
Date:   Fri, 28 May 2021 03:58:42 +0000
Message-ID: <8de36c1f7a0a4e839c6151b0963a894b@huawei.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
 <1621925504-33019-14-git-send-email-liweihang@huawei.com>
 <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
 <20210527131558.GB1002214@nvidia.com>
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

On 2021/5/27 21:16, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 01:08:37PM +0000, Marciniszyn, Mike wrote:
>>> +++ b/drivers/infiniband/hw/hfi1/verbs.c
>>> @@ -534,7 +534,8 @@ static inline void hfi1_handle_packet(struct
>>> hfi1_packet *packet,
>>>  		 * Notify rvt_multicast_detach() if it is waiting for us
>>>  		 * to finish.
>>>  		 */
>>> -		if (atomic_dec_return(&mcast->refcount) <= 1)
>>> +		refcount_dec(&mcast->refcount);
>>> +		if (refcount_read(&mcast->refcount) <= 1)
>>>  			wake_up(&mcast->wait);
>>
>> Is there refcount_ that preserves the atomic characteristics of the single call?
> 
> You are supposed to us refcount_dec_and_test() for patterns like this,
> this hunk looks wrong to me
> 
> Jason
> 

I made a mistake, thank you.

refcount_dec_and_test() test only if the refcount is 0, so I couldn't find a
good way to replace the atomic_t with refcount_t here.

And there is no refcount_dec/inc_return() for a refcount_t, I found some
previous disscussdion:

https://www.openwall.com/lists/kernel-hardening/2016/11/28/8
https://www.openwall.com/lists/kernel-hardening/2016/12/01/1
https://lkml.org/lkml/2017/9/1/389
https://yhbt.net/lore/all/20200921112218.GB2139@willie-the-truck/t/#md37f8b6084bccbc0ebf76ba249c069372b4d8497

I think such functions undermines the design of refcount. But to be honest, I
didn't find a clear reason.

Peter, could you please explain why you said "add_return and sub_return are
horrible interface for refcount"?

You can review the whole patch at:

https://patchwork.kernel.org/project/linux-rdma/patch/1621925504-33019-14-git-send-email-liweihang@huawei.com/

Thanks
Weihang
