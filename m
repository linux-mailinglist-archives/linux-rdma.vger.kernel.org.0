Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0037D65D391
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjADM7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 07:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjADM7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 07:59:35 -0500
Received: from out-137.mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72DFCF1
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 04:59:33 -0800 (PST)
Message-ID: <b6f210db-0946-1c1a-4bd0-030de6ccd6ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672837171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpBFyv1kXHBZXlOeMvLCwhcZmZGahoUO60e8REDfmGs=;
        b=WC1ZXHPcRl4QmDDfQs1K0NDPYa2ze54avYe+bGbF58GtY13Ah8kHOzzC2SfzjVWgLLP2rh
        rln09FH8rj5tthQymzBJVVGC4RwJoMPucmCyrqoIDXWNbVQ2I369nrozuHwvGhixD23h10
        j+RNbnAz/RuKr++0oez9TeOcptI8zMo=
Date:   Wed, 4 Jan 2023 20:59:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
 regions
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230103060855.644516-1-yanjun.zhu@intel.com>
 <MWHPR11MB0029F8368BF8A689F9CBD311E9F49@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB0029F8368BF8A689F9CBD311E9F49@MWHPR11MB0029.namprd11.prod.outlook.com>
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


在 2023/1/4 7:35, Saleem, Shiraz 写道:
>> Subject: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
>> regions
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a followup to the EFA dmabuf[1]. Irdma driver currently does not support
>> on-demand-paging(ODP). So it uses habanalabs as the dmabuf exporter, and
>> irdma as the importer to allow for peer2peer access through libibverbs.
>>
>> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
>> This function is introduced in EFA dmabuf[1] which allows the driver to get a
>> dmabuf umem which is pinned and does not require move_notify callback
>> implementation. The returned umem is pinned and DMA mapped like standard cpu
>> umems, and is released through ib_umem_release().
>>
>> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Is there a corresponding user-space patch?

Yes. I will send it out very soon.

Zhu Yanjun

