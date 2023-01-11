Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798366541C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjAKF7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 00:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjAKF7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 00:59:20 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8213BD
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 21:59:19 -0800 (PST)
Message-ID: <315d24cb-e180-3fe3-5f4c-f0e547035ed4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673416758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jtllCfTJFjQxuT2skEmUBXNvpH6FxhSL1qJQKeV58NQ=;
        b=eVyMW8S/gbPfU3jCqramvsYWKaPkte0eH2EBBBYDc3neImAGGTPKGREgiu8/SwkDJbseeX
        8W4yGW6M9d2dt1nKvIpO9qeIgscfzvAiubC/Z6UHSFqCAalCvdWJORtWjp9FUBe3u41NNU
        A8JuV4k3+WoOEqW8XvoPGfoKUgPsrk8=
Date:   Wed, 11 Jan 2023 13:59:08 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into new
 functions
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-3-yanjun.zhu@intel.com>
 <MWHPR11MB002992573341AA0ED11BB499E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB002992573341AA0ED11BB499E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/1/10 12:11, Saleem, Shiraz 写道:
>> Subject: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into new
>> functions
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In the function irdma_reg_user_mr, the mr allocation and free will be used by other
>> functions. As such, the source codes related with mr allocation and free are split
>> into the new functions.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 78 ++++++++++++++++++-----------
>>   1 file changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 40109da6489a..5cff8656d79e 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2794,6 +2794,52 @@ static int irdma_reg_user_mr_type_mem(struct
>> irdma_device *iwdev,
>>   	return err;
>>   }
>>
>> +static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
>> +					 struct ib_pd *pd, u64 virt,
>> +					 __u16 reg_type,
> enum irdma_memreg_type


Good catch


>
>> +					 struct irdma_device *iwdev)
>> +{
>> +	struct irdma_mr *iwmr;
>> +	struct irdma_pbl *iwpbl;
>> +
>> +	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
>> +	if (!iwmr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	iwpbl = &iwmr->iwpbl;
>> +	iwpbl->iwmr = iwmr;
>> +	iwmr->region = region;
>> +	iwmr->ibmr.pd = pd;
>> +	iwmr->ibmr.device = pd->device;
>> +	iwmr->ibmr.iova = virt;
>> +	iwmr->page_size = PAGE_SIZE;
> Delete this and see comment below,


Will delete.


>
>> +	iwmr->type = reg_type;
>> +
>> +	if (reg_type == IRDMA_MEMREG_TYPE_MEM) {
>> +		iwmr->page_size = ib_umem_find_best_pgsz(region,
>> +							 iwdev->rf-
>>> sc_dev.hw_attrs.page_size_cap,
> I think Jason made the comment to always validate the page size with this function before use in rdma_umem_for_each_dma_block.
>
> we can move it out of this if block with something like,
>
> pgsz_bitmask = reg_type == IRDMA_MEMREG_TYPE_MEM ?
> 			iwdev->rf->sc_dev.hw_attrs.page_size_cap : PAGE_SIZE;
>
> iwmr->page_size = ib_umem_find_best_pgsz(region, pgsz_bitmask, virt);


Wonderful. I followed your suggestions in the latest commits.


>
>
>
>> +							 virt);
>> +		if (unlikely(!iwmr->page_size)) {
>> +			kfree(iwmr);
>> +			return ERR_PTR(-EOPNOTSUPP);
>> +		}
>> +	}
>> +
>> +	iwmr->len = region->length;
>> +	iwpbl->user_base = virt;
>> +	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
>> +
>> +	return iwmr;
>> +}
>> +
>> +/*
>> + * This function frees the resources from irdma_alloc_iwmr  */ static
> This doesn't follow kdoc format? And not very useful. I would delete it.

Will delete.

Appreciate your helps. I will send out the latest commits very soon.

Zhu Yanjun

>
>> +void irdma_free_iwmr(struct irdma_mr *iwmr) {
>> +	kfree(iwmr);
>> +}
>> +
>>   /**
>>    * irdma_reg_user_mr - Register a user memory region
>>    * @pd: ptr of pd
>> @@ -2839,34 +2885,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,
>>   		return ERR_PTR(-EFAULT);
>>   	}
>>
>> -	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
>> -	if (!iwmr) {
>> +	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type, iwdev);
>> +	if (IS_ERR(iwmr)) {
>>   		ib_umem_release(region);
>> -		return ERR_PTR(-ENOMEM);
>> +		return (struct ib_mr *)iwmr;
>>   	}
>>
>>   	iwpbl = &iwmr->iwpbl;
>> -	iwpbl->iwmr = iwmr;
>> -	iwmr->region = region;
>> -	iwmr->ibmr.pd = pd;
>> -	iwmr->ibmr.device = pd->device;
>> -	iwmr->ibmr.iova = virt;
>> -	iwmr->page_size = PAGE_SIZE;
>> -
>> -	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
>> -		iwmr->page_size = ib_umem_find_best_pgsz(region,
>> -							 iwdev->rf-
>>> sc_dev.hw_attrs.page_size_cap,
>> -							 virt);
>> -		if (unlikely(!iwmr->page_size)) {
>> -			kfree(iwmr);
>> -			ib_umem_release(region);
>> -			return ERR_PTR(-EOPNOTSUPP);
>> -		}
>> -	}
>> -	iwmr->len = region->length;
>> -	iwpbl->user_base = virt;
>> -	iwmr->type = req.reg_type;
>> -	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
>>
>>   	switch (req.reg_type) {
>>   	case IRDMA_MEMREG_TYPE_QP:
>> @@ -2918,13 +2943,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,
>>   		goto error;
>>   	}
>>
>> -	iwmr->type = req.reg_type;
>> -
>>   	return &iwmr->ibmr;
>> -
>>   error:
>>   	ib_umem_release(region);
>> -	kfree(iwmr);
>> +	irdma_free_iwmr(iwmr);
>>
>>   	return ERR_PTR(err);
>>   }
>> --
>> 2.27.0
