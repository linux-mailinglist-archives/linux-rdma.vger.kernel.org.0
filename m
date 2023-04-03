Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA686D500B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDCSKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjDCSKc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 14:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631552134
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 11:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F277E623C6
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 18:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9002C433EF;
        Mon,  3 Apr 2023 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545430;
        bh=sZebXdJwumK+L+/UccqJgOCWXp6hgzHYl7Y6rgC2vBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxCpev6GaJmiM3D/CihsUg5C7BTokUk9w/8cfdfCwb5MmFkDJyBkF65XCF/pYUPqm
         OUFtnKTqpGOrth/SFmX/zWyZanyt4EYTmj8ffVV+1S41c0FmvoDf8J7IKn7sJmodiW
         LHJBDr+/jlQWkADA3h2EH+y8XxvZ4wAorDNkXqvYY5LrjMJPFNn2r50wGTQFMeUUEL
         CkyQiBE9MJ1BFLwx0J4fpaWcYnY8Xzp92jWZwgSplOCBdM5fAfj070no5pTEUXPQou
         BNdBARlwYqz1UIYjXM0k/3xojsBd84PvhM/v8d1zsHM4Ifhe5JlwZV8CT8QdfQwnQu
         5wH1zcWaZH96w==
Date:   Mon, 3 Apr 2023 21:10:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
Message-ID: <20230403181026.GB4514@unreal>
References: <095b1562-0c5e-4390-adf3-59ec0ed3e97e@linux.dev>
 <20230401024417.3334889-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401024417.3334889-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 01, 2023 at 10:44:17AM +0800, Zhu Yanjun wrote:
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
>  drivers/infiniband/sw/rxe/rxe_qp.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index ab72db68b58f..7856c02c1b46 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -176,6 +176,10 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>  	spin_lock_init(&qp->rq.producer_lock);
>  	spin_lock_init(&qp->rq.consumer_lock);
>  
> +	memset(&qp->req.task, 0, sizeof(struct rxe_task));
> +	memset(&qp->comp.task, 0, sizeof(struct rxe_task));
> +	memset(&qp->resp.task, 0, sizeof(struct rxe_task));

IMHO QP is already zeroed here.

Please don't send patches as reply-to.

Thanks

> +
>  	atomic_set(&qp->ssn, 0);
>  	atomic_set(&qp->skb_out, 0);
>  }
> @@ -773,15 +777,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  
>  	qp->valid = 0;
>  	qp->qp_timeout_jiffies = 0;
> -	rxe_cleanup_task(&qp->resp.task);
> +
> +	if (qp->resp.task.func)
> +		rxe_cleanup_task(&qp->resp.task);
>  
>  	if (qp_type(qp) == IB_QPT_RC) {
>  		del_timer_sync(&qp->retrans_timer);
>  		del_timer_sync(&qp->rnr_nak_timer);
>  	}
>  
> -	rxe_cleanup_task(&qp->req.task);
> -	rxe_cleanup_task(&qp->comp.task);
> +	if (qp->req.task.func)
> +		rxe_cleanup_task(&qp->req.task);
> +
> +	if (qp->comp.task.func)
> +		rxe_cleanup_task(&qp->comp.task);
>  
>  	/* flush out any receive wr's or pending requests */
>  	if (qp->req.task.func)
> -- 
> 2.27.0
> 
