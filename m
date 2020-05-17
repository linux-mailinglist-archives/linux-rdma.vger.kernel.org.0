Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61531D6C15
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEQTF7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 15:05:59 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:52560
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgEQTF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 May 2020 15:05:59 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 15:05:59 EDT
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aOUijLBRJiFEQaOUijvrFj; Sun, 17 May 2020 11:58:41 -0700
X-CMAE-Analysis: v=2.3 cv=QvMgIm6d c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=EHcmgxD4AAAA:20 a=VLKvWmZpXLvPKCahpf8A:9
 a=QEXdDO2ut3YA:10 a=bGBouMQXGW8eGej8sMnj:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: Questions about masked atomic
To:     Leon Romanovsky <leon@kernel.org>, liweihang <liweihang@huawei.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
 <20200512113512.GK4814@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A02363499@DGGEML522-MBX.china.huawei.com>
 <20200517131409.GA60005@unreal>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <1eedd4da-83eb-58ba-80ac-2e2c5d1c5b65@talpey.com>
Date:   Sun, 17 May 2020 14:58:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200517131409.GA60005@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBXAArkRQ9P9EL8IBAvmvJWQRiXyQedogkdCDBm/xgxVc2j9vv34fJ7VABMroxkg7+8tJgIcZ2du1mKaESiKtv5rfui6+ce2/ZKwI3AsIeZlK6T05jhy
 5rKXPGjJ24m475NKwSiFR2Q/nABP7RTPvDyJM4qfVrpiadIEIsVfY4RHHHgJbN+ziVceqKdhPD/EISaMyTpGccALKQir63wHGcM4E3aw2JYrOJxBIgpgYalz
 SSe330ymWqDb7ivQ6N35RzHgcevsOJL6NmdniT2pZhCbb0QlhVyyKstt20EOaLeka0n5D+SQO+SWltOYW+jhvA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/2020 9:14 AM, Leon Romanovsky wrote:
> On Fri, May 15, 2020 at 09:40:26AM +0000, liweihang wrote:
>> On 2020/5/12 19:35, Leon Romanovsky wrote:
>>> On Mon, May 11, 2020 at 01:54:48PM +0000, liweihang wrote:
>>>> Hi All,
>>>>
>>>> I have two questions about masked atomic (Masked Compare and Swap & MFetchAdd):
>>>>
>>>> 1. The kernel now supports masked atomic, but the it does not support atomic
>>>>     operation. Is the masked atomic valid in kernel currently?
>>>
>>> Yes, it is valid, but probably has a very little real value for the kernel ULPs.
>>> I see code in the RDS that uses atomics, but it says nothing to me, because
>>> upstream RDS and version in-real-use are completely different.
>>>
>>>> 2. In the userspace, ofed does not have the corresponding opcode for the masked
>>>>     atomic (IB_WR_MASKED_ATOMIC_CMP_AND_SWP, IB_WR_MASKED_ATOMIC_FETCH_AND_ADD),
>>>>     and ibv_send_wr also has no related data segment for it. How to support it in
>>>>     userspace?
>>>
>>> ibv_send_wr is not extensible, so the real solution will need to extend ibv_wr_post() [1]
>>> with specific and new post builders.
>>>
>>> Thanks
>>>
>>> [1] https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_wr_post.3.md
>>>
>>
>> Hi Leon,
>>
>> Thanks for your response. May I ask another question:
>>
>> Why it's not encouraged to use atomic/extended atomic/masked atomic operations in kernel?
>> Jason said that there seems no kernel users of extended atomic, is there any other reasons?
> 
> I don't think that "it is not encouraged", the more accurate will be
> "the IBTA atomics will give nothing to the kernel ULPs".
> 
> The atomic data is not necessary stored in the host memory, while ULPs
> need it in the memory. It means that they anyway will need to do some
> synchronization in the host and "cancel" any advantage of atomics if
> they exist.

Indeed, it is a common misconception by upper layer implementers that
the atomicity is available to the responder CPU. In fact, atomics work
only from the HCA that executes them, and the result is flushed to
memory, non-atomically, at some later time. These limitations greatly
reduce the motivation to use them at all, much less the exotic masked
ones.

I believe another reason they're not surfaced for kernel consumers is
that there aren't any. Primarily, the kernel consumers are storage, and
storage protocols stay far away from atomics.

Tom.
