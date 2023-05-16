Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705B704343
	for <lists+linux-rdma@lfdr.de>; Tue, 16 May 2023 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEPCKt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 22:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEPCKt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 22:10:49 -0400
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234753596
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 19:10:48 -0700 (PDT)
Message-ID: <b2d643f7-210f-dad8-ae4b-486b46f20a1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684203046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcBsn2F/7amQcKp6dUVvEZtnjYABV/LZb2RKuynLCGc=;
        b=RF/2XE1VPv0YLM4HS1yba+UuPcyaaU8zxdIA9j3HCteLtCx/iO5YreIIxBgOXB+5hp7gjQ
        TeXRc8DmstnqEKpdU4RYzRpD+mb4lKYKhwC9qq000YpzN4DWIrGN8LoXoP+mFWUcfl0iRK
        Bl9bd9zF9UZN3T2J46mOajS1EmVFEDE=
Date:   Tue, 16 May 2023 10:10:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix double free in rxe_qp.c
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, dan.carpenter@linaro.org,
        leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

On 5/16/23 04:10, Bob Pearson wrote:
> A recent patch can cause a double spin_unlock_bh() in rxe_qp_to_attr()
> at line 715 in rxe_qp.c. This patch corrects that behavior.
>
> A newer patch from Guoqing Jiang recommends replacing all spin_lock
> calls for qp->state_lock to spin_(un)lock_irqsave(restore)() since
> apparently the blktests test suite can call the kernel verbs APIs
> while in hard interrupt state. This patch needs to be applied first
> and Guoqing's patch modified to accommodate this small change.

If you don't mind, I will send a patch set with your patch as first one, 
then
refresh mine. Which means we don't need to keep the second paragraph
in commit message, what do you think?

> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-rdma/27773078-40ce-414f-8b97-781954da9f25@kili.mountain/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index c5451a4488ca..245dd36638c7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -712,8 +712,9 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
>   	if (qp->attr.sq_draining) {
>   		spin_unlock_bh(&qp->state_lock);
>   		cond_resched();
> +	} else {
> +		spin_unlock_bh(&qp->state_lock);
>   	}
> -	spin_unlock_bh(&qp->state_lock);
>   
>   	return 0;
>   }

Looks good, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
