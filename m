Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013B47ECE3
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 08:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhLXHy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 02:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhLXHy3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 02:54:29 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FFC061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 23:54:29 -0800 (PST)
Message-ID: <ae2dd1e6-a33b-c19e-7100-198ea3a491df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640332466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXLlxxN1iciEI8r1WerIXow5D/3YqXprzOtxY0P07rc=;
        b=wq+XrJ0bL92/mJjRE0G9NK03OqEUXzwVXdXMv7Pzcn9Frd9VlCQ2yZ2SWqpa6Ob7019Fi7
        hIoRZYsXiHKdZuCuVOXInV9Bx580NX3qlOYluHseWf0VH6O7w84ADuZJDt0oF1arUPtkc3
        FHE2Y2D+LirGCHKASMXGK6dqJ8qw0/g=
Date:   Fri, 24 Dec 2021 15:54:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
To:     Leon Romanovsky <leon@kernel.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-11-chengyou@linux.alibaba.com>
 <c1893907-e8fb-1eec-9611-3f08d1b2a3c2@linux.dev> <YcTD5jDwgDln4QBV@unreal>
 <6cb90490-d21c-e76e-19b9-2a7fe0669e04@linux.dev> <YcVi6CfbhKSfGgxs@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YcVi6CfbhKSfGgxs@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/12/24 14:04, Leon Romanovsky 写道:
> On Fri, Dec 24, 2021 at 06:55:41AM +0800, Yanjun Zhu wrote:
>> 在 2021/12/24 2:45, Leon Romanovsky 写道:
>>> On Thu, Dec 23, 2021 at 11:46:03PM +0800, Yanjun Zhu wrote:
>>>> 在 2021/12/21 10:48, Cheng Xu 写道:
>>>>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>>> ---
>>>>>     include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 49 insertions(+)
>>>>>     create mode 100644 include/uapi/rdma/erdma-abi.h
>>>>>
>>>>> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
>>>>> new file mode 100644
>>>>> index 000000000000..6bcba10c1e41
>>>>> --- /dev/null
>>>>> +++ b/include/uapi/rdma/erdma-abi.h
>>>>> @@ -0,0 +1,49 @@
>>>>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
>>>>> +/*
>>>>> + * Copyright (c) 2020-2021, Alibaba Group.
>>>>> + */
>>>>> +
>>>>> +#ifndef __ERDMA_USER_H__
>>>>> +#define __ERDMA_USER_H__
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +#define ERDMA_ABI_VERSION       1
>>>>
>>>> ERDMA_ABI_VERSION should be 2？
>>>
>>> Why?
>>>
>>> This field is for rdma-core and we don't have erdma provider in that
>>> library yet. It always starts from 1 for new drivers.
>> Please check this link:
>> http://mail.spinics.net/lists/linux-rdma/msg63012.html
> 
> OK, I still don't understand why.


Perhaps 32 bit machines require ABI version 2 which guarentees the user 
and kernel use the same ABI.

Zhu Yanjun

> 
> RXE case is different, because rdma-core already had broken RXE
> implementation, so this is why the version was incremented.
> 
>>
>> Jason mentioned in this link:
>>
>> "
>> /*
>>   * For 64 bit machines ABI version 1 and 2 are the same. Otherwise 32
>>   * bit machines require ABI version 2 which guarentees the user and
>>   * kernel use the same ABI.
>>   */
>> "
>>
>> Zhu Yanjun
>>>
>>> Thanks
>>

