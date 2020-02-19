Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4C163EAC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSIOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 03:14:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgBSIOs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 03:14:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E99AE7E4A56FAA8364EA;
        Wed, 19 Feb 2020 16:14:45 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Feb 2020
 16:14:36 +0800
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell allocation
 flow
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <1581325720-12975-8-git-send-email-liweihang@huawei.com>
 <20200219005225.GA25540@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <04b1c2e6-a3e1-9e29-708d-4ae29c1e1602@huawei.com>
Date:   Wed, 19 Feb 2020 16:14:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200219005225.GA25540@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/19 8:52, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 05:08:40PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Encapsulate the kernel qp doorbell allocation related code into 2
>> functions: alloc_qp_db() and free_qp_db().
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_qp.c | 214 +++++++++++++++++---------------
>>  1 file changed, 113 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index ad34187..46785f1 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -844,6 +844,96 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>>  		free_rq_inline_buf(hr_qp);
>>  }
>>  
>> +#define user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd) \
>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) && \
>> +		udata->outlen >= sizeof(*resp) && \
>> +		hns_roce_qp_has_sq(init_attr) && udata->inlen >= sizeof(*ucmd))
>> +
>> +#define user_qp_has_rdb(hr_dev, init_attr, udata, resp) \
>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
>> +		udata->outlen >= sizeof(*resp) && \
>> +		hns_roce_qp_has_rq(init_attr))
>> +
>> +#define kernel_qp_has_rdb(hr_dev, init_attr) \
>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
>> +		hns_roce_qp_has_rq(init_attr))
> 
> static inline functions not defines please
> 

OK, I will change them into inline functions.

> Also, these tests against inline and outlen look very strange. What
> are they doing?
> 
> Jason
>

These judgement about inlen and outlen is for compatibility reasons,
previous discussions can be found at:

https://patchwork.kernel.org/patch/10172233/

Thanks,
Weihang

> 

