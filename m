Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D765D3FC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 14:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjADNSl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 08:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbjADNSh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 08:18:37 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A52103A
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 05:18:35 -0800 (PST)
Message-ID: <ea2a9e6c-e046-fbde-d834-1417f1113403@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672838314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1X8GX0oUJh5hEb1UbpX6Zxz8T3kzEbjhfcgMUAO3oc=;
        b=BUdb2D77b+AizUgP3uXApcNfLtOj4arhwQh3FE24ZkKgb2Qiq2hAHghHl0dVRKNm95+J4Z
        sdpuzqMxlXSfHICziSPQAikFWxElz5lZAIV1c9Gvs6E/P/WRq+k6lm91B9emqLeQnF+H5e
        INbsl7sD+EGowNoVhu8D0znozGdw3ok=
Date:   Wed, 4 Jan 2023 21:18:27 +0800
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
 <MWHPR11MB0029214136E67C609CA87C61E9F59@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <MWHPR11MB0029214136E67C609CA87C61E9F59@MWHPR11MB0029.namprd11.prod.outlook.com>
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


在 2023/1/4 8:21, Saleem, Shiraz 写道:
>> Subject: RE: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
>> regions
>>
> [......]
>
>>> +
>>> +	switch (req.reg_type) {
>>> +	case IRDMA_MEMREG_TYPE_QP:
>>> +		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
>>> +		if (total > iwmr->page_cnt) {
>>> +			err = -EINVAL;
>>> +			goto error;
>>> +		}
>>> +		total = req.sq_pages + req.rq_pages;
>>> +		use_pbles = (total > 2);
>>> +		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>>> +		if (err)
>>> +			goto error;
>>> +
>>> +		ucontext = rdma_udata_to_drv_context(udata, struct
>>> irdma_ucontext,
>>> +						     ibucontext);
>>> +		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
>>> +		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
>>> +		iwpbl->on_list = true;
>>> +		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>>> +		break;
>>> +	case IRDMA_MEMREG_TYPE_CQ:
>>> +		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
>>> IRDMA_FEATURE_CQ_RESIZE)
>>> +			shadow_pgcnt = 0;
>>> +		total = req.cq_pages + shadow_pgcnt;
>>> +		if (total > iwmr->page_cnt) {
>>> +			err = -EINVAL;
>>> +			goto error;
>>> +		}
>>> +
>>> +		use_pbles = (req.cq_pages > 1);
>>> +		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
>>> +		if (err)
>>> +			goto error;
>>> +
>>> +		ucontext = rdma_udata_to_drv_context(udata, struct
>>> irdma_ucontext,
>>> +						     ibucontext);
>>> +		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
>>> +		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
>>> +		iwpbl->on_list = true;
>>> +		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>>> +		break;
>> I don't think we want to do this for user QP, CQ pinned memory. In fact, it will just
>> be dead-code.
>>
>> The irdma provider implementation of the ibv_reg_dmabuf_mr will just default to
>> IRDMA_MEMREG_TYPE_MEM type similar to how irdma_ureg_mr is implemented.
>>
>> https://github.com/linux-rdma/rdma-
>> core/blob/master/providers/irdma/uverbs.c#L128
>>
>> It should simplify this function a lot.
>>
>>
> Actually I don't see a need even to use the irdma_mem_reg_req ABI struct to pass any info from user-space like reg_type.

In the latest commit, the irdma_mem_reg_req ABI struct is removed.

I will send out it very soon.

Zhu Yanjun

>
> Shiraz
>
