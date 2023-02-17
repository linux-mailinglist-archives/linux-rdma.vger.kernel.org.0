Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432669A314
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 01:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBQArD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 19:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQArC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 19:47:02 -0500
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D3902F
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 16:47:00 -0800 (PST)
Message-ID: <073e4d3b-f451-27f9-716a-2cd2e51d8535@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676594818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RC557aVONVMdVK0QFB5eJuq97sjVB9j1idVVdauUZSw=;
        b=GSQiWRIwJgXKC+LmXJ832yTR7zgDiG3La5xEGZsDlK3SnrZKV5+CGqkovgVFQ8N6fGtPz+
        HgA8xRRQ9uXF2Wkem9fd+qWvB7+rwEpjQlNQPLaB4+yJ0y+t9De6Kt6yP+KoZQVTdBsx8g
        I0NrnGaWUeIkV0Ai879Fw+hB8LFQkyw=
Date:   Fri, 17 Feb 2023 08:46:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230201032115.631656-1-yanjun.zhu@intel.com>
 <Y+5FuSxVrtmCawC8@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Y+5FuSxVrtmCawC8@nvidia.com>
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


在 2023/2/16 23:03, Jason Gunthorpe 写道:
> On Wed, Feb 01, 2023 at 11:21:15AM +0800, Zhu Yanjun wrote:
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
>> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
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
>> @@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
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
> Shiraz is correct, I'm wondering how this even works. This is a new
> style uAPI without UVERBS_ATTR_UHW so inlen should always be 0.

Got it. Thanks Shiraz and Jason.

I will remove the test of inlen in the latest commit.

Best Regards,

Zhu Yanjun

>
> How did you manage to test this??
>
> Jason
