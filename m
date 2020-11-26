Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C602C4F02
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 07:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgKZG47 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 26 Nov 2020 01:56:59 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2383 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbgKZG47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 01:56:59 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ChT7d2r5Vz4xBP;
        Thu, 26 Nov 2020 14:56:29 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 14:56:56 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 14:56:56 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 14:56:56 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Topic: [PATCH v3 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Index: AQHWvyabVgXhi4YBY0GGAC1/VGLeSQ==
Date:   Thu, 26 Nov 2020 06:56:56 +0000
Message-ID: <fe0b9d5d1da248209b5cc1c3f1157254@huawei.com>
References: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
 <1605867440-2413-2-git-send-email-liweihang@huawei.com>
 <20201120201338.GS244516@ziepe.ca>
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

On 2020/11/21 4:13, Jason Gunthorpe wrote:
> On Fri, Nov 20, 2020 at 06:17:19PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Stash is a mechanism that uses the core information carried by the ARM AXI
>> bus to access the L3 cache. It can be used to improve the performance by
>> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_common.h | 10 ++++++++
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
>>  4 files changed, 37 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
>> index f5669ff..41a2252 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
>> @@ -53,6 +53,16 @@
>>  #define roce_set_bit(origin, shift, val) \
>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>>  
>> +#define FIELD_LOC(field_h, field_l) field_h, field_l
>> +
>> +#define _hr_reg_enable(arr, field_h, field_l)                                  \
>> +	(arr)[(field_l) / 32] |=                                               \
>> +		(BIT((field_l) % 32)) +                                        \
>> +		BUILD_BUG_ON_ZERO((field_h) != (field_l)) +                    \
>> +		BUILD_BUG_ON_ZERO((field_l) / 32 >= ARRAY_SIZE(arr))
>> +
>> +#define hr_reg_enable(arr, field) _hr_reg_enable(arr, field)
>> +
>>  #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
>>  #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
>>  
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 1d99022..ab7df8e 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -223,6 +223,7 @@ enum {
>>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
>>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
>> +	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
>>  };
>>  
>>  #define HNS_ROCE_DB_TYPE_COUNT			2
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 4b82912..da7f909 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -3177,6 +3177,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
>>  		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
>>  		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
>>  
>> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
>> +		hr_reg_enable(cq_context->raw, CQC_STASH);
>> +
>>  	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
>>  
>>  	roce_set_field(cq_context->byte_16_hop_addr,
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index 1409d05..50a5187 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -267,22 +267,27 @@ enum hns_roce_sgid_type {
>>  };
>>  
>>  struct hns_roce_v2_cq_context {
>> -	__le32	byte_4_pg_ceqn;
>> -	__le32	byte_8_cqn;
>> -	__le32	cqe_cur_blk_addr;
>> -	__le32	byte_16_hop_addr;
>> -	__le32	cqe_nxt_blk_addr;
>> -	__le32	byte_24_pgsz_addr;
>> -	__le32	byte_28_cq_pi;
>> -	__le32	byte_32_cq_ci;
>> -	__le32	cqe_ba;
>> -	__le32	byte_40_cqe_ba;
>> -	__le32	byte_44_db_record;
>> -	__le32	db_record_addr;
>> -	__le32	byte_52_cqe_cnt;
>> -	__le32	byte_56_cqe_period_maxcnt;
>> -	__le32	cqe_report_timer;
>> -	__le32	byte_64_se_cqe_idx;
>> +	union {
>> +		struct {
>> +			__le32 byte_4_pg_ceqn;
>> +			__le32 byte_8_cqn;
>> +			__le32 cqe_cur_blk_addr;
>> +			__le32 byte_16_hop_addr;
>> +			__le32 cqe_nxt_blk_addr;
>> +			__le32 byte_24_pgsz_addr;
>> +			__le32 byte_28_cq_pi;
>> +			__le32 byte_32_cq_ci;
>> +			__le32 cqe_ba;
>> +			__le32 byte_40_cqe_ba;
>> +			__le32 byte_44_db_record;
>> +			__le32 db_record_addr;
>> +			__le32 byte_52_cqe_cnt;
>> +			__le32 byte_56_cqe_period_maxcnt;
>> +			__le32 cqe_report_timer;
>> +			__le32 byte_64_se_cqe_idx;
>> +		};
>> +		__le32 raw[16];
>> +	};
> 
> It has missed the point of how the FIELD_LOC worked in the iba macros,
> you want to specify the type
> 
>   FIELD_LOC(struct hns_roce_v2_cq_context, 63, 63)
> 
> And not introduce a raw array in a union, just validate the type and
> cast it to a __le32 *
> 

Thank you, we will modify it as you suggest.

> And again, if you are going to be building macros like this then
> setting fields to all ones must be the corner case.
> 
> Write it more clearly:
> 
> hr_reg_set(cq_context, CQC_STASH, FIELD_ALL_ONES(CQC_STASH));
> 

OK, we will use hr_reg_enable(ptr, field) to set a single bit to one. And
use hr_reg_write(ptr, field, val) to fill a field with a value, which can be
also used like hr_reg_write(ptr, field, FIELD_ALL_ONES(field)).

Weihang

> Now you can replace some of the other macros with the safer/simpler
> scheme.
> 
> Jason
> 