>
>
>> ---
>> V1->V2: Fix the build warning by adding a static
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index f6973ea55eda..1572baa93856 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
>> *pd, u64 start, u64 len,
>>   	return ERR_PTR(err);
>>   }
>>
>> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>> +					      u64 len, u64 virt,
>> +					      int fd, int access,
>> +					      struct ib_udata *udata)
>> +{
>> +	struct irdma_device *iwdev = to_iwdev(pd->device);
>> +	struct irdma_ucontext *ucontext;
>> +	struct irdma_pble_alloc *palloc;
>> +	struct irdma_pbl *iwpbl;
>> +	struct irdma_mr *iwmr;
>> +	struct irdma_mem_reg_req req;
>> +	u32 total, stag = 0;
>> +	u8 shadow_pgcnt = 1;
>> +	bool use_pbles = false;
>> +	unsigned long flags;
>> +	int err = -EINVAL;
>> +	struct ib_umem_dmabuf *umem_dmabuf;
>> +
>> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
>> +						access);
>> +	if (IS_ERR(umem_dmabuf)) {
>> +		err = PTR_ERR(umem_dmabuf);
>> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n",
>> err);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
>> +		ib_umem_release(&umem_dmabuf->umem);
>> +		return ERR_PTR(-EFAULT);
>> +	}
>> +
>> +	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
>> +	if (!iwmr) {
>> +		ib_umem_release(&umem_dmabuf->umem);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	iwpbl = &iwmr->iwpbl;
>> +	iwpbl->iwmr = iwmr;
>> +	iwmr->region = &umem_dmabuf->umem;
>> +	iwmr->ibmr.pd = pd;
>> +	iwmr->ibmr.device = pd->device;
>> +	iwmr->ibmr.iova = virt;
>> +	iwmr->page_size = PAGE_SIZE;
>> +
>> +	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
>> +		iwmr->page_size = ib_umem_find_best_pgsz(iwmr->region,
>> +							 iwdev->rf-
>>> sc_dev.hw_attrs.page_size_cap,
>> +							 virt);
>> +		if (unlikely(!iwmr->page_size)) {
>> +			kfree(iwmr);
>> +			ib_umem_release(iwmr->region);
>> +			return ERR_PTR(-EOPNOTSUPP);
>> +		}
>> +	}
>> +	iwmr->len = iwmr->region->length;
>> +	iwpbl->user_base = virt;
>> +	palloc = &iwpbl->pble_alloc;
>> +	iwmr->type = req.reg_type;
>> +	iwmr->page_cnt = ib_umem_num_dma_blocks(iwmr->region,
>> +iwmr->page_size);
>> +
>> +	switch (req.reg_type) {
>> +	case IRDMA_MEMREG_TYPE_QP:
>> +		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
>> +		if (total > iwmr->page_cnt) {
>> +			err = -EINVAL;
>> +			goto error;
>> +		}
>> +		total = req.sq_pages + req.rq_pages;
>> +		use_pbles = (total > 2);
>> +		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +		if (err)
>> +			goto error;
>> +
>> +		ucontext = rdma_udata_to_drv_context(udata, struct
>> irdma_ucontext,
>> +						     ibucontext);
>> +		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
>> +		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
>> +		iwpbl->on_list = true;
>> +		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>> +		break;
>> +	case IRDMA_MEMREG_TYPE_CQ:
>> +		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
>> IRDMA_FEATURE_CQ_RESIZE)
>> +			shadow_pgcnt = 0;
>> +		total = req.cq_pages + shadow_pgcnt;
>> +		if (total > iwmr->page_cnt) {
>> +			err = -EINVAL;
>> +			goto error;
>> +		}
>> +
>> +		use_pbles = (req.cq_pages > 1);
>> +		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>> +		if (err)
>> +			goto error;
>> +
>> +		ucontext = rdma_udata_to_drv_context(udata, struct
>> irdma_ucontext,
>> +						     ibucontext);
>> +		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
>> +		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
>> +		iwpbl->on_list = true;
>> +		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>> +		break;
> I don't think we want to do this for user QP, CQ pinned memory. In fact, it will just be dead-code.
>
> The irdma provider implementation of the ibv_reg_dmabuf_mr will just default to IRDMA_MEMREG_TYPE_MEM type similar to how irdma_ureg_mr is implemented.
>
> https://github.com/linux-rdma/rdma-core/blob/master/providers/irdma/uverbs.c#L128
>
> It should simplify this function a lot.
>
>
>> +	case IRDMA_MEMREG_TYPE_MEM:
>> +		use_pbles = (iwmr->page_cnt != 1);
>> +
>> +		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
>> +		if (err)
>> +			goto error;
>> +
>> +		if (use_pbles) {
>> +			err = irdma_check_mr_contiguous(palloc,
>> +							iwmr->page_size);
>> +			if (err) {
>> +				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
>> +				iwpbl->pbl_allocated = false;
>> +			}
>> +		}
>> +
>> +		stag = irdma_create_stag(iwdev);
>> +		if (!stag) {
>> +			err = -ENOMEM;
>> +			goto error;
>> +		}
>> +
>> +		iwmr->stag = stag;
>> +		iwmr->ibmr.rkey = stag;
>> +		iwmr->ibmr.lkey = stag;
>> +		err = irdma_hwreg_mr(iwdev, iwmr, access);
>> +		if (err) {
>> +			irdma_free_stag(iwdev, stag);
>> +			goto error;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		goto error;
>> +	}
>> +
>> +	iwmr->type = req.reg_type;
>> +
>> +	return &iwmr->ibmr;
>> +
>> +error:
>> +	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
>> +		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
>> +	ib_umem_release(iwmr->region);
>> +	kfree(iwmr);
> Ideally we want unwind in the reverse order of allocation.
>
>> +
>> +	return ERR_PTR(err);
>> +}
>> +
>>   /**
>>    * irdma_reg_phys_mr - register kernel physical memory
>>    * @pd: ibpd pointer
>> @@ -4418,6 +4575,7 @@ static const struct ib_device_ops irdma_dev_ops = {
>>   	.query_port = irdma_query_port,
>>   	.query_qp = irdma_query_qp,
>>   	.reg_user_mr = irdma_reg_user_mr,
>> +	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
>>   	.req_notify_cq = irdma_req_notify_cq,
>>   	.resize_cq = irdma_resize_cq,
>>   	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
>> --
>> 2.27.0
