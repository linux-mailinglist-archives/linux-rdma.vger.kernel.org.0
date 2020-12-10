Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910AB2D525E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 05:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLJEBF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 9 Dec 2020 23:01:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2476 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbgLJEBC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 23:01:02 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cs0YF0HLNz54C4;
        Thu, 10 Dec 2020 11:59:45 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 10 Dec 2020 12:00:17 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 10 Dec 2020 12:00:16 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Thu, 10 Dec 2020 12:00:16 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 05/11] RDMA/hns: WARN_ON if get a reserved sl
 from users
Thread-Topic: [PATCH v2 for-next 05/11] RDMA/hns: WARN_ON if get a reserved sl
 from users
Thread-Index: AQHWyiqFeUZ8XkvfE0u5Kq9Tx0pz1w==
Date:   Thu, 10 Dec 2020 04:00:16 +0000
Message-ID: <29da177187e44ffd98a9b834ff3dc5ed@huawei.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
 <1607078436-26455-6-git-send-email-liweihang@huawei.com>
 <20201209210902.GA2001139@nvidia.com>
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

On 2020/12/10 5:09, Jason Gunthorpe wrote:
> On Fri, Dec 04, 2020 at 06:40:30PM +0800, Weihang Li wrote:
>> According to the RoCE v1 specification, the sl (service level) 0-7 are
>> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
>> driver should verify whether the value of sl is larger than 7, if so, an
>> exception should be returned.
>>
>> Fixes: 172505cfa3a8 ("RDMA/hns: Add check for the validity of sl configuration")
>> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 7a0c1ab..15e1313 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -433,6 +433,10 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
>>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
>>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
>>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
>> +
>> +	if (WARN_ON(ah->av.sl > MAX_SERVICE_LEVEL))
>> +		return -EINVAL;
>> +
>>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
>>  		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
>>  
>> @@ -4609,12 +4613,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
>>  	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
>>  
>>  	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
>> -	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
>> -		ibdev_err(ibdev,
>> -			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
>> -			  hr_qp->sl, MAX_SERVICE_LEVEL);
>> +	if (WARN_ON(hr_qp->sl > MAX_SERVICE_LEVEL))
>>  		return -EINVAL;
>> -	}
>>  
>>  	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
>>  		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);
> 
> Can any of these warn_on's be triggered by user space? That would not
> be OK
> 
> Jason
> 

Hi Jason,

Thanks for your comments, I understand that error that can be triggered by
userspace shouldn't use WARN_ON(). So I shouldn't use WARN_ON() in
hns_roce_v2_set_path().

As for the error in process of post_send, you suggested me to warn_on if
a kernel user try to pass in an illegal opcode. So I guess I should use
WARN_ON() too in sl's check when filling a UD WQE. Am I right?

Weihang
