Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5744EDF88
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiCaRVY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCaRVX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 13:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066B105A94
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D2361713
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 17:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B51AC34110;
        Thu, 31 Mar 2022 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648747175;
        bh=O309GUZD8qQicgdOYAPE4lo2BXEBL92V96GQ/EshcdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhSs8AZEvZcPEfstF6NurDFWLmJLcZRVXe+3nhOpPxwAaYPjrrvCtukw+H4D5zhiO
         aC79yo2sz996IBhG2RTB4mlloOCSzJ1SiHARo6JPV74q0RdIkXfdjUQLDnMsYFn5P7
         +CCULKYY0WPYq9laavoiG19IEtLFxk75gdQtkjem4gR9YLrqzeqRPQOhnO8OdsOMIp
         SYROd7v6y70tS4MUSKHs9HRWv4V5PsrzaSi7CJGKLBbNSzn7uX4TwNBg6UfHcybYXo
         S7nsSkAp+4LK7fcMbufCSOvW6/a6qSyWfndT0E2lWLp8BShAXuYde5kWu5tYf8Zofn
         W7Qb2wE0rq+Sw==
Date:   Thu, 31 Mar 2022 20:19:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] RDMA/rxe: Generate a completion on error after
 getting a wqe
Message-ID: <YkXiough/A/aGi1M@unreal>
References: <20220331120245.314614-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331120245.314614-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 31, 2022 at 08:02:45PM +0800, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion on error after
> getting a wqe. Fix the issue by calling rxe_completer() on error.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..01ae400e5481 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -648,26 +648,24 @@ int rxe_requester(void *arg)
>  		psn_compare(qp->req.psn, (qp->comp.psn +
>  				RXE_MAX_UNACKED_PSNS)) > 0)) {
>  		qp->req.wait_psn = 1;
> -		goto exit;
> +		goto qp_op_err;
>  	}
>  
>  	/* Limit the number of inflight SKBs per QP */
>  	if (unlikely(atomic_read(&qp->skb_out) >
>  		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
>  		qp->need_req_skb = 1;
> -		goto exit;
> +		goto qp_op_err;
>  	}
>  
>  	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
> -	if (unlikely(opcode < 0)) {
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto exit;
> -	}
> +	if (unlikely(opcode < 0))
> +		goto qp_op_err;
>  
>  	mask = rxe_opcode[opcode].mask;
>  	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
>  		if (check_init_depth(qp, wqe))
> -			goto exit;
> +			goto qp_op_err;
>  	}
>  
>  	mtu = get_mtu(qp);
> @@ -706,26 +704,26 @@ int rxe_requester(void *arg)
>  	av = rxe_get_av(&pkt, &ah);
>  	if (unlikely(!av)) {
>  		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		goto err_drop_ah;
>  	}
>  
>  	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
>  	if (unlikely(!skb)) {
>  		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		goto err_drop_ah;
>  	}
>  
>  	ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
>  	if (unlikely(ret)) {
>  		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
> +		if (ah)

No, ah can't be NULL. This is why I proposed to clean rxe_get_av() too.
**ahp is not NULL, as an input to that function and in all flows it is
updated with new ah pointer. If it can't update, the NULL will be
returned and rxe_requester() will exit.

Thanks

> +			rxe_put(ah);
>  		if (ret == -EFAULT)
>  			wqe->status = IB_WC_LOC_PROT_ERR;
>  		else
>  			wqe->status = IB_WC_LOC_QP_OP_ERR;
>  		kfree_skb(skb);
> -		goto err_drop_ah;
> +		goto err;
>  	}
>  
>  	if (ah)
> @@ -751,8 +749,7 @@ int rxe_requester(void *arg)
>  			goto exit;
>  		}
>  
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto err;
> +		goto qp_op_err;
>  	}
>  
>  	update_state(qp, wqe, &pkt);
> @@ -762,6 +759,9 @@ int rxe_requester(void *arg)
>  err_drop_ah:
>  	if (ah)
>  		rxe_put(ah);
> +
> +qp_op_err:
> +	wqe->status = IB_WC_LOC_QP_OP_ERR;
>  err:
>  	wqe->state = wqe_state_error;
>  	__rxe_do_task(&qp->comp.task);
> -- 
> 2.25.4
> 
> 
> 
