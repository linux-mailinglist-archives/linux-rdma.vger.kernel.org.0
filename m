Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C627B80C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfGaCnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 22:43:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbfGaCnL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 22:43:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6BA23A9573FAE8280B4;
        Wed, 31 Jul 2019 10:43:08 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 10:43:02 +0800
Subject: Re: [PATCH for-next 10/13] RDMA/hns: Remove unnecessary kzalloc
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-11-git-send-email-oulijun@huawei.com>
 <20190730134025.GD4878@mtr-leonro.mtl.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <aab804d4-561a-2e3a-969c-55a523c6ee0d@huawei.com>
Date:   Wed, 31 Jul 2019 10:43:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190730134025.GD4878@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/7/30 21:40, Leon Romanovsky Ð´µÀ:
> On Tue, Jul 30, 2019 at 04:56:47PM +0800, Lijun Ou wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> For hns_roce_v2_query_qp and hns_roce_v2_modify_qp,
>> we can use stack memory to create qp context data.
>> Make the code simpler.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++-----------------
>>  1 file changed, 27 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 1186e34..07ddfae 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -4288,22 +4288,19 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
>>  {
>>  	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>>  	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>> -	struct hns_roce_v2_qp_context *context;
>> -	struct hns_roce_v2_qp_context *qpc_mask;
>> +	struct hns_roce_v2_qp_context ctx[2];
>> +	struct hns_roce_v2_qp_context *context = ctx;
>> +	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
>>  	struct device *dev = hr_dev->dev;
>>  	int ret;
>>
>> -	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
>> -	if (!context)
>> -		return -ENOMEM;
>> -
>> -	qpc_mask = context + 1;
>>  	/*
>>  	 * In v2 engine, software pass context and context mask to hardware
>>  	 * when modifying qp. If software need modify some fields in context,
>>  	 * we should set all bits of the relevant fields in context mask to
>>  	 * 0 at the same time, else set them to 0x1.
>>  	 */
>> +	memset(context, 0, sizeof(*context));
> "struct hns_roce_v2_qp_context ctx[2] = {};" will do the trick.
>
> Thanks
>
> .
In this case, the mask is actually writen twice. if you do this, will it bring extra overhead when modify qp?



