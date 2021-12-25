Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0747F1CC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Dec 2021 04:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhLYDg5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 22:36:57 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55105 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhLYDg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 22:36:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.gZjWo_1640403413;
Received: from 192.168.0.121(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.gZjWo_1640403413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Dec 2021 11:36:54 +0800
Message-ID: <cc51c755-1e12-4bb3-e4ca-81be651debec@linux.alibaba.com>
Date:   Sat, 25 Dec 2021 11:36:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev> <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
 <e860964f-7084-8ff4-ffd5-bb296ee7cad1@linux.alibaba.com>
 <YcYPPieF3IrIIIv1@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcYPPieF3IrIIIv1@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/25/21 2:19 AM, Leon Romanovsky wrote:
> On Fri, Dec 24, 2021 at 03:12:35PM +0800, Cheng Xu wrote:
>>
>>
>> On 12/24/21 6:55 AM, Yanjun Zhu wrote:
>>> 在 2021/12/24 2:45, Leon Romanovsky 写道:
>>>> On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
>>>>> 在 2021/12/21 10:48, Cheng Xu 写道:
>>>>>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>>>> ---
>>>>>>     include/uapi/rdma/erdma-abi.h | 49
>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 49 insertions(+)
>>>>>>     create mode 100644 include/uapi/rdma/erdma-abi.h
>>>>>>
>>>>>> diff --git a/include/uapi/rdma/erdma-abi.h
>>>>>> b/include/uapi/rdma/erdma-abi.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..6bcba10c1e41
>>>>>> --- /dev/null
>>>>>> +++ b/include/uapi/rdma/erdma-abi.h
>>>>>> @@ -0,0 +1,49 @@
>>>>>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH
>>>>>> Linux-syscall-note) OR Linux-OpenIB) */
>>>>>> +/*
>>>>>> + * Copyright (c) 2020-2021, Alibaba Group.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef __ERDMA_USER_H__
>>>>>> +#define __ERDMA_USER_H__
>>>>>> +
>>>>>> +#include <linux/types.h>
>>>>>> +
>>>>>> +#define ERDMA_ABI_VERSION       1
>>>>>
>>>>> ERDMA_ABI_VERSION should be 2？
>>>>
>>>> Why?
>>>>
>>>> This field is for rdma-core and we don't have erdma provider in that
>>>> library yet. It always starts from 1 for new drivers.
>>> Please check this link:
>>> http://mail.spinics.net/lists/linux-rdma/msg63012.html
>>>
>>> Jason mentioned in this link:
>>>
>>> "
>>> /*
>>>    * For 64 bit machines ABI version 1 and 2 are the same. Otherwise 32
>>>    * bit machines require ABI version 2 which guarentees the user and
>>>    * kernel use the same ABI.
>>>    */
>>> "
>>>
>>> Zhu Yanjun
>>
>> Even though I do not understand the reason, but as mentioned above, I think
>> ERDMA_ABI_VERSION = 1 is fine, because ERDMA can only work in 64bit
>> machines.
> 
> Jason's comment came after we discovered that many of our API structures had
> problematic layout and weren't aligned to 64bits. This caused to issues when
> the 32bits software tried to use 64bit kernel.
> 
> So we didn't have many choices but bump ABI versions for broken drivers
> and RXE was one of them.
> 
> You are proposing new driver, it should start from 1.

Thanks for your explanation.

Thanks,
Cheng Xu

> Thanks
