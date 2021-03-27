Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220D34B385
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 02:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC0B3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 26 Mar 2021 21:29:38 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3387 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhC0B3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 21:29:32 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F6h5S361dz5ggC;
        Sat, 27 Mar 2021 09:26:52 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 27 Mar 2021 09:29:25 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 27 Mar 2021 09:29:25 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Sat, 27 Mar 2021 09:29:25 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 2/5] RDMA/hns: Reorganize hns_roce_create_cq()
Thread-Topic: [PATCH for-next 2/5] RDMA/hns: Reorganize hns_roce_create_cq()
Thread-Index: AQHXGw28Q5KnLlQnqEGTB98BKFnyhA==
Date:   Sat, 27 Mar 2021 01:29:25 +0000
Message-ID: <30e76bdea14a4a7bb00ab3a4e7a7515c@huawei.com>
References: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
 <1615972183-42510-3-git-send-email-liweihang@huawei.com>
 <20210326144016.GA844532@nvidia.com>
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

On 2021/3/26 22:40, Jason Gunthorpe wrote:
> On Wed, Mar 17, 2021 at 05:09:40PM +0800, Weihang Li wrote:
>> From: Yixing Liu <liuyixing1@huawei.com>
>>
>> Encapsulate two subprocesses into functions.
>>
>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_cq.c | 87 ++++++++++++++++++++++-----------
>>  1 file changed, 59 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
>> index 74fc494..467caa9 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
>> @@ -276,6 +276,58 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
>>  	}
>>  }
>>  
>> +static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
>> +				 const struct ib_cq_init_attr *attr)
>> +{
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +
>> +	if (!attr->cqe || attr->cqe > hr_dev->caps.max_cqes) {
>> +		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
>> +			  attr->cqe, hr_dev->caps.max_cqes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (attr->comp_vector >= hr_dev->caps.num_comp_vectors) {
>> +		ibdev_err(ibdev, "failed to check CQ vector = %u, max = %d.\n",
>> +			  attr->comp_vector, hr_dev->caps.num_comp_vectors);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_cq_ucmd(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
>> +		       struct hns_roce_ib_create_cq *ucmd)
>> +{
>> +	struct ib_device *ibdev = hr_cq->ib_cq.device;
>> +	int ret;
>> +
>> +	ret = ib_copy_from_udata(ucmd, udata, min(udata->inlen,
>> +						  sizeof(*ucmd)));
> 
> Is this leading up to something? Wrapping one function in another is
> getting a bit silly
> 
> Jason
> 

Thanks, I will use a variable instead.

Weihang
