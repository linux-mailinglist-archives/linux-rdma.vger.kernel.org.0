Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1932B59C8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 07:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgKQGiC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Nov 2020 01:38:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2372 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGiC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 01:38:02 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CZx850Z8Mz4wqy;
        Tue, 17 Nov 2020 14:37:41 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 17 Nov 2020 14:37:58 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 14:37:58 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Tue, 17 Nov 2020 14:37:58 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Topic: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Index: AQHWvBAlKbwt9UNgt0KPBLCpit0Bsw==
Date:   Tue, 17 Nov 2020 06:37:58 +0000
Message-ID: <2692da9a4b814dfa952659a903eb96f0@huawei.com>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
 <20201116134645.GL47002@unreal>
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

On 2020/11/16 21:47, Leon Romanovsky wrote:
> On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Stash is a mechanism that uses the core information carried by the ARM AXI
>> bus to access the L3 cache. It can be used to improve the performance by
>> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
>>  4 files changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
>> index f5669ff..8d96c4e 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
>> @@ -53,6 +53,18 @@
>>  #define roce_set_bit(origin, shift, val) \
>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>>
>> +#define FIELD_LOC(field_h, field_l) field_h, field_l
>> +
>> +#define _hr_reg_set(arr, field_h, field_l)                                     \
>> +	do {                                                                   \
>> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
>> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
>> +		(arr)[(field_h) / 32] |=                                       \
>> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
>> +	} while (0)
>> +
>> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
> 
> I afraid that it is too much.

Hi Leon,

Thanks for the comments.

> 1. FIELD_LOC() macro to hide two fields.

Jason has suggested us to simplify the function of setting/getting bit/field in
hns driver like IBA_SET and IBA_GET.

https://patchwork.kernel.org/project/linux-rdma/patch/1589982799-28728-3-git-send-email-liweihang@huawei.com/

So we try to make it easier and clearer to define a bitfield for developers.

For example:

	#define QPCEX_SRC_ID FIELD_LOC(94, 84)

	hr_reg_set(context->ext, QPCEX_SRC_ID);

This will set 84 ~ 91 bit of QPC to 1. Without FIELD_LOC(), it may look
like:

	#define QPCEX_SRC_ID_START 84
	#define QPCEX_SRC_ID_END 94

	hr_reg_set(context->ext, QPCEX_SRC_ID_END, QPCEX_SRC_ID_START);

> 2. hr_reg_set and  _hr_reg_set are the same.

'field' will be spilted into two parts: 'field_h' and 'field_l':

	#define _hr_reg_set(arr, field_h, field_l)
	...

	#define hr_reg_set(arr, field) _hr_reg_set(arr, field)

> 3. In both patches field_h and field_l are the same.

This is because we want hr_reg_set() to be used both for setting bits and for
setting fields. In this series, we just use it to set bit.

> 4. "do {} while (0)" without need.

OK, I will remove the do-while and replace BUILD_BUG_ON with BUILD_BUG_ON_ZERO:

	#define _hr_reg_set(arr, field_h, field_l)                                  \
		(arr)[(field_h) / 32] |=                                            \
			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32)) +      \
			BUILD_BUG_ON_ZERO(((field_h) / 32) != ((field_l) / 32)) +   \
			BUILD_BUG_ON_ZERO((field_h) / 32 >= ARRAY_SIZE(arr));

Weihang

> 
> Thanks
> 

