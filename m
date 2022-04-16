Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E425035D3
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Apr 2022 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiDPKGK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Apr 2022 06:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDPKGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Apr 2022 06:06:09 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380FEDF1F
        for <linux-rdma@vger.kernel.org>; Sat, 16 Apr 2022 03:03:36 -0700 (PDT)
Message-ID: <77223356-6762-aa69-1cb3-480b41b45d97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650103414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2XRyNkhWkPWTwYz4lP2bkcaNhuuohtxAKjcI6s44Jk=;
        b=IMDrV+o8AXYNGJ8imDfYQJqnF+5ZJFrXQzbw+RovKMOClNUSmEZszZXS9KHVqJyehVDam0
        3fT/udTXPHXBwUCjLts0A7q8EH8sX8K0lEKREH6Vevdg3PoaPTEahPq9sNhY0MW2GqGNQj
        AwJflfzchiFvx9roXISbMEsNr/kYMbw=
Date:   Sat, 16 Apr 2022 18:03:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] Subject: [PATCH for-next] RDMA/rxe: Fix "Soft RoCE
 Driver"
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220416063312.7777-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220416063312.7777-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/4/16 14:33, Bob Pearson 写道:
> The rping benchmark fails on long runs. The root cause of this
> failure has been traced to a failure to compute a nonzero value of mr
> in rare situations.
> 
> Fix this failure by correctly handling the computation of mr in
> read_reply() in rxe_resp.c in the replay flow.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")

Fixes should be 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder 
resources")


> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index e2653a8721fe..2e627685e804 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -734,8 +734,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	}
>   
>   	if (res->state == rdatm_res_state_new) {
> -		mr = qp->resp.mr;
> -		qp->resp.mr = NULL;
> +		if (!res->replay) {
> +			mr = qp->resp.mr;
> +			qp->resp.mr = NULL;
> +		} else {
> +			mr = rxe_recheck_mr(qp, res->read.rkey);
> +			if (!mr)
> +				return RESPST_ERR_RKEY_VIOLATION;
> +		}
>   
>   		if (res->read.resid <= mtu)
>   			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;
> 
> base-commit: 98c8026331ceabe1df579940b81eec75eb49cdd9

