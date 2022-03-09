Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC94D304F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiCINtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCINtT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 08:49:19 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672B149B91;
        Wed,  9 Mar 2022 05:48:19 -0800 (PST)
Message-ID: <daee0acc-709d-9523-6ca7-a6777430df7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646833696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qja1Ifb4XBFrqw5oPZs2VLQpDyt9RmXoFdLqOe6YM4c=;
        b=pIicI7HSATnbIQ2yU3vbIr6vepUDbWbbTKT/IZIrQjyCaHCDj5RAMwboQmhFlEYe+TpVa6
        24MUjYN/pSpGz82CRg9Q+iGlPW48plXuMcY0Vjgza1cDKDVOna28kn3pJ/Qhh4FHQ/7kMr
        4bweKYxPIemLV29IcuCt6ND3IUSSgc4=
Date:   Wed, 9 Mar 2022 21:48:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: get rid of create_user_ah
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
To:     Yajun Deng <yajun.deng@linux.dev>, jgg@nvidia.com,
        selvin.xavier@broadcom.com, galpress@amazon.com, sleybo@amazon.com,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308144033.3406606-1-yajun.deng@linux.dev>
 <f6da67eb-4f18-d1f1-6ec4-c9f927723421@linux.dev>
In-Reply-To: <f6da67eb-4f18-d1f1-6ec4-c9f927723421@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



在 2022/3/9 21:43, Yanjun Zhu 写道:
> 在 2022/3/8 22:40, Yajun Deng 写道:
>> There is no create_user_ah in ib_device_ops, remove it.
> In the file include/rdma/ib_verbs.h:
> 
> 2305 struct ib_device_ops {
> ...
> 2431         int (*create_user_ah)(struct ib_ah *ah, struct 
> rdma_ah_init_attr *attr,
> 2432                               struct ib_udata *udata);
> ...
> 
> create_user_ah exists.

I found your patch to remove create_user_ah.
IMO, you should merge the 2 patches as one.

Or after the patch to remove create_user_ah is merged in mainline,
then this patch can be sent out.

As such this will not misguide us.

Zhu Yanjun

> 
> Zhu Yanjun
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 80df9a8f71a1..fa0cf2554425 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -1053,7 +1053,6 @@ static const struct ib_device_ops rxe_dev_ops = {
>>       .create_cq = rxe_create_cq,
>>       .create_qp = rxe_create_qp,
>>       .create_srq = rxe_create_srq,
>> -    .create_user_ah = rxe_create_ah,
>>       .dealloc_driver = rxe_dealloc,
>>       .dealloc_mw = rxe_dealloc_mw,
>>       .dealloc_pd = rxe_dealloc_pd,
> 
