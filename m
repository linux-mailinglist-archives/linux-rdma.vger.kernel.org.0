Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57DB2B5B10
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 09:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKQIgC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Nov 2020 03:36:02 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2435 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 03:36:02 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CZzmG4vtVz53vc;
        Tue, 17 Nov 2020 16:35:42 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 17 Nov 2020 16:35:56 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 17 Nov 2020 16:35:55 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Tue, 17 Nov 2020 16:35:55 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Topic: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Thread-Index: AQHWvBAlKbwt9UNgt0KPBLCpit0Bsw==
Date:   Tue, 17 Nov 2020 08:35:55 +0000
Message-ID: <f688022a7cce488a82ce0d8427a1054e@huawei.com>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
 <20201116134645.GL47002@unreal> <2692da9a4b814dfa952659a903eb96f0@huawei.com>
 <20201117072034.GO47002@unreal>
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

On 2020/11/17 15:21, Leon Romanovsky wrote:
> On Tue, Nov 17, 2020 at 06:37:58AM +0000, liweihang wrote:
>> On 2020/11/16 21:47, Leon Romanovsky wrote:
>>> On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
>>>> From: Lang Cheng <chenglang@huawei.com>
>>>>
>>>> Stash is a mechanism that uses the core information carried by the ARM AXI
>>>> bus to access the L3 cache. It can be used to improve the performance by
>>>> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
>>>>
>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
>>>>  4 files changed, 39 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
>>>> index f5669ff..8d96c4e 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
>>>> @@ -53,6 +53,18 @@
>>>>  #define roce_set_bit(origin, shift, val) \
>>>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>>>>
>>>> +#define FIELD_LOC(field_h, field_l) field_h, field_l
>>>> +
>>>> +#define _hr_reg_set(arr, field_h, field_l)                                     \
>>>> +	do {                                                                   \
>>>> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
>>>> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
>>>> +		(arr)[(field_h) / 32] |=                                       \
>>>> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
>>>> +	} while (0)
>>>> +
>>>> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
>>>
>>> I afraid that it is too much.
>>
>> Hi Leon,
>>
>> Thanks for the comments.
>>
>>> 1. FIELD_LOC() macro to hide two fields.
>>
>> Jason has suggested us to simplify the function of setting/getting bit/field in
>> hns driver like IBA_SET and IBA_GET.
>>
>> https://patchwork.kernel.org/project/linux-rdma/patch/1589982799-28728-3-git-send-email-liweihang@huawei.com/
>>
>> So we try to make it easier and clearer to define a bitfield for developers.
> 
> Jason asked to use genmask and FIELD_PREP, but you invented something else.
> 
> Thanks
> 

We use them in another interface 'hr_reg_write(arr, field, val)' which hasn't been
used in this series.

Does it make any unacceptable mistake? We would appreciate any suggestions :)

Thanks
Weihang


