Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA7660CA5
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Jan 2023 07:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAGGXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Jan 2023 01:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAGGXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Jan 2023 01:23:05 -0500
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285E965AC5
        for <linux-rdma@vger.kernel.org>; Fri,  6 Jan 2023 22:23:03 -0800 (PST)
Message-ID: <ceae0c44-ea19-8428-30cd-9853fd762620@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673072578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPst4/bxLLO1vKtABlQeEtKsxYQIs5e3qji6Sxj+Om4=;
        b=HmxubsTO8vKV2XcGdKfN4xdN5pDb8E4Me9Ghb4IxZzHmeKV5dNn2HGiM52uTGMEouRTIX/
        pMbkgt4/wnjc06pP4Xd46OYSxH7gVD/S5XNbT/Ea/IM9OOStyQR/shbAkWvWdQffRXXQDB
        5wA72KbqoiER0iw1Nd0lgBlesxETggI=
Date:   Sat, 7 Jan 2023 14:22:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230105223710.973148-1-yanjun.zhu@intel.com>
 <Y7bSnIT+vxjEX3w3@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y7bSnIT+vxjEX3w3@ziepe.ca>
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

在 2023/1/5 21:37, Jason Gunthorpe 写道:
> On Thu, Jan 05, 2023 at 05:37:10PM -0500, Zhu Yanjun wrote:
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
>> V2->V3: Simplify the function by removing QP and CQ handling;
>> V1->V2: Fix the build warning by adding a static;
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 97 +++++++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index f6973ea55eda..7028b8af87b9 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2912,6 +2912,102 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>> +					      u64 len, u64 virt,
>> +					      int fd, int access,
>> +					      struct ib_udata *udata)
>> +{
>> +	struct irdma_device *iwdev = to_iwdev(pd->device);
>> +	struct irdma_pble_alloc *palloc;
>> +	struct irdma_pbl *iwpbl;
>> +	struct irdma_mr *iwmr;
>> +	u32 stag = 0;
>> +	bool use_pbles = false;
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
>> +	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
>> +	if (!iwmr) {
>> +		ib_umem_release(&umem_dmabuf->umem);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
> 
> again, please don't duplicate all this code, refactor the mr code so
> it can be shared.
Got it. I will refactor the mr code and split the shared code into 
several helper functions. After the commits are merged, I will continue 
to add the support of dmabuf with the helper functions.

Zhu Yanjun
> 
> Jason

