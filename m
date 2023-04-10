Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731726DC832
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDJPIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 11:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 11:08:37 -0400
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BC35B7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 08:08:36 -0700 (PDT)
Message-ID: <29d0ab8c-1ea4-bbce-120b-82c390b56a6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681139312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCYtir/eUxeNDVBikyg7EtEPUbKWFv3KXAg6PtqWN4k=;
        b=lyRuveH4t/jZDotQpHRuWWnxZc5zcPIaNU/xxXihsPJlkPYBgM3aSbY0dvjj9lMswt8VP1
        O4/uTbaGdvIrwjilrAS5fC9AJoxV4r+cNTCjTUW9u84nmIKFvjY23s+/pfaWv3lTNR9fLT
        HeudEBoFsYQKWLaGEiVAgFsgtcsqOlo=
Date:   Mon, 10 Apr 2023 23:08:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
References: <20230404063848.3844292-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230404063848.3844292-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/4/4 14:38, Zhu Yanjun 写道:
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
> ---
> V1 -> V2: Remove memset functions;

Gently ping

Zhu Yanjun
> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index ab72db68b58f..a1746c4f5448 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -773,15 +773,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>   
>   	qp->valid = 0;
>   	qp->qp_timeout_jiffies = 0;
> -	rxe_cleanup_task(&qp->resp.task);
> +
> +	if (qp->resp.task.func)
> +		rxe_cleanup_task(&qp->resp.task);
>   
>   	if (qp_type(qp) == IB_QPT_RC) {
>   		del_timer_sync(&qp->retrans_timer);
>   		del_timer_sync(&qp->rnr_nak_timer);
>   	}
>   
> -	rxe_cleanup_task(&qp->req.task);
> -	rxe_cleanup_task(&qp->comp.task);
> +	if (qp->req.task.func)
> +		rxe_cleanup_task(&qp->req.task);
> +
> +	if (qp->comp.task.func)
> +		rxe_cleanup_task(&qp->comp.task);
>   
>   	/* flush out any receive wr's or pending requests */
>   	if (qp->req.task.func)

