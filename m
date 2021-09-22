Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDECB414330
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 10:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhIVIEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 04:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhIVIDi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 04:03:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8042060F26;
        Wed, 22 Sep 2021 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632297703;
        bh=gaCKw2tUuCnbK4Tb26P0pB6gCaWe3hYKJ7mlLHQz/lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GspL3Revm/7EKvI02Neo8VmdVge5LYERgjpkIgpr98ENWtZRd9zM8sbECaxR45K5C
         /AmLlbP3/Pe3WgCLzzogHJ2PM9wYxgkzipakSMZs63UuSkv9HkexhtFxMM3Sz6IQtr
         YjT1DRArDSesOuzQPMIkqiLlpllriKywPyoXfk0K2ixS/qmZ364B8wKPrqraxOB9CU
         cX+33DEkhZQKI2ZPRLBEwaaQmPmByF6m3BdPRypaoMdnAa39MaadtXdg90XwrnCcQ2
         Jjlv0Pj/QYEoEHklb9PoeI3m8Z/sMlMQUxKVSBHzfperAZv5hf1ptC8RPFn0AIH0Vy
         A+9UGpUB79/eA==
Date:   Wed, 22 Sep 2021 11:01:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <YUri44sX8Lp3muc4@unreal>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 03:34:46PM -0300, Jason Gunthorpe wrote:
> The FSM can run in a circle allowing rdma_resolve_ip() to be called twice
> on the same id_priv. While this cannot happen without going through the
> work, it violates the invariant that the same address resolution
> background request cannot be active twice.
> 
>        CPU 1                                  CPU 2
> 
> rdma_resolve_addr():
>   RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
>   rdma_resolve_ip(addr_handler)  #1
> 
> 			 process_one_req(): for #1
>                           addr_handler():
>                             RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
>                             mutex_unlock(&id_priv->handler_mutex);
>                             [.. handler still running ..]
> 
> rdma_resolve_addr():
>   RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
>   rdma_resolve_ip(addr_handler)
>     !! two requests are now on the req_list
> 
> rdma_destroy_id():
>  destroy_id_handler_unlock():
>   _destroy_id():
>    cma_cancel_operation():
>     rdma_addr_cancel()
> 
>                           // process_one_req() self removes it
> 		          spin_lock_bh(&lock);
>                            cancel_delayed_work(&req->work);
> 	                   if (!list_empty(&req->list)) == true
> 
>       ! rdma_addr_cancel() returns after process_on_req #1 is done
> 
>    kfree(id_priv)
> 
> 			 process_one_req(): for #2
>                           addr_handler():
> 	                    mutex_lock(&id_priv->handler_mutex);
>                             !! Use after free on id_priv
> 
> rdma_addr_cancel() expects there to be one req on the list and only
> cancels the first one. The self-removal behavior of the work only happens
> after the handler has returned. This yields a situations where the
> req_list can have two reqs for the same "handle" but rdma_addr_cancel()
> only cancels the first one.
> 
> The second req remains active beyond rdma_destroy_id() and will
> use-after-free id_priv once it inevitably triggers.
> 
> Fix this by remembering if the id_priv has called rdma_resolve_ip() and
> always cancel before calling it again. This ensures the req_list never
> gets more than one item in it and doesn't cost anything in the normal flow
> that never uses this strange error path.
> 
> Cc: stable@vger.kernel.org
> Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
> Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c      | 17 +++++++++++++++++
>  drivers/infiniband/core/cma_priv.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c40791baced588..751cf5ea25f296 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1776,6 +1776,14 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
>  {
>  	switch (state) {
>  	case RDMA_CM_ADDR_QUERY:
> +		/*
> +		 * We can avoid doing the rdma_addr_cancel() based on state,
> +		 * only RDMA_CM_ADDR_QUERY has a work that could still execute.
> +		 * Notice that the addr_handler work could still be exiting
> +		 * outside this state, however due to the interaction with the
> +		 * handler_mutex the work is guaranteed not to touch id_priv
> +		 * during exit.
> +		 */
>  		rdma_addr_cancel(&id_priv->id.route.addr.dev_addr);
>  		break;
>  	case RDMA_CM_ROUTE_QUERY:
> @@ -3413,6 +3421,15 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
>  		if (dst_addr->sa_family == AF_IB) {
>  			ret = cma_resolve_ib_addr(id_priv);
>  		} else {
> +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> +			 * rdma_resolve_ip() is called, eg through the error
> +			 * path in addr_handler. If this happens the existing
> +			 * request must be canceled before issuing a new one.
> +			 */
> +			if (id_priv->used_resolve_ip)
> +				rdma_addr_cancel(&id->route.addr.dev_addr);
> +			else
> +				id_priv->used_resolve_ip = 1;

Why don't you never clear this field? If you assume that this is one lifetime
event, can you please add a comment with an explanation "why"?

Thanks

>  			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
>  					      &id->route.addr.dev_addr,
>  					      timeout_ms, addr_handler,
> diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
> index 5c463da9984536..f92f101ea9818f 100644
> --- a/drivers/infiniband/core/cma_priv.h
> +++ b/drivers/infiniband/core/cma_priv.h
> @@ -91,6 +91,7 @@ struct rdma_id_private {
>  	u8			afonly;
>  	u8			timeout;
>  	u8			min_rnr_timer;
> +	u8 used_resolve_ip;
>  	enum ib_gid_type	gid_type;
>  
>  	/*
> 
> base-commit: ad17bbef3dd573da937816edc0ab84fed6a17fa6
> -- 
> 2.33.0
> 
