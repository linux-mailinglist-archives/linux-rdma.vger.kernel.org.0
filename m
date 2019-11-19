Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D61102530
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfKSNJu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 08:09:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKSNJu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 08:09:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0275DFD2EEB5FC12C2CD;
        Tue, 19 Nov 2019 21:09:45 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 21:09:37 +0800
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
 <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
 <20191118170229.GC2149@ziepe.ca>
 <ace6095b-f8ba-80ca-7466-fcbf0c848a33@huawei.com>
 <678F3D1BB717D949B966B68EAEB446ED300C5791@dggemm526-mbx.china.huawei.com>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <5ddd0094-76e4-9251-f198-14806cfe96c0@huawei.com>
Date:   Tue, 19 Nov 2019 21:09:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED300C5791@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/19 17:43, Zengtao (B) wrote:
>> -----Original Message-----
>> From: linux-rdma-owner@vger.kernel.org
>> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Liuyixian (Eason)
>> Sent: Tuesday, November 19, 2019 4:00 PM
>> To: Jason Gunthorpe
>> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org;
>> Linuxarm
>> Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue
>> framework for flush cqe handler
>>
>>
>>
>> On 2019/11/19 1:02, Jason Gunthorpe wrote:
>>> On Mon, Nov 18, 2019 at 09:50:24PM +0800, Liuyixian (Eason) wrote:
>>>>> It kind of looks like this can be called multiple times? It won't work
>>>>> right unless it is called exactly once
>>>>>
>>>>> Jason
>>>>
>>>> Yes, you are right.
>>>>
>>>> So I think the reasonable solution is to allocate it dynamically, and I think
>>>> it is a very very little chance that the allocation will be failed. If this
>> happened,
>>>> I think the application also needs to be over.
>>>
>>> Why do you need more than one work in parallel for this? Once you
>>> start to move the HW to error that only has to happen once, surely?
>>>
>>> Jason
>>>
>> The flush operation moves QP, not the HW to error.
>>
>> For the QP, maybe the process A is posting send while the other
>> process B is modifying qp to error, both of these two operation
>> needs to initialize one flush work. That's why it could be called
>> multiple times.
>>
>> Furthermore, according to IB protocol 9.9.2.4.2, it may can't stop
>> posting wr into the qp even it already transitions to error state.
>> That's why it also needs to be called multiple times.
>>
>> Once the work is implemented successfully, we will free the work,
>> it is not a big problem to allocate it dynamically again and again.
>>
> 
> So can i understand that this function is designed to be reentrant?
> If so, I suggest to introduce a per dev/qp lock to protect.

Yes, currently we exactly use the following spinlock per qp to protect the verbs
which can be reentrant.

	spin_lock_irqsave(&qp->sq.lock, flags);

> 
>> Thanks.
>>
>>
> 

