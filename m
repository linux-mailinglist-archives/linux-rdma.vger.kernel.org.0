Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED0393EAA
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhE1IXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 28 May 2021 04:23:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2075 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhE1IXm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 04:23:42 -0400
Received: from dggeml711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FryGf0MSLzWn5G;
        Fri, 28 May 2021 16:17:30 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (7.185.36.148) by
 dggeml711-chm.china.huawei.com (10.3.17.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 16:22:06 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 16:22:05 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 28 May 2021 16:22:05 +0800
From:   liweihang <liweihang@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Topic: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Index: AQHXUTJz/ZoltCz67U2TkpxD2y6GdQ==
Date:   Fri, 28 May 2021 08:22:05 +0000
Message-ID: <6b844d0f597e4653ae35dbc81789a99b@huawei.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
 <1621925504-33019-14-git-send-email-liweihang@huawei.com>
 <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
 <20210527131558.GB1002214@nvidia.com>
 <8de36c1f7a0a4e839c6151b0963a894b@huawei.com>
 <YLCVPZazm+3pAqgf@hirez.programming.kicks-ass.net>
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

On 2021/5/28 15:01, Peter Zijlstra wrote:
> On Fri, May 28, 2021 at 03:58:42AM +0000, liweihang wrote:
>> Peter, could you please explain why you said "add_return and sub_return are
>> horrible interface for refcount"?
> 
> What would you need them for? The only special value is 0. Once you hit
> 0 the object is dead and you cannot revive.
>> If I look at drivers/infiniband/sw/rdmavt/mcast.c, which seems to be the
> relevant file, the thing that's called ->refcount is not in fact a
> reference count.
> 

I see, thank you.

refcount_t is not suitable for the current logic, so let's leave it as it is. I
will drop this patch from the series.

Weihang
