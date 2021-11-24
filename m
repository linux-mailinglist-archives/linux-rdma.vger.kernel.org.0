Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAC45B950
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhKXLms (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 06:42:48 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14978 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhKXLmr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 06:42:47 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hzf9q0bKqzZdFd;
        Wed, 24 Nov 2021 19:37:03 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 19:39:35 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 24 Nov
 2021 19:39:35 +0800
Subject: Re: [PATCH rdma-core 5/7] libhns: Fix wrong type of variables and
 fields
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
 <20211109124103.54326-6-liangwenpeng@huawei.com>
 <20211123141308.GA42666@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <a2acf617-013d-84b7-4622-44c024bac9f7@huawei.com>
Date:   Wed, 24 Nov 2021 19:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211123141308.GA42666@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/23 22:13, Jason Gunthorpe wrote:
> On Tue, Nov 09, 2021 at 08:41:01PM +0800, Wenpeng Liang wrote:
>> From: Xinhao Liu <liuxinhao5@hisilicon.com>
>>
>> Some variables and fields should be in type of unsigned instead of signed.
>>
>> Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>  providers/hns/hns_roce_u.h       |  6 +++---
>>  providers/hns/hns_roce_u_hw_v1.c |  6 +++---
>>  providers/hns/hns_roce_u_hw_v2.c | 11 +++++------
>>  3 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
>> index 0d7abd81..d5963941 100644
>> +++ b/providers/hns/hns_roce_u.h
>> @@ -99,7 +99,7 @@
>>  #define roce_set_bit(origin, shift, val) \
>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>>  
>> -#define hr_ilog32(n)		ilog32((n) - 1)
>> +#define hr_ilog32(n)		ilog32((unsigned int)(n) - 1)
> 
> This should be a static inline function not a macro, then it can have
> the correct type.
> 
> Also please send this series as a PR on the github
> 
> Thanks,
> Jason
> .
> 

I submitted a PR on the github:

https://github.com/linux-rdma/rdma-core/pull/1090

Thanks
Wenpeng
