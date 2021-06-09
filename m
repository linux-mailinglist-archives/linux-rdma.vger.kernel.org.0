Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF44B3A0AAF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhFIDhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 23:37:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8101 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhFIDhP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 23:37:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0CNG2Jr2zYrsy;
        Wed,  9 Jun 2021 11:32:30 +0800 (CST)
Received: from dggpeml100024.china.huawei.com (7.185.36.115) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:35:19 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:35:19 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Wed, 9 Jun 2021 11:35:19 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 3/4] libhns: Fixes data type when writing
 doorbell
Thread-Topic: [PATCH rdma-core 3/4] libhns: Fixes data type when writing
 doorbell
Thread-Index: AQHXU6R+23sTvMlAVUaHMDFBJVnBaw==
Date:   Wed, 9 Jun 2021 03:35:19 +0000
Message-ID: <ae83df8c9fd94f95bbc3cd8e2687f3e0@huawei.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-4-git-send-email-liweihang@huawei.com>
 <20210604144315.GA404834@nvidia.com>
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

On 2021/6/4 22:43, Jason Gunthorpe wrote:
> On Fri, May 28, 2021 at 05:32:58PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> The doorbell data is a __le32[] value instead of uint32_t[], and the DB
>> register should be written with a little-endian data instead of uint64_t.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  providers/hns/hns_roce_u_db.h    | 13 +++----------
>>  providers/hns/hns_roce_u_hw_v1.c | 17 +++++++++--------
>>  providers/hns/hns_roce_u_hw_v2.c | 28 +++++++++++++++++-----------
>>  3 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/providers/hns/hns_roce_u_db.h b/providers/hns/hns_roce_u_db.h
>> index b44e64d..453fa5a 100644
>> +++ b/providers/hns/hns_roce_u_db.h
>> @@ -37,18 +37,11 @@
>>  #ifndef _HNS_ROCE_U_DB_H
>>  #define _HNS_ROCE_U_DB_H
>>  
>> -#if __BYTE_ORDER == __LITTLE_ENDIAN
>> -#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[1] << 32 | val[0])
>> -#elif __BYTE_ORDER == __BIG_ENDIAN
>> -#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[0] << 32 | val[1])
>> -#else
>> -#error __BYTE_ORDER not defined
>> -#endif
>> +#define HNS_ROCE_WORD_NUM 2
>>  
>> -static inline void hns_roce_write64(uint32_t val[2],
>> -				    struct hns_roce_context *ctx, int offset)
>> +static inline void hns_roce_write64(__le64 *dest, __le32 val[HNS_ROCE_WORD_NUM])
>>  {
>> -	*(volatile uint64_t *) (ctx->uar + offset) = HNS_ROCE_PAIR_TO_64(val);
>> +	*(volatile __le64 *)dest = *(__le64 *)val;
>>  }
> 
> Please use the macros in util/mmio.h
> 
> Jason
> 

OK, thank you.

Weihang

