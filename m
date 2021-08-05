Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0A3E1148
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhHEJ3n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 05:29:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12454 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHEJ3n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 05:29:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GgNWh5By0zcl7t;
        Thu,  5 Aug 2021 17:25:52 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 17:29:27 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 5 Aug 2021 17:29:26 +0800
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
To:     Leon Romanovsky <leon@kernel.org>
CC:     <liangwenpeng@huawei.com>, <liweihang@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <chenglang@huawei.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal> <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
 <YQtdswHgMXhC7Mf5@unreal>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <974d3309-3617-6413-5a8d-c92b1b2f8dfe@huawei.com>
Date:   Thu, 5 Aug 2021 17:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YQtdswHgMXhC7Mf5@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/8/5 11:40, Leon Romanovsky wrote:
> On Thu, Aug 05, 2021 at 10:36:03AM +0800, YueHaibing wrote:
>> On 2021/8/4 21:53, Leon Romanovsky wrote:
>>> On Wed, Aug 04, 2021 at 08:59:39PM +0800, YueHaibing wrote:
>>>> If re-registering an MR in hns_roce_rereg_user_mr(), we should
>>>> return NULL instead of pass 0 to ERR_PTR.
>>>>
>>>> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>>> index 006c84bb3f9f..7089ac780291 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>>> @@ -352,7 +352,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>>>>  free_cmd_mbox:
>>>>  	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
>>>>  
>>>> -	return ERR_PTR(ret);
>>>> +	if (ret)
>>>> +		return ERR_PTR(ret);
>>>> +	return NULL;
>>>>  }
>>>
>>> I don't understand this function, it returns or ERR_PTR() or NULL, but
>>> should return &mr->ibmr in success path. How does it work?
>>
>> Did you means hns_roce_reg_user_mr()?
>>
>> hns_roce_rereg_user_mr() returns ERR_PTR() on failure, and return NULL on success,
>>
>> In ib_uverbs_rereg_mr(), old mr will be used if rereg_user_mr() return NULL, see:
>>
>>  829         new_mr = ib_dev->ops.rereg_user_mr(mr, cmd.flags, cmd.start, cmd.length,
>>  830                                            cmd.hca_va, cmd.access_flags, new_pd,
>>  831                                            &attrs->driver_udata);
>>  832         if (IS_ERR(new_mr)) {
>>  833                 ret = PTR_ERR(new_mr);
>>  834                 goto put_new_uobj;
>>  835         }
>>  836         if (new_mr) {
>> .....
>>  860                 mr = new_mr;
>>  861         } else {
>>  862                 if (cmd.flags & IB_MR_REREG_PD) {
>>  863                         atomic_dec(&orig_pd->usecnt);
>>  864                         mr->pd = new_pd;
>>  865                         atomic_inc(&new_pd->usecnt);
>>  866                 }
>>  867                 if (cmd.flags & IB_MR_REREG_TRANS)
>>  868                         mr->iova = cmd.hca_va;
>>  869         }
> 
> You overwrite various fields in old_mr when executing hns_roce_rereg_user_mr().
> For example mr->access flags, which is not returned to the original
> state after all failures.

IMO, if ibv_rereg_mr failed, the mr is in undefined state, user needs to call
ibv_dereg_mr in order to release it, so there no need to recover the original state.

Also， mlx4_ib_rereg_user_mr seems to do the same thing.

> 
> Also I'm not so sure about if it is valid to return NULL in all flows.
> 
> Thanks
> 
>>
>>
>>>
>>> Thanks
>>>
>>>>  
>>>>  int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>>> -- 
>>>> 2.17.1
>>>>
>>> .
>>>
> .
> 
