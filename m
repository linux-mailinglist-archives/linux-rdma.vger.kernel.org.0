Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942525822E6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiG0JQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiG0JQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 05:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15F1EC47
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 02:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E820C6176C
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D72C433B5;
        Wed, 27 Jul 2022 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658913407;
        bh=HI5hBHJh5Ce/IKehOqc9qcrS/SNZQ9sLD5Oh0ZVRhvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDtXG/3AhpKFEfsZ54FGNc4eJAllTYblfnkRq4QRvdBlgPl+JJgXoRUb6X9pKZh/i
         BdymJEaSncQGYqtTf9Su8DPG3s14oe9YCZsz10C+1hhgJyEGBxZnc1LXGrN9bLtoZq
         +lrDhBTuh2FnwYtfX0drO7a5EFk5wA0VkUEFGD6W3vtUqYg/CUXSCzTaBSnaokspde
         V2PeIUxmQO9URaF0ufOvBeCUB/Plg8ALj1JhD2fRP3O1TJiaxstBw3fchMHfTzawEC
         AE8xmi2ACeh5ctqQ7mlDNNNPP/jj5fTMOMjt2HbZHU0NEHyX8LDmN8a/Jx4ZajcBpW
         /5BPDQT0yYGGA==
Date:   Wed, 27 Jul 2022 12:16:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix qp error handler
Message-ID: <YuECen5fE+T8M1hj@unreal>
References: <20220726045631.183632-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726045631.183632-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 26, 2022 at 12:56:31AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> About 7 spin locks in qp creation needs to be initialized. Now these
> spin locks are initialized in the function rxe_qp_init_misc. This
> will avoid the error "initialize spin locks before use".
> 
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V2->V3: Keep the spin_lock_init in rxe_init_task for future use.
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Fixes line?

> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 22e9b85344c3..ae8c51ef2db6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -174,6 +174,14 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  	spin_lock_init(&qp->state_lock);
>  
> +	spin_lock_init(&qp->req.task.state_lock);
> +	spin_lock_init(&qp->resp.task.state_lock);
> +	spin_lock_init(&qp->comp.task.state_lock);
> +
> +	spin_lock_init(&qp->sq.sq_lock);
> +	spin_lock_init(&qp->rq.producer_lock);
> +	spin_lock_init(&qp->rq.consumer_lock);
> +
>  	atomic_set(&qp->ssn, 0);
>  	atomic_set(&qp->skb_out, 0);
>  }
> @@ -233,7 +241,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  	qp->req.opcode		= -1;
>  	qp->comp.opcode		= -1;
>  
> -	spin_lock_init(&qp->sq.sq_lock);
>  	skb_queue_head_init(&qp->req_pkts);
>  
>  	rxe_init_task(rxe, &qp->req.task, qp,
> @@ -284,9 +291,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>  		}
>  	}
>  
> -	spin_lock_init(&qp->rq.producer_lock);
> -	spin_lock_init(&qp->rq.consumer_lock);
> -
>  	skb_queue_head_init(&qp->resp_pkts);
>  
>  	rxe_init_task(rxe, &qp->resp.task, qp,
> -- 
> 2.34.1
> 
