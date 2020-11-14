Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4322B2B22
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Nov 2020 04:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNDrB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 13 Nov 2020 22:47:01 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2369 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 22:47:01 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CY1VD0n9hz4w77;
        Sat, 14 Nov 2020 11:46:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 14 Nov 2020 11:46:58 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 14 Nov 2020 11:46:58 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 14 Nov 2020 11:46:58 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/8] RDMA/hns: Add check for the validity of sl
 configuration in UD SQ WQE
Thread-Topic: [PATCH for-next 4/8] RDMA/hns: Add check for the validity of sl
 configuration in UD SQ WQE
Thread-Index: AQHWrrGb5sJLpqzLpESbSm5eotxBOw==
Date:   Sat, 14 Nov 2020 03:46:58 +0000
Message-ID: <5100fe6771d24c3e83fc401e490ce4fa@huawei.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
 <1604057975-23388-5-git-send-email-liweihang@huawei.com>
 <20201112183245.GA963928@nvidia.com>
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

On 2020/11/13 2:33, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 07:39:31PM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> According to the RoCE v1 specification, the sl (service level) 0-7 are
>> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
>> driver should verify whether the value of sl is larger than 7, if so, an
>> exception should be returned.
>>
>> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 7a1d30f..69386a5 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -427,9 +427,10 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>>  			     void *wqe, unsigned int *sge_idx,
>>  			     unsigned int owner_bit)
>>  {
>> -	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
>>  	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
>>  	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
>> +	struct ib_device *ib_dev = qp->ibqp.device;
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
>>  	unsigned int curr_idx = *sge_idx;
>>  	int valid_num_sge;
>>  	u32 msg_len = 0;
>> @@ -489,6 +490,13 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
>>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
>>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
>> +
>> +	if (unlikely(ah->av.sl > MAX_SERVICE_LEVEL)) {
>> +		ibdev_err(ib_dev,
>> +			  "failed to fill ud av, ud sl (%d) shouldn't be larger than %d.\n",
>> +			  ah->av.sl, MAX_SERVICE_LEVEL);
>> +		return -EINVAL;
>> +	}
> 
> We should not print for things like this, IIRC userspace can cause the
> ah's sl to become set out of bounds
> 
> Jason
> 

Hi Jason,

In "Annex A 16: RoCE", I found the following description:

	SL 0-7 are mapped directly to Priorities 0-7, respectively

	SL 8-15 are reserved.

	CA16-18: An attempt to use an Address Vector for a RoCE port containing
	a reserved SL value shall result in the Invalid Address Vector verb result.

So what should we do if the user wants to use the reserved sl? Should I just let it
do mask with 0x7 when creating AH?

Thanks
Weihang
