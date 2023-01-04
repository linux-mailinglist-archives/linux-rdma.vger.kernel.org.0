Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE265D388
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 13:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjADM6t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 07:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjADM6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 07:58:42 -0500
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C51005E
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 04:58:41 -0800 (PST)
Message-ID: <faa77d9a-33c3-f74c-dd85-128bdf86f215@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672837119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMoOOwUk6T9NFasphEpyoh5lgfld385u5kHXMA63S6s=;
        b=D800W/uUCD8Lwflqqp06ZqQlGPCdFz/YS16nxMDK9re5WQNUjpKV+0MHfOuGZnAINtfdwn
        W7Q1Q4CiSyV5tAIUY20pKFSZtCPJWJgYguUrUI/s1KbaoBQ3A8VspXFI2qA8630mbK0Xde
        hx+/VZkOfZZeAFqiogL3urognu0zB2U=
Date:   Wed, 4 Jan 2023 20:58:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230103013433.341997-1-yanjun.zhu@intel.com>
 <Y7S2DO0TFjxgDV6M@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y7S2DO0TFjxgDV6M@ziepe.ca>
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


在 2023/1/4 7:11, Jason Gunthorpe 写道:
> On Mon, Jan 02, 2023 at 08:34:33PM -0500, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
>> not support on-demand-paging(ODP). So it uses habanalabs as the
>> dmabuf exporter, and irdma as the importer to allow for peer2peer
>> access through libibverbs.
>>
>> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
>> This function is introduced in EFA dmabuf[1] which allows the driver
>> to get a dmabuf umem which is pinned and does not require move_notify
>> callback implementation. The returned umem is pinned and DMA mapped
>> like standard cpu umems, and is released through ib_umem_release().
>>
>> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index f6973ea55eda..76dc6e65930a 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>> +				       u64 len, u64 virt,
>> +				       int fd, int access,
>> +				       struct ib_udata *udata)
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
>> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
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
>> +							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
>> +							 virt);
> You can't call rdma_umem_for_each_dma_block() without also calling
> this function to validate that the page_size passed to
> rdma_umem_for_each_dma_block() is correct.
Got it. I will fix it in the latest commit.
>
> This seems to be an existing bug, please fix it.
>
> Also, is there a reason this code is all duplicated from
> irdma_reg_user_mr? Please split things up like the other drivers to
> obtain the umem then use shared code to process the umem as required.

Got it.

Zhu Yanjun

>
> Jason
