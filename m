Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1856E17A65E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEN3K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 5 Mar 2020 08:29:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgCEN3J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 08:29:09 -0500
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7CA63DCF3F3EEE667701;
        Thu,  5 Mar 2020 21:28:38 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 21:28:37 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0439.000;
 Thu, 5 Mar 2020 21:28:28 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode
 conversion from ib to hns
Thread-Topic: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode
 conversion from ib to hns
Thread-Index: AQHV8IxL8apXlqGeX0KNORb5L2i78Q==
Date:   Thu, 5 Mar 2020 13:28:28 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022743C5@DGGEML522-MBX.china.huawei.com>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-4-git-send-email-liweihang@huawei.com>
 <20200305061839.GQ121803@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A02274225@DGGEML522-MBX.china.huawei.com>
 <20200305120911.GC184088@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/5 20:09, Leon Romanovsky wrote:
> On Thu, Mar 05, 2020 at 11:22:18AM +0000, liweihang wrote:
>> On 2020/3/5 14:18, Leon Romanovsky wrote:
>>> On Mon, Mar 02, 2020 at 08:11:31PM +0800, Weihang Li wrote:
>>>> From: Xi Wang <wangxi11@huawei.com>
>>>>
>>>> Simplify the wr opcode conversion from ib to hns by using a map table
>>>> instead of the switch-case statement.
>>>>
>>>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 70 ++++++++++++++++++------------
>>>>  1 file changed, 43 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> index c8c345f..ea61ccb 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> @@ -56,6 +56,47 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
>>>>  	dseg->len  = cpu_to_le32(sg->length);
>>>>  }
>>>>
>>>> +/*
>>>> + * mapped-value = 1 + real-value
>>>> + * The hns wr opcode real value is start from 0, In order to distinguish between
>>>> + * initialized and uninitialized map values, we plus 1 to the actual value when
>>>> + * defining the mapping, so that the validity can be identified by checking the
>>>> + * mapped value is greater than 0.
>>>> + */
>>>> +#define HR_OPC_MAP(ib_key, hr_key) \
>>>> +		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
>>>> +
>>>> +static const u32 hns_roce_op_code[] = {
>>>> +	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
>>>> +	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
>>>> +	HR_OPC_MAP(SEND,			SEND),
>>>> +	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
>>>> +	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
>>>> +	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
>>>> +	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
>>>> +	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
>>>> +	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
>>>> +	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
>>>> +	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
>>>> +	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
>>>> +	[IB_WR_RESERVED1] = 0,
>>>
>>> hns_roce_op_code[] is declared as static, everything is initialized to
>>> 0, there is no need to set 0 again.
>>
>> OK, thank you.
>>
>>>
>>>> +};
>>>> +
>>>> +static inline u32 to_hr_opcode(u32 ib_opcode)
>>>
>>> No inline functions in *.c, please.
>>
>> Hi Leon,
>>
>> Thanks for your comments.
>>
>> But I'm confused about when we should use static inline and when we should
>> use macros if a function is only used in a *.c. A few days ago, Jason
>> suggested me to use static inline functions, you can check the link below:
>>
>> https://patchwork.kernel.org/patch/11372851/
>>
>> Are there any rules about that in kernel or in our rdma subsystem? Should
>> I use a macro, just remove the keyword "inline" from this definition or
>> move this definition to .h?
> 
> Just drop "inline" word from the declaration.
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst#L882
> 
>>
>>>
>>>> +{
>>>> +	u32 hr_opcode = 0;
>>>> +
>>>> +	if (ib_opcode < IB_WR_RESERVED1)
>>>
>>> if (ib_opcode > ARRAY_SIZE(hns_roce_op_code) - 1)
>>> 	return HNS_ROCE_V2_WQE_OP_MASK;
>>>
>>> return hns_roce_op_code[ib_opcode];
>>>
>>
>> The index of ib_key in hns_roce_op_code[] is not continuous, so there
>> are some invalid ib_wr_opcode for hns between the valid index.
>>
>> For hardware of HIP08, HNS_ROCE_V2_WQE_OP_MASK means invalid opcode but
>> not zero. So we have to check if the ib_wr_opcode has a mapping value in
>> hns_roce_op_code[], and if the mapping result is zero, we have to return
>> HNS_ROCE_V2_WQE_OP_MASK. Is it ok like this?
> 
> I didn't mean that you will use my code as is, what about this?
> 
> if (ib_opcode > ARRAY_SIZE(hns_roce_op_code) - 1)
>  	return HNS_ROCE_V2_WQE_OP_MASK;
> 
> return hns_roce_op_code[ib_opcode] ?: HNS_ROCE_V2_WQE_OP_MASK;
> 
> Thanks
> 

One more question, should I add a Reviewed-by tag for anyone who has comments
on my patch, or I should only do this when the reviewer asked me to do it?

For example, should I add a reviewed-by tag for you in this patch? Thank you :)
