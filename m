Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9B6653F5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 06:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjAKFoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 00:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjAKFnl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 00:43:41 -0500
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC39644C
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 21:41:22 -0800 (PST)
Message-ID: <1f6c066a-46a1-4d55-80ef-6752c10ea7f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673415677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UxPfG0G5GkzpHDVcEqhERp7g3BfnXXAstihObWiz/E=;
        b=IlcUpll/04Viyn7bAD13Rs4HqOha9AtZLTMIE/PKyQ57oBm3NZbh+ro0KPtyEN9jV+PkmK
        TkuxfEShLdzigdkt4LeNTnRj7efi1hbBIJyNVqq7YXXzzimE6FllU2Nop+8l13ib5qugRj
        N2P2Ht6a6K72tI4xOoVIGeEK3X509qk=
Date:   Wed, 11 Jan 2023 13:41:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into
 irdma_reg_user_mr_type_mem
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-2-yanjun.zhu@intel.com>
 <MWHPR11MB00297F705B53748288FB03E9E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB00297F705B53748288FB03E9E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
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


在 2023/1/10 12:10, Saleem, Shiraz 写道:
>> Subject: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into
>> irdma_reg_user_mr_type_mem
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The source codes related with IRDMA_MEMREG_TYPE_MEM are split into a new
>> function irdma_reg_user_mr_type_mem.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 85 +++++++++++++++++------------
>>   1 file changed, 51 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index f6973ea55eda..40109da6489a 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2745,6 +2745,55 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev,
>> struct irdma_mr *iwmr,
>>   	return ret;
>>   }
>>
>> +static int irdma_reg_user_mr_type_mem(struct irdma_device *iwdev,
>> +				      struct irdma_mr *iwmr, int access) {
>> +	int err = 0;
>> +	bool use_pbles = false;
>> +	u32 stag = 0;
> No need to initialize any of these?


Got it.


>
>> +	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
>> +
>> +	use_pbles = (iwmr->page_cnt != 1);
>> +
>> +	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
>> +	if (err)
>> +		return err;
>> +
>> +	if (use_pbles) {
>> +		err = irdma_check_mr_contiguous(&iwpbl->pble_alloc,
>> +						iwmr->page_size);
>> +		if (err) {
>> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
>>> pble_alloc);
>> +			iwpbl->pbl_allocated = false;
>> +			return err;
> No this should not cause an error. Just that we don't want to use pbles for this region. reset use_pbles to false here?


Got it.


>
>> +		}
>> +	}
>> +
>> +	stag = irdma_create_stag(iwdev);
>> +	if (!stag) {
>> +		if (use_pbles) {
>> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
>>> pble_alloc);
>> +			iwpbl->pbl_allocated = false;
>> +		}
>> +		return -ENOMEM;
>> +	}
>> +
>> +	iwmr->stag = stag;
>> +	iwmr->ibmr.rkey = stag;
>> +	iwmr->ibmr.lkey = stag;
>> +	err = irdma_hwreg_mr(iwdev, iwmr, access);
>> +	if (err) {
>> +		irdma_free_stag(iwdev, stag);
>> +		if (use_pbles) {
>> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
>>> pble_alloc);
>> +			iwpbl->pbl_allocated = false;
> Setting the iwpbl->pbl_allocated to false is not required. We are going to free up the iwmr memory on this error anyway.
>
> Just a suggestion. Maybe just use a  goto a label "free_pble" that does the irdma_free_pble and returns err. And re-use it for irdma_create_stag error unwind too.


Sure. I followed your advice in the latest commits.


>
>> +		}
>> +		return err;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>>   /**
>>    * irdma_reg_user_mr - Register a user memory region
>>    * @pd: ptr of pd
>> @@ -2761,17 +2810,15 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,  #define IRDMA_MEM_REG_MIN_REQ_LEN
>> offsetofend(struct irdma_mem_reg_req, sq_pages)
>>   	struct irdma_device *iwdev = to_iwdev(pd->device);
>>   	struct irdma_ucontext *ucontext;
>> -	struct irdma_pble_alloc *palloc;
>>   	struct irdma_pbl *iwpbl;
>>   	struct irdma_mr *iwmr;
>>   	struct ib_umem *region;
>>   	struct irdma_mem_reg_req req;
>> -	u32 total, stag = 0;
>> +	u32 total;
>>   	u8 shadow_pgcnt = 1;
>>   	bool use_pbles = false;
>>   	unsigned long flags;
>>   	int err = -EINVAL;
>> -	int ret;
>>
>>   	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>>   		return ERR_PTR(-EINVAL);
>> @@ -2818,7 +2865,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd,
>> u64 start, u64 len,
>>   	}
>>   	iwmr->len = region->length;
>>   	iwpbl->user_base = virt;
>> -	palloc = &iwpbl->pble_alloc;
>>   	iwmr->type = req.reg_type;
>>   	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
>>
>> @@ -2864,36 +2910,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,
>>   		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>>   		break;
>>   	case IRDMA_MEMREG_TYPE_MEM:
>> -		use_pbles = (iwmr->page_cnt != 1);
>> -
>> -		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
>> +		err = irdma_reg_user_mr_type_mem(iwdev, iwmr, access);
> Perhaps you can just pass the iwmr and access as args for this API and compute the iwdev in the function using to_iwdev(iwmr->ibmr.device)


Got it. I followed your advice in the latest commits.

I will send out the latest commits very soon.

Zhu Yanjun


>
>>   		if (err)
>>   			goto error;
>> -
>> -		if (use_pbles) {
>> -			ret = irdma_check_mr_contiguous(palloc,
>> -							iwmr->page_size);
>> -			if (ret) {
>> -				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
>> -				iwpbl->pbl_allocated = false;
>> -			}
>> -		}
>> -
>> -		stag = irdma_create_stag(iwdev);
>> -		if (!stag) {
>> -			err = -ENOMEM;
>> -			goto error;
>> -		}
>> -
>> -		iwmr->stag = stag;
>> -		iwmr->ibmr.rkey = stag;
>> -		iwmr->ibmr.lkey = stag;
>> -		err = irdma_hwreg_mr(iwdev, iwmr, access);
>> -		if (err) {
>> -			irdma_free_stag(iwdev, stag);
>> -			goto error;
>> -		}
>> -
>>   		break;
>>   	default:
>>   		goto error;
>> @@ -2904,8 +2923,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd,
>> u64 start, u64 len,
>>   	return &iwmr->ibmr;
>>
>>   error:
>> -	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
>> -		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
>>   	ib_umem_release(region);
>>   	kfree(iwmr);
>>
>> --
>> 2.27.0
