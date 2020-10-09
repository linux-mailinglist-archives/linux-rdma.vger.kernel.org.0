Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A136A288030
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 04:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgJICBn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 8 Oct 2020 22:01:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3565 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbgJICBm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 22:01:42 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 09B46F1622B8481DA6E0;
        Fri,  9 Oct 2020 10:01:41 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 9 Oct 2020 10:01:40 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 9 Oct 2020 10:01:40 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 9 Oct 2020 10:01:40 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Add new interfaces to
 set/clear/read fields in QPC
Thread-Topic: [PATCH for-next 2/3] RDMA/hns: Add new interfaces to
 set/clear/read fields in QPC
Thread-Index: AQHWlw0SDsyBn/lHWE620J1u4ur+Xw==
Date:   Fri, 9 Oct 2020 02:01:40 +0000
Message-ID: <91008f8b54474e23b204ce96513b055e@huawei.com>
References: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
 <1601458452-55263-3-git-send-email-liweihang@huawei.com>
 <20201006195551.GA161726@nvidia.com>
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

On 2020/10/7 3:56, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 05:34:11PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> For a field in extended QPC, there are four newly added interfaces:
>> - hr_reg_set(arr, field) can set all bits to 1,
>> - hr_reg_clear(arr, field) can clear all bits to 0,
>> - hr_reg_write(arr, field, val) can write a new value,
>> - hr_reg_read(arr, field) can read the value.
>> 'arr' is the array name of extended QPC, and 'field' is the global bit
>> offset of the whole array.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_common.h | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
>> index f5669ff..ab2386d 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
>> @@ -53,6 +53,32 @@
>>  #define roce_set_bit(origin, shift, val) \
>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>>  
>> +#define hr_reg_set(arr, field)                                                 \
>> +	((arr)[(field) / 32] |=                                                \
>> +	 cpu_to_le32((field##_W) +                                             \
>> +		     BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
>> +
>> +#define hr_reg_clear(arr, field)                                               \
>> +	((arr)[(field) / 32] &=                                                \
>> +	 ~cpu_to_le32((field##_W) +                                            \
>> +		      BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr))))
>> +
>> +#define hr_reg_write(arr, field, val)                                          \
>> +	do {                                                                   \
>> +		BUILD_BUG_ON((field) / 32 >= ARRAY_SIZE(arr));                 \
>> +		(arr)[(field) / 32] &= ~cpu_to_le32(field##_W);                \
>> +		(arr)[(field) / 32] |= cpu_to_le32(                            \
>> +			((u32)(val) << ((field) % 32)) & (field##_W));         \
>> +	} while (0)
>> +
>> +#define hr_reg_read(arr, field)                                                \
>> +	(((le32_to_cpu((arr)[(field) / 32]) & (field##_W)) >> (field) % 32) +  \
>> +	 BUILD_BUG_ON_ZERO((field) / 32 >= ARRAY_SIZE(arr)))
> 
> Why add these functions that are not used?
> 
> Jason
> 

hr_reg_set() is to be used in patch 3/3 in this series, the others are prepared
for follow-up series. I will put hr_reg_set() in patch #3 and add other interfaces
only when required.

Thanks
Weihang

