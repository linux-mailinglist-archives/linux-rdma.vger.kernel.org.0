Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EA101AAD
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 09:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKSIAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 03:00:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbfKSIAN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 03:00:13 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9389257D6A0281975BBC;
        Tue, 19 Nov 2019 16:00:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 16:00:01 +0800
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
 <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
 <20191118170229.GC2149@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
Date:   Tue, 19 Nov 2019 16:00:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191118170229.GC2149@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/19 1:02, Jason Gunthorpe wrote:
> On Mon, Nov 18, 2019 at 09:50:24PM +0800, Liuyixian (Eason) wrote:
>>> It kind of looks like this can be called multiple times? It won't work
>>> right unless it is called exactly once
>>>
>>> Jason
>>
>> Yes, you are right.
>>
>> So I think the reasonable solution is to allocate it dynamically, and I think
>> it is a very very little chance that the allocation will be failed. If this happened,
>> I think the application also needs to be over.
> 
> Why do you need more than one work in parallel for this? Once you
> start to move the HW to error that only has to happen once, surely?
> 
> Jason
> 
The flush operation moves QP, not the HW to error.

For the QP, maybe the process A is posting send while the other
process B is modifying qp to error, both of these two operation
needs to initialize one flush work. That's why it could be called
multiple times.

Furthermore, according to IB protocol 9.9.2.4.2, it may can't stop
posting wr into the qp even it already transitions to error state.
That's why it also needs to be called multiple times.

Once the work is implemented successfully, we will free the work,
it is not a big problem to allocate it dynamically again and again.

Thanks.



