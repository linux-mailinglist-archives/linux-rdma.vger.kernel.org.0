Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934A4B75BA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiBOSv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:51:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiBOSv6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:51:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA104403E9
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49F5561731
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 18:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0EEC340EB;
        Tue, 15 Feb 2022 18:51:41 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:51:38 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/3] ib_srp: Fix a deadlock
Message-ID: <Ygv2OkMeJYrTwdbi@unreal>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215182650.19839-4-bvanassche@acm.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 10:26:50AM -0800, Bart Van Assche wrote:
> Wait on tl_err_work instead of flushing system_long_wq since flushing
> system_long_wq is deadlock-prone.
> 
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Fixes: ef6c49d87c34 ("IB/srp: Eliminate state SRP_TARGET_DEAD")
> Reported-by: syzbot+831661966588c802aae9@syzkaller.appspotmail.com
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 2db7429b42e1..8e1561a6d325 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -4044,12 +4044,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
>  		mutex_lock(&host->target_mutex);
>  		list_for_each_entry(target, &host->target_list, list)
>  			srp_queue_remove_work(target);
> +		list_for_each_entry(target, &host->target_list, list)
> +			flush_work(&target->tl_err_work);

Sorry for my silly question, but why do you do flush and not cancel
here? You anyway remove SRP device, so the result of flush is not
really important, am I right?

Thanks

>  		mutex_unlock(&host->target_mutex);
>  
> -		/*
> -		 * Wait for tl_err and target port removal tasks.
> -		 */
> -		flush_workqueue(system_long_wq);
>  		flush_workqueue(srp_remove_wq);
>  
>  		kfree(host);
