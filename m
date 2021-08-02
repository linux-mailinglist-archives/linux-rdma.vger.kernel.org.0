Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0953DD1FD
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhHBIak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 04:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhHBIak (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 04:30:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 763E061057;
        Mon,  2 Aug 2021 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627893031;
        bh=f0r1hSkNYIx2tz2nq+hrJu+jMsXK3H9HOI0GpCW/+Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Piw0dn0Wn9DMdj6hwR/hIBgMV7wWwFdRkZbX8q6E+x/sI+4yPnsHsKAZ52w/uGt4n
         n2QwXTZNPJZQOKvAOYZLTHyhgk9VM93NNidAXOlyqfF/tcxyZ5jMH7J5BJa7mesXRW
         W42OoYW/Br1KMW8Sp01b7wk0DRetY/Hgk3lx07B/iWSW5/Vw1ifOfQvn9SWUeItyhN
         ddlYDJr2vyIzdRw4frFm75XAsgZTTax/IXUAurxAn1+nazB34AXIdSPUhCER8WA5W3
         kWum6GTONE6mOsdv0oafoG/vJ/fez82HSnnUPJql/V8v6c7bBnF8uK+v037qi4t7YI
         rLW7tSOIviSqQ==
Date:   Mon, 2 Aug 2021 11:30:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/5] Providers/rxe: Support XRC traffic
Message-ID: <YQetIxKBrtpBvL5Y@unreal>
References: <20210730152157.67592-1-rpearsonhpe@gmail.com>
 <20210730152157.67592-6-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730152157.67592-6-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 10:21:58AM -0500, Bob Pearson wrote:
> Extended create_qp and create_qp_ex verbs to support XRC QP types.
> Extended WRs to support XRC operations.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  providers/rxe/rxe.c | 132 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 96 insertions(+), 36 deletions(-)

<...>

> +static void wr_set_xrc_srqn(struct ibv_qp_ex *ibqp, uint32_t remote_srqn)
> +{
> +	struct rxe_qp *qp = container_of(ibqp, struct rxe_qp, vqp.qp_ex);
> +	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
> +						   qp->cur_index - 1);
> +
> +	if (qp->err)
> +		return;

Why is that?

> +
> +	wqe->wr.wr.xrc.srq_num = remote_srqn;
> +}
> +
