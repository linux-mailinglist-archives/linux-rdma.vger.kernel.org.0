Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7EA13D300
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAPEFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:05:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729110AbgAPEFX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:05:23 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68372C71EE946BDA8BB8;
        Thu, 16 Jan 2020 12:05:21 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 12:05:13 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
Date:   Thu, 16 Jan 2020 12:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200115205611.GG25201@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/16 4:56, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2020 at 09:42:26AM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> To support extended atomic operations including cmp & swap and fetch & add
>> of 8 bytes, 16 bytes, 32 bytes, 64 bytes in userspace, some field in qpc
>> should be configured.
>>
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 +++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  3 ++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index f1e0ba6..7edf3d8 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1692,7 +1692,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>>  	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
>>  	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
>>  	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
>> -	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
>> +	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
>>  	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
>>  	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
>>  	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
>> @@ -3286,6 +3286,9 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
>>  	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>>  		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
>>  	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
>> +	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
>> +		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
>> +	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
>>  }
>>  
>>  static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
>> @@ -3653,6 +3656,12 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>>  			     IB_ACCESS_REMOTE_ATOMIC));
>>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>>  			     0);
>> +		roce_set_bit(context->byte_76_srqn_op_en,
>> +			     V2_QPC_BYTE_76_EXT_ATE_S,
>> +			     !!(attr->qp_access_flags &
>> +				IB_ACCESS_REMOTE_ATOMIC));
>> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
>> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>>  	} else {
>>  		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
>>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
>> @@ -3668,6 +3677,11 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
>>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>>  			     0);
>> +		roce_set_bit(context->byte_76_srqn_op_en,
>> +			     V2_QPC_BYTE_76_EXT_ATE_S,
>> +			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
>> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
>> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>>  	}
> 
> What happens to your userspace if it runs on an old kernel and tries
> to use extended atomic?
> 
> Jason
>

Hi Jason,

If the hns userspace runs with old kernel, the hardware will report a asynchronous
event for the extended atomic operation and modify the qp to error state because
the enable bit in this qp's context hasn't been set.

The driver will print like this:

[ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
[ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!

Thanks
Weihang

> .
> 

