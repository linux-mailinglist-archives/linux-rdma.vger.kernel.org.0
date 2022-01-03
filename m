Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFCA48306A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 12:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiACLUZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 06:20:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiACLUY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 06:20:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247156101F
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 11:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC094C36AEE;
        Mon,  3 Jan 2022 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641208823;
        bh=c2CG5wWvmwgpUuU1AqAy3Lt9vXTF86Meo1Sz9x1o9Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE3nCMm00TksQXibQTMy3oSPaUw9ApM/XoPP7rQ2NVZhYKjOuZnEzv6AIbrRuXvvK
         xGu4l8bFss0VI8/YV1V2PjLy0KpEz6ySrbTMN+RuxaWra5xRPV/TtWiYrGjyLpeziR
         ji6bBZBDA+nspitd8XOQ1QjNWA8fzzGYus6Z3x/70WIbH6e6ZMHj5BQJIX87J1+yde
         IsVFMp74+CCEby/WBhfBtGBUPDw20w55r00kuEvYABvNw1aJiSmTAM3ZvqUcCUU5YY
         HKN8uGZ7LmxJVnOCTUQ+r5zmLaT0bjKXFRvOoL80rU3iS3y0ogA89AkrvPguhNNjr5
         BLnTobZJK3JZQ==
Date:   Mon, 3 Jan 2022 13:20:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Use the standard method to produce udp
 source port
Message-ID: <YdLb8zHz2GdVu+5D@unreal>
References: <20211224172735.1450623-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224172735.1450623-1-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 24, 2021 at 12:27:35PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Use the standard method to produce udp source port based on the
> commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp source port
> when set path").
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 0aa0d7e52773..9a0748ad6417 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -451,6 +451,14 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>  	return err;
>  }
>  
> +static u16 rxe_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> +{
> +	if (!fl)
> +		fl = rdma_calc_flow_label(lqpn, rqpn);
> +
> +	return rdma_flow_label_to_udp_sport(fl);
> +}
> +

Now, we have three drivers with the same function.

>  static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  			 int mask, struct ib_udata *udata)
>  {
> @@ -469,6 +477,16 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  	if (err)
>  		goto err1;
>  
> +	if (mask & IB_QP_AV) {
> +		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> +			u32 fl = attr->ah_attr.grh.flow_label;
> +			u32 lqp = qp->ibqp.qp_num;
> +			u32 rqp = qp->attr.dest_qp_num;
> +
> +			qp->src_port = rxe_get_udp_sport(fl, lqp, rqp);
> +		}
> +	}
> +
>  	return 0;
>  
>  err1:
> -- 
> 2.27.0
> 
