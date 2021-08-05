Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6776F3E0C7C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhHECgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 22:36:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7785 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhHECgV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Aug 2021 22:36:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgCQl1QDgzYlGn;
        Thu,  5 Aug 2021 10:35:59 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:36:06 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:36:04 +0800
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
To:     Leon Romanovsky <leon@kernel.org>
CC:     <liangwenpeng@huawei.com>, <liweihang@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <chenglang@huawei.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
Date:   Thu, 5 Aug 2021 10:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YQqb0U43eQUGK641@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/8/4 21:53, Leon Romanovsky wrote:
> On Wed, Aug 04, 2021 at 08:59:39PM +0800, YueHaibing wrote:
>> If re-registering an MR in hns_roce_rereg_user_mr(), we should
>> return NULL instead of pass 0 to ERR_PTR.
>>
>> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> index 006c84bb3f9f..7089ac780291 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> @@ -352,7 +352,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>>  free_cmd_mbox:
>>  	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
>>  
>> -	return ERR_PTR(ret);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +	return NULL;
>>  }
> 
> I don't understand this function, it returns or ERR_PTR() or NULL, but
> should return &mr->ibmr in success path. How does it work?

Did you means hns_roce_reg_user_mr()?

hns_roce_rereg_user_mr() returns ERR_PTR() on failure, and return NULL on success,

In ib_uverbs_rereg_mr(), old mr will be used if rereg_user_mr() return NULL, see:

 829         new_mr = ib_dev->ops.rereg_user_mr(mr, cmd.flags, cmd.start, cmd.length,
 830                                            cmd.hca_va, cmd.access_flags, new_pd,
 831                                            &attrs->driver_udata);
 832         if (IS_ERR(new_mr)) {
 833                 ret = PTR_ERR(new_mr);
 834                 goto put_new_uobj;
 835         }
 836         if (new_mr) {
.....
 860                 mr = new_mr;
 861         } else {
 862                 if (cmd.flags & IB_MR_REREG_PD) {
 863                         atomic_dec(&orig_pd->usecnt);
 864                         mr->pd = new_pd;
 865                         atomic_inc(&new_pd->usecnt);
 866                 }
 867                 if (cmd.flags & IB_MR_REREG_TRANS)
 868                         mr->iova = cmd.hca_va;
 869         }


> 
> Thanks
> 
>>  
>>  int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>> -- 
>> 2.17.1
>>
> .
> 
