Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360F047F187
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Dec 2021 01:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhLYADY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 19:03:24 -0500
Received: from out0.migadu.com ([94.23.1.103]:10567 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhLYADX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 19:03:23 -0500
Message-ID: <3d08b270-367e-e01d-a095-85309f8c1f7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640390599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+aRu7ZV32gPZhDZHGEcScWPJuNorY5WXOAj2wCLAD9Q=;
        b=Loi60gic5EMFPX48WzmfY+zNktegY7oS/mbeBU/sQoBr39pEu3cBCPtvkBzLUKDlVyQ6NH
        xhaoAa8wO8uMI3EX4unLWUdHpAEdajkVWj+cLKAsLAhw1ODepwaPea/crjXGBHtAmcakb2
        2mHMc45Ho5jRVpu9NT9GiULbUNu2X1o=
Date:   Sat, 25 Dec 2021 08:03:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
To:     Leon Romanovsky <leon@kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev> <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev>
 <e860964f-7084-8ff4-ffd5-bb296ee7cad1@linux.alibaba.com>
 <YcYPPieF3IrIIIv1@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YcYPPieF3IrIIIv1@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2021/12/25 2:19, Leon Romanovsky 写道:
> On Fri, Dec 24, 2021 at 03:12:35PM +0800, Cheng Xu wrote:
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
>>>>> ERDMA_ABI_VERSION should be 2？
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
>> Even though I do not understand the reason, but as mentioned above, I think
>> ERDMA_ABI_VERSION = 1 is fine, because ERDMA can only work in 64bit
>> machines.
> Jason's comment came after we discovered that many of our API structures had
> problematic layout and weren't aligned to 64bits. This caused to issues when
> the 32bits software tried to use 64bit kernel.

Got it. Thanks

Zhu Yanjun

>
> So we didn't have many choices but bump ABI versions for broken drivers
> and RXE was one of them.
>
> You are proposing new driver, it should start from 1.
>
> Thanks
