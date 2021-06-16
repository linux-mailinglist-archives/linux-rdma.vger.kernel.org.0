Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0B3A96AB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhFPJ6J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 16 Jun 2021 05:58:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhFPJ6I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Jun 2021 05:58:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G4gRm0nJmz1BN8v;
        Wed, 16 Jun 2021 17:51:00 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:55:46 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:55:46 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Wed, 16 Jun 2021 17:55:46 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Topic: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Index: AQHXU6R/LojSLjaQ0EW84zhJi1oR7g==
Date:   Wed, 16 Jun 2021 09:55:45 +0000
Message-ID: <3fa07c87b91047a79402a9871e4e932a@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
 <20210604145005.GA405010@nvidia.com>
 <efc5283d762542f6a4add9329744c4ee@huawei.com>
 <20210611113124.GO1002214@nvidia.com>
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

On 2021/6/11 19:31, Jason Gunthorpe wrote:
> On Fri, Jun 11, 2021 at 09:20:51AM +0000, liweihang wrote:
>> On 2021/6/4 22:50, Jason Gunthorpe wrote:
>>> On Fri, May 28, 2021 at 05:32:59PM +0800, Weihang Li wrote:
>>>> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
>>>> index aa57cc4..28d455b 100644
>>>> +++ b/providers/hns/hns_roce_u_hw_v2.c
>>>> @@ -33,10 +33,15 @@
>>>>  #define _GNU_SOURCE
>>>>  #include <stdio.h>
>>>>  #include <string.h>
>>>> +#include <sys/mman.h>
>>>>  #include "hns_roce_u.h"
>>>>  #include "hns_roce_u_db.h"
>>>>  #include "hns_roce_u_hw_v2.h"
>>>>  
>>>> +#if defined(__aarch64__) || defined(__arm__)
>>>> +#include <arm_neon.h>
>>>> +#endif
>>>> +
>>>>  #define HR_IBV_OPC_MAP(ib_key, hr_key) \
>>>>  		[IBV_WR_ ## ib_key] = HNS_ROCE_WQE_OP_ ## hr_key
>>>>  
>>>> @@ -313,6 +318,39 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
>>>>  			 (__le32 *)&sq_db);
>>>>  }
>>>>  
>>>> +static inline void hns_roce_write512(uint64_t *dest, uint64_t *val)
>>>> +{
>>>> +#if defined(__aarch64__) || defined(__arm__)
>>>> +	uint64x2x4_t dwqe;
>>>> +
>>>> +	/* Load multiple 4-element structures to 4 registers */
>>>> +	dwqe = vld4q_u64(val);
>>>> +	/* store multiple 4-element structures from 4 registers */
>>>> +	vst4q_u64(dest, dwqe);
>>>> +#else
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
>>>> +		hns_roce_write64(dest + i, val + HNS_ROCE_WORD_NUM * i);
>>>> +#endif
>>>> +}
>>>
>>> No code like this in providers. This should be done similiarly to how
>>> SSE is handled on x86
>>>
>>> This is 
>>>
>>>    mmio_memcpy_x64(dest, val, 64);
>>>
>>> The above should be conditionalized to trigger NEON
>>>
>>> #if defined(__aarch64__) || defined(__arm__)
>>> static inline void __mmio_memcpy_x64_64b(..)
>>> {..
>>>     vst4q_u64(dest, vld4q_u64(src))
>>> ..}
>>> #endif
>>>
>>> #define mmio_memcpy_x64(dest, src, bytecount)
>>>  ({if (__builtin_constant_p(bytecount == 64)
>>>         __mmio_memcpy_x64_64b(dest,src,bytecount)
>>>    ...
>>>
>>
>> OK, thank you.
>>
>>> And I'm not sure what barriers you need for prot_device, but certainly
>>> more than none. If you don't know then use the WC barriers
>>>
>>
>> ST4 instructions can guarantee the 64 bytes data to be wrote at a time, so we
>> don't need a barrier.
> 
> arm is always a relaxed out of order storage model, you need barriers
> to ensure that the observance of the ST4 is in-order with the other
> writes that might be going on
> 
> Jason
> 

Hi Jason

Sorry for the late reply. Here is the process of post send of HIP08/09:

   +-----------+
   | post send |
   +-----+-----+
         |
   +-----+-----+
   | write WQE |
   +-----+-----+
         |
         | udma_to_device_barrier()
         |
   +-----+-----+   Y  +-----------+  N
   |  HIP09 ?  +------+ multi WR ?+-------------+
   +-----+-----+      +-----+-----+             |
         | N                | Y                 |
   +-----+-----+      +-----+-----+    +--------+--------+
   |  ring DB  |      |  ring DB  |    |direct WQE (ST4) |
   +-----------+      +-----------+    +-----------------+

After users call ibv_post_send, the driver writes the WQE into memory, and add a
barrier to ensure that all of the WQE has been fully written. Then, for HIP09,
we check if there is only one WR, and if so, we write the WQE into pci bar space
via ST4 instructions, then the hardware will get the WQE. If there are more than
one WQEs, we generate a SQ doorbell to tell the hardware to read WQEs.

Direct WQE merge the process ring doorbell and get WQE from memory to the
hardware, avoiding reading WQEs from the memory after the doorbell is updated.
The ST4 instructions is atomic as ring doorbell for the hardware, and before
ST4, the WQE has been fully written into the memory. So I think current barrier
is enough for Direct WQE.

If there is still any issues in this process, could you please tell us where to
add the barrier? Thank you :)

Weihang

