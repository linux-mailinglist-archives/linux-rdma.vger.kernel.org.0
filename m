Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F6625140
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 04:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKKDET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 22:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKKDES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 22:04:18 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BF48777
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 19:04:17 -0800 (PST)
Message-ID: <9f649db1-a0f9-dff4-ad0b-905a356c7459@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668135856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwJ/cTYDi561cPUFWYYpBd08v4gN4m4JSjFYg4ZIe/k=;
        b=PDWLzVOwsZQEH0/mMbZIdi9j4Sr4/nA2FHO8w541tzspCWJfYwF4M9rNdd/gt0wEDRcQu2
        5XbOvAZ6M8mlQ5GRYbmlIqTuZnh1zR+e1erZ3MNmpnkgyT8VZbNpHPm4lX3tX1fr8pocwi
        Ly2n2iiaOyoDVDRmdNfM4OvBczOdnB4=
Date:   Fri, 11 Nov 2022 11:04:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 03/13] RDMA/rxe: Simplify reset state handling
 in rxe_resp.c
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Ian Ziemba <ian.ziemba@hpe.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
 <20221029031009.64467-4-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20221029031009.64467-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/10/29 11:10, Bob Pearson 写道:
> Make rxe_responder() more like rxe_completer() and take qp reset
> handling out of the state machine.

 From RDMA spec, qp reset is part of qp states. If qp reset is moved out 
of the state machine. And other devices still take qp reset in the state 
machine. Will this make difference on the connection between rxe and 
other ib devices, such as irdma, mlx devices.

You know, rxe should make basic connections with other ib devices.

Zhu Yanjun

> 
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c32bc12cc82f..c4f365449aa5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -40,7 +40,6 @@ enum resp_states {
>   	RESPST_ERR_LENGTH,
>   	RESPST_ERR_CQ_OVERFLOW,
>   	RESPST_ERROR,
> -	RESPST_RESET,
>   	RESPST_DONE,
>   	RESPST_EXIT,
>   };
> @@ -75,7 +74,6 @@ static char *resp_state_name[] = {
>   	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
>   	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
>   	[RESPST_ERROR]				= "ERROR",
> -	[RESPST_RESET]				= "RESET",
>   	[RESPST_DONE]				= "DONE",
>   	[RESPST_EXIT]				= "EXIT",
>   };
> @@ -1281,8 +1279,9 @@ int rxe_responder(void *arg)
>   
>   	switch (qp->resp.state) {
>   	case QP_STATE_RESET:
> -		state = RESPST_RESET;
> -		break;
> +		rxe_drain_req_pkts(qp, false);
> +		qp->resp.wqe = NULL;
> +		goto exit;
>   
>   	default:
>   		state = RESPST_GET_REQ;
> @@ -1441,11 +1440,6 @@ int rxe_responder(void *arg)
>   
>   			goto exit;
>   
> -		case RESPST_RESET:
> -			rxe_drain_req_pkts(qp, false);
> -			qp->resp.wqe = NULL;
> -			goto exit;
> -
>   		case RESPST_ERROR:
>   			qp->resp.goto_error = 0;
>   			pr_debug("qp#%d moved to error state\n", qp_num(qp));

