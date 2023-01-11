Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA95B665467
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjAKGLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 01:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAKGLf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 01:11:35 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F886445
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 22:11:32 -0800 (PST)
Message-ID: <d1273ff2-1f7d-239e-770f-2249546cd1b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673417490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwV0kBG79VbNuKzVXXWsrr5BUPOFdDHZ0uCn0P3b4fg=;
        b=eQATPLuM0bN2skD8tLPAWV1vmzB/5POwVa4hTMr+XaFKismJjp/6whiDGN7S8rOxa6PhIx
        bTphtN/CGX62f5hDe3mchWRMSYWIUX3gYB+2vb3KR61cVsbVW80CAYJTTRFqJqrJ/k23hg
        0l5IDBZ4CwTJDyEFjKWHWLlRe1B9Sj4=
Date:   Wed, 11 Jan 2023 14:11:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into
 irdma_reg_user_mr_type_qp
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-4-yanjun.zhu@intel.com>
 <MWHPR11MB00297D796AE392D8FFCFD0A3E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB00297D796AE392D8FFCFD0A3E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/1/10 12:10, Saleem, Shiraz 写道:
>> Subject: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into
>> irdma_reg_user_mr_type_qp
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Split the source codes related with QP handling into a new function.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 48 ++++++++++++++++++++---------
>>   1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 287d4313f14d..e90eba73c396 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2831,6 +2831,39 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
>>   	kfree(iwmr);
>>   }
>>
>> +static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
>> +				     struct irdma_device *iwdev,
>> +				     struct ib_udata *udata,
>> +				     struct irdma_mr *iwmr)
> You could omit iwdev and compute it from iwmr.


Got it.


>
>> +{
>> +	u32 total;
>> +	int err = 0;
> No need to initialize.
Got it.
>
>> +	u8 shadow_pgcnt = 1;
>> +	bool use_pbles = false;
>
> No need to initialize use_pbles.

Thanks. I will send out the latest commits very soon.

Zhu Yanjun

>
>
>> +	unsigned long flags;
>> +	struct irdma_ucontext *ucontext;
>> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
>> +
>> +	total = req.sq_pages + req.rq_pages + shadow_pgcnt;
>> +	if (total > iwmr->page_cnt)
>> +		return -EINVAL;
>> +
>> +	total = req.sq_pages + req.rq_pages;
>> +	use_pbles = (total > 2);
>> +	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +	if (err)
>> +		return err;
>> +
>> +	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
>> +					     ibucontext);
>> +	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
>> +	list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
>> +	iwpbl->on_list = true;
>> +	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>> +
>> +	return err;
>> +}
>> +
>>   /**
>>    * irdma_reg_user_mr - Register a user memory region
>>    * @pd: ptr of pd
>> @@ -2886,23 +2919,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,
>>
>>   	switch (req.reg_type) {
>>   	case IRDMA_MEMREG_TYPE_QP:
>> -		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
>> -		if (total > iwmr->page_cnt) {
>> -			err = -EINVAL;
>> -			goto error;
>> -		}
>> -		total = req.sq_pages + req.rq_pages;
>> -		use_pbles = (total > 2);
>> -		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +		err = irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr);
>>   		if (err)
>>   			goto error;
>>
>> -		ucontext = rdma_udata_to_drv_context(udata, struct
>> irdma_ucontext,
>> -						     ibucontext);
>> -		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
>> -		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
>> -		iwpbl->on_list = true;
>> -		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>>   		break;
>>   	case IRDMA_MEMREG_TYPE_CQ:
>>   		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
>> IRDMA_FEATURE_CQ_RESIZE)
>> --
>> 2.31.1
