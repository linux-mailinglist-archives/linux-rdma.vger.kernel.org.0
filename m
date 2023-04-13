Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1046E0B3D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDMKQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDMKQF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 06:16:05 -0400
X-Greylist: delayed 10670 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 03:15:59 PDT
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA2430FB
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 03:15:59 -0700 (PDT)
Message-ID: <047e3406-0676-76e4-9bbc-dd164532f053@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681380957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clE+wO4Y57r8qAM1kJgB2kqFzNXCb8FfDTPvPBgHywU=;
        b=pJgcZlbOSjeBpLLrqCmLAkOqTGOGi/Y4wLgw/Ofhz3ZkCezTl9fV0RQEz2XZAv9qq/dhuC
        GAzvU1qE1OU70oSSlXTLLNi2eg2DlW5dHEDpSWvde5kQoS6sAdtvoz8a3mKjCmaCVtTpnp
        MRxghQG/DAoimp7GNev/eDIHAksDy2g=
Date:   Thu, 13 Apr 2023 18:15:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/rxe: Fix the error "trying to
 register non-static key in rxe_cleanup_task"
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
References: <20230413095616.1365762-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230413095616.1365762-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/13 17:56, Zhu Yanjun 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> In the function rxe_create_qp(), rxe_qp_from_init() is called to
> initialize qp, internally things like rxe_init_task are not setup until
> rxe_qp_init_req().
>
> If an error occures before this point then the unwind will call
> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> which will oops when trying to access the uninitialized spinlock.
>
> If rxe_init_task is not executed, rxe_cleanup_task will not be called.
>
> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@intel.com>

Sorry. The signature is wrong. Please ignore this mail. The latest 
commit is sent out.

Zhu Yanjun

> ---
> V2 -> V3: Rebase to rdma-next;
> V1 -> V2: Remove memset functions;
> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 49891f8ed4e6..d5de5ba6940f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -761,9 +761,14 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>   		del_timer_sync(&qp->rnr_nak_timer);
>   	}
>   
> -	rxe_cleanup_task(&qp->resp.task);
> -	rxe_cleanup_task(&qp->req.task);
> -	rxe_cleanup_task(&qp->comp.task);
> +	if (qp->resp.task.func)
> +		rxe_cleanup_task(&qp->resp.task);
> +
> +	if (qp->req.task.func)
> +		rxe_cleanup_task(&qp->req.task);
> +
> +	if (qp->comp.task.func)
> +		rxe_cleanup_task(&qp->comp.task);
>   
>   	/* flush out any receive wr's or pending requests */
>   	rxe_requester(qp);
