Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB569A361
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 02:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBQB1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 20:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQB1l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 20:27:41 -0500
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58554D3E
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 17:27:40 -0800 (PST)
Message-ID: <c8d1b8a3-3e19-f4dc-fd41-249aa447a9b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676597258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOvNDS8cDPRnvxIdB6ORFF1acHHe7qMsT7MVgHy18fc=;
        b=KLysyUaE9YPNC+6kMsUTnd58zW0AQIcTGELyzXH0uP9fvyKjXYQDz/fCti80dHDyiVrgNL
        o+dDRiSb8c0ipc73xxxVy/6VdcoLsGC8wUOGO+h6hH2A5voPcmZVNISvXWCPM+UZsgEa17
        U2XyjnINsan76tjEa/DNvdza5sKFPPA=
Date:   Fri, 17 Feb 2023 09:27:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230201032115.631656-1-yanjun.zhu@intel.com>
 <MWHPR11MB0029CFC36AECD29382B4ABC5E9A39@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB0029CFC36AECD29382B4ABC5E9A39@MWHPR11MB0029.namprd11.prod.outlook.com>
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


在 2023/2/15 21:38, Saleem, Shiraz 写道:
>> Subject: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
>> memory regions
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
>> ---
>> V2->V3: Remove unnecessary variable initialization;
>>          Use error handler;
>> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>>          This commit is based on the shared functions from refactored
>>          irdma_reg_user_mr.
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 6982f38596c8..7525f4cdf6fb 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd
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
>> +	struct ib_umem_dmabuf *umem_dmabuf;
>> +	struct irdma_mr *iwmr;
>> +	int err;
>> +
>> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
>> +		return ERR_PTR(-EINVAL);
> Do we need this? we don't copy anything from udata. There is no info passed via ABI struct irdma_mem_reg_req.


Got it. I will remove the inlen test and send a new commit out.


>
>> +
>> +	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
>> access);
>> +	if (IS_ERR(umem_dmabuf)) {
>> +		err = PTR_ERR(umem_dmabuf);
>> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n",
>> err);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt,
>> IRDMA_MEMREG_TYPE_MEM);
>> +	if (IS_ERR(iwmr)) {
>> +		err = PTR_ERR(iwmr);
>> +		goto err_release;
>> +	}
>> +
>> +	err = irdma_reg_user_mr_type_mem(iwmr, access);
>> +	if (err)
>> +		goto err_iwmr;
>> +
>> +	return &iwmr->ibmr;
>> +
>> +err_iwmr:
>> +	irdma_free_iwmr(iwmr);
>> +
>> +err_release:
>> +	ib_umem_release(&umem_dmabuf->umem);
>> +
>> +	return ERR_PTR(err);
>> +}
>> +
>>   /**
>>    * irdma_reg_phys_mr - register kernel physical memory
>>    * @pd: ibpd pointer
>> @@ -4483,6 +4527,7 @@ static const struct ib_device_ops irdma_dev_ops = {
>>   	.query_port = irdma_query_port,
>>   	.query_qp = irdma_query_qp,
>>   	.reg_user_mr = irdma_reg_user_mr,
>> +	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
>>   	.req_notify_cq = irdma_req_notify_cq,
>>   	.resize_cq = irdma_resize_cq,
>>   	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
>> --
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

Thanks.

Zhu Yanjun

>
