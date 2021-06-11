Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B573A3EF9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFKJWv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 11 Jun 2021 05:22:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5388 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhFKJWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 05:22:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1Zwn531Pz6w6L;
        Fri, 11 Jun 2021 17:16:57 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:20:51 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:20:51 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 17:20:51 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Topic: [PATCH rdma-core 4/4] libhns: Add support for direct wqe
Thread-Index: AQHXU6R/LojSLjaQ0EW84zhJi1oR7g==
Date:   Fri, 11 Jun 2021 09:20:51 +0000
Message-ID: <efc5283d762542f6a4add9329744c4ee@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-5-git-send-email-liweihang@huawei.com>
 <20210604145005.GA405010@nvidia.com>
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

On 2021/6/4 22:50, Jason Gunthorpe wrote:
> On Fri, May 28, 2021 at 05:32:59PM +0800, Weihang Li wrote:
>> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
>> index aa57cc4..28d455b 100644
>> +++ b/providers/hns/hns_roce_u_hw_v2.c
>> @@ -33,10 +33,15 @@
>>  #define _GNU_SOURCE
>>  #include <stdio.h>
>>  #include <string.h>
>> +#include <sys/mman.h>
>>  #include "hns_roce_u.h"
>>  #include "hns_roce_u_db.h"
>>  #include "hns_roce_u_hw_v2.h"
>>  
>> +#if defined(__aarch64__) || defined(__arm__)
>> +#include <arm_neon.h>
>> +#endif
>> +
>>  #define HR_IBV_OPC_MAP(ib_key, hr_key) \
>>  		[IBV_WR_ ## ib_key] = HNS_ROCE_WQE_OP_ ## hr_key
>>  
>> @@ -313,6 +318,39 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
>>  			 (__le32 *)&sq_db);
>>  }
>>  
>> +static inline void hns_roce_write512(uint64_t *dest, uint64_t *val)
>> +{
>> +#if defined(__aarch64__) || defined(__arm__)
>> +	uint64x2x4_t dwqe;
>> +
>> +	/* Load multiple 4-element structures to 4 registers */
>> +	dwqe = vld4q_u64(val);
>> +	/* store multiple 4-element structures from 4 registers */
>> +	vst4q_u64(dest, dwqe);
>> +#else
>> +	int i;
>> +
>> +	for (i = 0; i < HNS_ROCE_WRITE_TIMES; i++)
>> +		hns_roce_write64(dest + i, val + HNS_ROCE_WORD_NUM * i);
>> +#endif
>> +}
> 
> No code like this in providers. This should be done similiarly to how
> SSE is handled on x86
> 
> This is 
> 
>    mmio_memcpy_x64(dest, val, 64);
> 
> The above should be conditionalized to trigger NEON
> 
> #if defined(__aarch64__) || defined(__arm__)
> static inline void __mmio_memcpy_x64_64b(..)
> {..
>     vst4q_u64(dest, vld4q_u64(src))
> ..}
> #endif
> 
> #define mmio_memcpy_x64(dest, src, bytecount)
>  ({if (__builtin_constant_p(bytecount == 64)
>         __mmio_memcpy_x64_64b(dest,src,bytecount)
>    ...
> 

OK, thank you.

> And I'm not sure what barriers you need for prot_device, but certainly
> more than none. If you don't know then use the WC barriers
> 

ST4 instructions can guarantee the 64 bytes data to be wrote at a time, so we
don't need a barrier.

Weihang

> Jason
> 

