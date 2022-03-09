Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9D4D302E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 14:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiCINol (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiCINoi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 08:44:38 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE104FBF0B;
        Wed,  9 Mar 2022 05:43:25 -0800 (PST)
Message-ID: <f6da67eb-4f18-d1f1-6ec4-c9f927723421@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646833403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKCg6b62OK3ru9vlrlF2vLy+aBAiaItrtd70F+lQgLk=;
        b=bVsgM0NL1XoiQOmfT4KlX6bZmwGkwqFGmNWnEUOM7cXbd6Z096ZZ6vDRe4HkTFgi07jFRw
        ilGjURBadyRrl/CIHnbtWVyt7lptwTBLXTJv3YksjC9750bbyuvof15nUe8LvlCeX0OExM
        CTEdK684fmNl7Dd4Ol+GFjiIdRWrZyc=
Date:   Wed, 9 Mar 2022 21:43:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: get rid of create_user_ah
To:     Yajun Deng <yajun.deng@linux.dev>, jgg@nvidia.com,
        selvin.xavier@broadcom.com, galpress@amazon.com, sleybo@amazon.com,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308144033.3406606-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220308144033.3406606-1-yajun.deng@linux.dev>
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

在 2022/3/8 22:40, Yajun Deng 写道:
> There is no create_user_ah in ib_device_ops, remove it.
In the file include/rdma/ib_verbs.h:

2305 struct ib_device_ops {
...
2431         int (*create_user_ah)(struct ib_ah *ah, struct 
rdma_ah_init_attr *attr,
2432                               struct ib_udata *udata);
...

create_user_ah exists.

Zhu Yanjun
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 80df9a8f71a1..fa0cf2554425 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1053,7 +1053,6 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	.create_cq = rxe_create_cq,
>   	.create_qp = rxe_create_qp,
>   	.create_srq = rxe_create_srq,
> -	.create_user_ah = rxe_create_ah,
>   	.dealloc_driver = rxe_dealloc,
>   	.dealloc_mw = rxe_dealloc_mw,
>   	.dealloc_pd = rxe_dealloc_pd,

