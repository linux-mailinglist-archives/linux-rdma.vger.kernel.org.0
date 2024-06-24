Return-Path: <linux-rdma+bounces-3440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B5914FB7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2552A2823C1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5545142635;
	Mon, 24 Jun 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcV8da8u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747413A894
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238691; cv=none; b=a9tF1h9bQQOhFsNMyXHj2yZppgkeL+OaRnFBXewHCmCVXwxxS+6IvP13a7/CJ0WY04GpMDxIXPePwqc4z0CIi9nwu87XydvOJbfS6SOI+3mp5cCNVlQK4Y609GWnsi4pJdYVuZtOJX1aEdGXXYiTHSwgHXkS1sSYP7oEWmSejYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238691; c=relaxed/simple;
	bh=tuf5bSvIMrggz19fMZWlfeomtN59SNGI2qHBZlr2oDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS5nTf8jaQuSRV++/BHIYuEcAbjXXVteA34MEuPYY1/1AZqMMQw4/iMAPp+MG8gpI/v3IfIxlVQ/8Mvv4CsLB3Ka9JqbitHJlStpTybLUGiCSC9KnSRhy9YGxuSbWuHjlhurdYazLOtp9t3t7l2/qUFUVQGvvqyFzotlq9tHQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcV8da8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E7FC32782;
	Mon, 24 Jun 2024 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719238690;
	bh=tuf5bSvIMrggz19fMZWlfeomtN59SNGI2qHBZlr2oDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcV8da8u95y5Db6IgzGdGjgjN9aq2vK794/D6iVLx9i6iIkSuEASz6vVeYEmQ6qwx
	 8tmybIjLVVhG2Rm4ytShzjKvr4w0gti/8IPb4UF8w2ALPxDNHyGf3Xc3G8guHIgbp9
	 3Tsihp0THnmw1PZw8IW2DKqjXdMhidb5yIgbtwGsUJ5Blj09o2j8p4BmEbHh8W6jNA
	 rATalfZWhh/jM6Eh/xxcDxk+1r+8oOTxR0SWQNK49fL8bxhirbYde+NjxDFyYXvwQq
	 TWmwy8H+Ffofh0lcJHXI17ez/MzpmMivRTNt68ZKR769MGPcdbip5TAQGiDihg0eF5
	 zq9Ro6tz9sRRg==
Date: Mon, 24 Jun 2024 17:18:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Honggang LI <honggangli@163.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	dledford@redhat.com, kamalh@mellanox.com, amirv@mellanox.com,
	monis@mellanox.com, haggaie@mellanox.com
Subject: Re: [PATCH] RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs
Message-ID: <20240624141805.GI29266@unreal>
References: <20240624020348.494338-1-honggangli@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624020348.494338-1-honggangli@163.com>

On Mon, Jun 24, 2024 at 10:03:48AM +0800, Honggang LI wrote:
> BTH_ACK_MASK bit is used to indicate that an acknowledge
> (for this packet) should be scheduled by the responder.
> Both UC and UD QPs are unacknowledged, so don't set
> BTH_ACK_MASK for UC or UD QPs.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index cd14c4c2dff9..ffd7ed712a02 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -445,8 +445,12 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>  	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
>  					 qp->attr.dest_qp_num;
>  
> -	ack_req = ((pkt->mask & RXE_END_MASK) ||
> -		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> +	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_UC)
> +		ack_req = 0;
> +	else {
> +		ack_req = ((pkt->mask & RXE_END_MASK) ||
> +			(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> +	}
>  	if (ack_req)
>  		qp->req.noack_pkts = 0;


Applied the patch with the following change:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ffd7ed712a02..479c07e6e4ed 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -424,7 +424,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
        int                     paylen;
        int                     solicited;
        u32                     qp_num;
-       int                     ack_req;
+       int                     ack_req = 0;

        /* length from start of bth to end of icrc */
        paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
@@ -445,12 +445,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
        qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
                                         qp->attr.dest_qp_num;

-       if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_UC)
-               ack_req = 0;
-       else {
+       if (qp_type(qp) != IB_QPT_UD && qp_type(qp) != IB_QPT_UC)
                ack_req = ((pkt->mask & RXE_END_MASK) ||
-                       (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
-       }
+                          (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
        if (ack_req)
                qp->req.noack_pkts = 0;



>  
> -- 
> 2.45.2
> 

