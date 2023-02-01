Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D5685DB3
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 04:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBADIK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 22:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBADIJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 22:08:09 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 19:08:06 PST
Received: from out-102.mta1.migadu.com (out-102.mta1.migadu.com [IPv6:2001:41d0:203:375::66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA8EB4C
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 19:08:06 -0800 (PST)
Message-ID: <012f7ed2-bd63-5a4e-a880-59ed69cd42eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675220505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTEZD0zcZI1WKGCpB3U/25JGxPLAtKNltFBXblornJ4=;
        b=TasQolD4LTLIQ4DjflQBJ4GT25ZB3TlL/MPtD97k3NcdeoZxMVeSMqSqlUN3YWfsXt+I/2
        xNO0nFrzGANF6GSEEGws3bSSi285LB7jQvHwW77NW1eGRw7lZxPfLTdSJni1nHh+LQ1eCS
        xVkrhEJ0XPyYwPkhZDjNBiwH2EP5n/4=
Date:   Wed, 1 Feb 2023 11:01:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230130032407.259855-1-yanjun.zhu@intel.com>
 <Y9koxP+oWLzhlvZE@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Y9koxP+oWLzhlvZE@nvidia.com>
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


在 2023/1/31 22:42, Jason Gunthorpe 写道:
> On Mon, Jan 30, 2023 at 11:24:07AM +0800, Zhu Yanjun wrote:
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
>> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>>          This commit is based on the shared functions from refactored
>>          irdma_reg_user_mr.
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 43 +++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 6982f38596c8..a638861689c2 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2977,6 +2977,48 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>> +					      u64 len, u64 virt,
>> +					      int fd, int access,
>> +					      struct ib_udata *udata)
>> +{
>> +	struct irdma_device *iwdev = to_iwdev(pd->device);
>> +	struct ib_umem_dmabuf *umem_dmabuf = NULL;
>> +	struct irdma_mr *iwmr = NULL;
> No reason to null initialize these


Got it.


>
>> +	int err;
>> +
>> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
>> +	if (IS_ERR(umem_dmabuf)) {
>> +		err = PTR_ERR(umem_dmabuf);
>> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
>> +	if (IS_ERR(iwmr)) {
>> +		ib_umem_release(&umem_dmabuf->umem);
>> +		return (struct ib_mr *)iwmr;
> err = PTR_ERR(iwmr);
> goto err_release;


Got it.


>
>> +	}
>> +
>> +	err = irdma_reg_user_mr_type_mem(iwmr, access);
>> +	if (err)
>> +		goto error;
>> +
>> +	return &iwmr->ibmr;
>> +
>> +error:
> err_iwmr:
>> +	irdma_free_iwmr(iwmr);
> err_release:

Got it. I will send the latest commit very soon.

Zhu Yanjun

>
>> +	ib_umem_release(&umem_dmabuf->umem);
>> +
>> +	return ERR_PTR(err);
>> +}
> Jason
