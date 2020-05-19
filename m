Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3471F1D8D1C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 03:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgESB17 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 18 May 2020 21:27:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:45696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgESB17 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 21:27:59 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id D04CE4384A7156BAB296;
        Tue, 19 May 2020 09:27:54 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 19 May 2020 09:27:54 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.243]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0487.000;
 Tue, 19 May 2020 09:27:46 +0800
From:   liweihang <liweihang@huawei.com>
To:     Tom Talpey <tom@talpey.com>, Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Questions about masked atomic
Thread-Topic: Questions about masked atomic
Thread-Index: AdYnm7vjyDIKjW3JQkW+0B8JTa36qA==
Date:   Tue, 19 May 2020 01:27:46 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A023661E4@DGGEML522-MBX.china.huawei.com>
References: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
 <20200512113512.GK4814@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A02363499@DGGEML522-MBX.china.huawei.com>
 <20200517131409.GA60005@unreal>
 <1eedd4da-83eb-58ba-80ac-2e2c5d1c5b65@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/5/18 2:58, Tom Talpey wrote:
> On 5/17/2020 9:14 AM, Leon Romanovsky wrote:
>> On Fri, May 15, 2020 at 09:40:26AM +0000, liweihang wrote:
>>> On 2020/5/12 19:35, Leon Romanovsky wrote:
>>>> On Mon, May 11, 2020 at 01:54:48PM +0000, liweihang wrote:
>>>>> Hi All,
>>>>>
>>>>> I have two questions about masked atomic (Masked Compare and Swap & MFetchAdd):
>>>>>
>>>>> 1. The kernel now supports masked atomic, but the it does not support atomic
>>>>>     operation. Is the masked atomic valid in kernel currently?
>>>>
>>>> Yes, it is valid, but probably has a very little real value for the kernel ULPs.
>>>> I see code in the RDS that uses atomics, but it says nothing to me, because
>>>> upstream RDS and version in-real-use are completely different.
>>>>
>>>>> 2. In the userspace, ofed does not have the corresponding opcode for the masked
>>>>>     atomic (IB_WR_MASKED_ATOMIC_CMP_AND_SWP, IB_WR_MASKED_ATOMIC_FETCH_AND_ADD),
>>>>>     and ibv_send_wr also has no related data segment for it. How to support it in
>>>>>     userspace?
>>>>
>>>> ibv_send_wr is not extensible, so the real solution will need to extend ibv_wr_post() [1]
>>>> with specific and new post builders.
>>>>
>>>> Thanks
>>>>
>>>> [1] https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_wr_post.3.md
>>>>
>>>
>>> Hi Leon,
>>>
>>> Thanks for your response. May I ask another question:
>>>
>>> Why it's not encouraged to use atomic/extended atomic/masked atomic operations in kernel?
>>> Jason said that there seems no kernel users of extended atomic, is there any other reasons?
>>
>> I don't think that "it is not encouraged", the more accurate will be
>> "the IBTA atomics will give nothing to the kernel ULPs".
>>
>> The atomic data is not necessary stored in the host memory, while ULPs
>> need it in the memory. It means that they anyway will need to do some
>> synchronization in the host and "cancel" any advantage of atomics if
>> they exist.
> 
> Indeed, it is a common misconception by upper layer implementers that
> the atomicity is available to the responder CPU. In fact, atomics work
> only from the HCA that executes them, and the result is flushed to
> memory, non-atomically, at some later time. These limitations greatly
> reduce the motivation to use them at all, much less the exotic masked
> ones.
> 
> I believe another reason they're not surfaced for kernel consumers is
> that there aren't any. Primarily, the kernel consumers are storage, and
> storage protocols stay far away from atomics.
> 
> Tom.
> 

Hi Tom and Leon,

Thank you for the explanation, it helps me lot.

Weihang
