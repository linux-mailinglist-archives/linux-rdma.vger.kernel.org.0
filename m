Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924EB66547B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAKGYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 01:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAKGYD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 01:24:03 -0500
X-Greylist: delayed 2552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 22:23:53 PST
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51911468
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 22:23:52 -0800 (PST)
Message-ID: <aa3d4de4-1302-5466-5157-b691a41fee51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673418230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7x/xRhcgmO3+Ra7KGmXWfIwZ0SowAhiw6hqlThz9LM=;
        b=f3CSJNt9980lSLn7dJpDGBHK/KL5aWRyM2cMpNpy9+s+demOPxd+LgeUWzDggJX8/l9KB2
        PfKH6g+fif6CHCH0LTpMPFATiY/bSxg3aIycH/BQqFboyn1KvBM7vkiTqf1B39bzsKb5Wq
        8SRVKJdhAnRtoALbKKvyEF9tNZ6pG3U=
Date:   Wed, 11 Jan 2023 14:23:45 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into
 irdma_reg_user_mr_type_cq
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-5-yanjun.zhu@intel.com>
 <MWHPR11MB002968ADD8E903D7ED9F84FEE9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB002968ADD8E903D7ED9F84FEE9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/1/10 12:12, Saleem, Shiraz 写道:
>> Subject: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into
>> irdma_reg_user_mr_type_cq
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Split the source codes related with CQ handling into a new function.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 60 +++++++++++++++++------------
>>   1 file changed, 35 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index e90eba73c396..b4befbafb830 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2864,6 +2864,40 @@ static int irdma_reg_user_mr_type_qp(struct
>> irdma_mem_reg_req req,
>>   	return err;
>>   }
>>
>> +static int irdma_reg_user_mr_type_cq(struct irdma_device *iwdev,
>> +				     struct irdma_mr *iwmr,
>> +				     struct ib_udata *udata,
>> +				     struct irdma_mem_reg_req req)
> I would keep the order of these API args same as the one for irdma_reg_user_mr_type_qp.
Got it.
>
>> +{
>> +	int err = 0;
> No need to initialize.
Got it.
>
>> +	u8 shadow_pgcnt = 1;
>> +	bool use_pbles = false;
> No need to initialize use_pbles.
Got it.
>
>> +	struct irdma_ucontext *ucontext;
>> +	unsigned long flags;
>> +	u32 total;
>> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
>> +
>> +	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
>> IRDMA_FEATURE_CQ_RESIZE)
>> +		shadow_pgcnt = 0;
>> +	total = req.cq_pages + shadow_pgcnt;
>> +	if (total > iwmr->page_cnt)
>> +		return -EINVAL;
>> +
>> +	use_pbles = (req.cq_pages > 1);
>> +	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +	if (err)
>> +		return err;
>> +
>> +	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
>> +					     ibucontext);
>> +	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
>> +	list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
>> +	iwpbl->on_list = true;
>> +	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>> +
>> +	return err;
>> +}
>> +
>>   /**
>>    * irdma_reg_user_mr - Register a user memory region
>>    * @pd: ptr of pd
>> @@ -2879,15 +2913,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,  {  #define IRDMA_MEM_REG_MIN_REQ_LEN
>> offsetofend(struct irdma_mem_reg_req, sq_pages)
>>   	struct irdma_device *iwdev = to_iwdev(pd->device);
>> -	struct irdma_ucontext *ucontext;
>> -	struct irdma_pbl *iwpbl;
>>   	struct irdma_mr *iwmr;
>>   	struct ib_umem *region;
>>   	struct irdma_mem_reg_req req;
>> -	u32 total;
>> -	u8 shadow_pgcnt = 1;
>> -	bool use_pbles = false;
>> -	unsigned long flags;
>>   	int err = -EINVAL;
> Do we need to initialize err here too? Probably separate from this patch but could clean up.

Yes. In switch-case-default, in default branch, err is not assigned to 
any error.

In the latest commit, err is assigned to -EINVAL in default branch and 
here err is not set.

I will send out the latest commits very soon.

Zhu Yanjun

>
>>   	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>> @@ -2915,8 +2943,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd,
>> u64 start, u64 len,
>>   		return (struct ib_mr *)iwmr;
>>   	}
>>
>> -	iwpbl = &iwmr->iwpbl;
>> -
>>   	switch (req.reg_type) {
>>   	case IRDMA_MEMREG_TYPE_QP:
>>   		err = irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr); @@ -
>> 2925,25 +2951,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64
>> start, u64 len,
>>
>>   		break;
>>   	case IRDMA_MEMREG_TYPE_CQ:
>> -		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
>> IRDMA_FEATURE_CQ_RESIZE)
>> -			shadow_pgcnt = 0;
>> -		total = req.cq_pages + shadow_pgcnt;
>> -		if (total > iwmr->page_cnt) {
>> -			err = -EINVAL;
>> -			goto error;
>> -		}
>> -
>> -		use_pbles = (req.cq_pages > 1);
>> -		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +		err = irdma_reg_user_mr_type_cq(iwdev, iwmr, udata, req);
>>   		if (err)
>>   			goto error;
>> -
>> -		ucontext = rdma_udata_to_drv_context(udata, struct
>> irdma_ucontext,
>> -						     ibucontext);
>> -		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
>> -		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
>> -		iwpbl->on_list = true;
>> -		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>>   		break;
>>   	case IRDMA_MEMREG_TYPE_MEM:
>>   		err = irdma_reg_user_mr_type_mem(iwdev, iwmr, access);
>> --
>> 2.31.1
