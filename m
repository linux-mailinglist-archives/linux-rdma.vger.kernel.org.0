Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F53484EDB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiAEHth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:49:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46694 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiAEHtg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:49:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B78B60FD2
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B9C36AE3;
        Wed,  5 Jan 2022 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368975;
        bh=riZPs/LBBYsNHXEE7Hn4+6w/vz+yaBBXsc28n2AVdLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqD2jCBxJDw4klDODAMsqVSTcqwrU+93FAj2EUf4t6y6LBOnvol0T3JVcZfBQqoD5
         6ntwBMtkapPJoMcq1K4ZdnaY0WhEkWTIyalFLjozyd5RnJ+X8qa2hlJ53npM7qFeu4
         VtaVYMpKsK5PL06KRtcOpXW0cSyKrXO1/zdzD4VDuBryRGhlv/NYexJENDKLNDQeJ8
         woRroA3xaUDKApxC1ThYiWuvELXFBcHBPnARVESLPSXVQNgxdvPLseRJVwUB32tU4w
         AfNDoTGqYBKVck9sTPqpiI2vsK3Vx8OKodn8ShqIhyXEJNVe2rvhwe5WC776LmnSQt
         n/9e1tq4PyFuQ==
Date:   Wed, 5 Jan 2022 09:49:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/5] RDMA/rxe: Remove the redundant randomization for UDP
 source port
Message-ID: <YdVNi3EK2tZsywk/@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-6-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105221237.2659462-6-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 05:12:37PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the UDP source port is modified in rxe_modify_qp, the randomization
> for UDP source port is redundant in this function. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 54b8711321c1..84d6ffe7350a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -210,15 +210,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  		return err;
>  	qp->sk->sk->sk_user_data = qp;
>  
> -	/* pick a source UDP port number for this QP based on
> -	 * the source QPN. this spreads traffic for different QPs
> -	 * across different NIC RX queues (while using a single
> -	 * flow for a given QP to maintain packet order).
> -	 * the port number must be in the Dynamic Ports range
> -	 * (0xc000 - 0xffff).
> +	/* Source UDP port number for this QP is modified in rxe_qp_modify.
>  	 */

This makes me wonder why do we set this src_port here?
Are we using this field before modify QP?

Thanks

> -	qp->src_port = RXE_ROCE_V2_SPORT +
> -		(hash_32_generic(qp_num(qp), 14) & 0x3fff);
> +	qp->src_port		= RXE_ROCE_V2_SPORT;
>  	qp->sq.max_wr		= init->cap.max_send_wr;
>  
>  	/* These caps are limited by rxe_qp_chk_cap() done by the caller */
> -- 
> 2.27.0
> 
